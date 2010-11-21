package cc.gullinbursti.math.geom {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.converts.Angle;
	import cc.gullinbursti.math.BasicMath;
	
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class Polyhedron extends BasicMath {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		//TODO: define & implement some polyhedra functions
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const TRIANGLE:String = "TRIANGLE";
		public static const RECTANGLE:String = "RECTANGLE";
		public static const PENTAGON:String = "PENTAGON";
		public static const HEXAGON:String = "HEXAGON";
		public static const SEPTAGON:String = "SEPTAGON";
		public static const OCTAGON:String = "OCTAGON";
		public static const NONAGON:String = "NONAGON";
		public static const DECAGON:String = "DECAGON";
		public static const DODECAGON:String = "DODECAGON";
		
		private static const BASE_ANG:int = 180;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function Polyhedron() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function name2Sides(name:String):int {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			switch (name) {
				case Polyhedron.TRIANGLE:
					return (3);
					break;
				
				case Polyhedron.RECTANGLE:
					return (4);
					break;
				
				case Polyhedron.PENTAGON:
					return (5);
					break;
				
				case Polyhedron.HEXAGON:
					return (6);
					break;
				
				case Polyhedron.SEPTAGON:
					return (7);
					break;
				
				case Polyhedron.OCTAGON:
					return (8);
					break;
				
				case Polyhedron.NONAGON:
					return (9);
					break;
				
				case Polyhedron.DECAGON:
					return (10);
					break;
				
				case Polyhedron.DODECAGON:
					return (12);
					break;
			}
			
			
			return (int(name));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function lenSegment(name:String, radius:Number, ratio:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			var pt1:Point = new Point();
				pt1.x = Math.sin(Angle.degreesToRadians(0)) * radius;
				pt1.y = Math.cos(Angle.degreesToRadians(0)) * radius;
				
			var pt2:Point = new Point();
				pt2.x = Math.sin(Angle.degreesToRadians(angSegment(name, radius, ratio))) * radius;
				pt2.y = Math.cos(Angle.degreesToRadians(angSegment(name, radius, ratio))) * radius;
					
			
			return (Point.distance(pt1, pt2));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function angSegment(name:String, radius:Number, ratio:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			return (angCircumference(name, radius, ratio) / name2Sides(name));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function angCircumference(name:String, radius:Number, ratio:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			return (((name2Sides(name) - ((name2Sides(name) - 2)) * BASE_ANG)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}