package cc.gullinbursti.math.geom {
	import cc.gullinbursti.converts.Angle;
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 
	// <[!] class delaration [¡]>
	public class Trig extends Triangle {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		//TODO: implement trig functions
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function Trig() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		public static function rotVector(ang1:Number, ang2:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var diff:Number = (ang1 - ang2) % 360;
			
			if (diff != diff % 180) {
				
				if (diff < 0)
					diff += 360;
				else
					diff -= 360;
			}
			
			
			return (diff);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function cosDeg(degrees:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Math.cos(Angle.degreesToRadians(degrees)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function sinDeg(degrees:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Math.sin(Angle.degreesToRadians(degrees)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function tanDeg(degrees:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Math.tan(Angle.degreesToRadians(degrees)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}