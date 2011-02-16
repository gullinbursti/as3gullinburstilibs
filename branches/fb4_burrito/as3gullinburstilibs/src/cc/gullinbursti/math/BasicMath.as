/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	math.BasicMath.as		
 * Version	: 	1.0
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	12-18-09
 * 
 * Purpose	:	Top-lvl class providing basic math operations & also is 
 * 				inherited by descendants belonging to the “cc.gullinbursti.math” package.
 * 
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~·¯
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~·¯
**/


/*
Licensed under the MIT License
Copyright (c) 2009 Matt Holcombe (matt@gullinbursti.cc)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHOR OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

http://code.gullinbursti.cc/
http://en.wikipedia.org/wiki/MIT_license/

[]~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~[].
*/


package cc.gullinbursti.math {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.lang.Bits;
	import cc.gullinbursti.lang.Numbers;
	import cc.gullinbursti.math.discrete.Factorization;
	import cc.gullinbursti.math.settheory.BasicSetTheory;
	
	import flash.geom.Point;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 
	// <[!] class delaration [¡]>
	public class BasicMath {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		// TODO: http://en.wikipedia.org/wiki/Multiplicative_group_of_integers_modulo_n
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		protected static const MAX_RADIX:int = 174;
		protected static const DIGITS:Array = new Array(
					"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", 
					"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", 
					"K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", 
					"U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", 
					"e", "f", "g", "h", "i", "j", "k", "l", "m", "n", 
					"o", "p", "q", "r", "s", "t", "u", "v", "w", "x", 
					"y", "z", "!", "#", "$", "%", "&", "(", ")", "*", 
					"+", ",", "-", ".", "/", ":", ";", "<", "=", ">", 
					"?", "@", "[", "^", "_", "`", "{", "|", "}", "~", 
					"À", "Á", "Â", "Ã", "Ä", "Å", "Ç", "È", "É", "Ê", 
					"Ë", "Ì", "Í", "Î", "Ï", "Ñ", "Ò", "Ó", "Ô", "Õ", 
					"Ö", "Ø", "Ù", "Ú", "Û", "Ü", "à", "á", "â", "ã", 
					"ä", "å", "ç", "è", "é", "ê", "ë", "ì", "í", "î", 
					"ï", "ñ", "ò", "ó", "ô", "õ", "ö", "ø", "ù", "ú", 
					"û", "ü", "¡", "¢", "£", "¤", "¥", "¦", "§", "°", 
					"´", "¿", "Ξ", "Δ", "Φ", "Γ", "Λ", "Π", "Θ", "Σ", 
					"Ω", "Ψ", "α", "β", "δ", "ε", "φ", "γ", "λ", "μ", 
					"π", "θ", "ρ", "ψ");
					
		
		// φ ≈ 1.6.180339887
		public static const GOLDEN_RATIO:Number = (1 + BasicMath.root(5)) / 2;
		
		// = 2√2
		public static const GELFOND_SCHNEIDER:Number = 2 * root(2); 
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		// <*] class constructor [*>
		public function BasicMath() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		public static function isDivisible(dividend:Number, divisor:Number):Boolean { //, isSelf:Boolean):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			// no remainder, it's divisible
			if (dividend % divisor == 0)
				return (true);
			
			// there's a remainder
			else
				return (false);	
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isMultiple(val:Number, multiplier:Number, isSelf:Boolean=true):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// allow self compare
			if (isSelf)
				return (BasicMath.isDivisible(val, multiplier));//, isSelf));
				
			else {
				// two values are different
				if (val != multiplier)
					return (BasicMath.isDivisible(val, multiplier));//, isSelf));
				
				else
					return (false);
			}
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function divisors(val:Number, isOne:Boolean=false, isSelf:Boolean=false):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// range of values to test against
			var range_pt:Point= new Point(1, BasicMath.half(val));
			
			// return array of divisors
			var div_arr:Array = new Array();
			
			// not including 1, start w/ next divisor
			if (!isOne) {
				
				// generate a set of prime #'s 2 - ½val
				var prime_arr:Array = BasicSetTheory.primes(range_pt.y);
				var prime_ind:int; 
				
				// loop thru the primes
				for (i=0; i<=prime_arr.length; i++) {
					
					// found a divisor, stop loop
					if (isDivisible(val, prime_arr[i])) {
						prime_ind = i;
						break;
					}
				}
				 
				// set smallest divisor to found prime
				range_pt.x = prime_arr[prime_ind];
			}
			
			// loop thru # range
			for (var i:int=range_pt.x; i<=range_pt.y; i++) {
				
				// the value is divisible, push into array
				if (BasicMath.isDivisible(val, i))
					div_arr.push(i);
			}
			
			
			// include the value, add to array
			if (isSelf)
				div_arr.push(val);
			
			// resulting divisors
			return (div_arr);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function smallestDivisor(val:Number, isOne:Boolean=false, isSelf:Boolean=true):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (BasicMath.divisors(val, isOne, isSelf).shift());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function isApproxEqual(val1:Number, val2:Number, places:int=5):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var diff:Number = Math.abs(val1 - val2);
			var range:Number = 1 / Math.pow(10, places);
			
			return (diff < range);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isInt(val:Number):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// value 
			if (val % Math.abs(Numbers.chopDecimal(val)) == 0)
				return (true);
				
			else
				return (false);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isEven(val:Number):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// value is divisible by two
			if (val % 2 == 0)
				return (true);
				
			else
				return (false);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function isPrime(val:Number):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// not an integer, not prime
			if (!BasicMath.isInt(val))
				return (false);
			
			// check for divisors
			else {
				
				// #'s 3 & less are prime
				if (val <= 3)
					return (true);
				
				// none excluding 1 & the value
				if (BasicMath.divisors(val).length == 0)
					return (true);
				
				else
					return (false);
			}
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isMersennePrime(val:int, isStrict:Boolean=true):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!BasicMath.isPrime(val) && isStrict)
				return (false);
			
			else 
				return (BasicMath.isPrime(Math.pow(2, val) - 1));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function mersennePrime(val:int, isStrict:Boolean=true):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!BasicMath.isPrime(val) && isStrict)
				return (0);
				
			else 
				return (Math.pow(2, val) - 1);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function wagstaffPrime(val:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!BasicMath.isPrime(val))
				return (0);
				
			else 
				return (Math.pow(2, val) / 3);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function isWieferichPrime(val:int):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!isPrime(val))
				return (false);
			
			return (Math.pow(22, val - 1) - 1 % square(val) == 0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isWilsonPrime(val:int):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!isPrime(val))
				return (false);
			
			return (Math.pow(22, val + 1) + 1 % square(val) == 0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// [http://en.wikipedia.org/wiki/Wall-Sun-Sun_prime]
		public static function isWallSunSunPrime(val:int):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: Implement Wall-Sun-Sun prime test [http://en.wikipedia.org/wiki/Wall-Sun-Sun_prime]
			
			if (!isPrime(val) || val < 5)
				return (false);
			
			var fib:int = val - (0)
			
			return (Math.pow(22, val + 1) + 1 % square(val) == 0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isPerfect(val:int):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// only +ints are perfect #'s
			if (val < 0)
				return (false);
				
			// array of divisors
			var div_arr:Array = BasicMath.divisors(val, true);
			
			
			// sum of the divisors = the original value
			if (BasicMath.summate(div_arr) == val)
				return (true);
				
			else
				return (false);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isSquareful(val:int):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var fact_arr:Array = Factorization.primeFactors(val).factors_arr;
			
			for (var i:int=0; i<fact_arr.length; i++) {
				if (fact_arr[i] == 0)
					return (true);
			}
			
			trace (Factorization.primeFactors(val));
			
			return (false);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isSquare(val:int):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			return ((Numbers.chopDecimal(root(val)) - root(val)) == 0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isCube(val:int):Boolean {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			return ((Numbers.chopDecimal(cube(val)) - cube(val)) == 0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// m = a^2·b^3 (> 0)
		public static function isRational(val:Number):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * 
			 */
			
			
			return (false);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isCoprime(val_arr:Array):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// get the greatest common factor
			var gcf:int = Factorization.gr8CommonFactor(val_arr);
			
			// only common factor is 1, they are coprime
			if (gcf == 1)
				return (true);
				
			else
				return (false);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function half(val:Number, isRounded:Boolean=false, precision:int=0):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// round the result
			if (isRounded)
				return (Numbers.decimalPrecision(val * 0.5, precision));
				
			
			// return 1/2
			return (Bits.rShift(val, 1));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function quarter(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			return (val * 0.25);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
				
		public static function square(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// multiply by itself 2x
			return (val * val);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function cube(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// multiply by itself 3x
			return (val * val * val);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function powr2(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// a exponent of 2
			return (Math.pow(2, val));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function powr10(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// a exponent of 10
			return (Math.pow(10, val));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function e(val:Number, exp:int):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// scientific notation w/ coefficient
			return (val * powr10(exp));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Calculates the ⁿ√ of a value.
		 * @param val A Number
		 * @param root 
		 * @return 
		 * 
		 */
		
		public static function root(val:Number, root:int=2):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// raise to ¹⁄root
			return (Math.pow(val, (1 / root)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function nRoot(val:Number, root:int=2):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// raise to ¹⁄root
			return (Math.pow(val, (1 / root)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function summate(val_arr:Array, isSigned:Boolean=true):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// summation total
			var tot:int = 0;
			
			// loop thru array
			for (var i:int=0; i<val_arr.length; i++) {
				
				// ignoring negative
				if (!isSigned)
					tot += Math.abs(val_arr[i]);
				
				else
					tot += val_arr[i];
			}
				 
				
			return (tot);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function moduloChain(val_arr:Array):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			
			var loop_modo:int = val_arr[0];
			
			
			for (var i:int=0; i<val_arr.length-1; i++) {
				loop_modo = loop_modo % val_arr[i+1];
			}
			
			
			// result modulus
			return (loop_modo);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function factorial(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var i:int;
			var res_num:Number = 1;
			
			// negative #'s
			if (val < 0) {
				
				// loop & multiply
				for (i=val*-1; i>0; i--)
					res_num *= i;
				
				// change sign to (-)
				res_num *= -1;
			
			// positive #'s
			} else if (val > 0) {
				
				// loop & multiply
				for (i=val; i>0; i--)
					res_num *= i;
			} 	
			
			// return resultant factorial
			return (res_num);	
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function changeBase(val:Number, radix:int):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// the running number
			var run_str:String = "";
			var ret_str:String = "";
			
			// radix must be at least binary
			if (radix < 2)
				radix = 2;
			
			// radix is no more than MAX RADIX
			if (radix > MAX_RADIX)
				radix = MAX_RADIX;
					
			// loop thru
			while (val >= radix) {
				run_str += DIGITS[val % radix];
				val = Numbers.chopDecimal(val / radix);
			}
			
			// add last digit
			run_str += DIGITS[val];
			
			// loop thru string & reverse
			for (var i:int=run_str.length; i>=0; i--)
				ret_str += run_str.charAt(i);
			
			// reverse & return
			return (ret_str);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// http://en.wikipedia.org/wiki/Cardinal_number
		// http://en.wikipedia.org/wiki/Ordinal_number
		

	}
}