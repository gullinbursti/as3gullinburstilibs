package cc.gullinbursti.science.geo {
	import flash.geom.Point;
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author:		Gullinbursti
	 * @class:		BasicGeology
	 * @package:	cc.gullinbursti.science.geo
	 * @created:	4:43:28 PM Dec 9, 2010
	 */
	// <[!] class delaration [!]>
	public class BasicGeology {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		protected static var richterScale_arr:Array = new Array(
			//	mph				knots				surge			name
			[new Point(0.0, 1.9),	2920000,	"Micro", 	"Microearthquakes, not felt"], 
			[new Point(2.0, 2.9), 	 365000,	"Minor", 	"Generally not felt, but recorded."],
			[new Point(3.0, 3.9), 	  49000,	"Minor", 	"Often felt, but rarely causes damage."],
			[new Point(4.0, 4.9), 	   6200,	"Light", 	"Noticeable shaking of indoor items, rattling noises. Significant damage unlikely."],
			[new Point(5.0, 5.9), 	    800,	"Moderate", "Can cause major damage to poorly constructed buildings over small regions. At most slight damage to well-designed buildings."],
			[new Point(6.0, 6.9), 	    120, 	"Strong", 	"Can be destructive in areas up to about 160 kilometres (100 mi) across in populated areas."],
			[new Point(7.0, 7.9), 	     18,	"Major", 	"Can cause serious damage over larger areas."],
			[new Point(8.0, 8.9), 	      1,	"Great", 	"Can cause serious damage in areas several hundred miles across."],
			[new Point(9.0, 9.9), 	    0.2, 	"Great", 	"Devastating in areas several thousand miles across."],
			[new Point(10.0, 10), 	      0,	"Epic", 	"Never recorded"]
		);
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function BasicGeology() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}