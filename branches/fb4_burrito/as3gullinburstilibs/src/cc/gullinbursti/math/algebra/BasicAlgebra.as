package cc.gullinbursti.math.algebra {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.lang.Numbers;
	import cc.gullinbursti.math.BasicMath;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 
	// <[!] class delaration [¡]>
	public class BasicAlgebra extends BasicMath {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function BasicAlgebra() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		/**
		 * Returns the opposite of a <code>Number</code> (<code>⁺γ + ⁻γ = 0</code>). 
		 * @param float The input <code>Number</code> to convert.
		 * @return The inverse (negated) value.
		 * 
		 */
		public static function additiveInverse(float:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Numbers.additiveInverse(float));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the multiplicative inverse of a <code>Number</code>. (ᵠ⁄₁ · ¹⁄ᵩ = ¹⁄₁).
		 * @param float A <code>Number</code> to reciprocate.
		 * @return The inverse value of a <code>Number</code>.
		 * 
		 */		
		public static function reciprocal(float:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Numbers.reciprocal(float));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
	}
}