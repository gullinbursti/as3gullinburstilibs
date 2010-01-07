package cc.gullinbursti.science.physics
{
	import cc.gullinbursti.math.BasicMath;
	
	public class Gravity extends BasicPhysics
	{
		public function Gravity()
		{
			super();
		}
		
		
		public static function twoBodies(m1:Number, m2:Number, dist:Number):Number {
			
			/**
			 *         ⎛ m₁m₂ ⎞
			 * F = G × ⎜——————⎜
			 *         ⎝  r²  ⎠
			 */
			 
			 
			 return (GRAV_CONST * ((m1 * m2) / BasicMath.square(dist)));
		}
		
		
		public static function multiBodies(masses:Array, dists:Array):Array {
			
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
		}	
	}
}