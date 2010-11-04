package utils.io {
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class ExternalLink {
		/**
		 * 
		 */
		public static var UNRECOGNIZED:String = "Unrecognized";
		public static var FIREFOX:String = "Firefox";
		public static var SAFARI:String = "Safari";
		public static var IE:String = "IE";
		public static var OPERA:String = "Opera";
		/** */
		private static var _windowOpen:String = "window.open";   
		private static var _windowName:String = "popwindow";
		private static var _windowNum:int = 0;  
		private static var _windowFeatures:String = "";
		/**
		 * 
		 */
		public static function getBrowser():String {
			var browser:String = ExternalLink.UNRECOGNIZED;     
			//Uses external interface to reach out to browser and grab browser useragent info.
			
			if (ExternalInterface.available) {
				var strUserAgent:String = String(ExternalInterface.call("function() {return navigator.userAgent;}")).toLowerCase();
				//Determines brand of browser using a find index. If not found indexOf returns (-1).
				
				if (strUserAgent != null && strUserAgent.indexOf("firefox") >= 0) {
					browser = ExternalLink.FIREFOX;
				} else if (strUserAgent != null && strUserAgent.indexOf("safari") >= 0){
					browser = ExternalLink.SAFARI;
				} else if (strUserAgent != null && strUserAgent.indexOf("msie") >= 0){
					browser = ExternalLink.IE;
				} else if (strUserAgent != null && strUserAgent.indexOf("opera") >= 0){	
					browser = ExternalLink.OPERA;
				}
			}
			return (browser);
		}
		/**
		 * 
		 */
		public static function open(url:String, target:String = "_blank", windowFeatures:String = ""):void {
			_windowFeatures = windowFeatures;
			if (ExternalInterface.available) {
				var strUserAgent:String = String(ExternalInterface.call("function() {return navigator.userAgent;}")).toLowerCase();
				if(strUserAgent.indexOf("safari") != -1 || strUserAgent.indexOf("firefox") != -1 || (strUserAgent.indexOf("msie") != -1 && uint(strUserAgent.substr(strUserAgent.indexOf("msie") + 5, 3)) >= 7)){
					ExternalInterface.call(_windowOpen, url, _windowName + _windowNum, _windowFeatures);
				}else{
					navigateToURL(new URLRequest(url), target);
				}
			} else {
				navigateToURL(new URLRequest(url), target);
			}			
		}
		/**
		 * 
		 */
		public static function jsCall(func:String, ... args):void {
			if (ExternalInterface.available) {
				var strUserAgent:String = String(ExternalInterface.call("function() {return navigator.userAgent;}")).toLowerCase();
				if(strUserAgent.indexOf("safari") != -1 || strUserAgent.indexOf("firefox") != -1 || (strUserAgent.indexOf("msie") != -1 && uint(strUserAgent.substr(strUserAgent.indexOf("msie") + 5, 3)) >= 7)){
					ExternalInterface.call(func, args);
				}else{
					navigateToURL(new URLRequest("javascript:" + func + "(" + args.toString() + ")"), "_self");
				}
			} else {
				navigateToURL(new URLRequest("javascript:" + func + "(" + args.toString() + ")"), "_self");
			}
		}
		/**
		 * 
		 */
		public static function openMailClient(adress:String, ccAdress:String, subject:String, body:String):void{
			try{
				var strUserAgent:String = String(ExternalInterface.call("function() {return navigator.userAgent;}")).toLowerCase();
//				trace('strUserAgent: ' + (strUserAgent));
				/** */
				if(strUserAgent.indexOf("safari") != -1 || strUserAgent.indexOf("firefox") != -1 || (strUserAgent.indexOf("msie") != -1 && uint(strUserAgent.substr(strUserAgent.indexOf("msie") + 5, 3)) >= 7)){
					ExternalInterface.call("window.open('mailto:" + adress + "?Cc=" + ccAdress + "&Subject=" + subject + "&Body=" + body + "','_self')");
//					trace('ExternalInterface: ');
				} else{
					navigateToURL(new URLRequest("mailto:" + adress + "?Cc=" + ccAdress + "&Subject=" + subject + "&Body=" + body), "_self");
//					trace('navigateToURL: ');
				}
			}catch(error:Error){}			
		}
	}
}
