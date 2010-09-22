package cc.gullinbursti.dataorgs.trees {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [!]>
	public class LeafVO {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public var id:int;
		public var ind:int;
		public var val_num:Number;
		public var val_str:String;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		// <*] class constructor [*>
		public function LeafVO(leafID:int, val_obj:Object=null) {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
			
			id = leafID;
			
			if (val_obj) {
				val_num = int(val_obj.num);
				val_str = String(val_obj.str);
			}
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public function clone(leafID:int):LeafVO {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (new LeafVO(leafID, {num:this.val_num, str:this.val_str}));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function toString():String {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
			var ret_str:String = "\LeafVO:\n[=-=-=-=-=-=-=-=-=-=-=-=-=-=]";
				ret_str += "\n[id]: "+this.id;
				ret_str += "\n[ind]: "+this.ind;
				ret_str += "\n[val_num]: "+this.val_num;
				ret_str += "\n[val_str]: "+this.val_str;
				ret_str += "\n[=-=-=-=-=-=-=-=-=-=-=-=-=-=]";
			
			return (ret_str+"\n");
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}