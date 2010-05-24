package cc.gullinbursti.utils {
	import flash.display.BitmapData;
	
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [!]>
	public class Colors {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		// <*] class constructor [*>
		public function Colors() {/*..\(^_^)/..*/}
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
		
		
		
		
		static public function toCGA(src_bmpData:BitmapData, isGrey:Boolean=false, isAlpha:Boolean=false):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			 reduceChannels(src_bmpData, 0, isGrey, isAlpha);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
			
		
		static public function toEGA( src_bmpData:BitmapData, isGrey:Boolean=false, isAlpha:Boolean=false):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			 reduceChannels(src_bmpData, 4, isGrey, isAlpha);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		static public function toHAM( src_bmpData:BitmapData, isGrey:Boolean=false, isAlpha:Boolean=false):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			 reduceChannels(src_bmpData, 6, isGrey, isAlpha);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		static public function toVGA( src_bmpData:BitmapData, isGrey:Boolean=false, isAlpha:Boolean=false):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			 reduceChannels(src_bmpData, 8, isGrey, isAlpha);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		static public function toSVGA( src_bmpData:BitmapData, isGrey:Boolean=false, isAlpha:Boolean=false):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			 reduceChannels(src_bmpData, 16, isGrey, isAlpha);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}