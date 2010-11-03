package cc.gullinbursti.utils {
	
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.lang.Bits;
	import cc.gullinbursti.lang.Arrays;
	import cc.gullinbursti.math.probility.Randomness;
	
	import flash.display.BitmapDataChannel;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/*
	Color:
	var t:uint=0×77ff8877
	var s:uint=0xff000000
	var h:uint=t&s
	var m:uint=h>>>24
	trace(m);
	*/
	
	// <[!] class delaration [!]>
	public class ColorUtilz extends Bitwise {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		// ]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const ALPHA:int = BitmapDataChannel.ALPHA;
		public static const RED:int = BitmapDataChannel.RED;
		public static const GREEN:int = BitmapDataChannel.GREEN;
		public static const BLUE:int = BitmapDataChannel.BLUE;
		
		public static const HUE:int = -1;
		public static const SATUR:int = -2;
		public static const BRITE:int = -4;
		public static const LUMI:int = -8;
		
		// html4 vga names
		public static const VGA_HTML_COLORS:Array = new Array(
			["aqua", 	0x00ffff], 
			["black", 	0x000000], 
			["blue", 	0x0000ff], 
			["fuchsia", 0xff00ff], 
			["gray", 	0x808080], 
			["green", 	0x008000], 
			["lime", 	0x00ff00], 
			["maroon", 	0x800000], 
			["navy", 	0x000080], 
			["olive", 	0x808000], 
			["purple", 	0x800080], 
			["red", 	0xff0000], 
			["silver", 	0xc0c0c0], 
			["teal", 	0x008080], 
			["white", 	0xffffff], 
			["yellow", 	0xffff00]
		);
		
		// html4 svg names
		public static const SVG_HTML_COLORS:Array = new Array(
			["aliceBlue", 				0xf0f8ff], 
			["antiqueWhite", 			0xfaeBD7], 
			["aquamarine", 				0x7fffd4], 
			["azure", 					0xf0ffff], 
			["beige", 					0xf5f5dc], 
			["bisque", 					0xffe4c4], 
			["blanchedAlmond", 			0xffebcd], 
			["blueViolet", 				0x8a2be2], 
			["brown", 					0xa52a2a], 
			["burlyWood", 				0xdeb887], 
			["cadetBlue", 				0x5f9ea0], 
			["chartreuse", 				0x7fff00], 
			["chocolate", 				0xd2691e], 
			["coral", 					0xff7f50], 
			["cornflowerBlue", 			0x6495ed], 
			["cornsilk", 				0xfff8dc], 
			["crimson", 				0xdc143c], 
			["cyan", 					0x00ffff], 
			["darkBlue", 				0x00008b], 
			["darkCyan", 				0x008b8b], 
			["darkGoldenRod", 			0xb8860b], 
			["darkGray", 				0xa9a9a9], 
			["darkGrey", 				0xa9a9a9], 
			["darkGreen", 				0x006400], 
			["darkKhaki", 				0xbdB76B], 
			["darkMagenta", 			0x8b008b], 
			["darkOliveGreen", 			0x556b2f], 
			["darkOrange", 				0xff8c00], 
			["darkOrchid", 				0x9932cc], 
			["darkRed", 				0x8b0000], 
			["darkSalmon", 				0xe9967a], 
			["darkSeaGreen", 			0x8fbc8f], 
			["darkSlateBlue", 			0x483d8b], 
			["darkSlateGray", 			0x2f4f4f], 
			["darkSlateGrey", 			0x2f4f4f], 
			["darkTurquoise", 			0x00ced1], 
			["darkViolet", 				0x9400d3], 
			["deepPink", 				0xff1493], 
			["deepSkyBlue", 			0x00bfff], 
			["dimGray", 				0x696969], 
			["dimGrey", 				0x696969], 
			["dodgerBlue", 				0x1e90ff], 
			["fireBrick", 				0xb22222], 
			["floralWhite", 			0xfffaf0], 
			["forestGreen", 			0x228b22], 
			["gainsboro", 				0xdcdcdC], 
			["ghostWhite", 				0xf8f8ff], 
			["gold", 					0xffd700], 
			["goldenRod", 				0xdaa520], 
			["grey", 					0x808080], 
			["greenYellow", 			0xadff2f], 
			["honeyDew", 				0xf0fff0], 
			["hotPink", 				0xff69b4], 
			["indianRed", 				0xcd5C5C], 
			["indigo", 					0x4b0082], 
			["ivory", 					0xfffff0], 
			["khaki", 					0xf0e68c], 
			["lavender", 				0xe6e6fa], 
			["lavenderBlush", 			0xfff0f5], 
			["lawnGreen", 				0x7cfc00], 
			["lemonChiffon", 			0xfffaCD], 
			["lightBlue", 				0xadd8e6], 
			["lightCoral", 				0xf08080], 
			["lightCyan", 				0xe0ffff], 
			["lightGoldenRodYellow", 	0xfafad2], 
			["lightGray", 				0xd3d3d3], 
			["lightGrey", 				0xd3d3d3], 
			["lightGreen", 				0x90ee90], 
			["lightPink", 				0xffb6c1], 
			["lightSalmon", 			0xffa07a], 
			["lightSeaGreen", 			0x20b2aa], 
			["lightSkyBlue", 			0x87cefa], 
			["lightSlateGray", 			0x778899], 
			["lightSlateGrey", 			0x778899], 
			["lightSteelBlue", 			0xb0c4de], 
			["lightYellow", 			0xffffe0], 
			["limeGreen", 				0x32cd32], 
			["linen", 					0xfaf0e6], 
			["magenta", 				0xff00ff], 
			["mediumAquaMarine", 		0x66cdaa], 
			["mediumBlue", 				0x0000cd], 
			["mediumOrchid", 			0xba55d3], 
			["mediumPurple", 			0x9370d8], 
			["mediumSeaGreen", 			0x3cb371], 
			["mediumSlateBlue", 		0x7b68ee], 
			["mediumSpringGreen", 		0x00fa9a], 
			["mediumTurquoise", 		0x48d1cc], 
			["mediumVioletRed", 		0xc71585], 
			["midnightBlue", 			0x191970], 
			["mintCream", 				0xf5fffa], 
			["mistyRose", 				0xffe4e1], 
			["moccasin", 				0xffe4b5], 
			["navajoWhite", 			0xffdead], 
			["oldLace", 				0xfdf5e6], 
			["oliveDrab", 				0x6b8e23], 
			["orange", 					0xffa500], 
			["orangeRed", 				0xff4500], 
			["orchid", 					0xda70d6], 
			["paleGoldenRod", 			0xeee8aa], 
			["paleGreen", 				0x98fb98], 
			["paleTurquoise", 			0xafeeee], 
			["paleVioletRed", 			0xd87093], 
			["papayaWhip", 				0xffefd5], 
			["peachPuff", 				0xffdab9], 
			["peru", 					0xcd853f], 
			["pink", 					0xffc0cb], 
			["plum", 					0xdda0dd], 
			["powderBlue", 				0xb0e0e6], 
			["rosyBrown", 				0xbc8f8f], 
			["royalBlue", 				0x4169e1], 
			["saddleBrown", 			0x8b4513], 
			["salmon", 					0xfa8072], 
			["sandyBrown", 				0xf4a460], 
			["seaGreen", 				0x2e8b57], 
			["seaShell", 				0xfff5ee], 
			["sienna", 					0xa0522d], 
			["skyBlue", 				0x87ceeb], 
			["slateBlue", 				0x6a5acd], 
			["slateGray", 				0x708090], 
			["slateGrey", 				0x708090], 
			["snow", 					0xfffafa], 
			["springGreen", 			0x00ff7f], 
			["steelBlue", 				0x4682b4], 
			["tan", 					0xd2b48c], 
			["thistle", 				0xd8bfd8], 
			["tomato", 					0xff6347], 
			["turquoise", 				0x40e0d0], 
			["violet", 					0xee82ee], 
			["wheat", 					0xf5deb3], 
			["whiteSmoke", 				0xf5f5f5], 
			["yellowGreen", 			0x9acd32]
		);
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		// <*] class constructor [*>
		public function ColorUtilz() {/*..\(^_^)/..*/}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function nameByHexRGB(color:uint):String {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._

			var allColor_arr:Array = Arrays.chain(false, VGA_HTML_COLORS, SVG_HTML_COLORS);
			
			for (var i:int=0; i<allColor_arr.length; i++) {
				trace("Searching for:["+color+"] in @("+i+"):["+((allColor_arr[i] as Array)[1] as uint)+"]");
				
				if (color == (allColor_arr[i] as Array)[1] as uint)
					return ((allColor_arr[i] as Array)[0] as String);
			}
			
			
			return ("");	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function rgbByName(name:String):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			var allColor_arr:Array = Arrays.chain(false, VGA_HTML_COLORS, SVG_HTML_COLORS);
			
			for (var i:int=0; i<allColor_arr.length; i++) {
				trace("Searching for:["+name+"] in @("+i+"):["+((allColor_arr[i] as Array)[0] as String)+"]");
						
				if (name.toLowerCase() == ((allColor_arr[i] as Array)[0] as String).toLowerCase())
					return ((allColor_arr[i] as Array)[1] as uint);
			}
			
			
			return (0xffffff + 0x000001);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
	
		public static function alphaAmt(color:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (Bits.rShift(color, 24) & 0xff);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function redAmt(color:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			if (color > 0xffffff)
				return (Bits.rShift(color, 16) & 0xff);
			
			return (Bits.rShift(color, 16));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function greenAmt(color:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (Bits.rShift(color, 8) & 0xff);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function blueAmt(color:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (color & 0xff);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function rndRGB(min:uint=0x000000, max:uint=0xffffff):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (Randomness.generateInt(min, max));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	
	
		public static function rndARGB(min:uint=0x00000000, max:uint=0xffffffff):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		return (Randomness.generateInt(min, max));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯


		public static function rndColorRange(min:uint=0x00, max:uint=0xff):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (Randomness.generateInt(min, max));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function rndGrey(min:uint=0x00, max:uint=0xff):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			var val:uint = rndColorRange(min, max);
			
			return (Bits.lShift(val, 16) | Bits.lShift(val, 8) | val);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function rndColorlVal(color:String, min:Number=0, max:Number=1):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			var val:uint = rndColorRange(0xff * min, 0xff * max);
			
			switch (color) {
				
				case ALPHA:
					return (Bits.lShift(val, 24));
					break;
					
				case RED:
					return (Bits.lShift(val, 16));
					break;
				
				case GREEN:
					return (Bits.lShift(val, 8));
					break;
					
				case BLUE:
					return (val);
					break;
					
				case SATUR:
					val /= 0xff;
					break;
					
				case BRITE:
					val /= 0xff;
					break;
					
				case LUMI:
					val /= 0xff;
					break;
			}
			
			return(val);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}