package cc.gullinbursti.sorting {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.lang.Arrays;
	import cc.gullinbursti.lang.Numbers;
	import cc.gullinbursti.math.BasicMath;
	
	import flash.geom.Point;

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
		// Bitonic sorter
		// Topological sort
		// Samplesort
		
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const MAX_RECURSIONS:int = 512;
		protected static var _recursion_pt:Point;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function BasicSorting() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// shortcuts to common sorting methods
		
		/**
		 * Utilizes the common <i>binary sort</i> algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */		
		public static function binarySort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Exchanging.binarySort(in_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the common <i>bubble sort</i> algorithm to order items in a list.
		 * @param in_arr A list of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */		
		public static function bubbleSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Exchanging.bubbleSort(in_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Utilizes the common <i>exchange sort</i> algorithm to order items in a list.
		 * @param in_arr A list of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */		
		public static function exchangeSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Exchanging.exchangeSort(in_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the common <i>heap sort</i> algorithm to order items in a list.
		 * @param in_arr A list of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */		
		public static function heapSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Selecting.heapSort(in_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the common <i>insertion sort</i> algorithm to order items in a list.
		 * @param in_arr A list of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */		
		public static function insertionSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Inserting.insertionSort(in_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the common <i>merge sort</i> algorithm to order items in a list.
		 * @param in_arr A list of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */		
		public static function mergeSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Merging.mergeSort(in_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the common <i>quicksort</i> algorithm to order items in a list.
		 * @param in_arr A list of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */		
		public static function quicksort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Exchanging.quicksort(in_arr, isAscending, 0, -1, MAX_RECURSIONS));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes a common <i>radix sort</i> algorithm to order items in a list.
		 * @param in_arr A list of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @param isLSD Whether or not to use least signifcant digit or most signifcant digit method
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */		
		public static function radixSort(in_arr:Array, isAscending:Boolean=true, isLSD:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// use LSD
			if (isLSD)
				return (Noncomparing.lsdRadixSort(in_arr, isAscending));
			
			// use MSD
			return (Noncomparing.msdRadixSort(in_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the common <i>selection sort</i> algorithm to order items in a list.
		 * @param in_arr A list of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */		
		public static function selectionSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Selecting.selectionSort(in_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		
		/**
		 * Determines if a list is in ascending or desending order.
		 * @param in_arr An <code>Array</code> to test
		 * @return A value specifiying order: -1=Descending, 0=Unordered, 1=Ascending
		 * 
		 */		
		public static function isSorted(in_arr:Array):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// it's in ascending order
			if (isAcsendSorted(in_arr))
				return (1);
			
			// it's in decending order
			if (isDesendSorted(in_arr))
				return (-1);
			
			
			// it's not in order
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Determines if a list is in ascending order 
		 * @param in_arr An <code>Array</code> to test
		 * @return Whether or not it's ascend sorted
		 * 
		 */		
		public static function isAcsendSorted(in_arr:Array):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// comapare the two arrays
			return (Arrays.isEqualTo(in_arr, quicksort(in_arr)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Determines if a list is in decending order 
		 * @param in_arr An <code>Array</code> to test
		 * @return Whether or not it's descend sorted
		 * 
		 */
		public static function isDesendSorted(in_arr:Array):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// compare the two arrays
			return (Arrays.isEqualTo(in_arr, quicksort(in_arr, false)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		
		/**
		 * Helper internal function to determine the returned item list ordering.
		 * @param sort_arr A list of sorted items
		 * @param isAscending Determines ascending / descending returned order
		 * @return The sorted <code>Array</code> in ascending / descending order
		 * 
		 */		
		protected static function orderBy(sort_arr:Array, isAscending:Boolean):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//trace ("ORDER BY ASC: ["+isAscending+"]")
			
			// descend flag, reverse it
			if (!isAscending)
				Arrays.reverse(sort_arr);
			
			
			// send back the list
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		
		
		/**
		 * Helper internal function to find the partition index in an <code>Array</code> for various sorting algorithms.
		 *  
		 * @param arr the array to sort
		 * @param l desired starting index
		 * @param r desired ending index
		 * @return  the index to divide on
		 * 
		 */		
		protected static function partition(in_arr:Array, l:int, r:int, piv:Number=-1):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			
			var pivot_val:Number = piv;
			
			if (piv == -1)
				pivot_val = in_arr[Numbers.dropDecimal((l + r) / 2)];
			 
			
			// loop incs
			var i:int = l;
			var j:int = r;
			
			// start val is less than end val
			while (i <= j) {
				
				// before the pivot, inc i
				while (in_arr[i] < pivot_val)
					i++;
				
				// after pivot, dec j
				while (in_arr[j] > pivot_val)
					j--;
				
				// swap vals at indexes i & j, then increment them
				if (i <= j)
					Arrays.swapElements(in_arr, i++, j--); 
			}
			
			// the index to partition on 
			return (i);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}