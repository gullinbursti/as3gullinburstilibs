package utils.math {
	/**
	* @author nikkoh
	*/
	public class Modulo {
		/**
		 * @param n The number.
		 * @param m The modulo.
		 * @usage returns Modulos for both positive and negative ints.
		 */
		public static function calc(n:int, m:int):int {
			// Positive (normal)
			if (n > -1) {
				return n & (m - 1);
			}
			// Negative
			n++;
			m--;
			return m - ((n ^ (n >> 31)) - (n >> 31) & m);
		}
	}
}
