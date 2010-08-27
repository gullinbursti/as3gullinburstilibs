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
		
		// in-lb = N-m * 8.856
		public static function newtonMeterToInchPounds(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 8.856);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// ft-lb = N-m * 0.738
		public static function newtonMeterToFtPounds(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.738);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// N-m = in-lbs * 0.1129
		public static function inchPoundsToNewtonMeters(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.1129);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// ft-lbs = in-lbs / 12
		public static function inchPoundsToFtPounds(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Length.inchesToFeet(val));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// N-m = ft-lbs * 1.355
		public static function ftPoundsToNewtonMeters(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 1.355);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// in-lbs = ft-lbs * 12
		public static function ftPoundsToInchPounds(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Length.feetToInches(val));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// lb = kg * 2.204623
		public static function kilogramsToPounds(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 2.204623);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
	}
}