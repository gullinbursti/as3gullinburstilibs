package utils.math {
	/**
	* @author nikkoh
	*/
	public class Spring {
		/**
		 * VARIABLES
		 */
		private var _spring:Number;
		private var _friction:Number;
		private var _v:Number = 0;
		private var _current:Number;
		private var _target:Number;
		
		private var _maxUpdates:int = 999999;
		private var _updateCount:int = 0;
		/**
		 * GETTERS AND SETTERS
		 */
		public function get spring():Number {
			return _spring;
		}
		public function set spring(spring:Number):void {
			_spring = spring;
		}
		public function get friction():Number {
			return _friction;
		}
		public function set friction(friction:Number):void {
			_friction = friction;
		}
		public function get current():Number {
			return _current;
		}
		public function set current(current:Number):void {
			_current = current;
		}
		public function get target():Number {
			return _target;
		}
		public function set target(target:Number):void {
			if (target != _target) {
				_updateCount = 0;
			}
			_target = target;
		}
		public function get maxUpdates():int {
			return _maxUpdates;
		}
		public function set maxUpdates(maxUpdates:int):void {
			_maxUpdates = maxUpdates;
		}
		/**
		 * CONSTRUCTOR 
		 */
		public function Spring(current:Number, target:Number, spring:Number = 0.5, friction:Number = 0.5) {
			_current = current;
			_target = target;
			_spring = spring;
			_friction = friction;
		}
		/**
		 * FUNCTIONS
		 */
		public function update():void {
			_v += (_target - current) * _spring;
			_current += (_v *= _friction);
			
			// Update count
			_updateCount++;
			if (_updateCount >= _maxUpdates) {
				_current = _target;
			}
		}
		/**
		 * 
		 */
		public function updateMulti(times:uint):void {
			var i:int;
			for (i = 0; i < times; i++) {
				update();
			}
		}
	}
}
