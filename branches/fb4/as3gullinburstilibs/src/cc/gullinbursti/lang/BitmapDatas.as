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
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
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
		
		
		
		public static function extractChannel(in_bmpData:BitmapData, channel:String):BitmapData {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
			
			// a new bmp data
			var bmpData:BitmapData = new BitmapData(in_bmpData.width, in_bmpData.height, true, 0x00);
			var copy:uint;
			
			switch (channel) {
				case "red":
					copy = BitmapDataChannel.RED;
					break;
				
				case "green":
					copy = BitmapDataChannel.GREEN;
					break;
				
				case "blue":
					copy = BitmapDataChannel.BLUE;
					break;
				
				case "alpha":
					copy = BitmapDataChannel.ALPHA;
					break;
			}
			
			
			for (var i:int=0; i<in_bmpData.height; i++) {
				for (var j:int=0; j<in_bmpData.width; j++)
					bmpData.copyChannel(in_bmpData, in_bmpData.rect, new Point(j, i), copy, copy);
			}
			
			
			return (bmpData);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function dropChannel(in_bmpData:BitmapData, channel:String):BitmapData {
			//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
			
			// a new bmp data
			var bmpData:BitmapData = new BitmapData(in_bmpData.width, in_bmpData.height, true, 0x00);
			var drop:uint;
			
			switch (channel) {
				case "red":
					drop = BitmapDataChannel.RED;
					break;
				
				case "green":
					drop = BitmapDataChannel.GREEN;
					break;
				
				case "blue":
					drop = BitmapDataChannel.BLUE;
					break;
				
				case "alpha":
					drop = BitmapDataChannel.ALPHA;
					break;
			}
			
			
			for (var i:int=0; i<in_bmpData.height; i++) {
				for (var j:int=0; j<in_bmpData.width; j++) {
					
					if (drop != BitmapDataChannel.RED)
						bmpData.copyChannel(in_bmpData, in_bmpData.rect, new Point(j, i), BitmapDataChannel.RED, BitmapDataChannel.RED);
				
					if (drop != BitmapDataChannel.GREEN)
						bmpData.copyChannel(in_bmpData, in_bmpData.rect, new Point(j, i), BitmapDataChannel.GREEN, BitmapDataChannel.GREEN);
					
					if (drop != BitmapDataChannel.BLUE)
						bmpData.copyChannel(in_bmpData, in_bmpData.rect, new Point(j, i), BitmapDataChannel.BLUE, BitmapDataChannel.BLUE);
					
					if (drop != BitmapDataChannel.ALPHA)
						bmpData.copyChannel(in_bmpData, in_bmpData.rect, new Point(j, i), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
				}
			}
			
			
			return (bmpData);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function swapChannels(in_bmpData:BitmapData, channel1:String, channel2:String):BitmapData {
			//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
			
			// a new bmp data
			var bmpData:BitmapData = new BitmapData(in_bmpData.width, in_bmpData.height, true, 0x00);
			var swap_pt:Point = new Point();
			
			switch (channel1) {
				case "red":
					swap_pt.x = BitmapDataChannel.RED;
					break;
				
				case "green":
					swap_pt.x = BitmapDataChannel.GREEN;
					break;
				
				case "blue":
					swap_pt.x = BitmapDataChannel.BLUE;
					break;
				
				case "alpha":
					swap_pt.x = BitmapDataChannel.ALPHA;
					break;
			}
			
			
			switch (channel2) {
				case "red":
					swap_pt.y = BitmapDataChannel.RED;
					break;
				
				case "green":
					swap_pt.y = BitmapDataChannel.GREEN;
					break;
				
				case "blue":
					swap_pt.y = BitmapDataChannel.BLUE;
					break;
				
				case "alpha":
					swap_pt.y = BitmapDataChannel.ALPHA;
					break;
			}
			
			
			for (var i:int=0; i<in_bmpData.height; i++) {
				for (var j:int=0; j<in_bmpData.width; j++) {
					
					if (swap_pt.x != BitmapDataChannel.RED && swap_pt.y != BitmapDataChannel.RED)
						bmpData.copyChannel(in_bmpData, in_bmpData.rect, new Point(j, i), BitmapDataChannel.RED, BitmapDataChannel.RED);
					
					else if (swap_pt.x != BitmapDataChannel.GREEN && swap_pt.y != BitmapDataChannel.GREEN)
						bmpData.copyChannel(in_bmpData, in_bmpData.rect, new Point(j, i), BitmapDataChannel.GREEN, BitmapDataChannel.GREEN);
					
					else if (swap_pt.x != BitmapDataChannel.BLUE && swap_pt.y != BitmapDataChannel.BLUE)
						bmpData.copyChannel(in_bmpData, in_bmpData.rect, new Point(j, i), BitmapDataChannel.BLUE, BitmapDataChannel.BLUE);
					
					else if (swap_pt.x != BitmapDataChannel.ALPHA && swap_pt.y != BitmapDataChannel.ALPHA)
						bmpData.copyChannel(in_bmpData, in_bmpData.rect, new Point(j, i), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
					
					else {
						bmpData.copyChannel(in_bmpData, in_bmpData.rect, new Point(j, i), swap_pt.x, swap_pt.y);
						bmpData.copyChannel(in_bmpData, in_bmpData.rect, new Point(j, i), swap_pt.y, swap_pt.x);
					}
				}
			}
			
			
			return (bmpData);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}