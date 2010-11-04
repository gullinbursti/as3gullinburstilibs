package cc.gullinbursti.converts {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class Area {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		//TODO: define & implement some add'l area conversions
		
		public function Area() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// cm2 = in2 * 6.4516
		public static function inches2ToCentimeters2(in_area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (in_area * 6.4516);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// m2 = ft2 * 0.09290304
		public static function feet2ToMeters2(ft_area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (ft_area * 0.09290304);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// m2 = yd2 * 0.836127
		public static function yards2ToMeters2(yd_area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (yd_area * 0.836127);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// hectares = acres * 0.4046856
		public static function acresToHectares(acres_area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (acres_area * 0.4046856);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// hectares = km2 * 100
		public static function kilometers2ToHectares(km_area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (km_area * 100);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// km2 = hectares * 0.01
		public static function hectaresToKilometers2(hectare_area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (hectare_area * 0.01);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// km2 = acres * 0.004046856
		public static function acres2ToKilometers2(acres_area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (acres_area * 0.004046856);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// km2 = mi2 * 2.589988
		public static function mi2ToKilometers2(mi_area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (mi_area * 2.589988);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// in2 = cm2 * 0.1550003
		public static function centimeters2ToInches2(cm_area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (cm_area * 0.1550003);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// in2 = ft2 * 144
		public static function feet2ToInches2(ft_area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (ft_area * 144);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// ft2 = in2 * 0.006944444444444
		public static function inches2ToFeet2(in_area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (in_area * 0.006944444444444);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// ft2 = m2 * 10.76391
		public static function meters2ToFeet2(m_area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (m_area * 10.76391);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// ft2 = acres * 43560
		public static function acresToFeet2(area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (area * 43560);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// yd2 = m2 * 1.195991
		public static function meters2ToYards2(m_area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (m_area * 1.195991);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// yd2 = acres * 4840.002
		public static function acresToYards2(area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (area * 4840.002);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// acres = ft2 * 0.00002295684
		public static function feet2ToAcres(area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (area * 0.00002295684);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// acres = yd2 * 0.0002066115
		public static function yards2ToAcres(area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (area * 0.0002066115);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// acres = hectares * 2.471054
		public static function hectaresToAcres(area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (area * 2.471054);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// acres = km2 * 247.1054
		public static function kilometers2ToAcres(area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (area * 247.1054);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// acres = mi2 * 640
		public static function miles2ToAcres(area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (area * 640);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// mi2 = acres * 0.0015625
		public static function acres2ToMiles2(area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (area * 0.0015625);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// mi2 = hectares * 0.003861022
		public static function hectares2ToMiles2(area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (area * 0.003861022);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// mi2 = km2 * 0.3861022
		public static function kilometers2ToMiles2(area:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (area * 0.3861022);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}