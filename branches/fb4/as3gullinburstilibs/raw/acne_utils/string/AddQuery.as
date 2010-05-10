package utils.string {
	/**
	* @author nikkoh
	*/
	public class AddQuery {
		/**
		 * 
		 */
		public static function addVariable(url:String, variable:String, value:String = null, checkLocal:Boolean = false, isLocal:Boolean = false):String {
			// Don't add
			if (checkLocal == true && isLocal == true) {
				return  url;
			}
			// Add
			var str:String;
			if (url.indexOf("?") != -1) {
				str = url + "&";
			} else {
				str = url + "?";
			}
			str += variable;
			if (value != null) {
				str += "=" + value;
			}
			// Return
			return str;
		}
	}
}
