package utils.user {
	/**
	* @author nikkoh
	*/
	public class KBPS {
		/**
		 * VARIABLES
		 */
		private static var _instance:KBPS;
		
		private var _totalBytes:uint = 1;
		private var _totalMilliSecs:uint = 1;
		private var _values:Array;
		private var _minMilliSecs:uint = 1000;
		private var _defaultKBPS:Number = 60;
		/**
		 * GETTERS AND SETTERS
		 */
		public function get totalBytes():uint {
			return _totalBytes;
		}
		public function get totalMilliSecs():uint {
			return _totalMilliSecs;
		}
		public function get totalAdds():uint {
			if (_values) {
				return _values.length;
			}
			return 0;
		}
		public function set minMilliSecs(minMilliSecs:uint):void {
			_minMilliSecs = minMilliSecs;
		}
		public function get minMilliSecs():uint {
			return _minMilliSecs;
		}
		public function set defaultKBPS(defaultKBPS:Number):void {
			_defaultKBPS = defaultKBPS;
		}
		public function get defaultKBPS():Number {
			return _defaultKBPS;
		}
		/**
		 * CONSTRUCTOR
		 */
		public function KBPS(pvt:SingletonEnforcer) {
			
		}
		/**
		 * SINGLETON
		 */
		public static function get instance():KBPS {
			if (KBPS._instance == null) {
				KBPS._instance = new KBPS(new SingletonEnforcer());
			}
			return KBPS._instance;
		}
		/**
		 * FUNCTIONS
		 */
		public function addLoadData(bytes:uint, millisecs:uint):void {
			if (millisecs > _minMilliSecs) {
				_totalBytes += bytes;
				_totalMilliSecs += millisecs;
			
				addValues(bytes, millisecs);
			}
		}
		/**
		 * 
		 */
		private function getKBPS(bytes:uint, millisecs:uint):Number {
			var kb:Number = bytes / 1024;
			var sec:Number = millisecs * 0.001;
			return kb / sec;
		}
		/**
		 * 
		 */
		private function addValues(bytes:uint, millisecs:uint):void {
			if (!_values) {
				_values = new Array();
			}
			var kbps:int = int(getKBPS(bytes, millisecs)) + 1;
//			trace("KBPS.addValues() - kbps = " + kbps);
			_values.push(kbps);
		}
		/**
		 * 
		 */
		public function getMean():Number {
			if (_totalBytes > 1) {
				return getKBPS(_totalBytes, _totalMilliSecs);
			}
			return _defaultKBPS;
			
		}
		/**
		 * 
		 */
		public function getMedian():Number {
			// Variables
			var s:Number;
			var len:int;
			// Length
			if (_values) {
				len = _values.length;
			} else {
				len = 0;
			}
			// Median
			if (len > 2) {
				// Sort
				_values.sort(Array.NUMERIC);
				var mid:int = int(len * 0.5);
				// Is even
				if (len % 2 == 0) {
					mid--;
					s = (_values[mid] + _values[(mid + 1)]) * 0.5;
				// Is odd
				} else {
					s = _values[mid];
				}
			// Default to mean
			} else {
				s = getMean();
			}
			// Return
			return s;
		}
		/**
		 * 
		 */
		public function reset():void {
			_totalBytes = 1;
			_totalMilliSecs = 1;
			
			_values = null;
		}
	}
}
/**
 * 
 */
class SingletonEnforcer {
	public function SingletonEnforcer() {
	}
}

