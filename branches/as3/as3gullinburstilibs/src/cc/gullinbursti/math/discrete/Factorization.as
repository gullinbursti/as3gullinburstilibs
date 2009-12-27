package cc.gullinbursti.math.discrete {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.math.settheory.BasicSetTheory;
	import cc.gullinbursti.utils.Arrays;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Factorization extends BasicMath {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function Factorization() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// http://en.wikipedia.org/wiki/Euler%27s_factorization_method
		public static function euler(val:int):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: implement Euler factorization for a given value
				
			return (new Array());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// http://en.wikipedia.org/wiki/Prime_factor
		public static function prime(val:int):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: implement prime factorization for a given value
			
			return (new Array());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function greatestCommon(val_arr:Array):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// array of divisors
			var div_arr:Array = new Array();
			
			
			// return the single val
			if (val_arr.length == 1)
				return (val_arr[0]);
			
			
			// prime w/ 1st divisors
			div_arr = BasicMath.divisors(val_arr[0], true, true);
			
			
			// loop thru the array of vals
			for (var i:int=1; i<val_arr.length; i++) {
				
				// 2nd'ary array of i+1 divisors 
				var tmp_arr:Array = BasicMath.divisors(val_arr[i], true, true);
				
				// updated divisor array by doing an intersect
				div_arr = BasicSetTheory.intersection(div_arr, tmp_arr);
			}
			
			
			// return the top index
			return (div_arr.pop() as int);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		

		public static function leastCommonMult(val_arr:Array):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: find the LCM			
			
			
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}