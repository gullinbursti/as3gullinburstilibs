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
		
		
		public static function invert(bin_str:String):String {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return binXOR(bin_str, ("11111111111111111111111111111111").substr(0, bin_str.length));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function pad(bin_str:String, amt:uint):String {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (bin_str);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Performs bitwise OR on a series of numbers 
		 * 
		 * @param arguements list of <code>String</code> formatted binary #s 
		 * 
		 * @return <code>String</code> formatted binary #
		 */
		public static function binOR(...args):String {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			var val:Number = parseInt(args[0], 2);
			
			for (var i:int=1; i<args.length; i++)
				val |= parseInt(args[i], 2);
			
			return (val.toString(2));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function binAND(...args):String {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var val:Number = parseInt(args[0], 2);
			var j:Number;
			
			for (var i:int=1; i<args.length; i++)
				val &= parseInt(args[i], 2);
			
			return (val.toString(2));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function binXOR(...args):String {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var val:Number = parseInt(args[0], 2);
			var j:Number;
			
			for (var i:int=1; i<args.length; i++) {
				val ^= parseInt(args[i], 2);
			}
			
			return (val.toString(2));
		}
		
		public static function binNOT(bin_str:String):String {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return ((~parseInt(bin_str, 2)).toString(2));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}