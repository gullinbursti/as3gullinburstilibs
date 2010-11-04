package cc.gullinbursti.puremvc.view.ui {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.puremvc.interfaces.IGullinUISprite_PMVC;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[

	// <[!] class delaration [¡]>
	public class AbstractSpriteUI_PMVC extends Sprite implements IGullinUISprite_PMVC {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[

		// <*] class constructor [*>
		public function AbstractSpriteUI_PMVC() {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractSpriteUI_PMVC <]=");
			
			super();
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public function onMediatorDrafted():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractSpriteUI_PMVC.onMediatorDrafted <]=");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function onMediatorRelieved():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractSpriteUI_PMVC.onMediatorRelieved <]=");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function onStageAdoption(stage_size:Point=null):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractSpriteUI_PMVC.onStageAdoption <]= ("+stage_size+")");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function onStageOrphaned():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractSpriteUI_PMVC.onStageOrphaned <]=");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function onStageResized(stage_size:Point):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractSpriteUI_PMVC.onStageResized <]= ("+stage_size+")");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function onEnterFrame():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractSpriteUI_PMVC.onEnterFrame <]=");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		protected function renderMe(stage_size:Point=null):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractSpriteUI_PMVC.renderMe <]= ("+stage_size+")");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		protected function scaffold(stage_size:Point=null):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractSpriteUI_PMVC.scaffold <]= ("+stage_size+")");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}