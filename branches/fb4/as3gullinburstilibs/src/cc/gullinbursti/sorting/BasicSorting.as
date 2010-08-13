package cc.gullinbursti.sorting {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.lang.Arrays;
	import cc.gullinbursti.math.BasicMath;
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
		
		
		// shortcuts to common sorting methods
		
		public static function binarySort(in_arr:Array, isAsc:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Exchanging.binarySort(in_arr, isAsc));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function bubbleSort(in_arr:Array, isAsc:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Exchanging.bubbleSort(in_arr, isAsc));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function insertionSort(in_arr:Array, isAsc:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Inserting.insertionSort(in_arr, isAsc));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function mergeSort(in_arr:Array, isAsc:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Merging.mergeSort(in_arr, isAsc));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function quicksort(in_arr:Array, isAsc:Boolean=true, l:int=0, r:int=-1):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Exchanging.quicksort(in_arr, l, r, isAsc));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function selectionSort(in_arr:Array, isAsc:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Selecting.selectionSort(in_arr, isAsc));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function heapSort(in_arr:Array, isAsc:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Selecting.heapSort(in_arr, isAsc));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function radixSort(in_arr:Array, isAsc:Boolean=true, isLSD:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (isLSD)
				return (Noncomparing.lsdRadixSort(in_arr, isAsc));
			
			return (Noncomparing.msdRadixSort(in_arr, isAsc));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		
		
		
		
		
		
		
		
		
		
		/**
		 * Finds the cutoff index in an array for various sorting algorithms
		 *  
		 * @param arr the array to sort
		 * @param l desired starting index
		 * @param r desired ending index
		 * @return  the index to divide on
		 * 
		 */		
		protected static function partition(arr:Array, l:int, r:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// the pivot point
			var pivot:int = arr[(l + r) / 2];
			
			// swap tmp
			var tmp:int;
			
			// loop incs
			var i:int = l;
			var j:int = r;
			
			// start val is less than end val
			while (i <= j) {
				
				// before the pivot, inc i
				while (arr[i] < pivot)
					i++;
				
				// after pivot, dec j
				while (arr[j] > pivot)
					j--;
				
				// swap i and j
				if (i <=j) {
					tmp = arr[i];
					arr[i] = arr[j];
					arr[j] = tmp;
					
					i++;
					j--;
				}
			}
			
			// 
			return (i);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}