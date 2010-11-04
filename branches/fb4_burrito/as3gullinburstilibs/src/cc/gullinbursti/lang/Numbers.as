package cc.gullinbursti.lang {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	/**
	 * @package cc.gullinbursti.lang
	 * @class Numbers
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class Numbers extends Ints {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		private static const MAX_SHIFT:uint = 2147483648;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function Numbers() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		/**
		 * Strips trailing decimal values from a <code>Number</code>.
		 * @param float The input <code>Number</code> to convert.
		 * @param places The # of digits following the decimal point.
		 * @return A <code>Number</code> w/ a set # of decomal places.
		 * 
		 */		
		public static function setPrecision(float:Number, places:int=2):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// get the decimal val of places (1/10^places)
			var fract:Number = 1 / BasicMath.powr10(places);
			
			// the fract < val
			if (fract <= float)
				return (dropDecimal(float / fract) * fract);
			
			else
				return (float);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Strips any decimal places from a <code>Number</code> using a bitwise left shift.
		 * @param float The input <code>Number</code> to convert.
		 * @return An <code>int</code> representation of the floating point value.
		 * 
		 */		
		public static function dropDecimal(float:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// build in floor method
			if (float > MAX_SHIFT || float < -MAX_SHIFT)
				return (Math.floor(float));
			
			if (Math.abs(float) == MAX_SHIFT)
				return (-Bits.lShift(float, 0));
			
			// bitwise left shift
			return (Bits.lShift(float, 0));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Strips any decimal places from a <code>Number</code> using a bitwise left shift.
		 * @param float The input <code>Number</code> to convert.
		 * @return An <code>int</code> representation of the floating point value.
		 * 
		 */		
		public static function stripUpperDigits(float:Number, digits:int):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var float_str:String = String(float);
			var int_str:String = float_str.split(".")[0];
			var dec_str:String = float_str.split(".")[1];
			var tmp_str:String = float_str;
			
			
			if (int_str.length > digits)
				tmp_str = float_str.substring(int_str.length - digits);
			
			return (Number(tmp_str));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Converts a <code>Number</code> to it's inverse. 
		 * @param float The input <code>Number</code> to convert.
		 * @return The inverse (negated) value.
		 * 
		 */
		public static function invert(float:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// the val multiplied by ¯1
			return (float * -1);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function middle(val1:int, val2:int, val3:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if ((val1 > val2) && (val1 > val3)) {
				if (val2 > val3)
					return (val2);
					 
				else
					return (val3);
					
			} else if ((val2 > val1) && (val2 > val3)) {
				
				if (val1 > val3)
					return (val1);
					
				else
					return (val3);
					
			} else if (val1 > val2)
				return (val1);
				
			else
				return (val2);
				
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function limitWrap(val:int, range:Point):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			while (val > range.y) 
				val -= (range.y - range.x);
				
			while (val < range.x) 
				val += (range.y - range.x);
			
			
			return (val);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function toPhrase(float:Number):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			return (Ints.toPhrase(float << 0));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Prepends a leading '0' to a <code>Number</code> if needed 
		 * @param float the <code>Number</code> to use
		 * @return 
		 * 
		 */		
		public static function formatDbl(float:Number):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			return (Ints.formatDbl(float << 0));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the ordinal suffix of a <code>Number</code> (th / st / nd / rd)
		 * @param float The input <code>Number</code> to find suffix for.
		 * @return A <code>String</code> representing the suffix of a <code>Number</code>.
		 * 
		 */		
		public static function ordinalSuffix(float:Number):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// use method from Ints
			return (Ints.ordinalSuffix(dropDecimal(float)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns a <code>Point</code> of two swapped <code>Number</code>s.
		 * @param val1 The 1st <code>Number</code> to swap.
		 * @param val2 The 2nd <code>Number</code> to swap.
		 * @return A <code>Point</code> obj representing two swapped <code>Number</code>s.
		 * 
		 */		
		public static function swap(float1:Number, float2:Number):Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._		
			
			// a point containing the swapped vals
			return (new Point(float2, float1));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}