package cc.gullinbursti.lang {
	
	
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.converts.Color;
	
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [!]>
	public class BitmapDatas {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		// ]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.

		public static const ALPHA:String = "ALPHA";
		public static const RED:String = "RED";
		public static const GREEN:String = "GREEN";
		public static const BLUE:String = "BLUE";
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		// <*] class constructor [*>
		public function BitmapDatas() {/*..\(^_^)/..*/}
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		
		
		public static function extractChannel(src_bmpData:BitmapData, channel:String):BitmapData {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
			
			// a new bmp data
			var out_bmpData:BitmapData = new BitmapData(src_bmpData.width, src_bmpData.height, true, 0x00);
			
			
			switch (channel) {
				
				case ALPHA:
					out_bmpData.copyChannel(src_bmpData, src_bmpData.rect, new Point(0, 0), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
					break;
				
				case RED:
					out_bmpData.copyChannel(src_bmpData, src_bmpData.rect, new Point(0, 0), BitmapDataChannel.RED, BitmapDataChannel.RED);
					break;
				
				case GREEN:
					out_bmpData.copyChannel(src_bmpData, src_bmpData.rect, new Point(0, 0), BitmapDataChannel.GREEN, BitmapDataChannel.GREEN);
					break;
				
				case BLUE:
					out_bmpData.copyChannel(src_bmpData, src_bmpData.rect, new Point(0, 0), BitmapDataChannel.BLUE, BitmapDataChannel.BLUE);
					break;
			}
			
			return (out_bmpData);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function dropChannel(src_bmpData:BitmapData, channel:String):BitmapData {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
			
			// array of channels to copy
			var chan_arr:Array = new Array();
				chan_arr.push(BitmapDataChannel.ALPHA);
				chan_arr.push(BitmapDataChannel.RED);
				chan_arr.push(BitmapDataChannel.GREEN);
				chan_arr.push(BitmapDataChannel.BLUE);
			
			// destination pt
			var dest_pt:Point = new Point();
				
			// a new bmp data
			var out_bmpData:BitmapData = new BitmapData(src_bmpData.width, src_bmpData.height, true, 0x00);
			
			
			switch (channel) {
				
				case ALPHA:
					chan_arr.splice(0, 1);
					break;
				
				case RED:
					chan_arr.splice(1, 1);
					break;
				
				case GREEN:
					chan_arr.splice(2, 1);
					break;
				
				case BLUE:
					chan_arr.splice(3, 1);
					break;
			}
			
			
			for (var i:int = 0; i < chan_arr.length; i++)
				out_bmpData.copyChannel(src_bmpData, src_bmpData.rect, dest_pt, int(chan_arr[i]), int(chan_arr[i]));
			
			
			return (out_bmpData);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function swapChannels(src_bmpData:BitmapData, channel1:String, channel2:String):BitmapData {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	

			if (channel1 == channel2)
				return (src_bmpData);
			
			
			// a new bmp data
			var out_bmpData:BitmapData = new BitmapData(src_bmpData.width, src_bmpData.height, true, 0x00);
			
			var swap_pt:Point = new Point();
			var dest_pt:Point = new Point();
			
			var chann_arr:Array = new Array();
				chann_arr.push(BitmapDataChannel.ALPHA);
				chann_arr.push(BitmapDataChannel.RED);
				chann_arr.push(BitmapDataChannel.GREEN);
				chann_arr.push(BitmapDataChannel.BLUE);
				
			
			switch (channel1) {
				
				case ALPHA:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.ALPHA);
					swap_pt.x = BitmapDataChannel.ALPHA;
					break;
				
				case RED:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.RED);
					swap_pt.x = BitmapDataChannel.RED;
					break;
				
				case GREEN:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.GREEN);
					swap_pt.x = BitmapDataChannel.GREEN;
					break;
				
				case BLUE:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.BLUE);
					swap_pt.x = BitmapDataChannel.BLUE;
					break;
			}
			
			
			
			switch (channel2) {
				
				case ALPHA:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.ALPHA);
					swap_pt.y = BitmapDataChannel.ALPHA;
					break;
				
				case RED:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.RED);
					swap_pt.y = BitmapDataChannel.RED;
					break;
				
				case GREEN:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.GREEN);
					swap_pt.y = BitmapDataChannel.GREEN;
					break;
				
				case BLUE:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.BLUE);
					swap_pt.y = BitmapDataChannel.BLUE;
					break;
			}
			
			// swap the two channels
			out_bmpData.copyChannel(src_bmpData, src_bmpData.rect, dest_pt, swap_pt.x, swap_pt.y);
			out_bmpData.copyChannel(src_bmpData, src_bmpData.rect, dest_pt, swap_pt.y, swap_pt.x);
			
			// copy the rest
			for (var i:int=0; i<chann_arr.length; i++)
				out_bmpData.copyChannel(src_bmpData, src_bmpData.rect, dest_pt, int(chann_arr[i]), int(chann_arr[i]));
			
			
			return (out_bmpData);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
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
		
		
		public static function chroma(bmpData:BitmapData, red:uint, green:uint, blue:uint):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
			for (var i:int=0; i<bmpData.width*bmpData.height; i++) {  
				var r:int = bmpData.getPixel32(i % bmpData.width, i / bmpData.width) + 0;  
				var g:int = bmpData.getPixel32(i % bmpData.width, i / bmpData.width) + 1;  
				var b:int = bmpData.getPixel32(i % bmpData.width, i / bmpData.width) + 2;  
				
				if (g > green && r > red && b < blue)  
					bmpData.setPixel32(i % bmpData.width, i / bmpData.width, Color.compARGBToHex(0x00, r, g, b)); 
			}
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		public static function avgColor(src:BitmapData, bounds:Rectangle=null, samples:Point=null):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			var color:uint;
			
			if (!bounds)
				bounds = src.rect;
			
			if (!samples)
				samples = new Point(4, 4);
			
			
			for (var i:int=0; i<samples.x; i++) {
				for (var j:int=0; j<samples.y; i++) {
					color += src.getPixel32(bounds.x, bounds.y);
				}
			}
			
			color /= i * j;
			
			return (color);
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