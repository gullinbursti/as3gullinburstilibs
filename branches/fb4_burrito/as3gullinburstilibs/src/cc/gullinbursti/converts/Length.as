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


package cc.gullinbursti.converts {
	
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
		//TODO: define & implement some add'l length conversions
		
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
		
		
		// m = yd * 0.9144
		public static function yardsToMeters(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 0.9144);	
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
		public static function statuteToKilometers(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 1.609343999999998);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// mi = km * 0.6213711922373346
		public static function kilometersToStatute(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 0.6213711922373346);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//lat = mi * 69.125 
		public static function statuteToLatitude(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 69.125);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//lat = mi * 69.125 
		public static function nauticalToLatitude(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (statuteToLatitude(nauticalToStatute(len)));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//lat = mi * (1/69.125) 
		public static function latitudeToStatute(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 0.014466546112116);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//lat = mi * 69.125 
		public static function latitudeToNautical(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (statuteToNautical(latitudeToStatute(len)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// nautical mi = statute mi * 0.868976241900648 
		public static function statuteToNautical(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 0.868976241900648);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// statute mi = nautical mi * 1.150779448023542 
		public static function nauticalToStatute(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 1.150779448023542);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// statute mi = AU * 92955810 
		public static function astroUnitsToStatute(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 92955810);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// statute mi = ly * 5878625000000 
		public static function lightYrsToStatute(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 5878625000000);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// statute mi = pc * 19169300000000 
		public static function parsecsToStatute(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 19169300000000);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// nautical mi = (km * 0.6213711922373346) * 1.150779
		public static function kilometersToNautical(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (statuteToNautical(kilometersToStatute(len)));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// km = (nautical mi * 1.1) * 1.8519999999999972 
		public static function nauticalToKilometers(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (statuteToKilometers(nauticalToStatute(len)));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// km = AU * 149597900 
		public static function astroUnitsToKilometers(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 149597900);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// km = ly * 9460730000000 
		public static function lightYrsToKilometers(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 9460730000000);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// km = pc * 30850000000000 
		public static function parsecsToKilometers(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 30850000000000);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// AU = km * 0.000000006684587 
		public static function kilometersToAstroUnits(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 0.000000006684587);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// AU = mi * 0.0000000107578 
		public static function milesToAstroUnits(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 0.0000000107578);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// AU = ly * 63241.08 
		public static function lightYrsToAstroUnits(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 63241.08);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// AU = pc * 206219.5
		public static function parsecsToAstroUnits(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 206219.5);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// ly = pc * 3.260848
		public static function parsecsToLightYrs(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 3.260848);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// pc = ly * 0.3066687 
		public static function lightYrsToParsecs(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (len * 0.3066687);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}