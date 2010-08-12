package cc.gullinbursti.sorting {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.lang.Arrays;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class BasicSorting extends BasicMath {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		// http://en.wikipedia.org/wiki/Sorting_algorithm
		
		
		/*
		 * Efficencies:
		 * 	Best Case -
		 *	Average Case -
		 *	Worst Case -
		*/
		
		
		/* Stable Sort:
		 *	Ordred key/vals maintain the same order
		 *	ORG  (4, 2) (3, 7) (3, 1) (5, 6)
		 *	SORT (3, 7) (3, 1) (4, 2) (5, 6) 
		*/
		
		/* Unstable Sort:
		 *	Ordered key/vals can be rearranged
		 *	ORG  (4, 2) (3, 7) (3, 1) (5, 6)
		*	SORT (3, 7) (3, 1) (4, 2) (5, 6) 
		*/
		
		
		/* Comparison Sort:
		*	if a ≤ b and b ≤ c then a ≤ c (transitivity)
		*	for all a and b, either a ≤ b or b ≤ a (trichomy)
		*
		* 	- Quick sort
		* 	- Heap sort
		* 	- Merge sort
		* 	- Intro sort
		* 	- Intersion sort
		* 	- Selection sort
		* 	- Bubble sort
		*/
		
		/*
		* Non-Comaparision Sorts:
		* 	- Bead sort
		*	- Burstsort
		* 	- Bucket sort
		* 	- Radix sort
		*	- Counting sort
		* 	- Pigeonhole sort
		* 	- Postman sort
		*/
		
		/* Han's algorithm:
		 *	A deterministic algorithm for sorting keys from a domain of finite size, taking 
		 *		O(n log log n) time
		 *		O(n) space
		*/
		
		/* Thorup's algorithm:
		*	A randomized algorithm for sorting keys from a domain of finite size, taking
		*		O(n log log n) time
		*		O(n) space
		*/
		
		/* Integer algorithm:
		*	An algorithm taking
		*		O(n√(log log n)) expected time
		*		O(n) space
		*/
		
		
		// Pancake sorting [http://en.wikipedia.org/wiki/Pancake_sorting]
		// Flash sort [http://www.neubert.net/FSOIntro.html]
		// Bitonic sorter
		// Topological sort
		// Samplesort
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.	
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function BasicSorting() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// shortcuts to primary sorting methods
		
		public static function bubbleSort(in_arr:Array, isAsc:Boolean=true):Array {
			return (Exchanging.bubbleSort(in_arr, isAsc));
		}
		
		public static function insertSort(in_arr:Array, isAsc:Boolean=true):Array {
			return (Inserting.insertionSort(in_arr, isAsc));
		}
		
		public static function mergeSort(in_arr:Array, isAsc:Boolean=true):Array {
			return (Merging.mergeSort(in_arr, isAsc));
		}
		
		public static function quicksort(in_arr:Array, l:int, r:int, isAsc:Boolean=true):Array {
			return (Exchanging.quicksort(in_arr, l, r, isAsc));
		}
		
		public static function selectSort(in_arr:Array, isAsc:Boolean=true):Array {
			return (Selecting.selectionSort(in_arr, isAsc));
		}
		
		
		
		
		/**
		 * Binary sorts the data set & returns the sorted list 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function binary(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// base index to compare
			var base_ind:int;
			
			// swap flag
			var isSwap:Boolean;
			
			
			// start outer sort loop
			for (var i:int=0; i<in_arr.length-1; i++) {
				
				// find the next smallest number
				base_ind = i;
				isSwap = false;
				
				// start inner loop
				for (var j:int=i+1; j<in_arr.length; j++) {
					
					// returning asc vals
					if (isAscending) {
						
						// index under [j] is >, set to swap
						if (in_arr[base_ind] > in_arr[j]) {
							base_ind = j;
							isSwap = true;
						}
					
					// return desc vals
					} else {
						
						// index under [j] is smaller, set to swap
						if (in_arr[base_ind] < in_arr[j]) {
							base_ind = j;
							isSwap = true;
						}
					}
				}
	
				// swap two array vals, if needed
				if (isSwap)
					Arrays.swapElements(in_arr, base_ind, i);
			}
			
			
			// return as a new ref'ed arr
			return (Arrays.ptMemRef(in_arr));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Intro sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function introsort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement intro sort algorithm
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Flash sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function flashsort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement flash sort algorithm
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Spaghetti sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function spaghettiSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement spaghetti sort algorithm
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Spread sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function spreadsort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement spread sort algorithm
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * J-sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function jSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement j sort algorithm
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Pool sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function poolSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement pool sort algorithm
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		protected static function partition(arr:Array, l:int, r:int):int {
			
			var tmp:int;
			var i:int = l;
			var j:int = r;
			var pivot:int = arr[(l + r) / 2];
			
			while (i <= j) {
				while (arr[i] < pivot)
					i++;
				
				while (arr[j] > pivot)
					j--;
				
				if (i <=j) {
					tmp = arr[i];
					arr[i] = arr[j];
					arr[j] = tmp;
					
					i++;
					j--;
				}
			}
			
			return (i);
		}
		
	}
}