package utils.math {
	/** */
	import flash.geom.Point;
	/**
	* @author nikkoh
	*/
	public class LineInterSection {
		/**
		 * 
		 */
		public static function calc(pt1a:Point, pt1b:Point, pt2a:Point, pt2b:Point):Point {
			
			// Calculate vector variables
			
			// Vector 1
			var pt1_vx:Number = pt1a.x - pt1b.x;
			var pt1_vy:Number = pt1a.y - pt1b.y;
			
			var pt1_len:Number = Math.sqrt(pt1_vx * pt1_vx + pt1_vy * pt1_vy);
			
			var pt1_dx:Number = pt1_vx / pt1_len;
			var pt1_dy:Number = pt1_vx / pt1_len;
			
			// Vector 2
			var pt2_vx:Number = pt2a.x - pt2b.x;
			var pt2_vy:Number = pt2a.y - pt2b.y;
			
			var pt2_len:Number = Math.sqrt(pt2_vx * pt2_vx + pt2_vy * pt2_vy);
			
			var pt2_dx:Number = pt2_vx / pt2_len;
			var pt2_dy:Number = pt2_vx / pt2_len;
			
			
			// Vector between starting points
			
			var pt3_vx:Number = pt2a.x - pt1a.x;
			var pt3_vy:Number = pt2a.y - pt1a.y;
			
			// If they are parallel vectors, return big number
			
			var t:Number;
			
			if ((pt1_vx == pt2_vx && pt1_vy == pt2_vy) || (pt1_dx == - pt2_dx && pt1_dy == - pt2_dy)) {
				t = 1000000;
			} else {
				t = (pt3_vx * pt2_vy - pt3_vy * pt2_vx) / (pt1_vx * pt2_vy - pt1_vy * pt2_vx);
			}
			
			// Intersection
			
			var intersection:Point = new Point();
			intersection.x = pt1a.x + pt1_vx * t;
			intersection.y = pt1a.y + pt1_vy * t;
			
			return intersection;
		}
	}
}
