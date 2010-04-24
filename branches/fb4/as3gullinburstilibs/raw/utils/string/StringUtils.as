/**
 * @author	karlr
 */

package utils.string {
	/**
	 * 
	 */
	public class StringUtils {
		/**
		 * 
		 * @param	content
		 * @param	search
		 * @param	replace
		 * @return
		 */
		public static function searchAndReplace(content:String, search:String, replace:String):String {
			var start:String;
			var end:String;
			var pos:int = content.indexOf(search);
			while (pos >= 0) {
				start = content.substr(0, pos);
				end = content.substr(pos+search.length);
				content = start+replace+end;
				pos = content.indexOf(search, pos+replace.length);
			}
			return content;
		}
	}
}
