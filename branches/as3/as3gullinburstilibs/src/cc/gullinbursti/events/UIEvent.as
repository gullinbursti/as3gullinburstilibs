package cc.gullinbursti.events {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import flash.events.Event;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	// <[!] class delaration [¡]>
	public class UIEvent extends Event {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const LOGO_CLICK:String = "LOGO_CLICK";
		public static const BTN_CLICK:String = "BTN_CLICK";
		
		public static const TEXTFIELD_KEYPRESS:String = "TEXTFIELD_KEYPRESS";
		
		
		public var data_obj:Object;
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		// <*] class constructor [*>
		public function UIEvent(type:String, payload:Object=null, bubbles:Boolean=true, cancelable:Boolean=true) {
			//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
			super(type, bubbles, cancelable);
			data_obj = payload;
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		override public function clone():Event {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
			return (new UIEvent(type, data_obj, bubbles, cancelable));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}