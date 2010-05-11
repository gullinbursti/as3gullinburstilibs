package cc.gullinbursti.science.weather {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [!]>
	public class BasicWeather {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		protected static var beaufort_arr:Array = new Array(
			//	name				mph			knots		wave ht		descript
			"Calm", 			[0, 1],		[0, 1],		[0, 0], 	"The sea is calm, like a mirror.", 
			"Light Air", 		[1, 3],		[1, 3],		[0, 1], 	"Ripples with the appearance of scales are formed, but without foam crests.", 
			"Light Breeze", 	[4, 7],		[4, 6],		[1, 2], 	"Small wavelets, still short, but more pronounced. Crests have a glassy appearance and do not break.", 
			"Gentle Breeze", 	[8, 12],	[7, 10],	[2, 3], 	"Large wavelets. Crests begin to break. Foam of glassy appearance. Some whitecaps.", 
			"Moderate Breeze", 	[13, 18],	[11, 16],	[3, 5],  	"Small waves, becoming larger; fairly frequent whitecaps.", 
			"Fresh Breeze", 	[19, 24],	[17, 21],	[6, 8],  	"Moderate waves, taking a more pronounced long form; many whitecaps are formed. Chance of some spray.", 
			"Strong Breeze", 	[25, 31],	[22, 27],	[9, 13], 	"Large waves begin to form; the white foam crests are more extensive everywhere. Probably some spray. If the storm forms in the tropics, a 6 or 7 on the Beaufort Scale corresponds to a Tropical Depression's wind speed as it develops first into a Tropical Storm, and if it strengthens, a hurricane.", 
			"Near Gale", 		[32, 38],	[28, 33], 	[13, 19], 	"Sea heaps up and white foam from breaking waves begins to be blown in streaks along the direction of the wind.",  
			"Gale", 			[39, 46],	[34, 40],	[18, 25], 	"Moderately high waves of greater length; edges of crests begin to break into spindrift. The foam is blown in well-marked streaks along the direction of the wind. If the storm forms in the tropics, once the wind reaches speeds above 38 mph, it is categorized as a Tropical Storm and given a name.",  
			"Severe Gale", 		[47, 54],	[41, 47],	[23, 32], 	"High waves. Dense streaks of foam along the direction of the wind. Crests of waves begin to topple, tumble and roll over. Spray may affect visibility.", 
			"Storm", 			[55, 63], 	[48, 55],	[29, 41], 	"Very high waves with long overhanging crests. The resulting foam, in great patches, is blown in dense white streaks along the direction of the wind. On the whole the surface of the sea takes on a white appearance. The 'tumbling' of the sea becomes heavy and visibility is affected.", 
			"Violent Storm", 	[64, 72],	[56, 63],	[37, 52], 	"Exceptionally high waves (small and medium-size ships might be for a time lost to view behind the waves). The sea is completely covered with long white patches of foam lying along the direction of the wind. Everywhere the edges of the wave crests are blown into froth. Visibility affected.", 
			"Hurricane", 		[73, 83],	[64, 71],	[45, 45], 	"The air is filled with foam and spray. Sea completely white with driving spray; visibility very seriously affected. A 12 on the Beaufort Scale corresponds to a Category 1 Hurricane on the Saffir-Simpson Scale, the scale by which hurricanes are measured.");
		
		
		protected static var tropical_arr:Array = new Array(
			//	mph			knots		surge	name
			[0, 38],	[0, 33],	[0, 0], "Depression", 
			[39, 73],	[34, 63],	[0, 3], "Storm", 
			[74, 74],	[64, 64],	[4, 4], "Hurricane");
		
		
		protected static var safirSimpson_arr:Array = new Array(
			//	mph			knots		surge		descript
			[74, 95],	[64, 82],	[4, 5], 	"No real damage to building structures. Damage primarily to unanchored mobile homes, shrubbery, and trees. Some damage to poorly constructed signs. Also, some coastal road flooding and minor pier damage.", 
			[96, 110],	[83, 95],	[6, 8], 	"Some roofing material, door, and window damage of buildings. Considerable damage to shrubbery and trees with some trees blown down. Considerable damage to mobile homes, poorly constructed signs, and piers. Coastal and low-lying escape routes flood 2-4 hours before arrival of the hurricane center. Small craft in unprotected anchorages break moorings.", 
			[111, 130],	[96, 113],	[9, 12], 	"Some structural damage to small residences and utility buildings. Damage to shrubbery and trees with foliage blown off trees and large trees blown down. Mobile homes and poorly constructed signs are destroyed. Low-lying escape routes are cut by rising water 3-5 hours before arrival of the center of the hurricane. Flooding near the coast destroys smaller structures with larger structures damaged by battering from floating debris. Terrain continuously lower than 5 ft above mean sea level may be flooded inland 8 miles (13 km) or more. Evacuation of low-lying residences with several blocks of the shoreline may be required.", 
			[131, 155],	[114, 135],	[13, 18], 	"More extensive curtainwall failures with some complete roof structure failures on small residences. Shrubs, trees, and all signs are blown down. Complete destruction of mobile homes. Extensive damage to doors and windows. Low-lying escape routes may be cut by rising water 3-5 hours before arrival of the center of the hurricane. Major damage to lower floors of structures near the shore. Terrain lower than 10 ft above sea level may be flooded requiring massive evacuation of residential areas as far inland as 6 miles.", 
			[156, 156],	[136, 136],	[19, 19], 	"Complete roof failure on many residences and industrial buildings. Some complete building failures with small utility buildings blown over or away. All shrubs, trees, and signs blown down. Complete destruction of mobile homes. Severe and extensive window and door damage. Low-lying escape routes are cut by rising water 3-5 hours before arrival of the center of the hurricane. Major damage to lower floors of all structures located less than 15 ft above sea level and within 500 yards of the shoreline. Massive evacuation of residential areas on low ground within 5-10 miles of the shoreline may be required.");
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function BasicWeather() {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
	}
}