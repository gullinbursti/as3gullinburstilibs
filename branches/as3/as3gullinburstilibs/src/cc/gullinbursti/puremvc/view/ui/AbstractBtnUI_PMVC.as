package cc.gullinbursti.puremvc.view.ui {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.puremvc.interfaces.IGullinUISprite_PMVC;
	
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[

	// <[!] class delaration [¡]>
	public class AbstractBtnUI_PMVC extends AbstractSpriteUI_PMVC implements IGullinUISprite_PMVC {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[

		// <*] class constructor [*>	
		public function AbstractBtnUI_PMVC() {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			super();
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		override public function onStageAdoption(stage_size:Point=null):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		override public function onMediatorDrafted():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		override public function onStageOrphaned():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		override public function onMediatorRelieved():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		override public function onStageResized(stage_size:Point):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		override public function onEnterFrame():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		override protected function renderMe(stage_size:Point=null):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		override protected function scaffold(stage_size:Point=null):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}