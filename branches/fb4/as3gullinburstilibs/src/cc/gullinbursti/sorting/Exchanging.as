package cc.gullinbursti.sorting {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.lang.Arrays;
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
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function Exchanging() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
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
					
					// returning asc vals
					if (isAscending) {
						
						// index under [j] is >, set to swap
						if (sort_arr[base_ind] > sort_arr[j]) {
							base_ind = j;
							isSwap = true;
						}
						
						// return desc vals
					} else {
						
						// index under [j] is smaller, set to swap
						if (sort_arr[base_ind] < sort_arr[j]) {
							base_ind = j;
							isSwap = true;
						}
					}
				}
				
				// swap two array vals, if needed
				if (isSwap)
					Arrays.swapElements(sort_arr, base_ind, i);
			}
			
			
			// return sorted array
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Bubble sorts the data set & returns the sorted list. 
		 * (aka exchange sort)
		 * 
		 * @param array
		 * @return Array
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
		 * Cocktail sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function cocktailSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement cocktail sort algorithm
			
			//O(n²)
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Comb sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function combSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement comb sort algorithm
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
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
		 * Odd-Even sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function oddEvenSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement odd/even sort algorithm
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Quicksorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function quicksort(in_arr:Array, l:int=0, r:int=-1, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement quick sort algorithm
			
			/*
				Not stable
				O(lg(n)) extra space (see discussion)
				O(n2) time, but typically O(n·lg(n)) time
				Not adaptive
			*/
			
			//var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			if (r == -1)
				r = in_arr.length;
			
			var ind:int = partition(in_arr, l, r);
			
			if (l < ind -1)
				quicksort(in_arr, l, ind - 1);
			
			if (ind < r)
				quicksort(in_arr, ind, r);
			
			
			return (in_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Quicksorts using 3-way partitoning of the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function quicksort3(in_arr:Array, l:int=0, r:int=-1, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement quick sort 3 algorithm
			
			/*
				Not stable
				O(lg(n)) extra space
				O(n²) time, but typically O(n·lg(n)) time
				Adaptive: O(n) time when O(1) unique keys
			*/
			
			//var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			if (r == -1)
				r = in_arr.length;
			
			var ind:int = partition(in_arr, l, r);
			
			if (l < ind -1)
				quicksort(in_arr, l, ind - 1);
			
			if (ind < r)
				quicksort(in_arr, ind, r);
			
			
			return (in_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}