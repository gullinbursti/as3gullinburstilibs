package cc.gullinbursti.converts {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>	
	public class Time {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		/**
		 * ms
		 * sec
		 * min
		 * hr
		 * dy
		 * wk
		 * mn
		 * yr
		 * cent
		 * mill
		 */
		 
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		// <*] class constructor [*>	
		public function Time() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// ms = sec * 1000
		public static function secsToMillisecs(dur:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (dur * 1000);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// m = sec * 0.01666666666667
		public static function secsToMins(dur:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (dur * 0.01666666666667);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// h = sec * 0.0002777777777778
		public static function secsToHrs(dur:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (secsToMins(dur) * 0.01666666666667);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// sec = ms * 0.001
		public static function millisecsToSecs(dur:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (dur * 0.001);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// sec = m * 60
		public static function minsToSecs(dur:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (dur * 60);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// sec = h * 3600
		public static function hrsToSecs(dur:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (hrsToMins(dur) * 60);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// m = h * 60
		public static function hrsToMins(dur:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (dur * 60);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// h = m * 0.01666666666667
		public static function minsTohrs(dur:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (dur * 0.01666666666667);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯

	}
}