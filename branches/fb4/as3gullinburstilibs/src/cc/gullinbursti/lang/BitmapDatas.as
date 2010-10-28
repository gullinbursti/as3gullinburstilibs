package cc.gullinbursti.lang {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
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
		
		
		
		public static function xeroxDisplayObject(dispObj:DisplayObject):BitmapData {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
			
			// bounding rectangle
			var bounds_rect:Rectangle = dispObj.getBounds(dispObj);
			
			// a new bmp data
			var bmpData:BitmapData = new BitmapData(int(bounds_rect.width + 0.5), int(bounds_rect.height + 0.5), true, 0x00);
				bmpData.draw(dispObj, new Matrix(1, 0, 0, 1, -bounds_rect.x, -bounds_rect.y));
			
			return (bmpData);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
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
		
	}
}