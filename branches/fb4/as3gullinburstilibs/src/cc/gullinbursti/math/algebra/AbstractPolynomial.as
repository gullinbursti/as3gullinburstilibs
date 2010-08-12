/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	AbstractPolynomial.as		
 * Version	: 	1.0
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	12-19-09
 * 
 * Purpose	:	Serves as a base class for polynomials
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
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class AbstractPolynomial extends BasicAlgebra {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		//TODO: define & implement some abstract polynomial operations
		
		public function AbstractPolynomial() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		protected static function completeTheSquare(a:Number, b:Number, c:Number):PolynomialVO {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * Definition: 
			 * aϰ² + bϰ + c = a(ϰ - h)² + k
			 * 
			 */
			 
			// return as a new PolyVO
			return (new PolynomialVO(a, b, c, -hVal(a, b, c), kVal(a, b, c)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function hVal(a:Number, b:Number, c:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * 
			 *      ⎛ 1b ⎞
			 * h = ⁻⎜————⎟
			 *      ⎝ 2a ⎠
			 * 
			 */
			
			// return the calc'd h-value
			return (-(b / (2 * a)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function kVal(a:Number, b:Number, c:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * 
			 *        ⎛ b² ⎞
			 * k = c -⎜————⎜
			 *        ⎝ 4a ⎠
			 * 
			 */
			
			// return the calc'ed k-value
			return (c - (BasicMath.square(b) / (4 * a)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}