package cc.gullinbursti.utils {
	import flash.geom.Point;
	
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class Numbers {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function Numbers() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function setPrecision(val:Number, places:int=2):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// get the decimal val of places (1/10^places)
			var fract:Number = 1 / Math.pow(10, places);
			
			// the fract < val
			if (fract <= val)
				return (dropDecimal(val / fract) * fract);
			
			else
				return (val);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function dropDecimal(val:Number):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val << 0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the ordinal suffix of a # (th / st / nd / rd)
		 * 
		 * @param date Date
		 * @retun String; 
		 */
		public static function getOrdinalSuffix(val:int):String {
			
			var suffix_str:String;
			
			switch(val) {
				
				case 1:
					suffix_str = "st";
					break;
				
				case 2:
					suffix_str =  "nd";
					break;

				case 3:
					suffix_str = "rd";
					break;
				
				default:
					suffix_str = "th";
					break;				
			}
			
			return (suffix_str);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Swaps the values of two #'s.
		 */
		public static function swap(val1:Number, val2:Number):Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._		
			
			var tmp_val:Number = val1;
			
			val1 = val2;
			val2 = tmp_val;
			
			return (new Point(val1, val2));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}