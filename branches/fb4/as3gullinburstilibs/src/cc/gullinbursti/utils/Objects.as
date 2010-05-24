package cc.gullinbursti.utils {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class Objects {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function Objects() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		/**
		 * Returns the obj as a concatinated string.
		 */
		public static function getString(_obj:Object, delim:String):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._		
			
			var _str:String = "";
			
			for (var key1:* in _obj) {
				_str += "["+key1+"] = "+ _obj[key1] + delim;
				
				for (var key2:* in _obj[key1])
					_str += " - ["+key1+"]["+key2+"] = "+ _obj[key1][key2] + delim;
			}
			
			
			return (_str);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	
		/** 
		 * Reverses the order of an obj's params.
		 */
		public static function reverse(_obj:Object):Object {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._		
			
			var key_arr:Array = new Array();
			var val:Object = new Object();
			var param:Object = new Object();
			
			for (var key:* in _obj)
				key_arr.push(key);
			
			key_arr.reverse();
			var j:int = key_arr.length;
			
			while(j--) {
				param = key_arr[j];
				val = _obj[param];
				
				delete _obj[param];
				_obj[param] = val;
			}
			
			return (_obj);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Swaps the positions of two keys in an obj.
		 */
		public static function swap(_obj:Object, key1:String, key2:String):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._		
			
			var tmp_obj:Object = new Object();
				tmp_obj = _obj[key1];
			
			_obj[key1] = _obj[key2];
			_obj[key2] = tmp_obj;
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}