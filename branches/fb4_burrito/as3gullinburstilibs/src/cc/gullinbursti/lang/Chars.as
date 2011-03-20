package cc.gullinbursti.lang {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Chars {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		
		// [short name, ascii (dec), unicode (bin)], [full name]
		public static const ASCII_CTRLS:Array = new Array(
			[[null,  0, 0x0000], ["NUL",  "NULL"]], 
			[["",    1, 0x0001], ["SOH",  "START OF HEADING"]], 
			[["",    2, 0x0002], ["SOT",  "START OF TEXT"]], 
			[["",    3, 0x0003], ["EOT",  "END OF TEXT"]], 
			[["",    4, 0x0004], ["EOT",  "END OF TRANSMISSION"]], 
			[["",    5, 0x0005], ["ENQ",  "ENQUIRY"]], 
			[["",    6, 0x0006], ["ACK",  "ACKNOWLEDGE"]], 
			[["\b",  7, 0x0007], ["BEL",  "BELL"]],  
			[["",    8, 0x0008], ["BAC",  "BACKSPACE"]], 
			[["\t",  9, 0x0009], ["TAB",  "CHARACTER TABULATION"]], 
			[["",   10, 0x000a], ["LF",  "LINE FEED"]], 
			[["",   11, 0x000b], ["LT",  "LINE TABULATION"]], 
			[["",   12, 0x000c], ["FF",  "FORM FEED"]], 
			[["",   13, 0x000d], ["CR",  "CARRIAGE RETURN"]], 
			[["",   14, 0x000e], ["SHO", "SHIFT OUT"]], 
			[["",   15, 0x000f], ["SHI", "SHIFT IN"]], 
			[["",   16, 0x0010], ["DLE", "DATA LINK ESCAPE"]], 
			[["",   17, 0x0011], ["DC1", "DEVICE CONTROL ONE (XON)"]], 
			[["",   18, 0x0012], ["DC2", "DEVICE CONTROL TWO"]], 
			[["",   19, 0x0013], ["DC3", "DEVICE CONTROL THREE (XOFF)"]], 
			[["",   20, 0x0014], ["DC4", "DEVICE CONTROL FOUR"]], 
			[["",   21, 0x0015], ["NCK", "NEGATIVE ACKNOWLEDGE"]], 
			[["",   22, 0x0016], ["SYN", "SYNCHRONOUS IDLE"]], 
			[["",   23, 0x0017], ["EOB", "END OF TRANSMISSION BLOCK"]], 
			[["",   24, 0x0018], ["CNL", "CANCEL"]], 
			[["",   25, 0x0019], ["EOM", "END OF MEDIUM"]], 
			[["",   26, 0x001a], ["SUB", "SUBSTITUTE"]], 
			[["\e", 27, 0x001b], ["ESC", "ESCAPE"]], 
			[["",   28, 0x001c], ["IS4", "INFORMATION SEPERATOR FOUR"]], 
			[["",   29, 0x001d], ["IS3", "INFORMATION SEPERATOR THREE"]], 
			[["",   30, 0x001e], ["IS2", "INFORMATION SEPERATOR TWO"]], 
			[["",   31, 0x001f], ["IS1", "INFORMATION SEPERATOR ONE"]], 
			[[" ",  32, 0x0020], ["SPC", "SPACE"]]
		);
		
		public static const LATIN_STD_SYMBS_1:Array = new Array(
			[["!",  33, 0x0021], [""]], 
			[["\"", 34, 0x0022], [""]], 
			[["#",  35, 0x0023], [""]], 
			[["$",  36, 0x0024], [""]], 
			[["%",  37, 0x0025], [""]], 
			[["&",  38, 0x0026], [""]], 
			[["'",  39, 0x0027], [""]], 
			[["(",  40, 0x0028], [""]], 
			[[")",  41, 0x0029], [""]], 
			[["*",  42, 0x002a], [""]], 
			[["+",  43, 0x002b], [""]], 
			[[",",  44, 0x002c], [""]], 
			[["-",  45, 0x002d], [""]], 
			[[".",  46, 0x002e], [""]], 
			[["/",  47, 0x002f], [""]]
		);
		
		public static const LATIN_STD_NUMS:Array = new Array(
			[["0", 48, 0x0030], ["ZERO"]], 
			[["1", 49, 0x0031], ["ONE"]], 
			[["2", 50, 0x0032], ["TWO"]], 
			[["3", 51, 0x0033], ["THREE"]], 
			[["4", 52, 0x0034], ["FOUR"]], 
			[["5", 53, 0x0035], ["FIVE"]], 
			[["6", 54, 0x0036], ["SIX"]], 
			[["7", 55, 0x0037], ["SEVEN"]], 
			[["8", 56, 0x0038], ["EIGHT"]], 
			[["9", 57, 0x0039], ["NINE"]] 
		);
		
		public static const LATIN_STD_SYMBS_2:Array = new Array(
			[[":", 58, 0x003a], [""]], 
			[[";", 59, 0x003b], [""]], 
			[["<", 60, 0x003c], [""]], 
			[["=", 61, 0x003d], [""]], 
			[[">", 62, 0x003e], [""]], 
			[["?", 63, 0x003f], [""]], 
			[["@", 64, 0x0040], [""]]
		);
		
		// [glyph, ascii val (dec), unicode val (bin)]
		public static const LATIN_STD_CHARS:Array = new Array(
			[["A", 65, 0x0041], ["a", 97,  0x0061], ["", ""]], 
			[["B", 66, 0x0042], ["b", 98,  0x0062], ["", ""]], 
			[["C", 67, 0x0043], ["c", 99,  0x0063], ["", ""]], 
			[["D", 68, 0x0044], ["d", 100, 0x0064], ["", ""]], 
			[["E", 69, 0x0045], ["e", 101, 0x0065], ["", ""]], 
			[["F", 70, 0x0046], ["f", 102, 0x0066], ["", ""]], 
			[["G", 71, 0x0047], ["g", 103, 0x0067], ["", ""]], 
			[["H", 72, 0x0048], ["h", 104, 0x0068], ["", ""]], 
			[["I", 73, 0x0049], ["i", 105, 0x0069], ["", ""]], 
			[["J", 74, 0x004a], ["j", 106, 0x006a], ["", ""]], 
			[["K", 75, 0x004b], ["k", 107, 0x006b], ["", ""]], 
			[["L", 76, 0x004c], ["l", 108, 0x006c], ["", ""]], 
			[["M", 77, 0x004d], ["m", 109, 0x006d], ["", ""]], 
			[["N", 78, 0x004e], ["n", 110, 0x006e], ["", ""]], 
			[["O", 79, 0x004f], ["o", 111, 0x006f], ["", ""]], 
			[["P", 80, 0x0050], ["p", 112, 0x0070], ["", ""]], 
			[["Q", 81, 0x0051], ["q", 113, 0x0071], ["", ""]], 
			[["R", 82, 0x0052], ["r", 114, 0x0072], ["", ""]], 
			[["S", 83, 0x0053], ["s", 115, 0x0073], ["", ""]], 
			[["T", 84, 0x0054], ["t", 116, 0x0074], ["", ""]], 
			[["U", 85, 0x0055], ["u", 117, 0x0075], ["", ""]], 
			[["V", 86, 0x0056], ["v", 118, 0x0076], ["", ""]], 
			[["W", 87, 0x0057], ["w", 119, 0x0077], ["", ""]], 
			[["X", 88, 0x0058], ["x", 120, 0x0078], ["", ""]], 
			[["Y", 89, 0x0059], ["y", 111, 0x0079], ["", ""]], 
			[["Z", 90, 0x005a], ["z", 122, 0x007a], ["", ""]]
		);
		
		
		public static const LATIN_STD_SYMBS_3:Array = new Array( 
			[["[",  91, 0x005], [""]], 
			[["\\", 92, 0x005], [""]], 
			[["]",  93, 0x005], [""]], 
			[["^",  94, 0x005], [""]], 
			[["_",  95, 0x005], [""]], 
			[["`",  96, 0x005], [""]]
		);
		
		public static const LATIN_STD_SYMBS_4:Array = new Array( 
			[["{",  123, 0x007b], [""]], 
			[["|",  124, 0x007c], [""]], 
			[["}",  125, 0x007d], [""]], 
			[["~",  125, 0x007e], [""]], 
			[["\d", 127, 0x007f], [""]]
		);
		
		/*
		public static const LATIN_SUPP_1:Array = new Array(
			[["",  91, 0x007b], [""]], 
		);
		*/
		// sub & super scripts
		public static const ASCII_SUBSUPERS:Array = new Array(
			["⁰", "₀"], // 0
			["¹", "₁"], // 1
			["²", "₂"], // 2
			["³", "₃"], // 3
			["⁴", "₄"], // 4
			["⁵", "₅"], // 5
			["⁶", "₆"], // 6
			["⁷", "₇"], // 7
			["⁸", "₈"], // 8
			["⁹", "₉"], // 9
			["ᴺ", "ⁿ"], // n
			["⁽", "₍"], // (
			["⁾", "₎"], // )
			["⁺", "₊"], // positive sign
			["⁻", "₋"] // negative sign
		); 
			
		
		// misc math
		public static const ASCII_MATH:Array = new Array(
			"∞", // infinity
			"≈", // approx
			"≠", // not equal
			"±", // plus/minus
			"½", // 1/2 fraction
			"¼", // 1/4 fraction
			"⩲", // plus/equals
			"⩮", // times/equals
			"⁺", // positive sign
			"⁻", // negative sign
			"∪", // union
			"∩", // intersection
			"∠", // angle
			"°", // degrees
			"⦜", // right angle
			"÷", // divide sign
			"×", // times sign
			"·", // dot product sign
			"∆", // change in
			"∍", // element of
			"∑", // summation
			"√", // root
			"≤", // less than or equal to
			"≥", // greater than or equal to
			"⊂", // subset
			"⊃", // superset
			"⊄", // not a subset
			"⊅", // not a superset
			"∫", // integral
			"⦚", // squiggly bar
			"⊥", // perpendicular
			"‖", // parallel
			"№" // number abbreviation
		);
		
		
		// roman numerals
		public static const ASCII_ROMAN_NUMS:Array = new Array(
			["Ⅰ", "ⅰ"], // 1
			["Ⅱ", "ⅱ"], // 2
			["Ⅲ", "ⅲ"], // 3
			["Ⅳ", "ⅳ"], // 4
			["Ⅴ", "ⅴ"], // 5
			["Ⅵ", "ⅵ"], // 6
			["Ⅶ", "ⅶ"], // 7
			["Ⅷ", "ⅷ"], // 8
			["Ⅸ", "ⅸ"], // 9
			["Ⅹ", "ⅹ"], // 10
			["Ⅺ", "ⅺ"], // 11
			["Ⅻ", "ⅻ"], // 12
			["Ⅼ", "ⅼ"], // 50
			["Ⅽ", "ⅽ"], // 100
			["Ⅾ", "ⅾ"], // 500
			["Ⅿ", "ⅿ"], // 1,000
			["ↀ", "ↀ"], // 1,000
			["ↁ", "ↁ"], // 5,000
			["ↂ", "ↂ"]  // 10,000
		);
			
			
		// greek alphabet
		public static const ASCII_GREEK:Array = new Array(
			["Α", "α"], // alpha
			["Β", "β"], // beta
			["Γ", "γ"], // gamma
			["Δ", "δ"], // delta 
			["Ε", "ε"], // epsilon
			["Ζ", "ζ"], // zeta
			["Η", "η"], // eta
			["Θ", "θ"], // theta
			["Ι", "ι"], // iota
			["Κ", "κ"], // kappa
			["Λ", "λ"], // lambda
			["Μ", "μ"], // mu
			["Ν", "ν"], // nu
			["Ξ", "ξ"], // xi
			["Ο", "ο"], // omicron
			["Π", "π"], // pi
			["Ρ", "ρ"], // rho
			["Σ", "σ"], // sigma
			["Τ", "τ"], // tau
			["Υ", "υ"], // upsilon
			["Φ", "φ"], // phi
			["Χ", "χ"], // chi
			["Ψ", "ψ"], // psi
			["Ω", "ω"], // omega
			
			["Ϝ", "ϝ"], // digamma (numeral symbol)
			["Ϙ", "ϙ"], // qoppa (replaced by kappa)
			["ϟ", "Ϟ"], // koppa (replaced by kappa)
			["⊢", "⊢"], // heta (replaced by eta)
			["Ϻ", "ϻ"], // san (replaced by sigma)
			["ϡ", "Ϡ"], // sampi / disigma (san + pi = 900)
			
			["Ϛ", "ϛ"], // stigma (lunate sigma + tau)
			["Ϸ", "ϸ"] // sho (added for Bactrian lang)
		);
			
		
		// cyrillic chars
		public static const ASCII_CYRILLIC:Array = new Array(
			["Б", "б"], // be
			["Г", "г"], // ve
			["Ҕ", "ҕ"], // ghe
			["Д", "д"], // de
			["Ђ", "ђ"], // dje
			["Є", "є"], // ie (ukrainian)
			["Ж", "ж"], // zhe
			["З", "з"], // ze
			["Ӡ", "ӡ"], // dze (abkasian)
			["И", "и"], // i
			["К", "к"], // ka
			["Л", "л"], // el
			["М", "м"], // em
			["Н", "н"], // en
			["О", "о"], // o
			["П", "п"], // pe
			["Р", "р"], // er
			["С", "с"], // es
			["Т", "т"], // te
			["У", "у"], // u
			["Ф", "ф"], // ef
			["Х", "х"], // ha
			["Ѡ", "ѡ"], // omega
			["Ц", "ц"], // tse
			["Ч", "ч"], // che
			["Џ", "џ"], // dzhe
			["Ш", "ш"], // sha
			["Ы", "ы"], // yeru
			["Э", "э"], // e
			["Ю", "ю"], // yu 
			["Я", "я"], // ya
			["Ѧ", "ѧ"], // small yus
			["Ѫ", "ѫ"], // big yus
			["Ѯ", "ѯ"], // ksi
			["Ѱ", "ѱ"], // psi
			["Ѳ", "ѳ"], // fita
			["Ѵ", "ѵ"], // izhitsa
			["Ҁ", "ҁ"], // koppa
			["Ѣ", "ѣ"], // yat
			["Ә", "ә"], // schwa
			["Һ", "һ"], // shha
			
			["҂", "҂"], // 1000 sign
			["҈", "҈"], // 100,000 sign
			["҉", "҉"], // 1,000,000 sign
			
			["Ъ", "ъ"], // hard sign
			["Ҍ", "ҍ"], // semisoft sign
			["Ь", "ь"]  // soft sign
		);
		
		
		// musical symbols
		public static const ASCII_MUSIC:Array = new Array(
			"𝄞", // treble clef
			"𝄢", // bass clef
			"♭", // flat
			"♯", // sharp
			"♮", // natural
			"𝄃", // start
			"𝄂", // end
			"𝄀", // measure
			"♩", // quarter note
			"♪", // eighth note
			"♫", // paired eighth note
			"♬", // paired sixtenth note
			"𝄆", // repeat start
			"𝄇", // repeat end
			"𝄈", // repeat
			"𝄐", // fermata top
			"𝄑", // fermata bottom
			"𝄒", // breathe
			"𝄪", // dbl sharp
			"𝄫" // dbl flat
		); 
			
		
		// glyphs of a six sided die
		public static const ASCII_DICE:Array = new Array(
			"⚀", // one 
			"⚁", // two
			"⚂", // three
			"⚃", // four
			"⚄", // five
			"⚅"  // six
		);
		
		
		/**
		 * U+2026 = …
		 * U+2122 = ™
		 * U+20AC = €
		 **/
		
		
		public static const PLURAL_SUFFIX:Array = [
			["S", 83, 0x0053], 
			["s", 115, 0x0073], 
			["", ""]
		];
		
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		// <*] class constructor [*>
		public function Chars() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		
		public static function isNumericASCII(char_str:String):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// no unicode val, false
			if (!hasCharCode(char_str) || char_str.length > 1)
				return (false);
			
			
			// char's unicode val
			var charCode:int = char_str.charCodeAt();
			
			// range of valid unicodes (0x0030 - 0x0039)
			var unicode_range:Point = new Point(LATIN_STD_NUMS[0][0][2], LATIN_STD_NUMS[LATIN_STD_NUMS.length-1][0][2]);
			
			// within range, true
			return (charCode >= unicode_range.x && charCode <= unicode_range.y);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isStandardASCII(char_str:String, isStrictCase:Boolean=true):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// no unicode val, false
			if (!hasCharCode(char_str) || char_str.length > 1)
				return (false);
			
			
			// loop counter
			var i:int;
			/*
			// upper & lower case letter arrays
			var uLetter_arr:Array = new Array();
			var lLetter_arr:Array = new Array();
			
			// push elements wrapped in an array 
			for (i=0; i<LATIN_STD_CHARS.length; i++) {
				uLetter_arr.push(LATIN_STD_CHARS[i][0]);
				lLetter_arr.push(LATIN_STD_CHARS[i][1]);
			}
			*/
			
			var subset_arr:Array = Arrays.subsetSlicer(LATIN_STD_SYMBS_1, [0]);
			
			
			// append most of the Basic Latin set (32 - 127)
			var basicLatin_arr:Array = new Array();
				basicLatin_arr.push(ASCII_CTRLS[ASCII_CTRLS.length-1][0]);
				
			for (i=0; i<LATIN_STD_SYMBS_1.length; i++)
				basicLatin_arr.push(LATIN_STD_SYMBS_1[i][0]);
			
			for (i=0; i<LATIN_STD_SYMBS_2.length; i++)
				basicLatin_arr.push(LATIN_STD_SYMBS_2[i][0]);
			
			for (i=0; i<LATIN_STD_CHARS.length; i++)
				basicLatin_arr.push(LATIN_STD_CHARS[i][0]);
			
			for (i=0; i<LATIN_STD_SYMBS_3.length; i++)
				basicLatin_arr.push(LATIN_STD_SYMBS_3[i][0]);
			
			for (i=0; i<LATIN_STD_CHARS.length; i++)
				basicLatin_arr.push(LATIN_STD_CHARS[i][1]);
			
			for (i=0; i<LATIN_STD_SYMBS_4.length; i++)
				basicLatin_arr.push(LATIN_STD_SYMBS_4[i][0]);
			
			// loop thru test string
			//for (i=0; i<char_str.length; i++) {
				
				// prime flag & counter
				var isFound:Boolean = false;
				//var j:int = 0;
				
				// loop thru allowed chars, stop when valid OR reached end
				//while (!isFound || j < basicLatin_arr.length-1) {
				for (i=0; i<basicLatin_arr.length; i++) {
					
					trace ("  -:]"+i+"[ FOUND:["+(char_str.charCodeAt() == basicLatin_arr[i][2])+"] >> CHAR:["+char_str.charAt()+"]="+char_str.charCodeAt()+" // ASCII("+i+") CHAR:["+basicLatin_arr[i][0]+"]="+basicLatin_arr[i][2]);
					
					// test char's unicode val against ascii array
					if (char_str.charCodeAt() == basicLatin_arr[i][2])
						return (true);	
				}
			//}
			
			// within range, true
			return (false);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isAlphaASCII(char_str:String, isStrictCase:Boolean=true):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// no unicode val, false
			if (!hasCharCode(char_str) || char_str.length > 1)
				return (false);
			
			
			// loop counter
			var i:int;
			
			// upper & lower case letter arrays
			var uLetter_arr:Array = new Array();
			var lLetter_arr:Array = new Array();
			
			// push elements wrapped in an array 
			for (i=0; i<LATIN_STD_CHARS.length; i++) {
				uLetter_arr.push(LATIN_STD_CHARS[i][0]);
				lLetter_arr.push(LATIN_STD_CHARS[i][1]);
			}
			
			// append upper & lower case chars from Basic Latin set (0x0020, 0x0041 - 0x005a, 0x0061 - 0x007a)
			var basicAlpha:Array = new Array();
				basicAlpha = Arrays.chain(true, [ASCII_CTRLS[ASCII_CTRLS.length-1][0]], uLetter_arr);
			
			// testing for upper / lower case
			if (isStrictCase)
				basicAlpha = Arrays.chain(true, basicAlpha, lLetter_arr);
			
			// just convert the char to upper case
			else
				char_str = char_str.toUpperCase();
			
			// loop thru the allowed ascii char's	
			for (i=0; i<basicAlpha.length; i++) {
				//trace ("  -:]"+i+"[ FOUND:["+(char_str.charCodeAt() == basicAlpha[i][2])+"] >> CHAR:["+char_str.charAt()+"]="+char_str.charCodeAt()+" // ASCII("+i+") CHAR:["+basicAlpha[i][0]+"]="+basicAlpha[i][2])
				
				// test char's unicode val against ascii array
				if (char_str.charCodeAt() == basicAlpha[i][2])
					return (true);	
			}
			
			// wasn't found
			return (false);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function hasCharCode(char_str:String):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// no length, false
			if (char_str.length == 0)
				return (false);
			
			// unicode val
			var charCode:int = char_str.charCodeAt();
			
			// return false if not found
			if (charCode == -1)
				return (false);
			
			// has an index
			return (true);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}