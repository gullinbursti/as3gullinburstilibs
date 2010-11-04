package utils.io {
	import utils.event.DataEvent;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;

	/**
	 * @author Svante
	 */
	/**
	 * !!!!!!!!!!BETA!!!!!!!!!
	 */
	public class MultiImageStreamLoader extends EventDispatcher {
		private static const FILE_COMPLETE : String = "MultiImageStreamLoader.File.Complete";
		private static const FILE_START : String = "MultiImageStreamLoader.File.Start";
		private static const FILE_GOTSIZE: String = "MultiImageStreamLoader.File.GotSize";

		private static const ALL_COMPLETE : String = "MultiImageStreamLoader.All.Complete";


		private var m_pos : uint;
		private var m_currentFile : ByteArray;
		private var m_filesloaded : int;
		
		
		private var m_images : Vector.<Bitmap>;
		private var m_complete : Boolean;

		
		
		public function MultiImageStreamLoader() {
			m_images = new Vector.<Bitmap>();
		}
		
		public function load(a_url:String) : void {

			var s : URLStream = new URLStream();
			var request : URLRequest = new URLRequest(a_url);
			s.addEventListener(Event.COMPLETE, loaderComplete);
			s.addEventListener(HTTPStatusEvent.HTTP_STATUS, loaderHttpstatus);
			s.addEventListener(ProgressEvent.PROGRESS, loaderProgress);
			s.addEventListener(IOErrorEvent.IO_ERROR, loaderError);
			s.load(request);
			
		}

		private function loaderHttpstatus(event : HTTPStatusEvent) : void {
//			trace(event.status);
		}
		
		private function gatherNewData(a_stream : URLStream) : void {
			var len : uint = a_stream.bytesAvailable;
			var d : ByteArray = new ByteArray();
			a_stream.readBytes(d, 0,len);
			parseData(d);
			m_pos +=len;

		}
		
		private function parseData(d : ByteArray) : void {
			d.position = 0;
			while ( d.bytesAvailable ) {
				
				var b1:uint = d.readUnsignedByte();
				
				if ( b1 == 0xFF && d.bytesAvailable ) {
					
					var b2:uint = d.readUnsignedByte();
					
					if ( b2 == 0xd8 ) { // CHECK SOF
					
//						trace("SOF",m_pos+d.position-2)
						createFile();
						dispatchEvent(new Event(FILE_START));
						m_currentFile.writeByte(b1);
						m_currentFile.writeByte(b2);
						
					}
					
					if (m_currentFile==null ) return;
					
					// CHECK SIZE
					if ( b2 == 0xC0 && d.bytesAvailable > 7 ) {
						var p : int = d.position;
						d.position = p+3;
						var cheight : uint = d.readUnsignedShort();
						d.position = p+5;
						var cwidth : uint = d.readUnsignedShort();
						d.position = p;
						
						dispatchEvent(new DataEvent(FILE_GOTSIZE,false,false,new Rectangle(0,0, cwidth, cheight)));
						
						m_currentFile.writeByte(b1);
						m_currentFile.writeByte(b2);
						
					} else if ( b2 == 0xd9 ) { // CHECK EOF
					
//						trace("EOF",m_pos+d.position-2)
						m_currentFile.writeByte(b1);
						m_currentFile.writeByte(b2);
						
						dumpFile();
//						createFile();
					} else if ( m_currentFile ){
						
						m_currentFile.writeByte(b1);
						m_currentFile.writeByte(b2);
						
					}
					
				} else if ( m_currentFile ) {
					m_currentFile.writeByte(b1);
				}
				
			}
		}
		
		private function dumpFile() : void {
			m_currentFile.position = 0;
			var l : Loader = new Loader();
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, onFileDump);
			l.loadBytes(m_currentFile);

			m_filesloaded++;
			m_currentFile = null;
		}
		
		private function onFileDump(event : Event) : void {
			
			var li : LoaderInfo = (event.target) as LoaderInfo;
			li.removeEventListener(Event.COMPLETE, onFileDump);
			m_images.push(li.content);
			
			dispatchEvent(new DataEvent(FILE_COMPLETE,false,false,li.content));
			if ( m_complete ) dispatchEvent(new Event(ALL_COMPLETE)); 
		}

		private function createFile() : void {
			m_currentFile = new ByteArray();
		}

		private function loaderProgress(event : ProgressEvent) : void {
//			trace(event.bytesLoaded);
			gatherNewData(event.target as URLStream);
		}

		private function loaderError(event : IOErrorEvent) : void {
//			trace(event.text);
		}

		private function loaderComplete(event : Event) : void {
//			trace("complete");
			m_complete = true;
		}
		
		
		
		
		public function get images() : Vector.<Bitmap> {
			return m_images;
		}
	}
}
