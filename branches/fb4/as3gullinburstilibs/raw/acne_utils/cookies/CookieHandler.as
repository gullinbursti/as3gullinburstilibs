package utils.cookies {
	import flash.net.SharedObject;
	/**
	 * @author nikkoh
	 */
	public class CookieHandler {
		/**
		 * 
		 */
		public static function setCookie(cookieName:String, params:Object):void{
			var cookie:SharedObject = SharedObject.getLocal(cookieName);
			for (var item:String in params) {
				cookie.data[item] = params[item];
			}
			cookie.flush();
		}
		/**
		 * 
		 */
		public static function getCookieParams(cookieName:String):Object{
			return SharedObject.getLocal(cookieName).data;
		}
	}
}
