/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	Combinatorics.as		
 * Version	: 	1.0
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	06-04-09
 * 
 * Purpose	:	Performs various operations concerning combinations.
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


package cc.gullinbursti.math.discrete {
	
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Combinatorics extends BasicMath {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
	
		// <*] class constructor [*>
		public function Combinatorics() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		/**
		 * Calculates unique permutations for a given set 
		 * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		 * <p></p>
		 * 
		 * @param n_items the # of items in the set
		 * @param k_per the # of items per combo
		 * 
		 * @return the unique # of item permutations 
		**/
		public static function permutate(n_items:int, k_per:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			/**
			 *     n!
			 * ----------
			 *   (n-k)!
			**/
			
			return (factorial(n_items) / factorial(n_items - k_per));
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Calculates non-repeating combos
		 * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		 * <p></p>
		 * 
		 * @param n_items the # of items in the set
		 * @param k_per the # of items per combo
		 * 
		 * @return the total possible combos
		**/
		public static function combinate(n_items:int, k_per:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			/**
			 *      n!
			 * ------------
			 *   k!(n-k)!
			**/
			
			// # of items in combo is zero or greater & not greater than total items
			if (k_per >= 0 && k_per <= n_items)
				return (factorial(n_items) / (factorial(k_per) * (factorial(n_items-k_per))));
			
			// return 0 combos
			else
				return (0);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Calculates all combos
		 * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		 * <p></p>
		 * 
		 * @param n_items the # of items in the set
		 * 
		 * @return the total possible combos, w/ repeats
		**/
		public static function combinateAll(n_items:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			/**
			 *   2 ^ n
			**/
			
			return (Math.pow(2, n_items));
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Calculates permutations on combos
		 * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		 * <p></p>
		 * 
		 * @param n_items the # of items in the set
		 * @param k_per the # of items per combo
		 * 
		 * @return the total permutations of combos
		**/
		public static function permutateCombos(n_items:int, k_per:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			/**
			 *      n!
			 * ------------ * k!
			 *   k!(n-k)!
			**/
			
			return (combinate(n_items, k_per) * factorial(k_per));
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Calculates all permutations on all combos
		 * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		 * <p></p>
		 * 
		 * @param n_items the # of items in the set
		 * @param k_per the # of items per combo
		 * 
		 * @return the total possible permutations of all combos
		**/
		public static function permutateAllCombos(n_items:int, k_per:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			/**
			 *     n!
			 * ----------
			 *   (n-k)!
			**/
			
			var tot:int = 0;
			
			for (var i:int=0; i<n_items; i++)
				tot += permutateCombos(n_items, i);
			
			return (tot);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}