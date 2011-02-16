/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	Randomness.as
 * Package	:	math.probility
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	12-19-09
 * 
 * Purpose	:	Produces pseudo-random results using various methods.
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
	import cc.gullinbursti.lang.DateTimes;
	import cc.gullinbursti.lang.Numbers;
	
	import flash.utils.getTimer;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Randomness extends Numbers {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		//TODO: implement some more add'l random generation techniques
		// http://www.mathcom.com/corpdir/techinfo.mdir/q210.html
		
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		private static const MODULUS:int = 2147483647; // (2³²) * 0.5
		private static const MULTIPLIER:int = 48271;
		
		private static const VERIFIER:int = 399268537;
		private static const JUMP_MULT:int = 22925;
		private static const STREAMS_TOT:int = 0xff;
		private static const SEED_STD:int = 123456789;
		
		
		// static vars
		private static var seed_arr:Array = new Array(); 	//[STREAMS_TOT] = {SEED_STD};  /* current state of each stream   */
		private static var stream_ind:int = 0;				/* stream index, 0 is the default */
		private static var isInit:Boolean = false;			/* test for stream initialization */
		
		
		private static const MT:Vector.<int> = new Vector.<int>(624);
		private static var _seed:int;
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		
		// <*] class constructor [*>
		public function Randomness() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		/**
		 * Performs a coin flip simulation. 
		 * @param tries The # of times to flip
		 * @return A boolean <code>true</code> for heads, <code>false</code> for tails. 
		 * 
		 */		
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
		
		
		
		/**
		 * Generates a random <code>int</code> w/in a given range.
		 * @param lower the smallest possible #
		 * @param upper the highest possible #
		 * 
		 * @return a random <code>int</code> from <code>lower</code> to <code>upper</code>
		 **/
		public static function generateInt(lower:Number=0, upper:Number=100):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			lower = Math.min(lower, upper);
			upper = Math.max(lower, upper);
			
			if (lower == upper)
				return (lower);
				
			return (Numbers.dropDecimal(generateFloat(lower, upper+1)));
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Generates a random floating pt number w/in a given range. 
		 * @param lower The smallest possible value.
		 * @param upper The biggest possible value.
		 * @param precision The # of decimals after the decimal place.
		 * @return A floating point number from <code>lower</code> to <code>upper</code>.
		 * 
		 */		
		public static function generateFloat(lower:Number=0, upper:Number=1, precision:int=5):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// range of values
			var range:Number = upper - lower;
			
			// pick a rnd #
			//var rnd:Number = (generateLehmer() * range) + lower;
			var rnd:Number = (Math.random() * range) + lower;
			
			
			// set # of decimals
			if (precision != Number.MAX_VALUE)
				return (Numbers.decimalPrecision(rnd, precision));
			
			// rnd floating pt #
			return (rnd);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Uses Park-Miller (Lehmer) generation to pick a random # from 0 to 1.
		 * @return A <code>Number</code> between 0 and 1.
		 * 
		 */		
		public static function generateLehmer():Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// shortcut eqs
			var div:int = MODULUS / MULTIPLIER;
			var mod:int = MODULUS % MULTIPLIER;
			
			var seed:int = Numbers.dropDecimal(Numbers.stripUpperDigits(DateTimes.asUnixEpoch(null, true) * 1000, 9));
			
			// formula
			//var val:int = MULTIPLIER * (seed_arr[stream_ind] % div) - mod * (seed_arr[stream_ind] / div);
			var val:int = MULTIPLIER * (seed % div) - mod * (seed / div);
			
			
			// calc'd val is positive
			if (val > 0) 
				seed_arr[stream_ind] = val;
			
			// val is negative
			else 
				seed_arr[stream_ind] = val + MODULUS;
			
			
			// lehmer rnd value
			return (seed_arr[stream_ind] / MODULUS);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// http://en.wikipedia.org/wiki/Linear_congruential_generator
		public static function generateCongruent(lower:Number, upper:Number):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			return (0);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// http://en.wikipedia.org/wiki/Inversive_congruential_generator
		public static function generateInvertedCongruent(lower:Number, upper:Number):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			return (0);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Generates a boolean <code>true</code> or <code>false</code>. 
		 * @param prob Likeliness of a boolean <code>true</code>.
		 * @return A boolean <code>true</code> or <code>false</code>.
		 * 
		 */		
		public static function generateBool(prob:Number=0.5):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			return (generateLehmer() > prob);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Generates a positive or negative 1. 
		 * @param prob Likeliness of a +1
		 * @return A <code>uint</code> either -1 or +1
		 * 
		 */		
		public static function generateSign(prob:Number=0.5):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			if (generateBool(prob))
				return (1);
			
			return (-1);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 *  Generates a 0x0 or 0x1 value.
		 * @param prob The likeliness of a 0x1
		 * @return A 0x0 or 0x1
		 * 
		 */		
		public static function generateBit(prob:Number=0.5):uint {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (generateBool(prob))
				return (0x1);
			
			return (0x0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Performs a die roll simulation.
		 * @param sides The total # of sides on the die.
		 * @return The value of the choosen side.
		 * 
		 */		
		public static function diceRoller(sides:int=6):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// generate rnd # 1 - sides
			var side:int = generateInt(1, sides);
			
			return (side);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function mersenneTwister(lower:Number=0, upper:Number=1):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: Implement Mersenne Twister method [http://en.wikipedia.org/wiki/Mersenne_Twister]
			
			var rnd_arr:Array = new Array();
				rnd_arr = [SEED_STD];
				
			
			var i:int; 
			var val:Number;
			var ind:Number = generateInt(0, 622);
			
			
			for (i=1; i<623; i++)
				rnd_arr.push(((0x6C078965 * rnd_arr[i-1]) + 1) & 0xffffffff);
			
			
			
			if (ind >= 623) {
				ind = 0;
				
				for (i=0; i<623; i++) {
					val = 0x80000000 & rnd_arr[i] + 0x7ffffddd & (rnd_arr[(i+1) % 624]);
					rnd_arr[i] = rnd_arr[(i+397) % 624] ^ (val >> 1);
					
					if ((val % 2) != 0)
						rnd_arr[i] ^= 0x9908b0df;
				}
			}
			
			val = rnd_arr[ind++];
			val ^= (val >> 11);
			val ^= (val << 7) & 0x9d2c5680;
			val ^= (val << 15) & 0xefc60000;
			val ^= (val >> 18);
			
			
			return (val);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		private function primeSeedList():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			for (var i:int=0; i<STREAMS_TOT; i++)
				seed_arr.push(SEED_STD);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		/**
		 * Helper function to fill up an array w/ Lehmer #'s ranging from 0 - 1 
		 * @param size The total numbers to generate
		 * @return An <code>Array</code> of Lehmer #'s
		 * 
		 */		
		private function lehmerPool(size:int=100):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// array to hold 0 - 1 vals
			var val_arr:Array = new Array();
			
			// push lehmer rnd numbers
			for (var i:int=0; i<size; i++)
				val_arr.push(generateLehmer());
			
			
			// 0 -1 vals
			return (val_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		private static function initStreams():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			for (var i:int=0; i<STREAMS_TOT; i++)
				seed_arr.push(SEED_STD);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		private static function getSeed(x:int):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			x = seed_arr[stream_ind];
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		private static function plantSeeds(x:int):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			var q:int = MODULUS / JUMP_MULT;
			var r:int = MODULUS % JUMP_MULT;
			var s:int;
			
			isInit = true;
			
			s = stream_ind;
			selectStream(0);
			putSeed(x);
			stream_ind = s;
			
			for (var j:int=1; j<STREAMS_TOT; j++) {
				x = JUMP_MULT * (seed_arr[j - 1] % q) - r * (seed_arr[j - 1] / q);
				
				if (x > 0)
					seed_arr[j] = x;
				else
					seed_arr[j] = x + MODULUS;
			}
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		private static function putSeed(x:int):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (x > 0)
				x = x % MODULUS;
			
			else if (x < 0)                                 
				x = DateTimes.asUnixEpoch() % MODULUS;
			
			else                              
				x = SEED_STD;
		
			seed_arr[stream_ind] = x;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		private static function selectStream(index:int):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			stream_ind = index % STREAMS_TOT;
			
			if (!isInit && stream_ind != 0)
				plantSeeds(SEED_STD);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		private static function test():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var i:int;
			var x:int;
			var u:Number;
			var isValid:Boolean;  
			
			selectStream(0);
			putSeed(1);
			
			for(i = 0; i < 10000; i++)
				u = Math.random();
			
			getSeed(x);
			isValid = (x == VERIFIER);
			
			selectStream(1); 
			plantSeeds(1);
			getSeed(x);
			
			isValid = isValid && (x == JUMP_MULT);    
			
			if (isValid)
				trace("\n The implementation of rngs.c is correct.\n\n");
			
			else
				trace("\n\a ERROR -- the implementation of rngs.c is not correct.\n\n");
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}