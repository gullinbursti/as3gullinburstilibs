/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	QuadraticFormula.as		
 * Version	: 	1.0
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	12-19-09
 * 
 * Purpose	:	Performs operations on a given quadratic formula
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



package cc.gullinbursti.math.algebra {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class QuadraticFormula extends QuadraticEquation {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		//TODO: define & implement some add'l quadratic formula operations
		
		/**
		 *            ________
		 *      -b ± √b² - 4ac
		 * ϰ = —————————————————
		 *           2a
		 */
		// <*] class constructor [*>
		public function QuadraticFormula() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		/**
		 * Accepts a, b, & c values of a quadratic eq and returns
		 * the value under the radical (Δ).
		 * 
		 * @param a
		 * @param b
		 * @param c
		 * 
		 * @return Number 
		 */
		public static function discriminant(a:Number, b:Number, c:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			/**
			 * Δ = b² - 4ac
			 * 
			 */
		
			return ((BasicMath.square(b)) - (4 * a * c));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Accepts a, b, & c values of a quadratic eq and returns
		 * roots of the equasion. If the discriminant happens to
		 * be a perfect square, the roots are rational, otherwise
		 * the roots are quadratic irrationals.
		 * 
		 * @param a
		 * @param b
		 * @param c
		 * 
		 * @return QuadPolynomialVO 
		 */
		public static function roots(a:Number, b:Number, c:Number):QuadPolynomialVO {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 *                   _
		 	 *             -b + √Δ
		 	 * 1st root = ——————————
		 	 *                2a
		 	 * 
		 	 *                   _
		 	 *             -b - √Δ
		 	 * 2nd root = ——————————
		 	 *                2a
		 	 */ 
			
			
			// point to hold the two possible roots
			var roots:Point = new Point();
			
			// discriminant is < zero, two imaginary roots
			if (discriminant(a, b, c) < 0) {
				
				// solve as if discriminant were positive
				roots.x = -b + (BasicMath.root(-discriminant(a, b, c)) / (2 * a));
				roots.y = -b - (BasicMath.root(-discriminant(a, b, c)) / (2 * a));
				
				// include h-value w/ results (-b / 2a)
				return (new QuadPolynomialVO(a, b, c, AbstractPolynomial.hVal(a, b, c), 0, discriminant(a, b, c), roots, false));
				
			// discriminant is zero, one real root (dbl root)
			} else if (discriminant(a, b, c) == 0) {
				roots.x = -b / (2 * a);
				roots.y = -b / (2 * a);
			
			// discriminant is > zero, two real roots
			} else {
				roots.x = (-b + BasicMath.root(discriminant(a, b, c))) / (2 * a);
				roots.y = (-b - BasicMath.root(discriminant(a, b, c))) / (2 * a);
			}
			
				
			
			// return as a QuadPolynomialVO
			return (new QuadPolynomialVO(a, b, c, 0, 0, discriminant(a, b, c), roots));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}