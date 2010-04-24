package utils.event {
	/** */
	import flash.events.Event;
	import flash.events.ProgressEvent;
	/**
	* @author nikkoh
	*/
	public class IdProgressEvent extends ProgressEvent {
		/**
		 * VARIABLES
		 */
		private var _id:String;
		/**
		 * GETTERS AND SETTERS
		 */
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		/**
		 * CONSTRUCTOR
		 * @param type					<String>
		 * @param bubbels				<Boolean (default = false)>
		 * @param cancelable			<Boolean (default = false)>
		 * @param bytesLoaded			<int (default = 0)>
		 * @param bytesTotal			<int (default = 0)>
		 */
		public function IdProgressEvent(type:String, bubbels:Boolean = false, cancelable:Boolean = false, bytesLoaded:int = 0, bytesTotal:int = 0) {
			super(type, bubbels, cancelable, bytesLoaded, bytesTotal);
		}
		/**
		 * 
		 */
		override public function clone():Event {
			var temp:IdProgressEvent = new IdProgressEvent(type, bubbles, cancelable, bytesLoaded, bytesTotal);
			temp.id = id;
			return temp;
		}
	}
}
