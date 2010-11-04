package cc.gullinbursti.math.geom {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	
	import flash.geom.Point;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [!]>
	public class Sphere extends BasicGeom {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		// <*] class constructor [*>
		public function Sphere() {/*..\(^_^)/..*/}
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		/**
		 * Calculates the surface area of a sphere 
		 * @param rad the sphere's radius
		 * @return the suface area
		 * 
		 */		
		public static function surface(rad:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return ((4 * Math.PI) * BasicMath.square(rad));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		/**
		 * Calculates the volume of a sphere 
		 * @param rad the sphere's radius
		 * @return volume
		 * 
		 */		
		public static function vol(rad:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// V = 4/3 PI r3
			
			return ((4/3) * Math.PI * BasicMath.cube(rad));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}