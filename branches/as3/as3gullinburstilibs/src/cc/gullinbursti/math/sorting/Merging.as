package cc.gullinbursti.math.sorting {
	
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
		// TODO: implement add'l merge sort algorithms
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function Merging() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		/**
		 * Merge sorts the data set & returns the sorted list 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function mergeSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: implement merge sort algorithm [http://en.wikipedia.org/wiki/Merge_sort]
			
			/**
			 * 
			 * if length(m) ≤ 1
			 *	 return m
			 * 
			 * var list left, right, result
			 * var integer middle = length(m) / 2
			 * 
			 * for each x in m up to middle
			 *	 add x to left
			 * 
			 * for each x in m after middle
			 *	 add x to right
			 * 
			 * left = merge_sort(left)
			 * right = merge_sort(right)
			 * 
			 * if left.last_item > right.first_item
			 *	 result = merge(left, right)
			 * 
			 * else
			 *	 result = append(left, right)
			 * 
			 * 
			 * return result
			 * 
			 */
			
			return (in_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯

	}
}