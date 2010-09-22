package cc.gullinbursti.converts {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class FluidVolume extends Volume {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		//TODO: define & implement some add'l lq measure conversions
		
		
		/**
		 * fluid oz
		 * cup
		 * pint
		 * quart
		 * gallon
		 * barrel
		*/
		
		// <*] class constructor [*>
		public function FluidVolume() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// cups = oz * 1/8
		public static function fluidOzToCups(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.125);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// oz = cup * 8
		public static function cupsToFluidOz(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 8);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// l = gal * 3.785412
		public static function gallonsToLiters(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 3.785412);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// gal = l * 0.264172037284185
		public static function litersToGallonss(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.264172037284185);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// bbl = gal * 0.03174603174603
		public static function gallonsToBarrels(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0.03174603174603);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// bbl = gal * 31.5
		public static function barrelsToGallons(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 31.5);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// l = qt * 0.9463529
		public static function quartsToLiters(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 0);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// qt = l * 1.056688260795735
		public static function litersToQuarts(vol:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (vol * 1.056688260795735);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯

	}
}