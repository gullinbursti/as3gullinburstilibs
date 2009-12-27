package cc.gullinbursti.math.geom {
	import cc.gullinbursti.math.BasicMath;
	
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 
	 // <[!] class delaration [¡]>
	public class Triangle extends Polygon {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function Triangle() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function pythagorate(a:Number, b:Number=0, c:Number=0):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			var ret_val:Number;
			
			if (c == 0)
				ret_val = BasicMath.root((square(a) + square(b)), 2);
			
			if (b == 0)
				ret_val = BasicMath.root((square(c) / square(a)), 2);
				
			return (ret_val);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function area(width:Number, height:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return ((width * height) / 2);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function triangularNum(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return ((len * (len + 1)) / 2);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}