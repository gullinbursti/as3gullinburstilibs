package cc.gullinbursti.science.weather {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Air extends BasicWeather {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		
			
		
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function Air() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		
		/**
		 * Calculates the windchill 
		 * 
		 * @param temp
		 * @param spd
		 * @return Number
		 */
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