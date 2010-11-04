package cc.gullinbursti.vo {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import flash.events.KeyboardEvent;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [¡]>
	public class KeyboardVO extends AbstractUserInputVO {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public var key_code:int;
		public var isPressed:Boolean;
		public var evt:KeyboardEvent;
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		
		
		// <*] class constructor [*>
		public function KeyboardVO(code:int, isDown:Boolean=true, e:KeyboardEvent=null) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			super(e);
			
			key_code = code;
			isPressed = isDown;
			
			if (e)
				this.evt = e;
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}