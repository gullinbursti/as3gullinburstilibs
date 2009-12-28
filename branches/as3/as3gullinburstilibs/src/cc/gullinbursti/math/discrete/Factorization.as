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
		
		
		
		public static function gr8CommonFactor(val_arr:Array):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// loop counter
			var i:int;
			
			// running modulus
			var swap_modo:int;
			
			// array of vals to swap around
			var swap_arr:Array = new Array(); 
			 
			 
			 
			// prime the swap array w/ all test vals
			for (i=0; i<val_arr.length; i++)
				swap_arr.push(val_arr[i]);
			
			
			// set up a conditional loop
			while (swap_arr[val_arr.length-1] != 0) {
				
				// tmp computed modulo
				var modo_arr:Array = new Array();
				
				// push all vals into array
				for (i=0; i<swap_arr.length; i++)
					modo_arr.push(swap_arr[i]);
				
				
				// calc the combined modulus
				swap_modo = BasicMath.moduloChain(modo_arr);
				
				
				// loop thru vals (exc last), swapping 1st val to higher index 
				for (i=0; i<swap_arr.length-1; i++)
					swap_arr[i] = swap_arr[(i+1)];
					
				
				
				// for the last element, set to the calc'ed modulus
				swap_arr[swap_arr.length-1] = swap_modo;
			}
			
			
			// 1st val is the GCF
			return (swap_arr.shift());
				
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		

		public static function leastCommonMult(val_arr:Array):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * 	  | a·b |
			 * 	-------------
			 * 	 gcd(a, b)
			 */
			 
			 
			// there's only 1 # or there's a zero
			if (val_arr.length < 2 || Arrays.containsValue(val_arr, 0))
				return (0);
			 
			 
			// init w/ 1st val (a)
			var nominator:int = val_arr[0];
			 
			 
			// loop thru the rest
			for (var i:int=1; i<val_arr.length; i++) {
				
				// multiply all the vals together
				nominator *= val_arr[i];
			}
			 
			// ((| nominator |) / GCF(val_arr))
			return (Math.abs(nominator) / Factorization.gr8CommonFactor(val_arr));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		
		
		
		
		
		// TODO: see if GCF by interesection is salvagable (fails on > 2 vals) 
		/* 
		public static function greatestCommonByIntersection(val_arr:Array):int {
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
		 */
		
	}
}