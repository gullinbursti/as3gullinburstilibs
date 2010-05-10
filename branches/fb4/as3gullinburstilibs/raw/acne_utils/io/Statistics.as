package utils.io {
	import com.google.analytics.GATracker;

	import flash.display.DisplayObject;
	import flash.errors.IllegalOperationError;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	/** */
	/**
	 * @author nikkoh
	*/
	public class Statistics {
		/**
	 	* VARIABLES 
	 	*/		
		private static var _instance:Statistics;
		
		private var _statistics:Object = new Object();

		private var _tracker:GATracker;
		
//		private var _statisticsFunc:String = "";
		private var _baseString:String = "";
		
		private var _sendQueue:Array = new Array();
		private var _isQueing:Boolean = false;
		private var _queueTimer:Timer;

		/**
		 *  CONSTRUCTOR
	 	*/			
		public function Statistics(singletonEnforcer:SingletonEnforcer){
		}
		/**
	 	* SINGLETON FUNCTION
	 	*/
		public static function get instance():Statistics {
			if (Statistics._instance == null) {
				Statistics._instance = new Statistics(new SingletonEnforcer());
			}
			return Statistics._instance;
		}
		/**
		 * 
		 */
		public function setTracker(root:DisplayObject, trackingCode:String):void{
			_tracker = new GATracker(root, trackingCode);
		}
		/**
	 	* GETTERS AND SETTERS
	 	*/
//	 	public function get statisticsFunc():String { return _statisticsFunc; }
//	 	public function set statisticsFunc(statisticsFunc:String):void { _statisticsFunc = statisticsFunc; }
	 	public function get baseString():String { return _baseString; }
	 	public function set baseString(str:String):void { _baseString = str; }	 		 	
		/**
		 * 
		 */
		private function startQueueTimer():void {
			// Stop old
			stopQueueTimer();
			
			// Create new
			_queueTimer = new Timer(1000);
			_queueTimer.addEventListener(TimerEvent.TIMER, onQueTimer);
			_queueTimer.start();
			
			_isQueing = true;
		}
		/**
		 * 
		 */
		private function stopQueueTimer():void {
			if (_queueTimer) {
				_queueTimer.stop();
				_queueTimer = null;
				
				_isQueing = false;
			}
		}
		/**
		 * @param id 	String 	The id of the data. See function "sendStat".
		 * @param data 	String 	The data to be sent to javascript function.
		 */	
		public function registerStatItem(id:String, data:String):void {	
			//trace("StatisticsJS.instance.registerStatItem() - " + id + " = " + data);
			_statistics[id] = data;
		}
		/**
		 * 
		 */
		public function sendStat(id:String, extra:String = null, delimiter:String = "/"):void {
//			trace("Statistics.instance.sendStat() - " + id);
			var statStr:String = _statistics[id];
			try {
				if (statStr != null) {
					if (extra != null) {
						statStr += delimiter + extra;
						statStr = statStr.replace(" ", "_");
//						trace(statStr)
					}
					sendStatToQueue(statStr);
				} else {
					throw new IllegalOperationError("Statistics.instance.SendStat() - id not found \"" + id + "\"");
				}
			} catch (error:IllegalOperationError) {
				//trace("StatisticsJS: " + error);
//				throw new IllegalOperationError("StatisticsJS: " + error);
			}
		}
		/**
		 * 
		 */
		private function sendStatToQueue(statStr:String):void {
			//trace("StatisticsJS.instance.sendStatToQueue() - " + statStr);
			_sendQueue.push({statStr:statStr, time:getTimer()});
			if (_isQueing != true) {
				startQueueTimer();
			}
		}
		/**
	 	* 
	 	*/			
		private function onQueTimer(event:TimerEvent):void {
//			trace("Statistics.instance.onQueTimer() - " + _sendQueue[0].statStr);
			
			var obj:Object = _sendQueue.shift();
			var statStr:String = _baseString + obj.statStr;
			
			if(_tracker == null)throw new IllegalOperationError("TRACKING ERROR: tracker needs to be set");
			_tracker.trackPageview(statStr);
			
			// Check queue
			if (_sendQueue.length < 1) {
				stopQueueTimer();
			}
			
		}
	}
}
/**
* 
*/	
class SingletonEnforcer {

}