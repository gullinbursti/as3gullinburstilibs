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
	public class Noncomparing extends BasicSorting {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		
		/*
		* Non-Comaparision Sorts:
		* 	- Bead sort
		*	- Burstsort
		* 	- Bucket sort
		* 	- Radix sort
		*	- Counting sort
		* 	- Pigeonhole sort
		* 	- Postman sort
		*/
		
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
			//TODO: implement bead sort algorithm
			
			// O(n) / O(n2)
			
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
			//TODO: implement bucket sort algorithm
			
			
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
			//TODO: implement burst sort algorithm
			
			
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
			//TODO: implement count sort algorithm
			
			
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
			//TODO: implement pigeonhole sort algorithm
			
			
			return (in_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Radix sorts the data set by LSD (least signifcant digit) & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function lsdRadixSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement lsd radix sort algorithm
			
			
			return (in_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function msdRadixSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement msd radix sort algorithm
			
			
			return (in_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function postmanSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement postman sort algorithm
			
			
			return (in_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function spaghettiSort(in_arr:Array, isAscending:Boolean=true):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//TODO: implement spaghetti sort algorithm
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}