package cc.gullinbursti.sorting {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.utils.Arrays;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class BasicSorting extends BasicMath {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		// TODO: beef up basic sorting class [http://en.wikipedia.org/wiki/Sorting_algorithm]
		//	Pancake sorting (http://en.wikipedia.org/wiki/Pancake_sorting)
		// (http://en.wikipedia.org/wiki/Sorting_algorithm)
		
		/*
		Exchange Sorts
			Bubble sort: for each pair of indices, swap the items if out of order
			Cocktail sort
			Comb sort
			Gnome sort
			Odd-even sort
			Quicksort: divide list into two, with all items on the first list coming before all items on the second list.; then sort the two lists. Often the method of choice
		
		Humorous or ineffective
			Bogosort
			Stooge sort
		
		Hybrid
			Flashsort
			Introsort: begin with quicksort and switch to heapsort when the recursion depth exceeds a certain level
		
		Insertion sorts
			Insertion sort: determine where the current item belongs in the list of sorted ones, and insert it there
			Library sort
			Patience sorting
			Shell sort: an attempt to improve insertion sort
			Tree sort (binary tree sort): build binary tree, then traverse it to create sorted list
		
		Merge sorts
			Merge sort: sort the first and second half of the list separately, then merge the sorted lists
			Strand sort
			Non-comparison sorts
			Bead sort
			Bucket sort
			Burstsort: build a compact, cache efficient burst trie and then traverse it to create sorted output
			Counting sort
			Pigeonhole sort
			Postman sort: variant of Bucket sort which takes advantage of hierarchical structure
			Radix sort: sorts strings letter by letter
		
		Selection sorts
			Heapsort: convert the list into a heap, keep removing the largest element from the heap and adding it to the end of the list
			Selection sort: pick the smallest of the remaining elements, add it to the end of the sorted list
			Smoothsort
		
		Other
			Bitonic sorter
			Pancake sorting
			Topological sort
		
		Unknown class
			Samplesort
		*/
		
		
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
					Arrays.swap(in_arr, base_ind, i);
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