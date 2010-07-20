package cc.gullinbursti.math.algebra {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	
	// <[!] class delaration [¡]>
	public class Complex extends BasicAlgebra {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function Complex() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>		
		
		/**
		 * Finds the absolute value of a complex number. 
		 * 
		 * @param comp_pt x = real portion & y = imaginary part
		 * 
		 * @return abs of a complex number
		 */
		public static function abs(comp_pt:Point):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			if (Math.abs(comp_pt.x) > Math.abs(comp_pt.y))
				return (Math.abs(comp_pt.x) * Math.sqrt(1 + (comp_pt.y / comp_pt.x) * (comp_pt.y / comp_pt.x)));
			
			return (Math.abs(comp_pt.y) * Math.sqrt(1 + (comp_pt.x / comp_pt.y) * (comp_pt.x / comp_pt.y)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Adds two complex numbers together. 
		 * 
		 * @param comp1_pt x = real portion & y = imaginary part
		 * @param comp2_pt x = real portion & y = imaginary part
		 * 
		 * @return sum of two complex numbers
		 */
		public static function sum(comp1_pt:Point, comp2_pt:Point):Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			return (new Point(comp1_pt.x + comp2_pt.x, comp1_pt.y + comp2_pt.y));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		/**
		 * Subtracts two complex numbers. 
		 * 
		 * @param comp1_pt x = real portion & y = imaginary part
		 * @param comp2_pt x = real portion & y = imaginary part
		 * 
		 * @return difference of two complex numbers
		 */
		public static function diff(comp1_pt:Point, comp2_pt:Point):Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			return (new Point(comp1_pt.x - comp2_pt.x, comp1_pt.y - comp2_pt.y));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Multiplies two complex numbers together. 
		 * 
		 * @param comp1_pt x = real portion & y = imaginary part
		 * @param comp2_pt x = real portion & y = imaginary part
		 * 
		 * @return product of two complex numbers
		 */
		public static function mult(comp1_pt:Point, comp2_pt:Point):Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (new Point(comp1_pt.x * comp2_pt.x - comp1_pt.y * comp2_pt.y, comp1_pt.y * comp2_pt.x + comp1_pt.x * comp2_pt.y));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Divides two complex numbers together. 
		 * 
		 * @param comp1_pt x = real portion & y = imaginary part
		 * @param comp2_pt x = real portion & y = imaginary part
		 * 
		 * @return division of two complex numbers
		 */
		public static function div(comp1_pt:Point, comp2_pt:Point):Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var r:Number;
			var s:Number;
			
			if (Math.abs(comp2_pt.x) >= Math.abs(comp2_pt.y)) {
				r = comp2_pt.y / comp2_pt.x;
				s = comp2_pt.x + r * comp2_pt.y;
				
				return (new Point((comp1_pt.x + comp1_pt.y * r) / s, (comp1_pt.y - comp1_pt.x * r) / s));
			}
			
			r = comp2_pt.x / comp2_pt.y;
			s = comp2_pt.y + r * comp2_pt.x;
			
			return (new Point((comp1_pt.x *r + comp1_pt.y) / s, (comp1_pt.y * r - comp1_pt.x) / s));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Normalizes a complex number. 
		 * 
		 * @param comp_pt x = real portion & y = imaginary part
		 * 
		 * @return a real number
		 */
		public static function norm(comp_pt:Point):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			return (BasicMath.square(comp_pt.x) + BasicMath.square(comp_pt.y));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}