package cc.gullinbursti.lang {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [!]>
	public class Sprites {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>	
		
		// <*] class constructor [*>
		public function Sprites() {/*..\(^_^)/..*/}
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
	}
}