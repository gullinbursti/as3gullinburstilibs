package cc.gullinbursti.net.apis {
	import cc.gullinbursti.lang.Strings;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	
	/**
	 * 
	 * @author:		Gullinbursti
	 * @class:		Twitter
	 * @package:	cc.gullinbursti.net.apis
	 * @created:	6:20:36 PM Nov 20, 2010
	 */
	public class Twitter {
		
		public function Twitter()
		{
		}
		
		
		public function sendTweet(username:String, password:String, text:String):void
		{
			var urlRequest:URLRequest = new URLRequest('http://api.twitter.com/1/statuses/update.xml');
			var urlLoader:URLLoader = new URLLoader();
			
			var vars:URLVariables = new URLVariables();
			vars.status = text.substr(0, 140);
			
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = vars;
			
			urlRequest.requestHeaders = [new URLRequestHeader("Authorization", "Basic " + Strings.encBase64(username + ":" + password))];
			
			urlLoader.load(urlRequest)
		}
	}
}