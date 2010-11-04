package cc.gullinbursti.sorting {
	import cc.gullinbursti.lang.Arrays;
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>-
	public class Inserting extends BasicSorting {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		/*
		 * Insertion sorts:
		 *	- Insertion sort: determine where the current item belongs in the list of sorted ones, and insert it there
		 *	- Library sort
		 *	- Patience sorting
		 *	- Shell sort: an attempt to improve insertion sort
		 *	- Tree sort (binary tree sort): build binary tree, then traverse it to create sorted list
		*/
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.	
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function Inserting() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		
		/**
		 * Utilizes <i>insertion sort</i> as the class default algorithm to sort a list of items.
		 * @param in_arr An <code>Array</code> of items to sort
		 * 
		 */		
		public static function sort(in_arr:Array, isAscending:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// perform bogo sort on list
			in_arr = insertionSort(in_arr, isAscending);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Utilizes the common insertion sort algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */	
		public static function insertionSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/*
				Stable
				O(1) extra space
				O(n²) comparisons and swaps
				Adaptive: O(n) time when nearly sorted
			*/
			
			
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			
			// loop from index 1 to end
			for (var i:int=1; i<sort_arr.length; i++) {
				
				// set a tmp obj
				var tmp_obj:Object = sort_arr[i];
				
				// prime j index
				var j:int = i;
				
				
				// loop while j is larger than 0 AND val at j-1 is larger than the tmp
				while (j > 0 && sort_arr[j-1] > tmp_obj) {
					
					// swap pt1
					sort_arr[j] = sort_arr[j-1];
					
					// dec j index
					j--;
				}
				
				// swap pt2
				sort_arr[j] = tmp_obj;
			}
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Utilizes the flash sort algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */	
		public static function flashSort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement flash sort algorithm [http://www.neubert.net/FSOIntro.html]
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the j-sort algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */
		public static function jSort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement j sort algorithm
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the library sort algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */	
		public static function librarySort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement library sort algorithm
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the patience sort algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */	
		public static function patienceSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement patience sort algorithm
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the shell sort algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */	
		public static function shellSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement shell sort algorithm
			
			/*
				Not stable
				O(1) extra space
				O(n ³⸍²) time as shown (see below)
				Adaptive: O(n·lg(n)) time when nearly sorted
			*/
			
			/**
			 * 	h = 1
			 * 	while h < n, h = 3*h + 1
			 * 		while h > 0,
			 * 		h = h / 3
			 * 		for k = 1:h, insertion sort a[k:h:n]
			 * 		→ invariant: each h-sub-array is sorted
			 * 	end
			 */
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Utilizes the tree sort algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */	
		public static function treeSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement tree sort algorithm
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}