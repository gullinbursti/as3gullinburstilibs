package cc.gullinbursti.science.weather {
	import cc.gullinbursti.math.BasicMath;
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Temperature extends BasicWeather {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		// <*] class constructor [*>
		public function Temperature() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function heatIndex(feh:Number, humid:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * heat_index = 
			 * 
			 * -42.379 + (2.04901523 * t) + (10.14333127 * h)
			 * - (0.22475541 * t * h) - (6.83783e-3 * t^2) 
			 * - (5.481717e-2 * h^2) + (1.22874e-3 * t^2 * h) 
			 * + (8.5282e-4 * t * h^2) - (1.99e-6 * t^2 * r^2)
			 * 
			 */
			
			var const_arr:Array = new Array(
				-42.379, 
				2.04901523, 
				10.14333127, 
				0.22475541, 
				BasicMath.e(6.837830, -3), 
				BasicMath.e(5.481717, -2), 
				BasicMath.e(1.228740, -3), 
				BasicMath.e(8.528200, -4), 
				BasicMath.e(1.990000, -3));
			
			var feh_sq:Number = BasicMath.square(feh);
			var humid_sq:Number = BasicMath.square(humid);
			
			return (const_arr[0] + (const_arr[1] * feh) + (const_arr[2] * humid) - (const_arr[3] * feh * humid) - (const_arr[4] * feh_sq) - (const_arr[5] * humid_sq) + (const_arr[6] * feh_sq * humid) + (const_arr[7] * feh * humid_sq) - (const_arr[8] * feh_sq * humid_sq));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function windChill(temp:Number, spd:Number):Number {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * 
			 * wind chill = 35.74 + (0.6215 × °F) - ((35.75 × mph) ^ 0.16) + ((0.4275 × °F × mph) ^ 0.16) [^ is “raised to”]
			 * 
			 */
			
			/*
			35.74 + (0.6215 × °F) - ((35.75 × mph) ^ 0.16) + ((0.4275 × °F × mph) ^ 0.16) [^ is “raised to”]
			
			
			35.74 + 0.6215T - 35.75V (**0.16) + 0.4275TV(**0.16) 
			
			T = °F
			V = mph
			*/
			
			
			return (34.74 + (0.6215 * temp) - Math.pow((35.75 * spd), 0.16) + Math.pow((0.4275 * temp * spd), 0.16));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}