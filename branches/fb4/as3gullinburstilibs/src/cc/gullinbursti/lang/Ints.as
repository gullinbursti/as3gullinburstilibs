package cc.gullinbursti.lang {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * @package cc.gullinbursti.lang
	 * @class Ints
	 * @author Gullinbursti
	 */
	// <[!] class delaration [!]>
	public class Ints {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		// <*] class constructor [*>	
		public function Ints() {/*..\(^_^)/..*/}
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		
		
		/**
		 * Returns the ordinal suffix of an <code>int</code> (th / st / nd / rd).
		 * @param val The value to find suffix for.
		 * @return A <code>String</code> representing the suffix of the <code>int</code>.
		 * 
		 */		
		public static function ordinalSuffix(val:int):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// use the one's digit to determine suffix
			switch(val % 10) {
				
				//> ends w/ 1
				case 1:
					return ("st");
					break;
				
				//> ends w/ 2
				case 2:
					return ("nd");
					break;
				
				//> ends w/ 3
				case 3:
					return ("rd");
					break;
				
				// ends w/ any other digit
				default:
					return ("th");
					break;
			}
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Converts an <code>int</code> to it's inverse. 
		 * @param float The input <code>int</code> to convert.
		 * @return The inverse (negated) value.
		 * 
		 */
		public static function invert(val:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// the val multiplied by ¯1
			return (val * -1);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Returns a <code>Point</code> of two swapped <code>int</code>s.
		 * @param val1 The 1st <code>int</code> to swap.
		 * @param val2 The 2nd <code>int</code> to swap.
		 * @return A <code>Point</code> obj representing two swapped <code>int</code>s.
		 * 
		 */		
		public static function swap(val1:int, val2:int):Point {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._		
		
			// temp holder val
			var tmp_val:Number = val1;
			
			// swap the vals
			val1 = val2;
			val2 = tmp_val;
			
			// a point containing the swapped vals
			return (new Point(val1, val2));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}