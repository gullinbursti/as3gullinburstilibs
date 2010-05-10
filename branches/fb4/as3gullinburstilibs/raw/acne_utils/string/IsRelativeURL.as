package utils.string {
	/**
	* @author nikkoh
	*/
	public class IsRelativeURL {
		/**
		 * 
		 */
		public static function check(url:String):Boolean {
			var isRelative:Boolean = url.indexOf("http://") == -1 && url.indexOf("https://") == -1;
			return isRelative;
		}
	}
}
