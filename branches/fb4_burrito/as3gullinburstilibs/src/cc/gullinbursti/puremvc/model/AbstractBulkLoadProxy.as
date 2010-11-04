package cc.gullinbursti.puremvc.model {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	import cc.gullinbursti.puremvc.model.vo.LoadVO;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [¡]>
	public class AbstractBulkLoadProxy extends Proxy implements IProxy {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const NAME:String = "AbstractBulkLoadProxy";
		
		protected static var bulkLoader:BulkLoader;
		protected var asset_arr:Array;
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		
		
		// <*] class constructor [*>
		public function AbstractBulkLoadProxy(proxyName:String=null, data:Object=null) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("[:_:] "+NAME+" [:_:]");
			
			// call the parent class
			super(proxyName, data);
			
			bulkLoader = new BulkLoader("blkldr_"+proxyName);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		
		override public function setData(data:Object):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("[:_:] "+NAME+".setData [:_:]");
			
			asset_arr = new Array();
			
			// cast the data as an array
			var load_arr:Array = data as Array;
			
			// loop thru the array
			for (var i:int=0; i<load_arr.length; i++) {
				
				// pull each element as a LoadVO
				var loadVO:LoadVO = load_arr[i] as LoadVO;
				
				// add to the bulk loader
				bulkLoader.add(new URLRequest(loadVO.url_str), {
					id:loadVO.id_str, 
					name:loadVO.name_str
				});
				
				// attach listener for this item
				bulkLoader.get(loadVO.id_str).addEventListener(BulkLoader.PROGRESS, hdlItem_Progress);
				bulkLoader.get(loadVO.id_str).addEventListener(BulkLoader.COMPLETE, hdlItem_Complete);
				
			}
			
			// attach listeners for the entire load
			bulkLoader.addEventListener(BulkLoader.ERROR, hdlLoad_error);
			bulkLoader.addEventListener(BulkLoader.PROGRESS, hdlBulkLot_Progress);
			bulkLoader.addEventListener(BulkLoader.COMPLETE, hdlBulkLot_Complete);
			
			// start loading
			bulkLoader.start();
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		protected function hdlLoad_error(e:BulkProgressEvent):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("[:_:] "+NAME+".hdlLoad_error [:_:]");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		protected function hdlItem_Complete(e:Event):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//trace ("[:_:] "+NAME+".hdlItem_Complete [:_:]");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		protected function hdlItem_Progress(e:ProgressEvent):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//trace ("[:_:] "+NAME+".hdlItem_Progress [:_:]");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯	
		
		protected function hdlBulkLot_Progress(e:ProgressEvent):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//trace ("[:_:] "+NAME+".hdlBulkLot_Progress [:_:]");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		protected function hdlBulkLot_Complete(e:Event):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//trace ("[:_:] "+NAME+".hdlBulkLot_Complete [:_:]");
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		override public function getData():Object {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			return (asset_arr);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}