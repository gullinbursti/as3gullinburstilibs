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
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function BasicSorting() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		
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
		
	}
}