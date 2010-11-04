package utils.xml {
	/** */
	import flash.net.URLLoader;
	/**
	 * @author nikkoh
	 */
	public class URLLoaderToXML {
		/**
		 * 
		 */
		public static function convert(loader:URLLoader):XML {
			var XMLData:XML = new XML();
			XMLData["ignoreWhitespace"] = true;
			XMLData = XML(loader.data);
			return XMLData;
		}
	}
}
