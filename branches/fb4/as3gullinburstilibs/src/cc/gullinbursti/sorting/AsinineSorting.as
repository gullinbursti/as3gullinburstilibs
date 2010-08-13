package cc.gullinbursti.sorting {
	import cc.gullinbursti.lang.Arrays;
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	
	// <[!] class delaration [¡]>
	public class AsinineSorting extends BasicSorting {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function AsinineSorting() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
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
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			
			
			
			
			return (in_arr);
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
			
			
			return (in_arr);
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
			
			return (in_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}