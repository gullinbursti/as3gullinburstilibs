package cc.gullinbursti.converts {
	
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
		//TODO: define & implement some add'l speed conversions
		
		public function Speed() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// fps = mph * 1.466667
		public static function mphToFps(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (spd * 1.466667);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// fps = m/s * 3.28084
		public static function mpsToFps(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (spd * 3.28084);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// fps = kph * 0.9113444
		public static function kphToFps(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (spd * 0.9113444);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// mph = fps * 0.6818182
		public static function fpsToMph(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (spd * 0.6818182);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// m/s = fps * 0.3048
		public static function fpsToMps(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (spd * 0.3048);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// kph = fps * 1.09728
		public static function fpsTokph(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (spd * 1.09728);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// kph = mph * ???
		public static function mphToKph(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Length.statuteToKilometers(spd));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// mph = kph * ???
		public static function kphToMph(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Length.kilometersToStatute(spd));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// knots = mph * 0.868976241091
		public static function mphToKnots(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (spd * 0.868976241091);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// mph = knots * 1.1507794490957538966042759682414
		public static function knotsToMph(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (spd * 1.1507794490957538966042759682414);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// kph = knots * ???
		public static function knotsToKph(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (mphToKph(knotsToMph(spd)));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// knots = kph * ???
		public static function kphToKnots(spd:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (mphToKnots(kphToMph(spd)));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯

	}
}