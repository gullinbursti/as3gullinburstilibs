package cc.gullinbursti.math.discrete {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.math.settheory.BasicSetTheory;
	import cc.gullinbursti.utils.Arrays;
	
	import flash.geom.Point;
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
		public static function primeFactors(val:int):FactorizedVO {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// expanded factors
			var factors_arr:Array = new Array();
			
			// dup factors [base, exp], [base, exp]
			var dup_arr:Array;
			
			// factorizing vars
			var prev_val:int = val;
			var sm_div:int = 1;
			
			
			// already prime, return val¹
			if (BasicMath.isPrime(val))
				return (new FactorizedVO([new Point(val, 1)]));
			
			
			// loop until the prev val is prime
			while (!BasicMath.isPrime(prev_val)) {
				
				// find the smallest prime divisor (exclude 1)
				sm_div = BasicMath.smallestDivisor(prev_val);
				
				// calc the new test val
				prev_val /= sm_div;
				
				// smallest divisor is prime, add to factor array
				if (BasicMath.isPrime(sm_div) && sm_div != 1)
					factors_arr.push(sm_div);
					
				// not prime, recursively factor it
				else
					primeFactors(sm_div);
			}
			
			// push final prime factor
			factors_arr.push(prev_val);
			
			// total up the duplicates ([prime, exp], [prime, exp])
			dup_arr = Arrays.tallyDups(factors_arr);
			
			// create a vo to return
			var vo:FactorizedVO = new FactorizedVO();
			
			// loop thru the factor array & add [base, exp] pairs
			for (var i:int=0; i<dup_arr.length; i++)
				vo.addFactor(new Point(dup_arr[i][0], dup_arr[i][1]));
			
			
			
			return (vo);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		
		
		public static function gr8CommonFactor(val_arr:Array):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// loop counter
			var i:int;
			
			// array of divisors
			var div_arr:Array = new Array();
			
			// calc'ed gcf
			var gcf:int;
			
			// return the single val
			if (val_arr.length == 1)
				return (val_arr[0]);
			
			
			// prime w/ 1st divisors
			div_arr = BasicMath.divisors(val_arr[0], true, true);
			
			
			// loop thru the array of vals
			for (i=1; i<val_arr.length; i++) {
				
				// 2nd'ary array of i+1 divisors 
				var tmp_arr:Array = BasicMath.divisors(val_arr[i], true, true);
				
				// updated divisor array by doing an intersect
				div_arr = BasicSetTheory.intersection(div_arr, tmp_arr);
			}
			
			// top index is the gcf
			gcf = int(div_arr.pop());
			
			// don't use the passed value as gcf
			if (gcf == val_arr[0] && gcf == val_arr[1])
				gcf = int(div_arr.pop());
			
			// return the top index
			return (gcf);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function gr8CommonFactorByModulus(val_arr:Array):int {
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
			
			
			// reverse the vals
			swap_arr.reverse();
			
			// drop the 1st element (zero)
			swap_arr.shift();
			
			// 1st val is the GCF
			return (swap_arr[0]);
				
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		

		public static function leastCommonMult(val_arr:Array):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * 	  | a·b |
			 * 	———————————
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
	}
}