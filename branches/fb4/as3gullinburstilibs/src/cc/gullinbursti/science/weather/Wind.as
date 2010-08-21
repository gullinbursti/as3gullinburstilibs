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
	public class Wind extends BasicWeather {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		
			
		
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function Wind() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
<<<<<<< .mine
		
		
		
		/**
		 * Calculates the windchill 
		 * 
		 * @param temp
		 * @param spd
		 * @return Number
		 */
		public static function windChill(temp:Number, spd:Number, isModern:Boolean=true):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * >= 2002
			 * wind chill = 35.74 + (0.6215 × °F) - ((35.75 × mph) ^ 0.16) + ((0.4275 × °F × mph) ^ 0.16) [^ is “raised to”]
			 * 
			 * < 2002
			 * wind chill = 0.0817 * (3.71 * SQRT(mph) + 5.81 - 0.25 * mph) * (°F - 91.4) + 91.4
			 * 
			 */
			
			/*
			35.74 + (0.6215 × °F) - ((35.75 × mph) ^ 0.16) + ((0.4275 × °F × mph) ^ 0.16) [^ is “raised to”]
			35.74 + 0.6215T - 35.75V (**0.16) + 0.4275TV(**0.16) 
			
			T = °F
			V = mph
			*/
			
			if (isModern)
				return (34.74 + 0.6215 * temp - 35.75 * Math.pow(spd, 0.16) + 0.4275 * temp * Math.pow(spd, 0.16));
			
			return (0.0817 * (3.71 * Math.sqrt(spd) + 5.81 - 0.25 * spd) * (temp - 91.4) + 91.4);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
=======
>>>>>>> .r57
	}
}