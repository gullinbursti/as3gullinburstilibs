package cc.gullinbursti.ui {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.interfaces.IGullinSprite;
	import flash.display.Sprite;
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[

	// <[!] class delaration [¡]>
	public class AbstractGullinSprite extends Sprite implements IGullinSprite {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		// <*] class constructor [*>
		public function AbstractGullinSprite() {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractGullinSprite <]=");
			
			super();
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public function onStageAdoption(stage_size:Point=null):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractGullinSprite <]= ("+stage_size+")");
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function onStageOrphaned():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractGullinSprite <]=");
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function onStageResized(stage_size:Point):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractGullinSprite <]= ("+stage_size+")");
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function onEnterFrame():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractGullinSprite <]=");
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}