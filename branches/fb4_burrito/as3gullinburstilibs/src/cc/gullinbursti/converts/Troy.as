package cc.gullinbursti.converts {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Troy extends Weight {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		/**
		 * grain
		 * pennyweight
		 * ounce
		 * pound
		 */
		
		// <*] class constructor [*>	
		public function Troy() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		// g = gr * 0.06479891
		public static function grainsToGrams(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.06479891);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// g = oz * 31.1034768
		public static function ozToGrams(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 31.1034768);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// gr = pw * 24
		public static function pennyToGrains(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 24);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// gr = g * 15.432358352941431
		public static function gramsToGrains(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 15.432358352941431);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// gr = oz * 480
		public static function OzToGrains(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 480);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// pw = gr * 0.04166666666667
		public static function grainsToPenny(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.04166666666667);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// oz = g * 0.03215074656863
		public static function gramsToOz(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.03215074656863);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// oz = gr * 0.002083333333333
		public static function grainsToOz(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.002083333333333);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// oz = lb * 12
		public static function poundsToOz(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 12);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		// lb = oz * 1/12
		public static function ozToPounds(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.083333333333333);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}