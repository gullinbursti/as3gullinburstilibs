package cc.gullinbursti.utils {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.probility.Randomness;
	
	import flash.display.BitmapData;
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
	public class Color {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		// <*] class constructor [*>
		public function Color() {/*..\(^_^)/..*/}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		
		public static function reduceChannels(src_bmpData:BitmapData, primer_val:int=16, isMakingGrey:Boolean=false, isAlphaMod:Boolean=false):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
			
			var i:int;
			var j:int=0;
			
			var val:int = 0;
			var total:int = 255;
			
			primer_val -= 2;
			
			if (primer_val <= 0) primer_val = 1;
			if (primer_val >= 255) primer_val = 254;
			
			var step:Number = total / primer_val;
			var offset:Number = (total - (total / (primer_val + 1))) / total;
			var values:Array = [];
			
			//loop thru, & push incs into array
			for (i=0; i<total; i++) {
				
				if (i >= (j * step * offset))
					j++;
				
				
				values.push(Math.floor((Math.ceil(j*step)-step)));
			}
			
			// run-time vars
			var a:int;
			var r:int;
			var g:int;
			var b:int;
			var c:int;
			
			// main x/y loop iters
			var iw:int = src_bmpData.width;
			var ih:int = src_bmpData.height;
		
			src_bmpData.lock();
			
			
			// do modify the alpha channel too
			if (isAlphaMod) {
				
				// making it greyscale
				if (isMakingGrey) {
					
					for (i=0; i<iw; i++) {
						for (j=0; j<ih; j++) {
							
							val = src_bmpData.getPixel32(i, j);
							
							a = values[(val >>> 24)- 1];
							r = values[(val >>> 16 & 0xFF)- 1];
							g = values[ (val >>> 8  & 0xFF)- 1];
							b = values[ (val & 0xFF)- 1];
							c = Math.ceil(((r + g + b) / 3));
							
							src_bmpData.setPixel32(i, j, (a<<24 | c << 16 | c << 8 | c));
						}
					}
				
				
				// not making it b/w
				} else {
					
					
					// COLORS WITH ALPHA AFFECTED
					for (i=0; i<iw; i++) {
						for (j=0; j<ih; j++) {
							
							val = src_bmpData.getPixel32(i, j);
							
							a = values[(val >>> 24)- 1];
							r = values[(val >>> 16 & 0xFF)- 1];
							g = values[ (val >>> 8  & 0xFF)- 1];
							b = values[ (val & 0xFF)- 1];
							
							src_bmpData.setPixel32(i, j, (a << 24 | r << 16 | g << 8 | b));
						}
					}
				}
				
			
			// not modifying alpha channel
			} else {
				
				// making it grey scale
				// GRAYSCALE WITH ALPHA NOT AFFECTED
				if (isMakingGrey)  {
					
					for (i=0; i<iw; i++) {
						for (j=0; j<ih; j++) {
							
							val = src_bmpData.getPixel32(i, j);
							
							r = values[(val >>> 16 & 0xFF)- 1];
							g = values[ (val >>> 8  & 0xFF)- 1];
							b = values[ (val & 0xFF)- 1];
							c = Math.ceil(((r + g + b) / 3));
							
							src_bmpData.setPixel32(i, j, ((val >>> 24) << 24 | c << 16 | c << 8 | c));
						
						}
					}
				
				//affect RGB channels, no greying	
				} else { 
					
					// COLORS WITH ALPHA NOT AFFECTED
					for (i=0; i<iw; i++) {
						for (j=0; j<ih; j++) {
							
							val = src_bmpData.getPixel32(i, j);
							
							r = values[(val >>> 16 & 0xFF)- 1];
							g = values[ (val >>> 8  & 0xFF)- 1];
							b = values[ (val & 0xFF)- 1];
							
							src_bmpData.setPixel32(i, j, ((val >>> 24)<<24 | r << 16 | g << 8 | b));
						}
					}
				}
			}
			
			src_bmpData.unlock();
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function toRGB(red:uint, green:uint, blue:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (red << 16 | green << 8 | blue);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function toARGB(alpha:uint, red:uint, green:uint, blue:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (alpha << 24 | red << 16 | green << 8 | blue);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function alphaChannel(color:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (color >> 24 & 0xff);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function redChannel(color:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			if (color > 0xffffff)
				return (color >> 16 & 0xff);
			
			return (color >> 16)
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function greenChannel(color:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (color >> 8 & 0xff);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function blueChannel(color:uint):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (color & 0xff);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function randRGB():uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (Randomness.generateInt(0x000000, 0xffffff));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	
		public static function randARGB():uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		return (Randomness.generateInt(0x00000000, 0xffffffff));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯

		public static function randChannel(min:uint=0xff, max:uint=0xff):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (Randomness.generateInt(min, max));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function randGrey(min:uint=0xff, max:uint=0xff):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			var val:uint = randChannel(min, max)
			
			return (toRGB(val, val, val));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	
		public static function toCGA(src_bmpData:BitmapData, isGrey:Boolean=false, isAlpha:Boolean=false):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			 reduceChannels(src_bmpData, 0, isGrey, isAlpha);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
			
		
		public static function toEGA( src_bmpData:BitmapData, isGrey:Boolean=false, isAlpha:Boolean=false):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			 reduceChannels(src_bmpData, 4, isGrey, isAlpha);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function toHAM( src_bmpData:BitmapData, isGrey:Boolean=false, isAlpha:Boolean=false):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			 reduceChannels(src_bmpData, 6, isGrey, isAlpha);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function toVGA( src_bmpData:BitmapData, isGrey:Boolean=false, isAlpha:Boolean=false):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			 reduceChannels(src_bmpData, 8, isGrey, isAlpha);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function toSVGA( src_bmpData:BitmapData, isGrey:Boolean=false, isAlpha:Boolean=false):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			 reduceChannels(src_bmpData, 16, isGrey, isAlpha);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
	}
}