package cc.gullinbursti.lang {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.converts.Angle;
	import cc.gullinbursti.converts.Color;
	import cc.gullinbursti.math.algebra.Matrices;
	import cc.gullinbursti.math.probility.Randomness;
	
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [!]>
	public class BitmapDatas {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		// ]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const MAX_DIM:Rectangle = new Rectangle(0, 0, 2880, 2800);
		private static const ORIGIN:Point = new Point();
		
		private static const R_LUM:Number = 0.212671; //0.3086;
		private static const G_LUM:Number = 0.715160; //0.6094;
		private static const B_LUM:Number = 0.072169; //0.0820;
		private static const A_LUM:Number = 0.0;
		
		private static const LUM_MATRIX:Array = new Array(
			R_LUM, G_LUM, B_LUM,
			R_LUM, G_LUM, B_LUM,
			R_LUM, G_LUM, B_LUM
		);
		
		private static const SAT_MATRIX:Array = new Array(
			 0.787, -0.715, -0.072,
			-0.212,  0.285, -0.072,
			-0.213, -0.715,  0.928
		);
		
		private static const HUE_MATRIX:Array = new Array(
			-0.213, -0.715,  0.928,
			 0.143,  0.140, -0.283,
			-0.787,  0.715,  0.072
		);
		
		private static const SEED_MAX:int = 2048;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		// <*] class constructor [*>
		public function BitmapDatas() {/*..\(^_^)/..*/}
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function greyscale(src_bmpData:BitmapData):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			src_bmpData.applyFilter(src_bmpData, src_bmpData.rect, ORIGIN, ColorMatrixFilters.greyscale());
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		public static function negative(src_bmpData:BitmapData):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			src_bmpData.applyFilter(src_bmpData, src_bmpData.rect, ORIGIN, ColorMatrixFilters.negative());
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		public static function briten(src_bmpData:BitmapData, amt:int=0):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			src_bmpData.applyFilter(src_bmpData, src_bmpData.rect, ORIGIN, ColorMatrixFilters.briten(amt));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		public static function contrast(src_bmpData:BitmapData, amt:Number=0):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			// apply filter
			src_bmpData.applyFilter(src_bmpData, src_bmpData.rect, ORIGIN, ColorMatrixFilters.contrast(amt));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		public static function saturate(src_bmpData:BitmapData, amt:Number=0):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			// apply filter
			src_bmpData.applyFilter(src_bmpData, src_bmpData.rect, ORIGIN, ColorMatrixFilters.saturate(amt));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		public static function hue(src_bmpData:BitmapData, amt:Number=0):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			src_bmpData.applyFilter(src_bmpData, src_bmpData.rect, ORIGIN, ColorMatrixFilters.hue(amt));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function extractChannel(src_bmpData:BitmapData, channel:uint, isMap:Boolean=false):BitmapData {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
			
			// a new bmp data
			var out_bmpData:BitmapData = new BitmapData(src_bmpData.width, src_bmpData.height, true, 0xff000000);
				out_bmpData.copyChannel(src_bmpData, src_bmpData.rect, ORIGIN, channel, channel);
			
			// convert to greyscale if a depth map 
			if (isMap)
				greyscale(out_bmpData);
			
			return (out_bmpData);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function dropChannel(src_bmpData:BitmapData, channel:uint):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
			
			
			var filter:ColorMatrixFilter;
				
			
			switch (channel) {
				
				case BitmapDataChannel.ALPHA:
					filter = new ColorMatrixFilter(
						[1, 0, 0, 0, 0,
						 0, 1, 0, 0, 0,
						 0, 0, 1, 0, 0,
						 0, 0, 0, 0, 0]
					);
					break;
				
				case BitmapDataChannel.RED:
					filter = new ColorMatrixFilter(
						[0, 0, 0, 0, 0,
						 0, 1, 0, 0, 0,
						 0, 0, 1, 0, 0,
						 0, 0, 0, 1, 0]
					);
					break;
				
				case BitmapDataChannel.GREEN:
					filter = new ColorMatrixFilter(
						[1, 0, 0, 0, 0,
						 0, 0, 0, 0, 0,
						 0, 0, 1, 0, 0,
						 0, 0, 0, 1, 0]
					);
					break;
				
				case BitmapDataChannel.BLUE:
					filter = new ColorMatrixFilter(
						[1, 0, 0, 0, 0,
						 0, 1, 0, 0, 0,
						 0, 0, 0, 0, 0,
						 0, 0, 0, 1, 0]
					);
					break;
			}
			
			src_bmpData.applyFilter(src_bmpData, src_bmpData.rect, ORIGIN, filter);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * 
		 * @param src_bmpData
		 * @param channel1
		 * @param channel2
		 * @return 
		 * 
		 */		
		public static function swapChannels(src_bmpData:BitmapData, src_channel:uint, dest_channel:uint):BitmapData {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	

			if (src_channel == dest_channel)
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
				
			
			switch (src_channel) {
				
				case BitmapDataChannel.ALPHA:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.ALPHA);
					swap_pt.x = BitmapDataChannel.ALPHA;
					break;
				
				case BitmapDataChannel.RED:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.RED);
					swap_pt.x = BitmapDataChannel.RED;
					break;
				
				case BitmapDataChannel.GREEN:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.GREEN);
					swap_pt.x = BitmapDataChannel.GREEN;
					break;
				
				case BitmapDataChannel.BLUE:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.BLUE);
					swap_pt.x = BitmapDataChannel.BLUE;
					break;
			}
			
			
			
			switch (dest_channel) {
				
				case BitmapDataChannel.ALPHA:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.ALPHA);
					swap_pt.y = BitmapDataChannel.ALPHA;
					break;
				
				case BitmapDataChannel.RED:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.RED);
					swap_pt.y = BitmapDataChannel.RED;
					break;
				
				case BitmapDataChannel.GREEN:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.GREEN);
					swap_pt.y = BitmapDataChannel.GREEN;
					break;
				
				case BitmapDataChannel.BLUE:
					Arrays.purgeValue(chann_arr, BitmapDataChannel.BLUE);
					swap_pt.y = BitmapDataChannel.BLUE;
					break;
			}
			
			// swap the two channels
			out_bmpData.copyChannel(src_bmpData, src_bmpData.rect, dest_pt, swap_pt.x, swap_pt.y);
			out_bmpData.copyChannel(src_bmpData, src_bmpData.rect, dest_pt, swap_pt.y, swap_pt.x);
			
			// copy the rest
			for (var i:int=0; i<chann_arr.length; i++)
				out_bmpData.copyChannel(src_bmpData, src_bmpData.rect, ORIGIN, int(chann_arr[i]), int(chann_arr[i]));
			
			
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
		
		
		public static function generatePerlinNoise(octaves:int=2, isGreyscale:Boolean=true, basePt:Point=null, dim:Rectangle=null):BitmapData {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			if (!dim)
				dim = new Rectangle(0, 0, 128, 128);
			
			if (!basePt)
				basePt = new Point(8, 8);
			
			var offset_arr:Array = new Array();
			
			for (var i:int=0; i<octaves; i++)
				offset_arr.push(new Point(Randomness.generateSign(), Randomness.generateSign()));
			
			
			var out_bmpData:BitmapData = new BitmapData(dim.width, dim.height, false);
				out_bmpData.perlinNoise(basePt.x, basePt.y, octaves, Randomness.generateInt(0, SEED_MAX), false, true, 10, isGreyscale, offset_arr);
			
			return (out_bmpData);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function rotate(src_bmpData:BitmapData, amt:Number):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			var center_pt:Point = new Point(src_bmpData.width * 0.5, src_bmpData.height * 0.5);
			var out_bmpData:BitmapData = new BitmapData(src_bmpData.width, src_bmpData.height, true, 0x00000000);
			
			var mtx:Matrix = new Matrix();
				mtx.translate(-center_pt.x, -center_pt.y);
				mtx.rotate(Angle.degreesToRadians(amt));
				mtx.translate(center_pt.x, center_pt.y);
			
			out_bmpData.draw(src_bmpData, mtx);
			src_bmpData.draw(out_bmpData);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function flip(src_bmpData:BitmapData, isVertical:Boolean=true):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			var out_bmpData:BitmapData = new BitmapData(src_bmpData.width, src_bmpData.height, true, 0x00000000);
			var mtx:Matrix = new Matrix();
			
			
			if (isVertical) {
				mtx.scale(1, -1);
				mtx.translate(0, src_bmpData.height);
			
			} else {
				mtx.scale(-1, 1);
				mtx.translate(src_bmpData.width, 0);
			}
			
			
			out_bmpData.draw(src_bmpData, mtx);
			src_bmpData.draw(out_bmpData);
				
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