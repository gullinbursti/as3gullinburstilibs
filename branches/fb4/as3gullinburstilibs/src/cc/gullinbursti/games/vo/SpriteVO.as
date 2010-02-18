/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	GameSpriteVO.as
 * Package	:	cc.gullinbursti.games.vo
 * Version	: 	1.0
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	08-25-09
 * 
 * Purpose	:	Provides a base VO class for game sprites.
 * 
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~·¯
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~·¯
**/



package cc.gullinbursti.games.vo {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.utils.Arrays;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.media.Sound;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [!]>	
	public class SpriteVO {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public var id:String;
		public var name_str:String;
		public var isClipping:Boolean;
		public var frames_arr:Array;
		public var frames_tot:int;
		public var sfx_arr:Array;
		public var pos_pt:Point;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		// <*] class constructor [*>
		public function SpriteVO(spriteID:String, name:String, clipping:Boolean=false, pos:Point=null, imgs:Array=null, sfx:Array=null) {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			// attribs
			id = spriteID;
			name_str = name;
			isClipping = clipping;
			
			// copy bmp frames if any
			frames_arr = Arrays.elementTypeCopy(BitmapData, imgs);
			frames_tot = frames_arr.length;
			
			sfx_arr = Arrays.elementTypeCopy(Sound, sfx);
			
			if (pos)
				pos_pt = pos.clone();
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function clone():GameItemSpriteVO {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			return (new GameItemSpriteVO(this.id, this.name_str, pos_pt, this.frames_arr, this.sfx_arr));
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function replaceFrame(ind:int, bmpData:BitmapData):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			// index in bounds
			if (ind < frames_tot) {
			
				// get current frame & trash it
				var bmpData:BitmapData = (frames_arr[ind] as BitmapData);
					bmpData.dispose();
					
				// set a clone on index
				frames_arr[ind] = bmpData.clone();
			}
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function replaceAllFrames(imgs_arr:Array):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			// get current frame & trash it
			for (var i:int=0; i<frames_tot; i++) {
				var bmpData:BitmapData = (frames_arr[i] as BitmapData);
					bmpData.dispose();	
			}
			
			// update frame array & total
			frames_arr = Arrays.elementTypeCopy(BitmapData, imgs_arr);
			frames_tot = frames_arr.length;
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}