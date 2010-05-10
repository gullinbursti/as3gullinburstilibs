/**
 * @author nikkoh
 */
package utils.io{
	/** */
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	/** */	
	public class SendAndLoad extends EventDispatcher {
		/**
	 	 * SEND DATA
		 * @param	address				<String>
		 * @param	message				<URLVariables>
		 */
		public static function sendAndLoad(address:String,message:URLVariables):void{
			//trace(this + ":sendData()");
			/** */	
			var request:URLRequest = new URLRequest(address);
			request.data = message;
			/** */			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(SendAndLoadConstants.SUCCESS,onSuccess);
			loader.addEventListener(SendAndLoadConstants.SERVER_ERROR,onError);
			/** */			
			var onSuccess:Function = function(event:Event):void{
				//trace(this + ":onSuccess()");
				dispatchEvent(event);
			};
			/** */	
			var onError:Function = function(event:IOErrorEvent):void {
				//trace(this + ":onError()");	
				dispatchEvent(event);
			};
			/** */
			loader.load(request);
		}
	}
}