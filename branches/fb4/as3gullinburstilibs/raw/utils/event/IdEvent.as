package utils.event {
	/** */
	import flash.events.Event;

	/**
	* @author nikkoh
	*/
	public class IdEvent extends Event {
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
		 */
		public function IdEvent(type:String, bubbels:Boolean = false, cancelable:Boolean = false, id : String = "") {
			_id = id;
			super(type, bubbels, cancelable);
		}
		/**
		 * 
		 */
		override public function clone():Event {
			var temp:IdEvent = new IdEvent(type, bubbles, cancelable);
			temp.id = id;
			return temp;
		}
	}
}
