package cc.gullinbursti.converts {
	import cc.gullinbursti.lang.Colors;

	//] includes [!]>
	// ]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.lang.Bits;
	import cc.gullinbursti.lang.Ints;

	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	// <[!] class delaration [!]>
	public class Color {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>	
		
		// <*] class constructor [*>
		public function Color() {/*..\(^_^)/..*/}
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function compRGBToHex(red:uint=0x00, green:uint=0x00, blue:uint=0x00):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (Bits.lShift(red, 16) | Bits.lShift(green, 8) | blue);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function compARGBToHex(alpha:uint=0x00, red:uint=0x00, green:uint=0x00, blue:uint=0x00):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (Bits.lShift(alpha, 24) | Bits.lShift(red, 16) | Bits.lShift(green, 8) | blue);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function argbPercentToHex(alpha:uint=0x00, red:uint=0x00, green:uint=0x00, blue:uint=0x00):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (Bits.lShift(alpha * 0xff, 24) | Bits.lShift(red * 0xff, 16) | Bits.lShift(green * 0xff, 8) | blue * 0xff);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function rgbPercentToHex(red:Number=0, green:Number=0, blue:Number=0):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (Bits.lShift(red * 0xff, 16) | Bits.lShift(green * 0xff, 8) | blue * 0xff);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		
		public static function hsbToHsi(hue:uint, sat:uint, brite:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (hue << 16 | sat << 8 | brite);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function hsbToHsl(hue:uint=0x00, sat:uint=0x00, brite:uint=0x00):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (hue << 16 | sat << 8 | brite);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function hsbToRgb(hue:uint, sat:uint, brite:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (hue << 16 | sat << 8 | brite);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function hsiToHsb(hue:uint, sat:uint, intens:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (hue << 16 | sat << 8 | intens);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function hsiToRbg(hue:uint, sat:uint, intens:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (0x000000);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function hslToHsb(hue:uint, sat:uint, lumi:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (hue << 16 | sat << 8 | lumi);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function hslToHsi(hue:uint, sat:uint, lumi:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (hue << 16 | sat << 8 | lumi);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function hslToHsv(hue:Number, sat:Number, lumi:Number):Object {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (rgbToHsv(hslToRbg(hue, lumi, sat)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function hslToRbg(hue:uint, sat:uint, lumi:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			var delta:Number;
	
			if (lumi < 0.5)
				delta = sat * lumi;
			
			else
				delta = sat * (1 - lumi);
			
			return (hueToRgb(lumi - delta, lumi + delta, hue));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function hsvToHsb(hue:uint, sat:uint, val:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (rgbToHsb(hsvToRgb(hue, sat, val)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function hsvToRgb(hue:uint, sat:uint, val:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (hueToRgb((1 - sat) * val, val, hue));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function hueToRgb(min:Number, max:Number, hue:Number):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			var mu:Number, md:Number, F:Number, n:Number;
			
			while (hue < 0) hue += 360;
			
			n = (hue / 60) << 0;
			F = (hue - n * 60) / 60;
			n %= 6;
			
			mu = min + ((max - min) * F);
			md = max - ((max - min) * F);
			
			switch (n) {
				
				case 0: 
					return (compRGBToHex(max, mu, min));
					break;
				
				case 1:
					return (compRGBToHex(md, max, min));
					break;
				
				case 2:
					return (compRGBToHex(min, max, mu));
					break;
				
				case 3: 
					return (compRGBToHex(min, md, max));
					break;
				
				case 4:
					return (compRGBToHex(mu, min, max));
					break;
				
				case 5: 
					return (compRGBToHex(max, min, md));
					break;
			}
			
			return (0x000000);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function rgbToHsb(rgb:uint=0x000000):uint {
			//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (rgb);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function rgbToHsi(rgb:uint=0x000000):uint {
			//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (rgb);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function rgbToHsl(rgb:uint=0x000000):uint {
			//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			var range:Point = new Point();
			var delta:Number;
			
			var hue:Number;
			var sat:Number;
			var lumi:Number;
			
			var r:uint = Colors.redAmt(rgb);
			var g:uint = Colors.greenAmt(rgb);
			var b:uint = Colors.blueAmt(rgb);
			
			range.y = Math.max(r, Math.max(g, b));
			range.x = Math.min(r, Math.min(g, b));
			
			lumi = (range.x + range.y) *0.5;
			
			if (lumi == 0)
				return (0x000000);//{h:hue, lumi:0, sat:1});
			
			delta = (range.y - range.x) / 2;
			
			if (lumi < 0.5)
				sat = delta / lumi;
				
			else
				sat = delta / (1 - lumi);
			
			hue = rgbToHue(rgb);
			
			
			//return {h:hue, l:lumi, s:sat};
			return (0x0000000);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function rgbToHsv(rgb:uint=0x000000):uint {
			//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			var range:Point= new Point();
			var sat:Number = 0;
			var v:Number = 0;
			var hue:Number = 0;
			
			var r:uint = cc.gullinbursti.lang.Colors.redAmt(rgb);
			var g:uint = cc.gullinbursti.lang.Colors.greenAmt(rgb);
			var b:uint = cc.gullinbursti.lang.Colors.blueAmt(rgb);
			
			range.y = Math.max(r, g, b);
			range.x = Math.min(r, g, b);
			
			if (range.y == 0)
				return (0x000000);//{h:0, s:0, v:0};
			
			v = range.y;
			sat = (range.y - range.x) / range.y;
			
			hue = rgbToHue(rgb);
			
			return (0x000000);//{h:hue, s:sat, v:v};
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function rgbToHue(rgb:uint=0x000000):uint {
			//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			var F:Number;
			var n:Number;
			
			var r:uint = cc.gullinbursti.lang.Colors.redAmt(rgb);
			var g:uint = cc.gullinbursti.lang.Colors.greenAmt(rgb);
			var b:uint = cc.gullinbursti.lang.Colors.blueAmt(rgb);
			
			
			var range:Point = new Point();
			range.y = Math.max(r, Math.max(g, b));
			range.x = Math.min(r, Math.min(g, b));
			
			// achromatic case
			if (range.y - range.x == 0)
				return (0);
			
			var mid:uint = Ints.middle(r, g, b);
			
			// using this loop to avoid super-ugly nested ifs
			while (true) {
				
				if (r == range.y) {
					if (b == range.x) 
						n = 0; 
						
					else 
						n = 5;		
					break;
				}
				
				
				if (g == range.y) {
					if (b == range.x)
						n = 1;
						
					else 
						n = 2;
					break;
				}
				
				if (r == range.x)
					n = 3;
					
				else
					n = 4;
				break;
			}
			
			if ((n % 2) == 0)
				F = mid - range.x;
				
			else
				F = range.y - mid;
			
			F = F / (range.y - range.x);
			
			return (60 * (n + F));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		//http://en.wikipedia.org/wiki/Candela_per_square_metre
	}
}
