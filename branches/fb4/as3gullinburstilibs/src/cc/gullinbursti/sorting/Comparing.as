package cc.gullinbursti.sorting {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class Comparing extends BasicSorting {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		// TODO: implement add'l exchange sorts
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.	
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function Comparing() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		/**
		 * Bubble sorts the data set & returns the sorted list. 
		 * (aka exchange sort)
		 * 
		 * @param array
		 * @return Array
		 */
		public static function bubbleSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: implement bubble sort algorithm
			
			
			/**
			 * 
			 * procedure bubbleSort( A : list of sortable items ) defined as:
			 * 	 do
			 * 	   swapped := false
			 *     for each i in 0 to length(A) - 2 inclusive do:
			 * 
			 *       if A[i] > A[i+1] then
			 *         swap( A[i], A[i+1] )
			 *         swapped := true
			 *       end if
			 * 
			 *     end for
			 *   while swapped
			 * end procedure
			 * 
			 */
			
			return (in_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		
		/**
		 * Bucket sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function bucketSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: implement bucket sort algorithm
			
			
			/**
			 * 
			 * function bucket-sort(array, n) is
			 *   buckets ← new array of n empty lists
			 *   
			 *   for i = 0 to (length(array)-1) do
			 *     insert array[i] into buckets[msbits(array[i], k)]
			 *     
			 *     for i = 0 to n - 1 do
			 *       next-sort(buckets[i])
			 * 
			 * 
			 * return the concatenation of buckets[0], ..., buckets[n-1]
			 */
			
			return (in_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Radix sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function radixSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: implement radix sort algorithm
			
			
			return (in_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}