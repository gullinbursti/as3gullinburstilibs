package cc.gullinbursti.vo {
	
	import flash.events.Event;
	
	public class AbstractUserInputVO {
		
		public var evtType_evt:Event;
		public var evtType_name:String;
		
		
		public function AbstractUserInputVO (eType:Event) {
			
			evtType_evt = eType.clone();
			evtType_name = eType.toString();
		}

	}
}