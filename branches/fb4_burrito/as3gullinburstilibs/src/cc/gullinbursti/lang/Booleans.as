package cc.gullinbursti.lang {
	
	import cc.gullinbursti.math.BasicMath;
	
	public class Booleans {
		
		public function Booleans() {}
		
		public static function neg1False_plus1True(bool:Boolean=true):Number {
			
			return ((int(bool) * 2) -1);
		}
		
		public static function flip(bool:Boolean, amt:int=1):Boolean {
			
			return (Boolean(int(bool) + int(!BasicMath.isEven(amt)) % 2));
		}
		
		public static function invert(bool:Boolean):Boolean {
			
			return (!bool);
		}
	}
}