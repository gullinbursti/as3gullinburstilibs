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


package cc.gullinbursti.lang {
	
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
		
		public static const MALE_NAMES:Array = new Array(
			"Arthur", 
			"Ty", 
			"Nick", 
			"Brian", 
			"Lucian", 
			"Alex", 
			"John", 
			"Adrian", 
			"Alexander", 
			"Dino", 
			"Luigi", 
			"George", 
			"William", 
			"Jimmy", 
			"Charles", 
			"Kenny", 
			"Victor", 
			"Ron", 
			"Keith", 
			"Don", 
			"Ron", 
			"Edward", 
			"Michael", 
			"Tim", 
			"Tom", 
			"David"
		);
		
		public static const FEMALE_NAMES:Array = new Array(
			"Kay", 
			"Leppy", 
			"Nora", 
			"Abigail", 
			"Audrey", 
			"Fiona", 
			"Daisy", 
			"Diedre", 
			"Iris"
		);
		
		public static const LAST_NAMES:Array = new Array("Sludge", 
			"Gunrun", 
			"Lei", 
			"Stokes", 
			"Yault", 
			"Tessler", 
			"Facotti", 
			"Wilson", 
			"Gumby", 
			"Luss", 
			"Uncton", 
			"Entropy", 
			"Biggles", 
			'Savage', 
			'Shabby', 
			'Pewty', 
			'Scribbler', 
			'Frampton', 
			'Aldridge', 
			'Lewis', 
			'Higgins', 
			'Bumble', 
			'Apricot', 
			'Peach', 
			'Thatcher', 
			'Thomas', 
			'Lemming'
		);
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
		
		
		public static function isContaining(in_str:String, char_str:String):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// index of the character(s)
			var char_ind:int = in_str.indexOf(char_str);
			
			// return false if not found
			if (char_ind == -1)
				return (false);
			
			// has an index
			return (true);
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
		
		
		
		public static function afterFirst(in_str:String, char_str:String):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			
			// return empty string if not found
			if (!isContaining(in_str, char_str))
				return ("");
			
			
			// return all chars after
			return (in_str.substr(in_str.indexOf(char_str) + char_str.length));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function afterLast(in_str:String, char_str:String):String {
			
			// return empty string if not found
			if (!isContaining(in_str, char_str))
				return ("");
			
			
			// return all chars after
			return (in_str.substr(in_str.lastIndexOf(char_str) + char_str.length));
		}
		
		
		public static function beforeFirst(in_str:String, char_str:String):String {
			
			
			// return empty string if not found
			if (!isContaining(in_str, char_str))
				return ("");
			
			
			// return all chars prior
			return (in_str.substr(0, in_str.indexOf(char_str)));
		}
		
		
		public static function isStartingWith(in_str:String, char_str:String):Boolean {
			
			return (in_str.indexOf(char_str) == 0);
		}
		
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
		
		
		public static function genRndASCII(amt:int=0, isMultiCased:Boolean=true, isSpaces:Boolean=false):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			
			// return string
			var concat_str:String = "";
			
			// character bank
			var char_arr:Array = new Array();
			var len:int = LATIN_STD_CHARS.length*int(isMultiCased+1);
				
			// prime the char array w/ letters
			for (i=0; i<len; i++) {
				
				// upper case
				if (i < LATIN_STD_CHARS.length)
					char_arr.push(LATIN_STD_CHARS[i][0][0]);
				
				// lower case, bring index back to 0
				else
					char_arr.push(LATIN_STD_CHARS[i-LATIN_STD_CHARS.length][1][0]);
			}
			
			
			// allow spaces
			if (isSpaces)
				char_arr.push(ASCII_CTRLS[ASCII_CTRLS.length-1][0][0]);
			
			
			// randomize amount
			if (amt <= 0)
				amt = Randomness.generateInt(4, 32);
			
			
			// loop thru amount to generate
			for (var i:int=0; i<amt; i++) {
				
				// pick a random char & append
				concat_str += char_arr[Arrays.rndIndex(char_arr)];
			}
			
			
			return (concat_str);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Generates a random name 
		 * @param gender 0:rnd / 1:male / 2:female
		 * @param hasSurName include the last name
		 * @return a random name
		 * 
		 */		
		public static function nameBank(gender:int=0, hasSurName:Boolean=false):String {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var fName_str:String = "";
			var lName_str:String = "";
			var genderFlip:Boolean = Randomness.coinFlip();
			
			var rndBoy_str:String = MALE_NAMES[Arrays.rndIndex(MALE_NAMES)];
			var rndGirl_str:String = FEMALE_NAMES[Arrays.rndIndex(FEMALE_NAMES)];
			
			// male or female
			switch (gender) {
				
				// heads for male - tails for female
				case 0:
					
					if (Randomness.coinFlip())
						fName_str = rndBoy_str;
					
					else
						fName_str = rndGirl_str;
					
					break;
				
				// male
				case 1:
					fName_str = rndBoy_str;
					break;
				
				// female
				case 2:
					fName_str = rndGirl_str;
					break;
			}
			
			
			lName_str = LAST_NAMES[Arrays.rndIndex(LAST_NAMES)];
			
			return (fName_str + " " + lName_str);
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