package cc.gullinbursti.converts {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Angle {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		// <*] class constructor [*>	
		public function Angle() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		/**
		 * degrees
		 * radians
		 */
		
		
		
		public static function degreesToRadians(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 *                 π
			 * radians = ° × —————
			 *                180
			 */
		
		
			return (val * (Math.PI / 180));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function radiansToDegrees(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			/**
			 *                180 
			 * ° = radians × —————
			 *                 π
			 */
		
			return (val * (180 / Math.PI));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function cartToPolar(coord:Point):Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (new Point());	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function polarToCart(rad:Number, theta:Number):Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Point.polar(rad, degreesToRadians(theta)));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯

	}
}