/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	NPCGameSpriteVO.as
 * Package	:	cc.gullinbursti.games.vo
 * Version	: 	1.0
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	08-25-09
 * 
 * Purpose	:	Provides a VO class for NPC game character sprites.
 * 
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~·¯
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~·¯
**/



package cc.gullinbursti.games.vo {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.utils.Arrays;
	
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [!]>
	public class NPCGameSpriteVO extends InteractiveGameSpriteVO {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public var dialog_arr:Array;
		public var dialog_tot:int;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		// <*] class constructor [*>	
		public function NPCGameSpriteVO(spriteID:String, name:String, pos:Point=null, imgs:Array=null, sfx:Array=null, dialog:Array=null) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// id / name / has clipping / frames / sfx
			super(spriteID, name, false, pos, imgs, sfx);
			
			dialog_arr = Arrays.elementTypeCopy(String, dialog);
			dialog_tot = dialog_arr.length;
			
		}//~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function appendDialogLine(msg_str:String):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			dialog_arr.push(msg_str);
			dialog_tot = dialog_arr.length;
			
		}//~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}