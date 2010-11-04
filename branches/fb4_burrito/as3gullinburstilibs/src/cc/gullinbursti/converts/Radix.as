package cc.gullinbursti.converts {
	
	public class Radix {
		
		public function Radix() {
		}
		
		public static function dec2Bin(val:Number):String {
			return (val.toString(2));
		}
		
		public static function dec2Hex(val:Number):String {
			return (val.toString(16));
		}
		
		public static function bin2Dec(val:String):int {
			return (parseInt(val, 2));
		}
		
		public static function bin2Hex(val:String):String {
			return (dec2Hex(bin2Dec(val)));
		}
		
		public static function hex2Bin(val:String):String {
			return ("");//val.toString(2));
		}
		
		public static function hex2Dec(val:String):int {
			return (0);//val.toString(2));
		}
	}
}