package cc.gullinbursti.science.earth {
	import flash.geom.Point;
	
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
			//	name				mph					knots				wave ht		descript
			["Calm", 				new Point(0, 1),	new Point(0, 1),	new Point(0, 0), 	"The sea is calm, like a mirror."], 
			["Light Air", 			new Point(1, 3),	new Point(1, 3),	new Point(0, 1), 	"Ripples with the appearance of scales are formed, but without foam crests."], 
			["Light Breeze", 		new Point(4, 7),	new Point(4, 6),	new Point(1, 2), 	"Small wavelets, still short, but more pronounced. Crests have a glassy appearance and do not break."], 
			["Gentle Breeze", 		new Point(8, 12),	new Point(7, 10),	new Point(2, 3), 	"Large wavelets. Crests begin to break. Foam of glassy appearance. Some whitecaps."], 
			["Moderate Breeze", 	new Point(13, 18),	new Point(11, 16),	new Point(3, 5),  	"Small waves, becoming larger; fairly frequent whitecaps."], 
			["Fresh Breeze", 		new Point(19, 24),	new Point(17, 21),	new Point(6, 8),  	"Moderate waves, taking a more pronounced long form; many whitecaps are formed. Chance of some spray."], 
			["Strong Breeze", 		new Point(25, 31),	new Point(22, 27),	new Point(9, 13), 	"Large waves begin to form; the white foam crests are more extensive everywhere. Probably some spray. If the storm forms in the tropics, a 6 or 7 on the Beaufort Scale corresponds to a Tropical Depression's wind speed as it develops first into a Tropical Storm, and if it strengthens, a hurricane."], 
			["Near Gale", 			new Point(32, 38),	new Point(28, 33), 	new Point(13, 19), 	"Sea heaps up and white foam from breaking waves begins to be blown in streaks along the direction of the wind."],  
			["Gale", 				new Point(39, 46),	new Point(34, 40),	new Point(18, 25), 	"Moderately high waves of greater length; edges of crests begin to break into spindrift. The foam is blown in well-marked streaks along the direction of the wind. If the storm forms in the tropics, once the wind reaches speeds above 38 mph, it is categorized as a Tropical Storm and given a name."],  
			["Severe Gale", 		new Point(47, 54),	new Point(41, 47),	new Point(23, 32), 	"High waves. Dense streaks of foam along the direction of the wind. Crests of waves begin to topple, tumble and roll over. Spray may affect visibility."], 
			["Storm", 				new Point(55, 63), 	new Point(48, 55),	new Point(29, 41), 	"Very high waves with long overhanging crests. The resulting foam, in great patches, is blown in dense white streaks along the direction of the wind. On the whole the surface of the sea takes on a white appearance. The 'tumbling' of the sea becomes heavy and visibility is affected."], 
			["Violent Storm", 		new Point(64, 72),	new Point(56, 63),	new Point(37, 52), 	"Exceptionally high waves (small and medium-size ships might be for a time lost to view behind the waves). The sea is completely covered with long white patches of foam lying along the direction of the wind. Everywhere the edges of the wave crests are blown into froth. Visibility affected."], 
			["Hurricane", 			new Point(73, 83),	new Point(64, 71),	new Point(45, 45), 	"The air is filled with foam and spray. Sea completely white with driving spray; visibility very seriously affected. A 12 on the Beaufort Scale corresponds to a Category 1 Hurricane on the Saffir-Simpson Scale, the scale by which hurricanes are measured."]
		);
		
		
		protected static var tropical_arr:Array = new Array(
			//	mph				knots				surge			name
			[new Point(0, 38),	new Point(0, 33),	new Point(0, 0), "Depression"], 
			[new Point(39, 73),	new Point(34, 63),	new Point(0, 3), "Storm"], 
			[new Point(74, 74),	new Point(64, 64),	new Point(4, 4), "Hurricane"]
		);
		
		
		protected static var safirSimpson_arr:Array = new Array(
			//	mph					knots					surge				descript
			[new Point(74, 95),		new Point(64, 82),		new Point(4, 5), 	"No real damage to building structures. Damage primarily to unanchored mobile homes, shrubbery, and trees. Some damage to poorly constructed signs. Also, some coastal road flooding and minor pier damage."], 
			[new Point(96, 110),	new Point(83, 95),		new Point(6, 8), 	"Some roofing material, door, and window damage of buildings. Considerable damage to shrubbery and trees with some trees blown down. Considerable damage to mobile homes, poorly constructed signs, and piers. Coastal and low-lying escape routes flood 2-4 hours before arrival of the hurricane center. Small craft in unprotected anchorages break moorings."], 
			[new Point(111, 130),	new Point(96, 113),		new Point(9, 12), 	"Some structural damage to small residences and utility buildings. Damage to shrubbery and trees with foliage blown off trees and large trees blown down. Mobile homes and poorly constructed signs are destroyed. Low-lying escape routes are cut by rising water 3-5 hours before arrival of the center of the hurricane. Flooding near the coast destroys smaller structures with larger structures damaged by battering from floating debris. Terrain continuously lower than 5 ft above mean sea level may be flooded inland 8 miles (13 km) or more. Evacuation of low-lying residences with several blocks of the shoreline may be required."], 
			[new Point(131, 155),	new Point(114, 135),	new Point(13, 18), 	"More extensive curtainwall failures with some complete roof structure failures on small residences. Shrubs, trees, and all signs are blown down. Complete destruction of mobile homes. Extensive damage to doors and windows. Low-lying escape routes may be cut by rising water 3-5 hours before arrival of the center of the hurricane. Major damage to lower floors of structures near the shore. Terrain lower than 10 ft above sea level may be flooded requiring massive evacuation of residential areas as far inland as 6 miles."], 
			[new Point(156, 156),	new Point(136, 136),	new Point(19, 19), 	"Complete roof failure on many residences and industrial buildings. Some complete building failures with small utility buildings blown over or away. All shrubs, trees, and signs blown down. Complete destruction of mobile homes. Severe and extensive window and door damage. Low-lying escape routes are cut by rising water 3-5 hours before arrival of the center of the hurricane. Major damage to lower floors of all structures located less than 15 ft above sea level and within 500 yards of the shoreline. Massive evacuation of residential areas on low ground within 5-10 miles of the shoreline may be required."]
		);
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function BasicWeather() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
	}
}