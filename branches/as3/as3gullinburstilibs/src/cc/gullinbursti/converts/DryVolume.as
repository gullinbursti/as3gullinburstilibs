package cc.gullinbursti.converts {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]> 
	public class DryVolume extends Volume {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		// TODO: define & implement some add'l lq measure conversions
		
		// <*] class constructor [*>
		public function DryVolume() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// in3 = pt * 33.6
		public static function pintsToInches3(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 33.6);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// pt = in3 * 0.02976190476190
		public static function inches3ToPints(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.02976190476190);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// pk = gal * 0.5
		public static function gallonsToPecks(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.5);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// gal = pk * 2
		public static function pecksToGallons(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 2);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// bu = pk * 0.25
		public static function pecksToBushels(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.25);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// bu = gal * 1/8
		public static function gallonsToBushels(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.125);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// gal = bu * 8
		public static function bushelsToGallons(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 8);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}