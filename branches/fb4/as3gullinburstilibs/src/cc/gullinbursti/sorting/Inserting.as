package cc.gullinbursti.sorting {
	import cc.gullinbursti.utils.Arrays;
	
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
		 * Insertion sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function insertionSort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var j:int;
			var tmp:int;
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			for (var i:int=1; i<sort_arr.length; i++) {
				tmp = sort_arr[i];
				j = i;
				
				while (j > 0 && sort_arr[j-1] > tmp) {
					sort_arr[j] = sort_arr[j-1];
					j--;
				}
				sort_arr[j] = tmp;
			}
			
			return (sort_arr);
			
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Library sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function librarySort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Patience sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function patienceSort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Shell sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function shellSort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Tree sorts the data set & returns the sorted list. 
		 * 
		 * @param array
		 * @return Array
		 */
		public static function treeSort(in_arr:Array, isAscending:Boolean=true):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var sort_arr:Array = Arrays.xerox(in_arr, true);
			
			return (sort_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}