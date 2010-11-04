package cc.gullinbursti.sorting {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.lang.Arrays;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	
	// <[!] class delaration [¡]>
	public class Asinine extends BasicSorting {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function Asinine() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		/**
		 * Utilizes <i>bogo sort</i> as the class default algorithm to sort a list of items.
		 * @param in_arr An <code>Array</code> of items to sort
		 * 
		 */		
		public static function sort(in_arr:Array, isAscending:Boolean=true):void {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// perform bogo sort on list
			in_arr = bogoSort(in_arr, isAscending);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the <i>bogo sort</i> (bogus) algorithm to order items in a list.
		 * <p>AKA <i>random sort</i>, <i>shotgun sort</i>, or <i>monkey sort</i></p>
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */	
		public static function bogoSort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement bogo sort algorithm
			
			/* O(n • n!) */
			
			
			// duplicate input array
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the <i>lucky sort</i> algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */	
		public static function luckysort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement lucky sort algorithm
			
			
			// duplicate input array
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Utilizes the <i>stooge sort</i> algorithm to order items in a list.
		 * @param in_arr An <code>Array</code> of items to sort
		 * @param isAscending Determines ascending / descending returned order
		 * @return A new <code>Array</code> of sorted items
		 * 
		 */	
		public static function stoogeSort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement stooge sort algorithm
			
			/* O(n²⁽⁷ʹ¹⁰⁾ */
			
			// duplicate input array
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			
			// return the sorted list
			return (orderBy(sort_arr, isAscending));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯	
	}
}