package cc.gullinbursti.lang {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [!]>
	public class DisplayObjs {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>	
		
		// <*] class constructor [*>
		public function DisplayObjs() {/*..\(^_^)/..*/}
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function fill(sprite:Sprite, color:uint, opac:Number, bounds:Rectangle=null, isClear:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			if (!bounds)
				bounds = new Rectangle(0, 0, sprite.width, sprite.height);
			
			
			var g:Graphics = sprite.graphics;
			
			if (isClear)
				g.clear();
			
			
			g.beginFill(color, opac);
			g.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
			g.endFill();
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function outline(sprite:Sprite, color:uint, opac:Number, thick:Number=1, bounds:Rectangle=null, isClear:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			if (!bounds)
				bounds = new Rectangle(0, 0, sprite.width, sprite.height);
			
			
			var g:Graphics = sprite.graphics;
			
			if (isClear)
				g.clear();
			
			
			g.lineStyle(thick, color, opac);
			g.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
			g.endFill();
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function xeroxOnBmpData(dispObj:DisplayObject):BitmapData {
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