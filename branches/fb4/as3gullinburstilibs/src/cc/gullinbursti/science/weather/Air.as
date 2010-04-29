package cc.gullinbursti.science.weather {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Air {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		
		private static var beaufort_arr = new Array(
		//	name				mph			knots		wave ht
			"Calm", 			[0, 1],		[0, 1],		[0, 0], 
			"Light Air", 		[1, 3],		[1, 3],		[0, 1], 
			"Light Breeze", 	[4, 7],		[4, 6],		[1, 2], 
			"Gentle Breeze", 	[8, 12],	[7, 10],	[2, 3], 
			"Moderate Breeze", 	[13, 18],	[11, 16],	[3, 5], 
			"Fresh Breeze", 	[19, 24],	[17, 21],	[6, 8], 
			"Strong Breeze", 	[25, 31],	[22, 27],	[9, 13], 
			"Near Gale", 		[32, 38],	[28, 33], 	13, 19], 
			"Gale", 			[39, 46],	[34, 40],	[18, 25], 
			"Severe Gale", 		[47, 54],	[41, 47],	[23, 32], 
			"Storm", 			[55, 63], 	[48, 55],	[29, 41], 
			"Violent Storm", 	[64, 72],	[56, 63],	[37, 52], 
			"Hurricane", 		[73, 83],	[64, 71],	[45, 45]);
		
		private static var safir_arr = new Array(
			//	name				mph			knots		wave ht
			"Calm", 			[0, 1],		[0, 1],		[0, 0], 
			"Light Air", 		[1, 3],		[1, 3],		[0, 1], 
			"Light Breeze", 	[4, 7],		[4, 6],		[1, 2], 
			"Gentle Breeze", 	[8, 12],	[7, 10],	[2, 3], 
			"Moderate Breeze", 	[13, 18],	[11, 16],	[3, 5], 
			"Fresh Breeze", 	[19, 24],	[17, 21],	[6, 8], 
			"Strong Breeze", 	[25, 31],	[22, 27],	[9, 13], 
			"Near Gale", 		[32, 38],	[28, 33], 	13, 19], 
			"Gale", 			[39, 46],	[34, 40],	[18, 25], 
			"Severe Gale", 		[47, 54],	[41, 47],	[23, 32], 
			"Storm", 			[55, 63], 	[48, 55],	[29, 41], 
			"Violent Storm", 	[64, 72],	[56, 63],	[37, 52], 
			"Hurricane", 		[73, 83],	[64, 71],	[45, 45]);
			
		
		
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
			
			
			return (34.74 + (0.6215 * temp) - Math.pow((35.75 * spd), 0.16) + Math.pow((0.4275 * temp * spd), 0.16));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}