package cc.gullinbursti.science.physics {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	
	// <[!] class delaration [¡]>
	public class Gravity extends BasicPhysics {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function Gravity() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		public static function twoBodies(m1:Number, m2:Number, dist:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			/**
			 *         ⎛ m₁m₂ ⎞
			 * F = G × ⎜——————⎜
			 *         ⎝  r²  ⎠
			 */
			 
			 
			 return (GRAV_CONST * ((m1 * m2) / BasicMath.square(dist)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function multiBodies(masses:Array, dists:Array):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// array of forces between bodies
			var force_arr:Array = new Array();
			
			// loop thru the body masses…
			for (var i:int=0; i<masses.length-1; i++) {
				
				// loop thru the distances…
				for (var j:int=0; j<dists.length; j++)
				
					// push the force between two bodies
					force_arr.push(twoBodies(masses[i], masses[i+1], dists[j]));
			}
			
			return (force_arr);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯	
	}
}