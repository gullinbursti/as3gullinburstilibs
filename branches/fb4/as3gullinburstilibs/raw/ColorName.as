/*
	Copyright (c) 2009 Mark Walters
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
*/

package com.yourpalmark.utils
{
	import flash.utils.Dictionary;
	
	/**
	 * The ColorName class defines the names and hexadecimal values of the colors defined in SVG 1.0.
	 * The colors include the X11 colors supported by popular browsers with the addition of gray/grey variants from SVG 1.0.
	 * The resulting list is precisely the same as the SVG 1.0 color keyword names.
	 * The SVG 1.0 colors include the HTML4 colors, based on the VGA colors.
	 * @see http://www.w3.org/TR/css3-color/#html4
	 * @see http://www.w3.org/TR/css3-color/#svg-color
	 * 
	 * @author Mark Walters
	 */
	public class ColorName
	{
		//HTML4 COLOR KEYWORDS - VGA
		//@see http://www.w3.org/TR/css3-color/#html4
		public static const AQUA:ColorName = new ColorName( "aqua", 0x00FFFF );
		public static const BLACK:ColorName = new ColorName( "black", 0x000000 );
		public static const BLUE:ColorName = new ColorName( "blue", 0x0000FF );
		public static const FUCHSIA:ColorName = new ColorName( "fuchsia", 0xFF00FF );
		public static const GRAY:ColorName = new ColorName( "gray", 0x808080 );
		public static const GREEN:ColorName = new ColorName( "green", 0x008000 );
		public static const LIME:ColorName = new ColorName( "lime", 0x00FF00 );
		public static const MAROON:ColorName = new ColorName( "maroon", 0x800000 );
		public static const NAVY:ColorName = new ColorName( "navy", 0x000080 );
		public static const OLIVE:ColorName = new ColorName( "olive", 0x808000 );
		public static const PURPLE:ColorName = new ColorName( "purple", 0x800080 );
		public static const RED:ColorName = new ColorName( "red", 0xFF0000 );
		public static const SILVER:ColorName = new ColorName( "silver", 0xC0C0C0 );
		public static const TEAL:ColorName = new ColorName( "teal", 0x008080 );
		public static const WHITE:ColorName = new ColorName( "white", 0xFFFFFF );
		public static const YELLOW:ColorName = new ColorName( "yellow", 0xFFFF00 );
		
		//SVG COLOR KEYWORDS - X11 ( INCLUDES THE 16 HTML4 - VGA COLORS )
		//@see http://www.w3.org/TR/css3-color/#svg-color
		public static const ALICE_BLUE:ColorName = new ColorName( "aliceBlue", 0xF0F8FF );
		public static const ANTIQUE_WHITE:ColorName = new ColorName( "antiqueWhite", 0xFAEBD7 );
		public static const AQUAMARINE:ColorName = new ColorName( "aquamarine", 0x7FFFD4 );
		public static const AZURE:ColorName = new ColorName( "azure", 0xF0FFFF );
		public static const BEIGE:ColorName = new ColorName( "beige", 0xF5F5DC );
		public static const BISQUE:ColorName = new ColorName( "bisque", 0xFFE4C4 );
		public static const BLANCHED_ALMOND:ColorName = new ColorName( "blanchedAlmond", 0xFFEBCD );
		public static const BLUE_VIOLET:ColorName = new ColorName( "blueViolet", 0x8A2BE2 );
		public static const BROWN:ColorName = new ColorName( "brown", 0xA52A2A );
		public static const BURLY_WOOD:ColorName = new ColorName( "burlyWood", 0xDEB887 );
		public static const CADET_BLUE:ColorName = new ColorName( "cadetBlue", 0x5F9EA0 );
		public static const CHARTREUSE:ColorName = new ColorName( "chartreuse", 0x7FFF00 );
		public static const CHOCOLATE:ColorName = new ColorName( "chocolate", 0xD2691E );
		public static const CORAL:ColorName = new ColorName( "coral", 0xFF7F50 );
		public static const CORNFLOWER_BLUE:ColorName = new ColorName( "cornflowerBlue", 0x6495ED );
		public static const CORNSILK:ColorName = new ColorName( "cornsilk", 0xFFF8DC );
		public static const CRIMSON:ColorName = new ColorName( "crimson", 0xDC143C );
		public static const CYAN:ColorName = new ColorName( "cyan", 0x00FFFF );
		public static const DARK_BLUE:ColorName = new ColorName( "darkBlue", 0x00008B );
		public static const DARK_CYAN:ColorName = new ColorName( "darkCyan", 0x008B8B );
		public static const DARK_GOLDEN_ROD:ColorName = new ColorName( "darkGoldenRod", 0xB8860B );
		public static const DARK_GRAY:ColorName = new ColorName( "darkGray", 0xA9A9A9 );
		public static const DARK_GREY:ColorName = new ColorName( "darkGrey", 0xA9A9A9 );
		public static const DARK_GREEN:ColorName = new ColorName( "darkGreen", 0x006400 );
		public static const DARK_KHAKI:ColorName = new ColorName( "darkKhaki", 0xBDB76B );
		public static const DARK_MAGENTA:ColorName = new ColorName( "darkMagenta", 0x8B008B );
		public static const DARK_OLIVE_GREEN:ColorName = new ColorName( "darkOliveGreen", 0x556B2F );
		public static const DARK_ORANGE:ColorName = new ColorName( "darkOrange", 0xFF8C00 );
		public static const DARK_ORCHID:ColorName = new ColorName( "darkOrchid", 0x9932CC );
		public static const DARK_RED:ColorName = new ColorName( "darkRed", 0x8B0000 );
		public static const DARK_SALMON:ColorName = new ColorName( "darkSalmon", 0xE9967A );
		public static const DARK_SEA_GREEN:ColorName = new ColorName( "darkSeaGreen", 0x8FBC8F );
		public static const DARK_SLATE_BLUE:ColorName = new ColorName( "darkSlateBlue", 0x483D8B );
		public static const DARK_SLATE_GRAY:ColorName = new ColorName( "darkSlateGray", 0x2F4F4F );
		public static const DARK_SLATE_GREY:ColorName = new ColorName( "darkSlateGrey", 0x2F4F4F );
		public static const DARK_TURQUOISE:ColorName = new ColorName( "darkTurquoise", 0x00CED1 );
		public static const DARK_VIOLET:ColorName = new ColorName( "darkViolet", 0x9400D3 );
		public static const DEEP_PINK:ColorName = new ColorName( "deepPink", 0xFF1493 );
		public static const DEEP_SKY_BLUE:ColorName = new ColorName( "deepSkyBlue", 0x00BFFF );
		public static const DIM_GRAY:ColorName = new ColorName( "dimGray", 0x696969 );
		public static const DIM_GREY:ColorName = new ColorName( "dimGrey", 0x696969 );
		public static const DODGER_BLUE:ColorName = new ColorName( "dodgerBlue", 0x1E90FF );
		public static const FIRE_BRICK:ColorName = new ColorName( "fireBrick", 0xB22222 );
		public static const FLORAL_WHITE:ColorName = new ColorName( "floralWhite", 0xFFFAF0 );
		public static const FOREST_GREEN:ColorName = new ColorName( "forestGreen", 0x228B22 );
		public static const GAINSBORO:ColorName = new ColorName( "gainsboro", 0xDCDCDC );
		public static const GHOST_WHITE:ColorName = new ColorName( "ghostWhite", 0xF8F8FF );
		public static const GOLD:ColorName = new ColorName( "gold", 0xFFD700 );
		public static const GOLDEN_ROD:ColorName = new ColorName( "goldenRod", 0xDAA520 );
		public static const GREY:ColorName = new ColorName( "grey", 0x808080 );
		public static const GREEN_YELLOW:ColorName = new ColorName( "greenYellow", 0xADFF2F );
		public static const HONEY_DEW:ColorName = new ColorName( "honeyDew", 0xF0FFF0 );
		public static const HOT_PINK:ColorName = new ColorName( "hotPink", 0xFF69B4 );
		public static const INDIAN_RED:ColorName = new ColorName( "indianRed", 0xCD5C5C );
		public static const INDIGO:ColorName = new ColorName( "indigo", 0x4B0082 );
		public static const IVORY:ColorName = new ColorName( "ivory", 0xFFFFF0 );
		public static const KHAKI:ColorName = new ColorName( "khaki", 0xF0E68C );
		public static const LAVENDER:ColorName = new ColorName( "lavender", 0xE6E6FA );
		public static const LAVENDER_BLUSH:ColorName = new ColorName( "lavenderBlush", 0xFFF0F5 );
		public static const LAWN_GREEN:ColorName = new ColorName( "lawnGreen", 0x7CFC00 );
		public static const LEMON_CHIFFON:ColorName = new ColorName( "lemonChiffon", 0xFFFACD );
		public static const LIGHT_BLUE:ColorName = new ColorName( "lightBlue", 0xADD8E6 );
		public static const LIGHT_CORAL:ColorName = new ColorName( "lightCoral", 0xF08080 );
		public static const LIGHT_CYAN:ColorName = new ColorName( "lightCyan", 0xE0FFFF );
		public static const LIGHT_GOLDEN_ROD_YELLOW:ColorName = new ColorName( "lightGoldenRodYellow", 0xFAFAD2 );
		public static const LIGHT_GRAY:ColorName = new ColorName( "lightGray", 0xD3D3D3 );
		public static const LIGHT_GREY:ColorName = new ColorName( "lightGrey", 0xD3D3D3 );
		public static const LIGHT_GREEN:ColorName = new ColorName( "lightGreen", 0x90EE90 );
		public static const LIGHT_PINK:ColorName = new ColorName( "lightPink", 0xFFB6C1 );
		public static const LIGHT_SALMON:ColorName = new ColorName( "lightSalmon", 0xFFA07A );
		public static const LIGHT_SEA_GREEN:ColorName = new ColorName( "lightSeaGreen", 0x20B2AA );
		public static const LIGHT_SKY_BLUE:ColorName = new ColorName( "lightSkyBlue", 0x87CEFA );
		public static const LIGHT_SLATE_GRAY:ColorName = new ColorName( "lightSlateGray", 0x778899 );
		public static const LIGHT_SLATE_GREY:ColorName = new ColorName( "lightSlateGrey", 0x778899 );
		public static const LIGHT_STEEL_BLUE:ColorName = new ColorName( "lightSteelBlue", 0xB0C4DE );
		public static const LIGHT_YELLOW:ColorName = new ColorName( "lightYellow", 0xFFFFE0 );
		public static const LIME_GREEN:ColorName = new ColorName( "limeGreen", 0x32CD32 );
		public static const LINEN:ColorName = new ColorName( "linen", 0xFAF0E6 );
		public static const MAGENTA:ColorName = new ColorName( "magenta", 0xFF00FF );
		public static const MEDIUM_AQUA_MARINE:ColorName = new ColorName( "mediumAquaMarine", 0x66CDAA );
		public static const MEDIUM_BLUE:ColorName = new ColorName( "mediumBlue", 0x0000CD );
		public static const MEDIUM_ORCHID:ColorName = new ColorName( "mediumOrchid", 0xBA55D3 );
		public static const MEDIUM_PURPLE:ColorName = new ColorName( "mediumPurple", 0x9370D8 );
		public static const MEDIUM_SEA_GREEN:ColorName = new ColorName( "mediumSeaGreen", 0x3CB371 );
		public static const MEDIUM_SLATE_BLUE:ColorName = new ColorName( "mediumSlateBlue", 0x7B68EE );
		public static const MEDIUM_SPRING_GREEN:ColorName = new ColorName( "mediumSpringGreen", 0x00FA9A );
		public static const MEDIUM_TURQUOISE:ColorName = new ColorName( "mediumTurquoise", 0x48D1CC );
		public static const MEDIUM_VIOLET_RED:ColorName = new ColorName( "mediumVioletRed", 0xC71585 );
		public static const MIDNIGHT_BLUE:ColorName = new ColorName( "midnightBlue", 0x191970 );
		public static const MINT_CREAM:ColorName = new ColorName( "mintCream", 0xF5FFFA );
		public static const MISTY_ROSE:ColorName = new ColorName( "mistyRose", 0xFFE4E1 );
		public static const MOCCASIN:ColorName = new ColorName( "moccasin", 0xFFE4B5 );
		public static const NAVAJO_WHITE:ColorName = new ColorName( "navajoWhite", 0xFFDEAD );
		public static const OLD_LACE:ColorName = new ColorName( "oldLace", 0xFDF5E6 );
		public static const OLIVE_DRAB:ColorName = new ColorName( "oliveDrab", 0x6B8E23 );
		public static const ORANGE:ColorName = new ColorName( "orange", 0xFFA500 );
		public static const ORANGE_RED:ColorName = new ColorName( "orangeRed", 0xFF4500 );
		public static const ORCHID:ColorName = new ColorName( "orchid", 0xDA70D6 );
		public static const PALE_GOLDEN_ROD:ColorName = new ColorName( "paleGoldenRod", 0xEEE8AA );
		public static const PALE_GREEN:ColorName = new ColorName( "paleGreen", 0x98FB98 );
		public static const PALE_TURQUOISE:ColorName = new ColorName( "paleTurquoise", 0xAFEEEE );
		public static const PALE_VIOLET_RED:ColorName = new ColorName( "paleVioletRed", 0xD87093 );
		public static const PAPAYA_WHIP:ColorName = new ColorName( "papayaWhip", 0xFFEFD5 );
		public static const PEACH_PUFF:ColorName = new ColorName( "peachPuff", 0xFFDAB9 );
		public static const PERU:ColorName = new ColorName( "peru", 0xCD853F );
		public static const PINK:ColorName = new ColorName( "pink", 0xFFC0CB );
		public static const PLUM:ColorName = new ColorName( "plum", 0xDDA0DD );
		public static const POWDER_BLUE:ColorName = new ColorName( "powderBlue", 0xB0E0E6 );
		public static const ROSY_BROWN:ColorName = new ColorName( "rosyBrown", 0xBC8F8F );
		public static const ROYAL_BLUE:ColorName = new ColorName( "royalBlue", 0x4169E1 );
		public static const SADDLE_BROWN:ColorName = new ColorName( "saddleBrown", 0x8B4513 );
		public static const SALMON:ColorName = new ColorName( "salmon", 0xFA8072 );
		public static const SANDY_BROWN:ColorName = new ColorName( "sandyBrown", 0xF4A460 );
		public static const SEA_GREEN:ColorName = new ColorName( "seaGreen", 0x2E8B57 );
		public static const SEA_SHELL:ColorName = new ColorName( "seaShell", 0xFFF5EE );
		public static const SIENNA:ColorName = new ColorName( "sienna", 0xA0522D );
		public static const SKY_BLUE:ColorName = new ColorName( "skyBlue", 0x87CEEB );
		public static const SLATE_BLUE:ColorName = new ColorName( "slateBlue", 0x6A5ACD );
		public static const SLATE_GRAY:ColorName = new ColorName( "slateGray", 0x708090 );
		public static const SLATE_GREY:ColorName = new ColorName( "slateGrey", 0x708090 );
		public static const SNOW:ColorName = new ColorName( "snow", 0xFFFAFA );
		public static const SPRING_GREEN:ColorName = new ColorName( "springGreen", 0x00FF7F );
		public static const STEEL_BLUE:ColorName = new ColorName( "steelBlue", 0x4682B4 );
		public static const TAN:ColorName = new ColorName( "tan", 0xD2B48C );
		public static const THISTLE:ColorName = new ColorName( "thistle", 0xD8BFD8 );
		public static const TOMATO:ColorName = new ColorName( "tomato", 0xFF6347 );
		public static const TURQUOISE:ColorName = new ColorName( "turquoise", 0x40E0D0 );
		public static const VIOLET:ColorName = new ColorName( "violet", 0xEE82EE );
		public static const WHEAT:ColorName = new ColorName( "wheat", 0xF5DEB3 );
		public static const WHITE_SMOKE:ColorName = new ColorName( "whiteSmoke", 0xF5F5F5 );
		public static const YELLOW_GREEN:ColorName = new ColorName( "yellowGreen", 0x9ACD32 );
		
		/**
		 * @private
		 */
		protected static var nameDict:Dictionary;
		
		/**
		 * @private
		 */
		protected static var colorDict:Dictionary;
		
		/**
		 * @private
		 */
		private var _name:String;
		
		/**
		 * @private
		 */
		private var _color:uint;
		
		/**
		 * Constructor.
		 * 
		 * @param name The string name of a color (case-insensitive).
		 * @param color The hexadecimal value of a color.
		 */
		public function ColorName( name:String, color:uint )
		{
			if( !nameDict ) nameDict = new Dictionary();
			if( !colorDict ) colorDict = new Dictionary();
			
			this.name = name;
			this.color = color;
		}
		
		/**
		 * The string name of a color (case-insensitive).
		 */
		public function get name():String
		{
			return _name;
		}
		
		/**
		 * @private
		 */
		public function set name( value:String ):void
		{
			_name = value;
			nameDict[ value.toLowerCase() ] = this;
		}
		
		/**
		 * The hexadecimal value of a color.
		 */
		public function get color():uint
		{
			return _color;
		}
		
		/**
		 * @private
		 */
		public function set color( value:uint ):void
		{
			_color = value;
			colorDict[ value ] = this;
		}
		
		/**
		 * Returns the corresponding ColorName object from the string name.
		 * 
		 * @param name The string name of a color (case-insensitive).
		 * @return A ColorName object.
		 */
		public static function getColorNameByName( name:String ):ColorName
		{
			return nameDict[ name.toLowerCase() ];
		}
		
		/**
		 * Returns the corresponding ColorName object from the hexadecimal value.
		 * 
		 * @param color The hexadecimal value of a color.
		 * @return A ColorName object.
		 */
		public static function getColorNameByColor( color:uint ):ColorName
		{
			return colorDict[ color ];
		}
		
		/**
		 * Returns a string containing all the properties of the ColorName object.
		 */
		public function toString():String
		{
			var colorString:String = color.toString( 16 ).toUpperCase();
			while( 6 > colorString.length ) colorString = "0" + colorString;
			return "[ColorName name=\"" + name + "\" color=0x" + colorString + "]";
		}
		
	}
}