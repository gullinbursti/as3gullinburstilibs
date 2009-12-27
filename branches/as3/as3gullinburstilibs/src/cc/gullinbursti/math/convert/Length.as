/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	utils.convert.Length.as		
 * Version	: 	1.0
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	12-18-09
 * 
 * Purpose	:	Performs length conversions / operations on 
 * 				SI & English measurements.
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


package cc.gullinbursti.math.convert {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>	
	public class Length {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		// TODO: define & implement some add'l length conversions
		
		// <*] class constructor [*>
		public function Length() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// cm = in * 2.5
		public static function inchesToCentimenters(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 2.5);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// ft = in * 12
		public static function inchesToFeet(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * (1/12));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		// ft = in * 12
		public static function feetToInches(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 12);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		
		
		
		// in = cm * 0.3937
		public static function centimetersToInches(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 0.3937);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// m = ft * 30.480000000000015
		public static function feetToCentimeters(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 30.480000000000015);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// m = ft * 0.3048
		public static function feetToMeters(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 0.3048);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// fathoms = ft * (1/6)
		public static function feetToFathoms(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * (1/6));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// ft = fathoms * 6
		public static function fathomsToFeet(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 6);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// ft = fathoms * 1.8287999999999984
		public static function fathomsToMeters(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 1.8287999999999984);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// m = yd * ???
		public static function yardsToMeters(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 0);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// ft = m * 3.280839895013122
		public static function metersToFeet(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 3.280839895013122);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// yd = m * 1.0936132983377087
		public static function metersToYards(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 1.0936132983377087);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// km = mi * 1.609343999999998
		public static function milesToKilometers(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 1.609343999999998);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// mi = km * 0.6213711922373346
		public static function kilometersToMiles(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 0.6213711922373346);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// nautical mi = statute mi / 1.1 
		public static function statuteToNautical(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len / 1.1);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// statute mi = nautical mi * 1.150779448023542 
		public static function nauticalToStatute(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 1.150779448023542);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// nautical mi = (km * ???) * 1.1
		public static function kilometersToNautical(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (kilometersToMiles(len) * 0);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// km = (nautical mi * 1.1) * 1.8519999999999972 
		public static function nauticalToKilometers(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (nauticalToStatute(len) * 1.8519999999999972);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}