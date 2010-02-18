package cc.gullinbursti.ui {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.interfaces.IGullinSprite;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[

	// <[!] class delaration [¡]>
	public class AbstractGullinBtnSprite extends AbstractGullinSprite implements IGullinSprite {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		private var isEnabled:Boolean;
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[

		// <*] class constructor [*>
		public function AbstractGullinBtnSprite(rect:Rectangle, fill:uint=0x00ff00, enabled:Boolean=true) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			trace ("  =[> AbstractGullinBtnSprite <]= ("+rect+")");
			
			super();
			
			this.isEnabled = enabled; 
			
			this.graphics.beginFill(fill);
			this.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			this.graphics.endFill();
			
			this.buttonMode = this.useHandCursor = enabled;
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		override public function onStageAdoption(stage_size:Point=null):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractGullinBtnSprite.onStageAdoption <]= ("+stage_size+")");
			
			super.onStageAdoption(stage_size);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		override public function onStageOrphaned():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractGullinBtnSprite.onStageOrphaned <]=");
			
			super.onStageOrphaned();
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		override public function onStageResized(stage_size:Point):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractGullinBtnSprite.onStageResized <]= ("+stage_size+")");
			
			super.onStageResized(stage_size);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		override public function onEnterFrame():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractGullinBtnSprite.onEnterFrame <]=");
			
			super.onEnterFrame();
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		protected function toggleEnabled():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			trace ("  =[> AbstractGullinBtnSprite.toggleEnabled <]= ("+this.isEnabled+")");
			
			this.isEnabled = !isEnabled;
			this.buttonMode = this.useHandCursor = this.isEnabled;
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		private function renderMe(stage_size:Point):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractGullinBtnSprite.renderMe <]= ("+stage_size+")");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		private function scaffold(stage_size:Point=null):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("  =[> AbstractGullinBtnSprite.scaffold <]= ("+stage_size+")");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}