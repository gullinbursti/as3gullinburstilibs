package utils.text {

	/**
	 * @author Mathias
	 */
	public class SearchAndReplace {
		
		public static function search(a_template : String, a_search : String, a_replace : String) : String {
			var str : String;
			var pattern : RegExp = new RegExp("\\" + a_search + "\\", "g");
			 
			str = a_template.replace(pattern, a_replace);
			
			return str;
		}
		
	}
}
