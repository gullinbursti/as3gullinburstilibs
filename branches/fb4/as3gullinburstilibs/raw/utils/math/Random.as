/**
 * @author karlr
 */
package utils.math {
	/**
	 * 
	 */
	public class Random {
		/** */
		public static function fromRange(min:Number, max:Number):Number {
			var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
			return randomNum;
		}
		/**
		 * dice function is good for randomizing outputs from arrays. Return random numbers 0 + sides
		 */
		public static function dice(sides:int):int {
			return int(Math.random()*sides);
		}
	}
}