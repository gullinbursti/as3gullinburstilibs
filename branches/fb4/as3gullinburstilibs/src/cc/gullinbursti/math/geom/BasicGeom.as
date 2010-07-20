/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	BasicGeom.as		
 * Version	: 	1.0
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	12-23-09
 * 
 * Purpose	:	Provides basic math for geometic operations & functions.
 * 
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~·¯
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~·¯
**/

package cc.gullinbursti.math.geom {
	
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	
	import flash.geom.Point;
	
	 // <[!] class delaration [¡]>
	public class BasicGeom extends BasicMath {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		// TODO: define & implement some add'l geometry functions
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function BasicGeom() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function midPt(pt1:Point, pt2:Point):Point {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * c = 2πr
			 * 
			 */
			
			return (new Point());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function angleDiff(ang1:Number, ang2:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var diff:Number = (ang1 - ang2) % 360;
			
			if (diff != diff % 180) {
				
				if (diff < 0)
					diff += 360;
				else
					diff -= 360;
			}
				
			
			return (diff);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}