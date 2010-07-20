package cc.gullinbursti.sorting {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Noncomparing extends BasicSorting {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.	
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function Noncomparing() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		/**
		 * Bead sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function beadSort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: implement radix sort algorithm
			
			
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
		 * Burst sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function burstsort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: implement radix sort algorithm
			
			
			return (in_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Count sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function countSort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: implement radix sort algorithm
			
			
			return (in_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Pigenhole sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function pigeonholeSort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: implement radix sort algorithm
			
			
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