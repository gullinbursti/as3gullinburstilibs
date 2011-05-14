package cc.gullinbursti.sorting {
	import cc.gullinbursti.lang.Arrays;
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class Merging extends BasicSorting {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		//TODO: implement add'l merge sort algorithms
		
		
		/*
		 * Merge sorts:
		 * 	- Merge sort: sort the first and second half of the list separately, then merge the sorted lists
		 * 	- Strand sort
		*/
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.	
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function Merging() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		/**
		 * Utilizes <i>merge sort</i> as the class default algorithm to sort a list of items.
		 * @param in_arr An <code>Array</code> of items to sort
		 * 
		 */		
		public static function sort(in_arr:Array, isAscending:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// perform bogo sort on list
			in_arr = mergeSort(in_arr, isAscending);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Utilizes the common merge sort algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */
		public static function mergeSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement merge sort algorithm
			
			/*
				Stable
				Θ(n) extra space for arrays (as shown)
				Θ(lg(n)) extra space for linked lists
				Θ(n·lg(n)) time
				Not adaptive
				Does not require random access to data
			*/
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Utilizes the polyphase sort algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */
		public static function polyphaseSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement polyphase sort algorithm
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the strand sort algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */
		public static function strandSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement strand sort algorithm
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Utilizes the timsort algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */
		public static function timsort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement time sort algorithm
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the unshuffle sort algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */
		public static function unshuffleSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement unshuffle sort algorithm
			
			// sorted array
			var sort_arr:Array = Arrays.xerox(in_arr, true); 
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}