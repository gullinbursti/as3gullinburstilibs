package cc.gullinbursti.math.settheory {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.lang.Arrays;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 
	// <[!] class delaration [¡]>
	public class BasicSetTheory extends BasicMath {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		/**
		 * Infinite union & intersection (DeMorgan's Law)
		 * http://www.apronus.com/provenmath/sum.htm
		 * 
		 * 
		 * http://en.wikipedia.org/wiki/Hausdorff_maximal_principle
		 * http://www.apronus.com/provenmath/choice.htm
		 * 
		 * 
		 * http://en.wikipedia.org/wiki/Zorn%27s_lemma
		 * http://www.apronus.com/provenmath/choice.htm
		 */
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// complex set (a + bi)
		private static const C_SET:Array = new Array();
		
		// quaternion set (i^2 = j^2 = k^2 = ijk = -1)
		private static const H_SET:Array = new Array(); 
		
		
		// rational set (0.5, 3, 10.2)
		private static const Q_SET:Array = new Array();
		
		// real set (2, 5/3, π)
		private static const R_SET:Array = new Array();
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		 
		// <*] class constructor [*>	
		public function BasicSetTheory() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// natural #'s (N set: non-negative ints) {(0), 1, 2, 3, 4, 5}
		public static function naturals(max:int, isZero:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// start at zero
			if (isZero)
				return (integers(0, max));
			
			// start at one
			else
				return (integers(1, max)); 
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// integer #'s (Z set no decimals) {-5, -2, 4, 12, 50}
		public static function integers(min:int, max:int):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// list of ints
			var set_arr:Array = new Array();
			
			// push vals
			for (var i:int=min; i<=max; i++)
				set_arr.push(i);	
			
			
			return (set_arr);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// prime #'s {2, 3, 5, 7, 11, 13} using the “Sieve of Eratosthenes”
		public static function primes(max:int, min:int=2):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// loop counter
			var i:int;
			
			// # to test against
			var prime_test:int = min;
			
			// current multiple index
			var ind:int = 0;
			
			// return # set
			var sift_arr:Array = new Array();
			
			// push min-max values into array
			for (i=min; i<=max; i++)
				sift_arr.push(i);
			
			
			// continue until test^2 is > the max  
			while (BasicMath.square(prime_test) <= max) {
				
				// loop thru all values in set
				for (i=ind; i<sift_arr.length; i++) {
					
					// value @ index is a mutliple of the test prime, drop it 
					if (BasicMath.isMultiple(sift_arr[i], prime_test, false))
						sift_arr.splice(i, 1);
				}
				
				// increment the starting index
				ind++;
				
				// update the test prime
				prime_test = sift_arr[ind];
			}
			
			return (sift_arr);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * {1, 2, ♀} ∪ {♪, Ϟ, ♀} = {1, 2, ♪, Ϟ, ♀}
		 * Some basic properties of unions:
         * A ∪ B = B ∪ A
         * A ∪ (B ∪ C) = (A ∪ B) ∪ C
         * A ⊆ (A ∪ B)
         * A ∪ A = A
         * A ∪ ∅ = A
         * A ⊆ B ⇔ A ∪ B = B
		 */
		// combined values, no repeats (set of all objs which are members of either A or B)
		public static function union(... args):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// concatinated array 
			var union_arr:Array = new Array();
			
			// loop thru each arg (ARRAY) & concat
			for (var i:int=0; i<args.length; i++)
				union_arr.concat(args[i]);
			
			return (union_arr);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * {1, 2, Ϟ} ∩ {♂, ¢, β} = {Ϟ}
		 * Some basic properties of intersections:
		 * A ∩ B = B ∩ A
		 * A ∩ (B ∩ C) = (A ∩ B) ∩ C
		 * A ∩ B ⊆ A
		 * A ∩ A = A
		 * A ∩ ∅ = ∅
		 * A ⊆ B ⇔ A ∩ B = A
		 * if A ∩ B = ∅, sets are “disjoint”
		 */
		// common values, no repeats (set of all objs which are members of both A and B)
		public static function intersection(... args):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// loop counters
			var i:int;
			var j:int;
			
			// all values from args
			var chain_arr:Array = new Array();
			
			// return vals that are duplicated
			var intersect_arr:Array = new Array();
			
			
			// loop thru the args & append vals
			for (i=0; i<args.length; i++)
				chain_arr = Arrays.chain(true, chain_arr, args[i]);
			
			// loop thru array 1st time
			for (i=0; i<chain_arr.length; i++) {
				
				// loop thru array 2nd time
				for (j=i+1; j<chain_arr.length; j++) {
					
					// if 1st loop = the 2nd, push & restart
					if (chain_arr[i] == chain_arr[j] && !Arrays.containsValue(intersect_arr, chain_arr[i])) {
						intersect_arr.push(chain_arr[i]);
						break;
					}
				}
			}
			
			return (intersect_arr);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * {1, 2, Ϟ} \ {β, ¢, Ϟ} = {1, 2}
		 * Some basic properties of complements:
		 * A ∪ A′ = U
		 * A ∩ A′ = ∅
		 * (A′)′ = A
		 * A \ A = ∅
		 * U′ = ∅ and ∅′ = U
		 * A \ B = A ∩ B′
		 */
		// common values in sets, no repeats (set theoretic difference)
		public static function complement(... args):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// combined vals
			var union_arr:Array = BasicSetTheory.union(args);
			
			// common vals
			var intersect_arr:Array = BasicSetTheory.intersection(args);
			
			// loop thru the common set
			for (var i:int=0; i<intersect_arr.length; i++) {
				
				// loop thru combined val set
				for (var j:int=0; j<union_arr.length; j++) {
					
					// found val in union set, drop it & restart
					if (intersect_arr[i] == union_arr[j]) {
						union_arr.splice(j, 1);
						break;
					}
				}
			}
			
			
			return (union_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Some basic properties of cartesian products:
		 * {1, 2, ♂} × {♠, ♣, ♂} = {(1, ♠), (1, ♣), (1, ♂), (2, ♠), (2, ♣), (2, ♂), (♂, ♠), (♂, ♣), (♂, ♂)}
		 * A × ∅ = ∅
		 * A × (B ∪ C) = (A × B) ∪ (A × C)
		 * (A ∪ B) × C = (A × C) ∪ (B × C)
		 * If A & B are finite: 
		 * >> | A × B | = | B × A | = | A | × | B |
		 */
		// set of all ordered pairs (x, y) such that A contains x and B contains y
		public static function cartisianProduct(... args):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// no set or only one, return ∅
			if (args.length <= 1)
				return ([]);
			
			// loop counter
			var i:int;
			
			// largest set
			var max_ind:int = 0;
			var max_arr:Array = Arrays.elementObjCopy(args[0] as Array);
			
			
			// array of ordered pairs 
			var cart_arr:Array = new Array();
			
			// loop thru args
			for (i=0; i<args.length-1; i++) {
				
				// parse current & next array
				var curr_arr:Array = args[i] as Array;
				var next_arr:Array = args[i+1] as Array;
				
				// compare the lengths
				var tmp_ind:int = Arrays.lengthCompare(true, curr_arr, next_arr);
				
				// length change, update index
				if (tmp_ind > -1)
					max_ind = tmp_ind + i;
				
				// define max array from args
				max_arr = args[max_ind] as Array;
			}
			
			// loop thru largest set
			for (i=0; i<max_arr.length; i++) {
				
				// loop thru all the sets
				for (var j:int=0; j<args.length; j++) {
					
					// not the largest…
					if (j != max_ind) {
						var arg_arr:Array = args[j] as Array;
						
						// loop thru the current arg set
						for (var q:int=0; q<arg_arr.length; q++) {
							
							// push paired coords
							cart_arr.push([max_arr[i], arg_arr[q]]);
						}
					}
				}
			}
			
			return (cart_arr);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// http://www.apronus.com/provenmath/axioms.htm
		public static function selection():void {
			
		}
		
		
		// http://www.apronus.com/provenmath/axioms.htm
		public static function regularity():void {
			
		}
		
		
		// http://www.apronus.com/provenmath/axioms.htm
		public static function infinity():void {
			
		}
		
		public static function powerSet():void {
			
		}
		
		
		// http://en.wikipedia.org/wiki/Axiom_of_choice
		public static function axiomOfChoice():void {
			
		}
		
		
		
		private static function coordArray(arr1:Array, arr2:Array):Array {
			
			// coords to return
			var coord_arr:Array = new Array();
			
			// loop thru 1st array
			for (var i:int=0; i<arr1.length; i++) {
				
				// reset the pair
				var pair_arr:Array = new Array();
				
				// loop thru 2nd array & push
				for (var j:int=0; j<arr2.length; j++) {
					pair_arr.push(arr1[i]);
					pair_arr.push(arr2[j]);
				}
				
				// push pair array into coord array
				coord_arr.push(pair_arr);
			}
			
			
			return (coord_arr);
		}
		
	}
}