package cc.gullinbursti.sorting {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.lang.Arrays;
	import cc.gullinbursti.lang.Numbers;
	import cc.gullinbursti.lang.Objects;
	
	import flash.geom.Point;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Exchanging extends BasicSorting {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		/*
		* Exchange Sorts:
		*	- Bubble sort
		*	- Cocktail sort
		*	- Comb sort
		*	- Gnome sort
		*	- Odd-even sort
		*	- Quicksort
		*/
		
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		private static var resurse_pt:Point;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function Exchanging() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		/**
		 * Utilizes the common <i>exchange sort</i> algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */	
		public static function exchangeSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			var len:int = in_arr.length;
			var tmp:int;
			
			for (var i:int=0; i<len; i++) {
				for (var j:int=i+1; j<len; j++) {
				
					if (sort_arr[i] > sort_arr[j])
						Arrays.swapElements(sort_arr, i, j);
				}
			}
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		
		/**
		 * Utilizes the <i>binary sort</i> algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */
		public static function binarySort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// array length
			var len:int = in_arr.length;
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			// base index to compare
			var base_ind:int;
			
			// swap flag
			var isSwap:Boolean;
			
			
			// start outer sort loop
			for (var i:int=0; i<len; i++) {
				
				// find the next smallest number
				base_ind = i;
				isSwap = false;
				
				// start inner loop
				for (var j:int=i+1; j<len; j++) {
						
					// index under [j] is >, set to swap
					if (sort_arr[base_ind] > sort_arr[j]) {
						base_ind = j;
						isSwap = true;
					}	
				}
				
				// swap two array vals, if needed
				if (isSwap)
					Arrays.swapElements(sort_arr, base_ind, i);
			}
			
			
			// return sorted list asc / desc
			return (orderBy(sort_arr, isAscending));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the <i>bubble sort</i> algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */
		public static function bubbleSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/*
				Stable
				O(1) extra space
				O(n²) comparisons and swaps
				Adaptive: O(n) when nearly sorted
			*/
			
			
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			var isSwapped:Boolean = true;
			var j:int = 0;
			var tmp:int;
			
			// loop until no swapping
			while (isSwapped) {
				
				// prime boolean
				isSwapped = false;
				
				// loop counter
				j++;
				
				// loop thru array, counter to length
				for (var i:int=0; i<sort_arr.length - j; i++) {
					
					// swap elements if current > the next
					if (sort_arr[i] > sort_arr[i+1])
						Arrays.swapElements(sort_arr, i, i+1);
				}
			}
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		
		/**
		 * Utilizes the <i>cocktail sort</i> algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */
		public static function cocktailSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement cocktail sort algorithm
			
			//O(n²)
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Utilizes the <i>comb sort</i> algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */	
		public static function combSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement comb sort algorithm
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Utilizes the <i>gnome sort</i> algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */
		public static function gnomeSort(in_arr:Array):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement gnome sort algorithm
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			/**
			 * 
			 * function gnomeSort(a[0..size-1]) {
			 *   i := 1
			 *   j := 2
			 * 
			 *   while (i < size) {
			 *     
			 *     if a[i-1] >= a[i]) { # for descending sort, reverse the comparison to <=
			 *       i := j
			 *       j := j + 1 
			 *     
			 *     } else {
			 *       swap a[i-1] and a[i]
			 *       i := i - 1
			 *       
			 *       if (i = 0) {
			 *         i := j
			 *         j := j + 1
			 *       }
			 *     }
			 *   }
			 * }
			 * 
			 */
			
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the <i>odd/even sort</i> algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */
		public static function oddEvenSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement odd/even sort algorithm
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Utilizes the <i>quicksort</i> algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param l Starting index to sort on
		 * @param r Ending index to sort on
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */
		public static function quicksort(in_arr:Array, l:int=0, r:int=-1, max:int=MAX_RECURSIONS, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			/*
				Not stable
				O(lg(n)) extra space (see discussion)
				O(n2) time, but typically O(n·lg(n)) time
				Not adaptive
			*/
			
			// change end index to last
			if (r == -1)
				r = in_arr.length-1;
			
			
			// duplicate input array
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			
			// init recurse counter
			resurse_pt = new Point(0, Math.min(max, MAX_RECURSIONS));
			
			// start the sort
			kwiksort(sort_arr, l, r);
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Utilizes the <i>3-way quicksort</i> algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param l Starting index to sort on
		 * @param r Ending index to sort on
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */	
		public static function quicksort3(in_arr:Array, l:int=0, r:int=-1, max:int=MAX_RECURSIONS, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement quick sort 3 algorithm
			
			/*
				Not stable
				O(lg(n)) extra space
				O(n²) time, but typically O(n·lg(n)) time
				Adaptive: O(n) time when O(1) unique keys
			*/
			
			// change end index to last
			if (r == -1)
				r = in_arr.length-1;
			
			
			// duplicate input array
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			
			// init recurse counter
			resurse_pt = new Point(0, Math.min(max, MAX_RECURSIONS));
			
			// start the sort
			kwiksort3(sort_arr, l, r);
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Helper internal function for quicksort recursion.
		 * @param in_arr An <code>Array</code> containing all / a segment of the items 
		 * @param l Staring index to sort on
		 * @param r Ending index to sort on
		 * 
		 */		
		private static function kwiksort(in_arr:Array, l:int, r:int):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// find the index to partition on
			var par_ind:int = partition(in_arr, l, r);
			
			
			// inc the rescurse counter
			resurse_pt.x++;
			
			// abandon sort at max recursions
			if (resurse_pt.x >= resurse_pt.y)
				return;
			
			// recurse when left index
			if (l < par_ind - 1)
				kwiksort(in_arr, l, par_ind - 1);
			
			
			// recurse when partition index 
			if (par_ind < r)
				kwiksort(in_arr, par_ind, r);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Helper internal function for 3-way quicksort recursion.
		 * @param in_arr An <code>Array</code> containing all / a segment of the items 
		 * @param l Staring index to sort on
		 * @param r Ending index to sort on
		 * 
		 */		
		private static function kwiksort3(in_arr:Array, l:int, r:int):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// inc the rescurse counter
			resurse_pt.x++;
			
			trace ("\n\n]] ("+resurse_pt.x+")START ->> l:["+l+"] r:["+r+"] arr:["+in_arr+"]")
			
			// cutoff
			if (l+3 > r)
				insertSort(in_arr, l, r);
				
			// sort low, middle, high
			else {
				
				// middle index
				var m:int = Numbers.dropDecimal((l + r) / 2);
				trace ("]] SORT ->> l:["+l+"] m:["+m+"] r:["+r+"] ")
				
				
				// middle not equal to left val
				if (in_arr[m] >= in_arr[l]) {
					Arrays.swapElements(in_arr, l, m);
					trace ("  -:]] 1-SWAP(l/m) ->> arr:["+in_arr+"]")
				}
			
				// right not equal to left val
				if (in_arr[r] <= in_arr[l]) {
					Arrays.swapElements(in_arr, l, r);
					trace ("  -:]] 2-SWAP(l/r) ->> arr:["+in_arr+"]")
				}
				
				// right not equal to middle val
				if (in_arr[r] >= in_arr[m]) {
					Arrays.swapElements(in_arr, m, r);
					trace ("  -:]] 3-SWAP(m/r) ->> arr:["+in_arr+"]")
				}
				
				
				// swap items at middle & right index - 1
				Arrays.swapElements(in_arr, m, r-1);
				trace ("  -:]] 4-SWAP(m/r-1) ->> arr:["+in_arr+"]")
				
				
				// make a pivot val & find partition
				var pivot_val:int = in_arr[r-1];
				var par_ind:Number = partition(in_arr, l, r, in_arr[r-1])
				trace ("]] PAR ->> piv:["+pivot_val+"] par:["+par_ind+"]\n")
				
				
				// restore prev pivot
				Arrays.swapElements(in_arr, m, r-1);
				trace ("]] RES(i/r-1) ->> arr:["+in_arr+"]")
				
				
				
				// recurse when left index
				if (l < par_ind - 1)
					kwiksort3(in_arr, l, par_ind - 1);
				
				
				// recurse when partition index 
				if (par_ind < r)
					kwiksort3(in_arr, par_ind, r);
			}
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Helper internal function for 3-way quicksort that performs an insertion sort
		 * @param in_arr
		 * @param l
		 * @param r
		 * 
		 */		
		private static function insertSort(in_arr:Array, l:int, r:int):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// loop from left+1 to right
			for (var i:int=l+1; i<=r; i++) {
				
				// prime counter
				var j:int = i;
				
				// loop until j equals left AND i is larger than j-1
				while (j>l && in_arr[i] < in_arr[j-1]) {
					
					// make j the prev j
					in_arr[j] = in_arr[--j];
				}
				
				// swap i & j items
				in_arr[j] = in_arr[i];
			}
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}