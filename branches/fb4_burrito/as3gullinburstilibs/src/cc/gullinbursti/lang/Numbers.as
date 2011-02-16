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
	public class Numbers {
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
		public static function decimalPrecision(float:Number, places:int=2):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Number(float.toFixed(places)));
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
		
		
		public static function extendDecimal(float:Number, places:int):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (float.toFixed(places));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isBetween(val:Number, lower:Number, upper:Number, isInclusive:Boolean=true):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// include bounds
			if (isInclusive)
				return (val >= lower && val <= upper);
			
			// 
			return (val > lower && val < upper);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function decimalCount(float:Number):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			return (String(float).split(".")[1].length);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function wholeDigitCount(float:Number):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (String(float).split(".")[0].length);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
				
		public static function stripUpperDigits(float:Number, place:int):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var exp:int = BasicMath.powr10(place);
			var int_str:String = String(float).split(".")[0];
			
			if (int_str.length > String(exp).length)
				return (Number(int_str.substring(int_str.length - String(exp).length)) + decimalPlace(float));
			
			return (float);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function integerPlace(float:Number, position:int=0, isSigned:Boolean=false):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// multipliers
			var exp:int;
			var fract:Number;
			
			// values
			var whole:int = dropDecimal(float);
			var places:int = wholeDigitCount(float);
			var digit:int = whole;
			var sub:int = whole;
			var sum:Number = 0;
			
			
			// special case-- position zero or larger than digits
			if (position == 0 || position > places)
				return (whole);
			
			// dec for string iterate
			position--;
			
			
			// loop from the top (biggest digit 1st)
			var i:int = places;
			while (i-- && i != position) {
				
				// upd multipliers
				exp = BasicMath.powr10(i);
				fract = 1 / BasicMath.powr10(i);
				
				//if (i != position) {
					
					// inc the running total & drop off the inc
					sum += dropDecimal(sub * fract) * exp;
					sub = whole - sum;
					//trace ("<"+i+"> sum:["+sum+"] sub:["+sub+"] ["+exp+"] ["+fract+"]");
					
				/*} else {
					digit = dropDecimal(sub * fract);
					sub = dropDecimal(digit * exp);
					
					trace ("<"+i+"> ::SKIPPED::: digit:["+digit+"] // sub:["+sub+"] ["+exp+"] ["+fract+"]");
				}*/
			}
			
			// get the single digit & actual val
			digit = dropDecimal(sub * 1 / BasicMath.powr10(position));
			sub = dropDecimal(digit * BasicMath.powr10(position));
			
			//trace ("<"+i+"> ::EXITED::: digit:["+digit+"] // sub:["+sub+"] ["+BasicMath.powr10(position)+"] ["+(1 / BasicMath.powr10(position))+"]");
			
			
			// apply ±
			if (!isSigned)
				return (Math.abs(digit));
			
			
			return (digit);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * (Υ Φ Ψ Ϟ α β γ δ λ φ ψ ϕ ϸ = 0) (<code>Υ Φ Ψ Ϟ α β γ δ λ φ ψ ϕ ϸ = 0</code>) 
		 * @param float
		 * @param position
		 * @param isSigned
		 * @return 
		 * 
		 */		
		public static function decimalPlace(float:Number, position:int=0, isSigned:Boolean=false):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// move decimal pt over by 10^
			var exp:int = BasicMath.powr10(position);
			
			// strip out just the decimal val
			var decimal:Number = decimalPrecision(float - dropDecimal(float), decimalCount(float));
			
			// calc the val of decimal at position
			var digit:Number = dropDecimal(decimal * exp) - (dropDecimal(decimal * (exp * 0.1)) * 10);
			
			
			// special case, return full decimal
			if (position == 0)
				digit = decimal;
			
			
			// take ± in account
			if (!isSigned)
				return (Math.abs(digit));
			
			
			return (digit);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function additiveIdent(float:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * Additive identity of a number states:
			 * 
			 *  γ + ϕ = γ 
			 *  
			 **/
			
			// 
			return (float - float);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the opposite of a <code>Number</code> (<code>⁺γ + ⁻γ = 0</code>). 
		 * @param float The input <code>Number</code> to convert.
		 * @return The inverse (negated) value.
		 * 
		 */
		public static function additiveInverse(float:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * Inverse element of a number states:
			 * 
			 *  ⁺γ + ⁻γ = 0 
			 *  
			 **/
			
			// the val multiplied by ¯1
			return (float * -1);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the multiplicative inverse of a <code>Number</code>. (ᵠ⁄₁ · ¹⁄ᵩ = ¹⁄₁).
		 * @param float A <code>Number</code> to reciprocate.
		 * @return The inverse value of a <code>Number</code>.
		 * 
		 */		
		public static function reciprocal(float:Number):Number {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * Multiplicative inverse function states:
			 * 
			 *  ¹⁄ᵪ · ˣ⁄₁ = ¹⁄₁ 
			 * Where χ is a non-zero number.
			 * 
			 **/
			
			// zero has unique quasi-inverse
			if (float == 0)
				return (0);
			
			return (1 / float);
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
		
		
		
		public static function isInt(float:Number):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			return ((Numbers.dropDecimal(float) - float) == 0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Prepends a leading '0' to a <code>Number</code> if needed 
		 * @param float the <code>Number</code> to use
		 * @return 
		 * 
		 */		
		public static function formatDblDigit(float:Number):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			return (Ints.formatDblDigit(float << 0));
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