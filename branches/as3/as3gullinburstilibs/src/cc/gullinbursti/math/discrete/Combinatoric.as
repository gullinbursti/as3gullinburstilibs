package cc.gullinbursti.math.discrete {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Combinatoric extends BasicMath {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
	
		// <*] class constructor [*>
		public function Combinatoric() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		/**
		 * Calculates unique permutations for a given set 
		 * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		 * <p></p>
		 * 
		 * @param n_items the # of items in the set
		 * @param k_per the # of items per combo
		 * 
		 * @return the unique # of item permutations 
		**/
		public static function orderedPairs(... args):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// prime w/ 1st arg set
			var pair_tot:int = (args[0] as Array).length;
			
			// loop thru remaining args & tally…
			for (var i:int=1; i<args.length; i++)
				pair_tot *= (args[i] as Array).length;
			
			
			return (pair_tot);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Calculates unique permutations for a given set 
		 * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		 * <p></p>
		 * 
		 * @param n_items the # of items in the set
		 * @param k_per the # of items per combo
		 * 
		 * @return the unique # of item permutations 
		**/
		public static function permutate(n_items:int, k_per:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			/**
			 *     n!
			 * ——————————
			 *   (n-k)!
			**/
			
			return (factorial(n_items) / factorial(n_items - k_per));
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Calculates non-repeating combos
		 * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		 * <p></p>
		 * 
		 * @param n_items the # of items in the set
		 * @param k_per the # of items per combo
		 * 
		 * @return the total possible combos
		**/
		public static function combinate(n_items:int, k_per:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			/**
			 *      n!
			 * ————————————
			 *   k!(n-k)!
			**/
			
			// # of items in combo is ≥ & not greater than total items
			if (k_per >= 0 && k_per <= n_items)
				return (factorial(n_items) / (factorial(k_per) * (factorial(n_items-k_per))));
			
			// return 0 combos
			else
				return (0);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Calculates all combos
		 * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		 * <p></p>
		 * 
		 * @param n_items the # of items in the set
		 * 
		 * @return the total possible combos, w/ repeats
		**/
		public static function combinateAll(n_items:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			/**
			 *   2ⁿ
			**/
			
			return (Math.pow(2, n_items));
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Calculates permutations on combos
		 * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		 * <p></p>
		 * 
		 * @param n_items the # of items in the set
		 * @param k_per the # of items per combo
		 * 
		 * @return the total permutations of combos
		**/
		public static function permutateCombos(n_items:int, k_per:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			/**
			 *      n!
			 * ———————————— * k!
			 *   k!(n-k)!
			**/
			
			return (combinate(n_items, k_per) * factorial(k_per));
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Calculates all permutations on all combos
		 * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		 * <p></p>
		 * 
		 * @param n_items the # of items in the set
		 * @param k_per the # of items per combo
		 * 
		 * @return the total possible permutations of all combos
		**/
		public static function permutateAllCombos(n_items:int, k_per:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			/**
			 *     n!
			 * ——————————
			 *   (n-k)!
			**/
			
			var tot:int = 0;
			
			for (var i:int=0; i<n_items; i++)
				tot += permutateCombos(n_items, i);
			
			return (tot);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}