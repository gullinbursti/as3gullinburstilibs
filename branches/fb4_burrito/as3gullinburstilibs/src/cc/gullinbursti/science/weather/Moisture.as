package cc.gullinbursti.science.weather {
	import cc.gullinbursti.math.BasicMath;
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [!]>
	public class Moisture extends BasicWeather {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		// <*] class constructor [*>
		public function Moisture() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function realitiveHumidity(feh:Number, dewPt:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * rel_humidity = 
			 * 
			 * T=(Math.exp((17.67 * T)/(243.5+T)));
			 * Td=(Math.exp((17.67 * Td)/(243.5+Td)));
			 * inform.Relh.value=parseInt(100*(Td/T));
			 * 
			 */
			
			
			var humid:Number = 0;
			
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
	
		public static function specificHumidity(celc:Number, reh:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * sh = (0.622 * E) / (vp_Mb - (0.378 * E))
			 * 
			 */
			
			return (0);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function satVaporPressure(celc:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * mb = 6.11*10.0**(7.5*Tc/(237.7+Tc))
			 * 
			 */
			
			return (6.11 * BasicMath.powr10(7.5 * celc / (237.7 + celc)));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function vaporPressure(celc:Number, reh:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * mb = (6.11 * 10^(7.5 * ((Tc - (14.55 + 0.114 * Tc) * (1 - (0.01 * RH)) - ((2.5 + 0.007 * Tc) * (1 - (0.01 * RH)))^3 - (15.9 + 0.117 * Tc) * (1 - (0.01 * RH))^14))/(237.7+((Tc - (14.55 + 0.114 * Tc) * (1 - (0.01 * RH)) - ((2.5 + 0.007 * Tc) * (1 - (0.01 * RH))) ^ 3 - (15.9 + 0.117 * Tc) * (1 - (0.01 * RH)) ^ 14)))))
			 * 
			 */
			
			return (6.11 * BasicMath.powr10(7.5 * celc / (237.7 + celc)));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function dewPt(feh:Number, rh:Number=-1):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * 	((((Tf-32)/1.8)-(14.55+0.114*((Tf-32)/1.8))* 
				(1-(0.01*RH))-((2.5+0.007*((Tf-32)/1.8))*(1-(0.01*RH))) 
				^3-(15.9+0.117*((Tf-32)/1.8))*(1-(0.01*RH))^14)*1.8)+32
			 * 
			 */
			
			
			return (0);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function vPressure(cel:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * 6.11*10.0**(7.5*Tdc/(237.7+Tdc))
			 * 
			 */
			
			
			return (0);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}