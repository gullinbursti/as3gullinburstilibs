package cc.gullinbursti.lang {
	
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	/**
	 * @package cc.gullinbursti.lang
	 * @class Numbers
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Bits extends Ints {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		// <*] class constructor [*>
		public function Bits() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		/**
		 * Bitwise shifts an <code>int</code> a # of places to the left. 
		 * @param val The <code>int</code> to shift.
		 * @param places The # of places to shift.
		 * @return The shifted <code>int</code>.
		 * 
		 */		
		public static function lShift(val:int, places:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// shift the val
			return (val << places);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Bitwise shifts an <code>int</code> a # of places to the right. 
		 * @param val The <code>int</code> to shift.
		 * @param places The # of places to shift.
		 * @return The shifted <code>int</code>.
		 * 
		 */	
		public static function rShift(val:int, places:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// shift the val
			return (val >> places);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}