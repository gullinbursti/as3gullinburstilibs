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
		
		private static const ORDINAL_SUFFIXES:Array = [
			"th", 
			"st", 
			"nd", 
			"rd", 
			"th"
		];
		
		
		private static const ORDINAL_NAMES:Array = [
			"zero",
			"fir", 
			"seco", 
			"thi", 
			"four", 
			"fif", 
			"six", 
			"seven", 
			"eigh", 
			"nine", 
			"ten", 
			"eleven", 
			"twelve"
		];
		
		
		public static const NAMES:Array = [
			"zero", 
			"one", 
			"two", 
			"three", 
			"four", 
			"five", 
			ORDINAL_NAMES[6], 
			ORDINAL_NAMES[7], 
			ORDINAL_NAMES[8], 
			ORDINAL_NAMES[9], 
			ORDINAL_NAMES[10], 
			ORDINAL_NAMES[11], 
			ORDINAL_NAMES[12], 
			ORDINAL_NAMES[3] + "teen", 
			ORDINAL_NAMES[4] + "teen", 
			ORDINAL_NAMES[5] + "teen", 
			ORDINAL_NAMES[6] + "teen", 
			ORDINAL_NAMES[7] + "teen", 
			ORDINAL_NAMES[8] + "teen", 
			ORDINAL_NAMES[9] + "teen", 
			"twenty", 
			ORDINAL_NAMES[3] + "ty", 
			ORDINAL_NAMES[4] + "ty", 
			ORDINAL_NAMES[5] + "ty", 
			ORDINAL_NAMES[6] + "ty", 
			ORDINAL_NAMES[7] + "ty", 
			ORDINAL_NAMES[8] + "y", 
			ORDINAL_NAMES[9] + "ty", 
		];
		
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
			return (ORDINAL_SUFFIXES[Math.min(val % 10, 4)]);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Prepends a leading '0' to an <code>int</code> if needed 
		 * @param float the <code>int</code> to use
		 * @return 
		 * 
		 */	
		public static function formatDbl(val:int):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// add leading zero if smaller than ten
			if (val < 10)
				return (Strings.prependZeroes(1, val.toString()));
			
			
			return (val.toString());
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
		
		
		public static function toPhrase(val:int):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// worded number
			var phrase_str:String = "";
			
			
			// 0-12, specific name
			if (val <= 12)
				return (NAMES[val]);
			
			// 13-19, teens
			else if (val < 20)
				return (ORDINAL_NAMES[val % 10] + "teen");
			
			// 20-29, use twenty
			else if (val < 30)
				phrase_str = "twenty";
			
			// 30-90, use ordinal prefix w/ 'ty'
			else
				phrase_str = ORDINAL_NAMES[(val / 10) << 0] + "ty";
			
			
			// add one's value
			if (val % 10 != 0)
				phrase_str += "-" + NAMES[val % 10];
			
			
			return (phrase_str);				
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