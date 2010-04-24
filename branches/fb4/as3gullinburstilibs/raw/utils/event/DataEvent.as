package utils.event {
	import flash.events.Event;

	/**
	 * @author Svante
	 */
	public class DataEvent extends Event {
		private var _data : Object;
		
		public function DataEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false,data:Object=null) {
			_data = data;
			super(type, bubbles, cancelable);
		}
		
		public function get data() : Object {
			return _data;
		}
		
		public function set data(a_val : Object) : void {
			_data = a_val;
		}
	}
}
