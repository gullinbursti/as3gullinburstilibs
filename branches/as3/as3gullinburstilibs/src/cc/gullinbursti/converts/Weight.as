package cc.gullinbursti.converts {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Weight {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		// TODO: define & implement some add'l weight conversions
		
		// <*] class constructor [*>
		public function Weight() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// g = ounces * ???
		public static function ouncesToGrams(weight:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (weight * 0);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// ounces = g * ???
		public static function gramsToOunces(weight:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (weight * 0);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// g = lbs * ???
		public static function poundsToGrams(weight:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (weight * 0);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// lbs = g * ???
		public static function gramsToPounds(weight:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (weight * 0);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// kg = lbs * 0.4535922
		public static function poundsToKilos(weight:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (weight * 0.4535922);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// lbs = kg * 2.2
		public static function kilosToPounds(weight:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (weight * 2.204623);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯

	}
}