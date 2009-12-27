package cc.gullinbursti.vo  {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class MouseVO extends AbstractUserInputVO {
		
		public var evt_name:String;
		public var trg_obj:Object;
		public var currTrg_obj:Object;
		public var mouseEvt:MouseEvent;
		
		public var local_pt:Point = new Point();
		public var isWheeling:Boolean = false;
		public var isBtnDown:Boolean;
		public var wheel_delta:int = 0;
		
		public var isCtrl:Boolean;
		public var isAlt:Boolean;
		public var isShift:Boolean;
		
		public var keyDn_bits:uint = 0x000;
		
		
		public function MouseVO(evtType:String, isWheel:Boolean=false, e:MouseEvent=null) {
			super(e as Event);
			
			evt_name = evtType;
			isWheeling = isWheel;
			
			mouseEvt = e as MouseEvent
			wheel_delta = e.delta;
			
			local_pt.offset(e.localX, e.localY);
				
			trg_obj = e.target;
			currTrg_obj = e.currentTarget;
			
			trace (keyDn_bits >> 0x010);
			
		}
	}
}