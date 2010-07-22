/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	Strings.as		
 * Version	: 	1.0
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	06-04-09
 * 
 * Purpose	:	Performs various operations on Strings.
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


package cc.gullinbursti.utils {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.probility.ListScrambler;
	import cc.gullinbursti.math.probility.Randomness;
	
	import flash.geom.Point;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 
	// <[!] class delaration [¡]>
	public class Strings extends Chars {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const PHONE_FORMAT_1:String = "(###) ###-####";
		public static const PHONE_FORMAT_2:String = "###.###.####";
		public static const PHONE_FORMAT_3:String = "### ###-####";
		public static const PHONE_FORMAT_4:String = "### ### ####";
		
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		// <*] class constructor [*>
		public function Strings() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function isBoolean(val:String):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			if (int(val) == 1 || val.toLowerCase() == "true" || val.toLowerCase() == "t")
				return (true);
				
			else
				return (false);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isEmail(val:String):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var lnAtPos:Number = 0;
			var lnAtSecPos:Number = 0;
			var lnDotPos:Number = 0;
			
			lnAtPos = val.indexOf("@", 1);
			
			if (lnAtPos == 0)
				return (false);
			
			else {
				lnAtSecPos = val.indexOf("@", lnAtPos + 1);
				
				if (lnAtSecPos != -1)
					return (false);
					
				else {
					lnDotPos = val.indexOf(".", lnAtPos + 2);
					
					if (lnDotPos == -1)
						return (false);
					else
						return (true);
				}
			}
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isEmpty(val:String):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			if (val.length == 0)
				return (true);
				
			else
				return (false);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isNumeric(val:String):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (!isNaN(Number(val)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function prependZeroes(ret_len:int, val:int):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var ret_str:String = val.toString();
			var digits:int = 0;
			var amt:int = 0;
			
			var base_cnt:int = 1;
			
			
			if (val < 10)
				digits = 1; 
				
			else if (val < 100)
				digits = 2;
				
			else if (val < 1000)
				digits = 3;
			
			else if (val < 10000)
				digits = 4;
				
			else if (val < 100000)
				digits = 5;
				
			else if (val < 1000000)
				digits = 6;
				
			else if (val < 10000000)
				digits = 7;
				
			else if (val < 100000000)
				digits = 8;
				
			else if (val < 1000000000)
				digits = 9;
				
			amt = ret_len - digits;
			
			if (amt > 0) {
				for (var i:int=0; i<amt; i++)
					ret_str = "0" + ret_str;
			}
			
			return (ret_str);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function genRndASCII(len:int, isMultiCased:Boolean=true, asciiRange:Point=null):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// no ascii range specified, use 'A' - 'Z'
			if (!asciiRange)
				asciiRange = new Point(65, 90);
			
			// return string
			var concat_str:String = "";
			
			// coin flip for case
			if (isMultiCased && Randomness.coinFlip())
				
			// loop thru & picking rand chars
			for (var i:int=0; i<len; i++) {
				var rnd_char:String = String.fromCharCode(Randomness.generateInt(asciiRange.x, asciiRange.y));
				
				// upper + lower case
				if (isMultiCased && asciiRange.x == 65 && asciiRange.y == 90)
					rnd_char += int(Randomness.pickBit()) * 32;
					
				// append
				concat_str += rnd_char;
			}
			
			
			return (concat_str);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isPhone(val:String, frmt:String):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var isValid:Boolean = false;
		
			switch (frmt) {
				case PHONE_FORMAT_1:
					if (val.charAt(0) == "(" && val.charAt(4) == ")" && val.charAt(5) == " " && val.charAt(9) == "-" && isNumeric(val.substr(1, 3)) && isNumeric(val.substr(6, 3)) && isNumeric(val.substr(10, 4)))
						isValid = true;
					
					break;
					
				case PHONE_FORMAT_2:
					if (val.charAt(3) == "." && val.charAt(7) == "." && isNumeric(val.substr(0, 3)) && isNumeric(val.substr(4, 3)) && isNumeric(val.substr(8, 4)))
						isValid = true;
					
					break;
					
				case PHONE_FORMAT_3:
					if (val.charAt(3) == " " && val.charAt(7) == "-" && isNumeric(val.substr(0, 3)) && isNumeric(val.substr(4, 3)) && isNumeric(val.substr(8, 4)))
						isValid = true;
						
					break;
				
				case PHONE_FORMAT_4:
					if (val.charAt(3) == " " && val.charAt(7) == " " && isNumeric(val.substr(0, 3)) && isNumeric(val.substr(4, 3)) && isNumeric(val.substr(8, 4)))
						isValid = true;
					break;
				
				default:
					if (isNumeric(val))
						isValid = true;
					break;
			}
			
			return (isValid);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function toArray(val:String):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var char_arr:Array = new Array();
			
			// push string chars into array
			for (var i:int=0; i<val.length; i++)
				char_arr.push(val.charAt(i));
				
			return (char_arr);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function scramble(val:String):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var new_arr:Array = new Array();
			var char_arr:Array = toArray(val);
			var rnd_str:String = "";
			
			// randomize the array
			new_arr = ListScrambler.randomizeArray(char_arr);
			
			// reconstruct the string from array
			for (var i:int=0; i<val.length; i++)
				rnd_str += new_arr[i];
			
			return (rnd_str);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function toProperNoun(val:String):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var ret_str:String = val.charAt(0).toUpperCase();
		
			for (var i:int=0; i<val.length; i++)
				ret_str += val.charAt(i).toLowerCase();
			
			return (ret_str);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
	
		public static function findNReplace(src_str:String, find_str:String, replace_str:String, isAll:Boolean=true):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var new_str:String = "";
			var str_arr:Array = src_str.split(find_str);
			var occ_num:Number = str_arr.length;
			var rep_num:Number = 0;
				
			for (var i:Number=0; i<occ_num; i++) {
				new_str += str_arr[i];
				rep_num++;
				
				if (i < occ_num - 1) {
					if (isAll || (!isAll && rep_num == 1))
						new_str += replace_str;
						
					if (!isAll && (rep_num > 1))
						new_str += find_str;
				}
			}
			
			return (new_str);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function reverse(val:String):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// return string
			var rev_str:String = "";
			
			// loop thru string…
			for (var i:int=val.length; i>=0; i--)
				rev_str += val.charAt(i);
			
			// return result
			return (rev_str);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function htmlLink(link_str:String, href:String, target:String="_blank"):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			return("<a href='"+href+"' target='"+target+"'>"+link_str+"</a>");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function parseToHTML(src_str:String, html_arr:Array):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var tmp_str:String;
			var html_str:String = src_str;
			
			var s_ind:int = -1;
			var e_ind:int = -1;
			
			// loop thru html tags to build
			for (var j:int=0; j<html_arr.length; j++){
				
				// pull each element as an obj
				var tag_obj:Object = html_arr[j] as Object;
				
				// test the 'tag' param
				switch (tag_obj['tag']) {
					
					// anchor tag
					case "a":
						
						s_ind = src_str.indexOf("http://");
						
						if (s_ind == -1)
							s_ind = src_str.indexOf("www.");
							
						
						if (s_ind > -1) {
							e_ind = src_str.indexOf(" ", s_ind);
							
							var ret_ind:int = src_str.indexOf("\n", s_ind);
							
							//if (ret_ind < e_ind)
							//	e_ind = ret_ind;
							
							// no space, try <FONT>
							if (e_ind == -1)
								e_ind = src_str.indexOf("</FONT>", s_ind);
							
							// no <FONT>, go to the end
							if (e_ind == -1)
								e_ind = src_str.length;
								
							if (e_ind > -1) {
								tmp_str = src_str.substring(s_ind, e_ind);
								
								// build into html
								html_str = findNReplace(src_str, tmp_str, "<a href='"+tmp_str+"' target='"+tag_obj['trg']+"'>"+tmp_str+"</a>");
							}
						}
						
						break;
				}
			}
			
			return(html_str);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function trim(in_str:String):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (lTrim(rTrim(in_str)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function lTrim(in_str:String):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			var i:int = 0;
			
			while ((i< in_str.length) && (in_str.substr(i, 1) == " ")) 
				i++;
			
			
			return (in_str.substr(i, in_str.length - i));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function rTrim(in_str:String):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			var i:int = in_str.length - 1;
			
			while ((i > 0) && (in_str.substr(i, 1) == " "))
				i--;
			
			
			return (in_str.substr(0, i + 1));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}