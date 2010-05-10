package utils.io {	
	/** */
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	/**
	* @author nikkoh
	*/
	public class SendData {
		/**
		 * 
		 */
		public static function send(loader:URLLoader, url:String, vars:URLVariables, method:String):void {
			
			var request:URLRequest = new URLRequest(url);
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			request.data = vars;
			request.method = method;
			loader.load(request);
			
		}
	}
}
