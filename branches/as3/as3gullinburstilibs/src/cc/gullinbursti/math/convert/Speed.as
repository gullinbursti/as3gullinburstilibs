package cc.gullinbursti.math.convert {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class Speed {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		// TODO: define & implement some add'l speed conversions
		
		public function Speed() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// kph = mph * ???
		public static function mphToKph(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (spd * 0);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// mph = kph * ???
		public static function kphToMph(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (spd * 0);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// knots = mph * ???
		public static function mphToKnots(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (spd * 0);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// mph = knots * ???
		public static function knotsToMph(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (spd * 0);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// kph = knots * ???
		public static function knotsToKph(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (knotsToMph(spd) * 0);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// knots = kph * ???
		public static function kphToKnots(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (kphToMph(spd) * 0);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯

	}
}