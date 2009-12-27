package cc.gullinbursti.ui
{
	import cc.gullinbursti.interfaces.IGullinSprite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class AbstractImageSprite extends Sprite implements IGullinSprite {
		
		private var img_bmpData:BitmapData;
		private var imgHolder_sprite:Sprite;
		private var imgOffset_pt:Point;
		
		public function AbstractImageSprite(bmpData:BitmapData=null, params:Object=null) {
			super();
			
			imgHolder_sprite = new Sprite();
			
			if (bmpData) {
				img_bmpData = bmpData.clone();
				
				imgHolder_sprite.x = -img_bmpData.width / 2;
				imgHolder_sprite.y = -img_bmpData.height / 2;
				
				imgHolder_sprite.addChild(new Bitmap(img_bmpData));
			}
			
			// apply sprite params
			for (var prop:* in params) {
				imgHolder_sprite[prop] = params[prop];
			}
		}
		
		public function set bmpData(val:BitmapData):void {
			img_bmpData = val.clone();
			
			orphanBmp();
			adoptImgAsBmp(img_bmpData);
		}
		
		public function set offset(val:Point):void {
			imgOffset_pt = val.clone();	
			
			imgHolder_sprite.x = imgOffset_pt.x;
			imgHolder_sprite.y = imgOffset_pt.y;
		}
		
		public function adoptImgAsBmp(bmpData:BitmapData=null):void {
			
			if (bmpData) {
				img_bmpData = bmpData.clone();
			}
			
			this.addChild(new Bitmap(img_bmpData));
		}
		
		public function onStageAdoption(stage_size:Point=null):void {
		}
		
		public function onStageOrphaned():void {
			
			orphanBmp();
		}
		
		public function onStageResized(stage_size:Point):void {
		}
		
		public function onEnterFrame():void {
		}
		
		private function orphanBmp():void {
			
			if (imgHolder_sprite.numChildren == 1) {
				imgHolder_sprite.removeChildAt(0);
			}
		}
	}
}