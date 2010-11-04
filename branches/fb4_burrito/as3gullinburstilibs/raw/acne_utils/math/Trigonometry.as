package utils.math {
	/** */
	import flash.geom.Point;
	/**
	* @author nikkoh
	*/
	public class Trigonometry {
		/** */
		private static const toDEGREES:Number = 180 / Math.PI;
        private static const toRADIANS:Number = Math.PI / 180;
		/**
		 *
		 */
		public static function convertDegreeToRadian(degree:Number):Number {
			return degree * toRADIANS;
		}
		/**
		 *
		 */
		public static function convertRadianToDegree(radian:Number):Number {
			return radian * toDEGREES;
		}
		/**
		 *
		 */
		public static function distance(pt1:Point, pt2:Point):Number {
			return Point.distance(pt1, pt2);
		}
		/**
		 *
		 */
		public static function polar(len:Number, radians:Number):Point {
			return Point.polar(len, radians);
		}
		/**
		 *
		 */
		public static function polarDegree(len:Number, degree:Number):Point {
			return Point.polar(len, (degree * toRADIANS));
		}
		/**
		 *
		 */
		public static function polarWithOffset(offset:Point, len:Number, radians:Number):Point {
			var rpt:Point = Point.polar(len, radians);
			rpt.offset(offset.x, offset.y);
			return rpt;
		}
		/**
		 *
		 */
		public static function polarDegreeWithOffset(offset:Point, len:Number, degree:Number):Point {
			var rpt:Point = Point.polar(len, (degree * toRADIANS));
			rpt.offset(offset.x, offset.y);
			return rpt;
		}
		/**
		 *
		 */
		public static function angle(pt1:Point, pt2:Point):Number {
			return Math.atan2((pt2.y - pt1.y), (pt2.x - pt1.x));
		}
		/**
		 *
		 */
		public static function angleDegree(pt1:Point, pt2:Point):Number {
			return (Math.atan2((pt2.y - pt1.y), (pt2.x - pt1.x)) * toDEGREES);
		}
	}
}