package cc.gullinbursti.net {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.events.AMFEvent;
	
	import flash.events.EventDispatcher;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	// <[!] class delaration [!]>
	public class AMFObject extends EventDispatcher {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		private var _gateway:String;
		private var _method:String;
		private var _objEnc:int;
		
		private var _netConn:NetConnection;
		
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		// <*] class constructor [*>
		public function AMFObject(gateway:String=null) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			super();
			
			// instaniate the props
			_netConn = new NetConnection();
			_objEnc = ObjectEncoding.AMF3;
			_method = new String();
			
			// has a url, init net conn
			if (gateway) {
				_gateway = gateway;
				init();
			}
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		private function init():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// set encoding & connect
			_netConn.objectEncoding = _objEnc;
			_netConn.connect(_gateway);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		private function hdlResult(data:Object):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// send a result event
			dispatchEvent(new AMFEvent(AMFEvent.RESULT, data));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		private function hdlFault(data:Object):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			for(var i:* in data)
				trace(data[i]);
			
			// send a fault event
			dispatchEvent(new AMFEvent(AMFEvent.FAULT, data));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function send(data:Object):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace("AMFObject.send("+_method+", "+data+")");
			
			// has params
			if (data)
				_netConn.call(_method, new Responder(hdlResult, hdlFault), data);
			
			// no params
			else
				_netConn.call(_method, new Responder(hdlResult, hdlFault));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public function get gateway():String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			return (_gateway);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function set gateway(val:String):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			_gateway = val;
			init();
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function get method():String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			return (_method);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function set method(val:String):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			_method = val;
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function get objectEncoding():int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			return (_objEnc);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function set objectEncoding(val:int):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			_objEnc = val;
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}