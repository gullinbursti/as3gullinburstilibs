package cc.gullinbursti.puremvc.model.vo {
	
	// <[!] class delaration [¡]>
	public class LoadVO {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public var url_str:String;
		public var id_str:String;
		public var name_str:String;
		public var priority:int;
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		
		
		// <*] class constructor [*>
		public function LoadVO(url:String, id:String, name:String, queue:int=0) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			url_str = url;
			id_str = id;
			name_str = name;
			priority = queue;
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}