package cc.gullinbursti.math.geom {


	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.converts.Angle;
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.math.algebra.Fractions;
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	
	/**
	 * 
	 * @author Gullinbursti
	 */	
	// <[!] class delaration [¡]>
	public class Line extends BasicGeom {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		//TODO: define & implement some add'l line functions
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function Line() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function midPt(pt1:Point, pt2:Point):Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var mid_pt:Point = pt1.clone();
				mid_pt.x += (pt2.x - pt1.x) * 0.5;
				mid_pt.y += (pt2.y - pt1.y) * 0.5;
				
			return (mid_pt);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function slope(pt1:Point, pt2:Point, reduce:Boolean=true):Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var slope_pt:Point = new Point();
				slope_pt.x = pt2.x - pt1.x;
				slope_pt.y = pt2.y - pt1.y;
			
			
			if (reduce)
				return (Fractions.reduce(slope_pt));
				
			return (slope_pt);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}
