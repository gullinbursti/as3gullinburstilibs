package cc.gullinbursti.fx {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [¡]>
	public class ColorVO {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const BRITE_BOUNDS:Point = new Point(-100, 100);
		public static const SATUR_BOUNDS:Point = new Point(-100, 100);
		public static const CONTR_BOUNDS:Point = new Point(-100, 100);
		public static const HUE_BOUNDS:Point = new Point(-180, 180);
		
		public var briteRange_pt:Point;
		public var saturRange_pt:Point;
		public var contrRange_pt:Point;
		public var hueRange_pt:Point;
		
		public var briteHist_pt:Point;
		public var saturHist_pt:Point;
		public var contrHist_pt:Point;
		public var hueHist_pt:Point;
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		// <*] class constructor [*>
		public function ColorVO(briteRange:Point=null, saturRange:Point=null, contrRange:Point=null, hueRange:Point=null) {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			if (!briteRange)
				briteRange_pt = BRITE_BOUNDS.clone();
				
			else
				briteRange_pt = briteRange.clone();
				
			briteHist_pt = new Point();
			saturHist_pt = new Point();
			contrHist_pt = new Point();
			hueHist_pt = new Point();
			
			if (!saturRange)
				briteRange_pt = SATUR_BOUNDS.clone();
				
			else
				briteRange_pt = saturRange.clone();
				
				
				
			if (!contrRange)
				contrRange_pt = CONTR_BOUNDS.clone();
				
			else
				contrRange_pt = contrRange.clone();
				
			
				
			if (!hueRange)
				hueRange_pt = HUE_BOUNDS.clone();
				
			else
				hueRange_pt = hueRange.clone();
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
	}
}