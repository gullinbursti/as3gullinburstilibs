package cc.gullinbursti.lang {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
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
		
	}
}