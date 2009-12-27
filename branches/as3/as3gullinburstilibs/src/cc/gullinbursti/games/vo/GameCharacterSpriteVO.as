/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	GameCharacterSpriteVO.as
 * Package	:	cc.gullinbursti.games.vo
 * Version	: 	1.0
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	08-25-09
 * 
 * Purpose	:	Extendable VO class for game character sprites.
 * 
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~·¯
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~·¯
**/



package cc.gullinbursti.games.vo {
	import flash.geom.Point;
	
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [!]>	
	public class GameCharacterSpriteVO extends InteractiveGameSpriteVO {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public var hp:Point;
		public var ap:Point;
		public var strength:Number;
		public var defense:Number;
		public var stamina:Number;
		public var luck:Number;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		// <*] class constructor [*>	
		public function GameCharacterSpriteVO(spriteID:String, name:String, hpVals:Point, apVals:Point, str:Number, def:Number, stam:Number, luk:Number, pos:Point=null, imgs:Array=null, sfx:Array=null) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			hp = hpVals.clone();
			ap = apVals.clone();
			
			strength = str;
			defense = def;
			stamina = stam;
			luck = luk;
			
			super(spriteID, name, false, pos, imgs, sfx);
			
		}//~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}