package cc.gullinbursti.converts {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Force {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		/**
		 * newtons
		 * kilograms
		 * pounds
		 */
		
		// <*] class constructor [*>	
		public function Force() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// N = kg * 9.80665
		public static function kilogramsToNewtons(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 9.80665);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// N = lb * 4.44822
		public static function poundsToNewtons(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 4.44822);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// kg = N * 0.1019716
		public static function newtonsToKilograms(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.1019716);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// kg = lb * 0.4535922
		public static function poundsToKilograms(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.4535922);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// lb = N * 0.224809
		public static function newtonsToPounds(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.1019716);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// lb = kg * 2.204623
		public static function kilogramsToPounds(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 2.204623);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
	}
}