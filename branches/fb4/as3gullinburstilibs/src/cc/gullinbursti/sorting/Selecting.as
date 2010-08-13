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
	public class Selecting extends BasicSorting {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		/*
		 * Selection sorts:
		 *	- Heapsort: convert the list into a heap, keep removing the largest element from the heap and adding it to the end of the list
		 * 	- Selection sort: pick the smallest of the remaining elements, add it to the end of the sorted list
		 *  - Smoothsort
		*/
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.	
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function Selecting() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function selectionSort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/*
			Not stable
			O(1) extra space
			Θ(n²) comparisons
			Θ(n) swaps
			Not adaptive
			*/
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			var len:int = in_arr.length;
			var min_ind:int;
			
			// loop from top to bot
			for (var i:int=len-1; i>0; i--) {
				
				// prime lowest index
				min_ind = 0;
				
				// loop from 1st to counter
				for (var j:int=1; j<=i; j++) {
					
					// val is less than lowest index, set lowest to val
					if (sort_arr[j] < sort_arr[min_ind])
						min_ind = j;
				}
				
				// swap the elements
				Arrays.swapElements(sort_arr, min_ind, i);
			}
			
			// return ordered list
			return (orderBy(sort_arr, !isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function cartTreeSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function heapSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: Implement heap sort
			
			/*
				Not stable
				O(1) extra space (see discussion)
				O(n·lg(n)) time
				Not really adaptive
			*/
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		
		
		
		public static function poolsort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement poolsort algorithm
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function smoothsort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: Implement smoothsort
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function tournamentSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}