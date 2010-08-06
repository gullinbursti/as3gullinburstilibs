/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	math.probility.Random.as		
 * Version	: 	1.0
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	12-19-09
 * 
 * Purpose	:	Produces pseudo-random results
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

package cc.gullinbursti.math.probility {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.lang.Numbers;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Randomness extends Numbers {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		// TODO: implement some more add'l random generation techniques
		
		public function Randomness() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		/**
		 * Generates a random <code>int</code>   
		 * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		 * @param lower the smallest possible #
		 * @param upper the highest possible #
		 * 
		 * @return a random <code>int</code> from <code>lower</code> to <code>upper</code>
		 **/
		public static function generateInt(lower:Number, upper:Number):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// remove decimal from floating pt #
			return (Numbers.dropDecimal(generateFloat(lower, upper+1)));
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function generateFloat(lower:Number=0, upper:Number=1, precision:int=2):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// range of values
			var range:Number = upper - lower;
			
			// pick a rnd #
			var rnd:Number = (Math.random() * range) + lower;
			
			// set # of decimals
			rnd = Numbers.setPrecision(rnd, precision);
			
			// rnd floating pt #
			return (rnd);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// http://en.wikipedia.org/wiki/Park%E2%80%93Miller_random_number_generator
		public static function generateLehmer(lower:Number, upper:Number):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var range:Number = (upper - lower) +1;
			var rnd:int = Numbers.dropDecimal((Math.random() * range)+lower); 
			
			return (rnd);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// http://en.wikipedia.org/wiki/Linear_congruential_generator
		public static function generateCongruent(lower:Number, upper:Number):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var range:Number = (upper - lower) +1;
			var rnd:int = Numbers.dropDecimal((Math.random() * range)+lower); 
			
			return (rnd);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// http://en.wikipedia.org/wiki/Inversive_congruential_generator
		public static function generateInvertedCongruent(lower:Number, upper:Number):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var range:Number = (upper - lower) +1;
			var rnd:int = Numbers.dropDecimal((Math.random() * range)+lower); 
			
			return (rnd);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function coinFlip(tries:int=1):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var calc:Number = 0;
			
			// loop # of tries, adding a 0 or 1
			for (var i:int=0; i<tries; i++)
				calc += generateInt(0, 100);
			
			// get the ave
			calc /= tries;
			
			// true if at least 50%
			return (calc >= 50);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function pickBool(prob:Number=0.5):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			return (generateFloat(0, 1, 4) > prob);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function pickSign(prob:Number=0.5):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			if (pickBool(prob))
				return (1);
			
			return (-1);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function pickBit(prob:Number=0.5):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (pickBool(prob))
				return (0x1);
			
			return (0x0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function diceRoller(sides:int=6):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// generate rnd # 1 - sides
			var side:int = generateInt(1, sides);
			
			return (side);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}