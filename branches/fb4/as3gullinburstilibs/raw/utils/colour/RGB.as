package utils.colour {

	public class RGB {
		
		protected var r:int;
		protected var g:int;
		protected var b:int;

		/**
		 * creates a rgb object with default value ( 0, 0, 0 ) which is black.
		 */
		public function RGB( rVal:int = 0, gVal:int = 0, bVal:int = 0 ) {
			red = rVal;
			blue = bVal;
			green = gVal;
		}
		
		/**
		 * returns a rgb object from a hex string like: "#123456"
		 */
		public static function createFromHEX( hexVal:String ):RGB {
			if( hexVal.length == 7 ) {
				var rgbcolor:RGB = new RGB();
				rgbcolor.red = int( "0x" + hexVal.substr( 1, 2 ) );
				rgbcolor.green = int( "0x" + hexVal.substr( 3, 2 ) );
				rgbcolor.blue = int( "0x" + hexVal.substr( 5, 2 ) );
			} else {
				throw new Error( "the hex parameter to create an rgb object has to be in the form like: #123456 not: " + hexVal );
			}

			return rgbcolor;
		}
		
		
		/**
		 * creates a rgb object from a color number which can be between 0 and 16777215 ( 0xFFFFFF )
		 */
		public static function createFromNumber( val:Number ):RGB {
			if( !isNaN( val ) && val >= 0 && val <= 0xFFFFFF ) {
				var rgbcolor:RGB = new RGB();
				rgbcolor.red = val >> 16 & 0xFF;
				rgbcolor.green = val >> 8 & 0xFF;
				rgbcolor.blue = val & 0xFF;
				
			} else {
				throw new Error( "the number parameter to create an rgb object has to be between 0 and 0xFFFFFF not: " + val );
			}
			
			return rgbcolor;
		}
		
		
		/**
		 * returns a copy of the rgb object
		 */
		public function clone():RGB {
			return new RGB( red, green, blue);
		}
		
		
		/**
		 * returns true if the rgb object to compare has the same colorvalue as the current.
		 */
		public function equals( compare:RGB ):Boolean {
			return number == compare.number;
		}

		
		/**
		 * sets the single color values
		 */
		public function set red( val:int ):void {
			if( !isNaN( val ) ) r = Math.max( Math.min( Math.round(val), 255 ), 0 );
		}
		public function set green( val:int ):void {
			if( !isNaN( val ) ) g = Math.max( Math.min( Math.round(val), 255 ), 0 );
		}
		public function set blue( val:int ):void {
			if( !isNaN( val ) ) b = Math.max( Math.min( Math.round(val), 255 ), 0 );
		}

		
		/**
		 * returns the single color values
		 */
		public function get red():int {
			return r;
		}
		public function get green():int {
			return g;	
		}
		public function get blue():int {
			return b;	
		}

		/**
		 * returns the rgb value as a 16mio number
		 */
		public function get number():Number {
			return (r << 16 | g << 8 | b);
		}

		/**
		 * returns the hex code as a string
		 */
		public function get hex():String {
			return "0x" + red.toString( 16 ) + green.toString( 16 ) + blue.toString( 16 );
		}
		
		public function get hex_html():String {
			return "#" + red.toString( 16 ) + green.toString( 16 ) + blue.toString( 16 );
		}
	}
}