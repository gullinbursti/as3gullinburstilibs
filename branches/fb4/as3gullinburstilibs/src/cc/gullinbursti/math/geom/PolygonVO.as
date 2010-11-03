package cc.gullinbursti.math.geom {
	import flash.geom.Point;

	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.interfaces.IValueObject;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class PolygonVO implements IValueObject {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
	
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public var sides_tot:Number;
		public var radius:int;
		public var ratio:Number;
		public var inner_ang:Number;
		public var summ_ang:int;
		public var seg_len:Number;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function PolygonVO(sides:int, rad:int, rat:Number=1.0) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			sides_tot = sides;
			radius = rad;
			ratio = rat;
			
			summ_ang = ((sides_tot - 2) * 180);
			inner_ang = summ_ang / sides_tot;
			
			seg_len = BasicGeom.ditanceBetweenPts(new Point(Math.sin(0) * radius, Math.cos(0) * radius), new Point(Math.sin(inner_ang) * radius, Math.cos(inner_ang) * radius));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public function toString():String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var ret_str:String = "\nPolygonVO:\n";
				ret_str += "[=-=-=-=-=-=-=-=-=-=-=-=-=-=-=]\n";
				ret_str += "sides_tot: ["+sides_tot+"]\n";
				ret_str += "radius: ["+radius+"]\n";
				ret_str += "ratio: ["+ratio+"]\n";
				ret_str += "inner_ang: ["+inner_ang+"]\n";
				ret_str += "summ_ang: ["+summ_ang+"]\n";
				ret_str += "seg_len: ["+seg_len+"]\n";
				ret_str += "[=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=]\n\n";
			
			return (ret_str);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}
