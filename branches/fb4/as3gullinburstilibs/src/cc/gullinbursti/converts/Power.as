package cc.gullinbursti.converts {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Power {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		// <*] class constructor [*>	
		public function Power() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		// w = hp * 745.6999
		public static function horsepowerToWatts(pwr:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (pwr * 745.6999);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// kw = hp * 1000
		public static function horsepowerToKilowatts(pwr:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (wattsToKilowatts(horsepowerToWatts(pwr)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// hp = w * 0.001341022
		public static function wattsToHorsepower(pwr:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (pwr * 0.001341022);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// kw = w * 1/1000
		public static function wattsToKilowatts(pwr:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (pwr * 0.001);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// w = kw * 1000
		public static function kilowattsToWatts(pwr:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (pwr * 1000);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// hp = (kw * 1000) * 0.001341022 
		public static function kilowattsToHorsepower(pwr:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (wattsToHorsepower(kilowattsToWatts(pwr)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}