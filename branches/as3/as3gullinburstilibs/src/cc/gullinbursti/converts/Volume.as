package cc.gullinbursti.converts {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class Volume {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		// TODO: define & implement some add'l volume conversions
		
		public function Volume() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// ft3 = m3 * 35.31467
		public static function meters3ToFeet3(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 35.31467);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// m3 = ft3 * 0.02831685
		public static function feet3ToMeters3(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.02831685);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// yd3 = m3 * ???
		public static function meters3ToYards3(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// m3 = yd3 * ???
		public static function yards3ToMeters3(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		
		// cup = pt * 2
		public static function pintsToCups(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 2);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// cup = qt * 4
		public static function quartsToCups(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 4);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// cup = gal * 16
		public static function gallonsToCups(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 16);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// pt = cup * 0.5
		public static function cupsToPints(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.5);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// pt = qt * 2
		public static function quartsToPints(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 2);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// pt = gal * 8
		public static function gallonsToPints(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 8);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// qt = cup * 0.25
		public static function cupsToQuarts(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.25);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// qt = pt * 0.5
		public static function pintsToQuarts(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.5);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// qt = gal * 4
		public static function gallonsToQuarts(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 4);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// gal = cup * 1/16
		public static function cupsToGallons(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.0625);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// gal = pt * 1/6
		public static function pintsToGallons(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.125);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// gal = qt * 0.25
		public static function quartsToGallons(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.25);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}