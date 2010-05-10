package utils.colour {

	/**
	 * @author Markus
	 */
	public class RGBA { 
		
		private var r:int;
		private var g:int;
		private var b:int;
		private var a:int;
		
		public function RGBA( rVal:int = 0, gVal:int = 0, bVal:int = 0, aVal:int = 255 ) {
			red = rVal;
			blue = bVal;
			green = gVal;
			alpha = aVal; 
		}
		public static function createFromHEX( hexVal:String ):RGBA {
			if( hexVal.length == 9 ) {
				var rgbacolor:RGBA = new RGBA();
				rgbacolor.alpha = int( "0x" + hexVal.substr( 1, 2 ) );
				rgbacolor.red = int( "0x" + hexVal.substr( 3, 2 ) );
				rgbacolor.green = int( "0x" + hexVal.substr( 5, 2 ) );
				rgbacolor.blue = int( "0x" + hexVal.substr( 7, 2 ) );
			} else {
				throw new Error( "the hex parameter to create an rgba object has to be in the form like: #FF00FF00 not: " + hexVal );
			}

			return rgbacolor;
		}
		
		public static function createFromNumber( val:Number ):RGBA {
			if( !isNaN( val ) && val >= 0 && val <= 0xFFFFFFFF ) {
				var rgbacolor:RGBA = new RGBA();
				rgbacolor.alpha = val >> 24 & 0xFF;
				rgbacolor.red = val >> 16 & 0xFF;
				rgbacolor.green = val >> 8 & 0xFF;
				rgbacolor.blue = val & 0xFF;
			} else {
				throw new Error( "the number parameter to create an rgba object has to be between 0 and 0xFFFFFFFF not: " + val );
			}
			
			return rgbacolor;
		}
		
		public function set red( val:int ):void {
			if( !isNaN( val ) ) r = Math.max( Math.min( val, 255 ), 0 );
		}
		public function set green( val:int ):void {
			if( !isNaN( val ) ) g = Math.max( Math.min( val, 255 ), 0 );
		}
		public function set blue( val:int ):void {
			if( !isNaN( val ) ) b = Math.max( Math.min( val, 255 ), 0 );
		}
		public function set alpha( val:int ):void {
			if( !isNaN( val ) ) a = Math.max( Math.min( val, 255 ), 0 );
		}
		
		public function get red():int {
			return r;
		}
		public function get green():int {
			return g;	
		}
		public function get blue():int {
			return b;	
		}
		public function get alpha():int {
			return a;	
		}
		public function get alphaNumber():Number {
			return Number(a)/255;	
		}

		public function equals( compare:RGB ):Boolean {
			return number == compare.number;
		}		
		public function get number():Number {
			return (a << 24 | r << 16 | g << 8 | b);
		}
		public function get numberNoAlpha():Number {
			return (r << 16 | g << 8 | b);
		}
		public function get hex():String {
			var prefix:String="0x";
			return prefix + alpha.toString( 16 ) + red.toString( 16 ) + green.toString( 16 ) + blue.toString( 16 );
		}
		public function get hexNoAlpha():String {
			var prefix:String="0x";
			return prefix + red.toString( 16 ) + green.toString( 16 ) + blue.toString( 16 );
		}
		
		public function clone():RGBA {
			return new RGBA( red, green, blue, alpha);
		}
		
		public static function getMidRGBA(startColor : RGBA, endColor : RGBA, perc : Number) : RGBA {
			var rColor:RGBA = new RGBA();
			rColor.alpha = startColor.alpha + ((endColor.alpha-startColor.alpha)*perc);
			rColor.red = startColor.red + ((endColor.red-startColor.red)*perc);
			rColor.green = startColor.green + ((endColor.green-startColor.green)*perc);
			rColor.blue = startColor.blue + ((endColor.blue-startColor.blue)*perc);
			return rColor;
		}
	}
}
