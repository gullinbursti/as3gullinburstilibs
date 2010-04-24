package utils.layout {
	import flash.display.DisplayObject;
	/**
	 * @author arwidthornstrom
	 * @time Sep 1, 2009
	 * @project Doritos_CTSB
	 */
	public class Resize {
		
		public static function fullscreenMiddleResize(clip:DisplayObject, ratio:Number, stageWidth:Number, stageHeight:Number):void {
			
			if(stageWidth / stageHeight > ratio) {
				clip.width = stageWidth;
				clip.height = stageWidth / ratio;
				
				clip.y = stageHeight/2 - clip.height/2;
				clip.x = 0;
				
			} else {
				clip.height = stageHeight;
				clip.width = stageHeight * ratio;
				
				clip.x = stageWidth/2 - clip.width/2;
				clip.y = 0;
				
			}
			
		}
		
		public static function fullscreenMiddleTallTopWideResize(clip:DisplayObject, ratio:Number, stageWidth:Number, stageHeight:Number):void {
			var vy:Number = 0;
			if ((stageHeight/2 - clip.height/2) < 0) {
				vy = (stageHeight/2 - clip.height/2)*.5;
			} else {
				vy = (stageHeight/2 - clip.height/2);
			}
					
			if(stageWidth / stageHeight > ratio) {
				clip.width = stageWidth;
				clip.height = stageWidth / ratio;
				
				clip.x = 0;
				clip.y = vy;
				
			} else {
				clip.height = stageHeight;
				clip.width = stageHeight * ratio;
				
				clip.x = stageWidth/2 - clip.width/2;
				clip.y = 0;
				
			}
			
		}
		
		public static function fullscreenMiddleTallBottomWideResize(clip:DisplayObject, ratio:Number, stageWidth:Number, stageHeight:Number):void {
			
			var vy:Number = 0;
			if ((stageHeight - clip.height) < 0) {
				vy = (stageHeight - clip.height)*.8;
			} else {
				vy = stageHeight - clip.height;
			}	
			
			if(stageWidth / stageHeight > ratio) {
				clip.width = stageWidth;
				clip.height = stageWidth / ratio;
				
				clip.x = 0;
				clip.y = vy;
				
			} else {
				clip.height = stageHeight;
				clip.width = stageHeight * ratio;
				
				clip.x = stageWidth/2 - clip.width/2;
				clip.y = 0;
				
			}
			
		}
		
		public static function fullscreenMiddleTallPercBottomWideResize(clip:DisplayObject, ratio:Number, stageWidth:Number, stageHeight:Number, shift:Number):void {
			
			var vy:Number = 0;
			if ((stageHeight - clip.height) < 0) {
				vy = (stageHeight - clip.height)*shift;
			} else {
				vy = stageHeight - clip.height;
			}	
			
			if(stageWidth / stageHeight > ratio) {
				clip.width = stageWidth;
				clip.height = stageWidth / ratio;
				
				clip.x = 0;
				clip.y = vy;
				
			} else {
				clip.height = stageHeight;
				clip.width = stageHeight * ratio;
				
				clip.x = stageWidth/2 - clip.width/2;
				clip.y = 0;
				
			}
			
		}
		
	}
}
