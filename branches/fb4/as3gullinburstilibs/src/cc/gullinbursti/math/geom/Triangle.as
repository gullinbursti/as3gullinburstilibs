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
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
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
		
			/**
			 * a² + b² = c²
			 * 
			 */
		
			// hypotenus is zero	
			if (c == 0)
				return (BasicMath.root((square(a) + square(b))));
			
			// a leg is zero
			if (b == 0)
				return (BasicMath.root((square(c) + square(a))));
			
			
			// error
			return (-1);
				
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function area(width:Number, height:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			/**
			 * a = ½wh
			 * 
			 */
		
			return ((width * height) / 2);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function interiorPts(len:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			/**
			 *            len · (len + 1)
			 * points =  —————————————————
			 *                   2
			 * 
			 */
		
		
			return ((len * (len + 1)) / 2);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}