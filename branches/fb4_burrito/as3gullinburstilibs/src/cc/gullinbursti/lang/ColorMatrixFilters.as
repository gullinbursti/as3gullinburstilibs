package cc.gullinbursti.lang {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.converts.Angle;
	import cc.gullinbursti.math.algebra.Matrices;
	
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	/**
	 * @class   ColorMatrixFilters
	 * @package cc.gullinbursti.lang
	 
	 * @author  "mattH" -//» ¯'gü|l¡ñ·ßµrS†í._
	 * @created Feb 8, 2011 @ 12:59:51 AM
	 * 
	 * @brief 
	 */
	// <[!] class delaration [¡]>
	public class ColorMatrixFilters {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const R_LUM:Number = 0.212671; //0.3086;
		public static const G_LUM:Number = 0.715160; //0.6094;
		public static const B_LUM:Number = 0.072169; //0.0820;
		public static const A_LUM:Number = 0.0;
		
		public static const LUM_MATRIX:Array = new Array(
			R_LUM, G_LUM, B_LUM,
			R_LUM, G_LUM, B_LUM,
			R_LUM, G_LUM, B_LUM
		);
		
		public static const SAT_MATRIX:Array = new Array(
			 0.787, -0.715, -0.072,
			-0.212,  0.285, -0.072,
			-0.213, -0.715,  0.928
		);
		
		public static const HUE_MATRIX:Array = new Array(
			-0.213, -0.715,  0.928,
			 0.143,  0.140, -0.283,
			-0.787,  0.715,  0.072
		);
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function ColorMatrixFilters() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		public static function briten(amt:int=0):ColorMatrixFilter {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			amt = Math.min(Math.max(amt, -255), 255);
			
			return(new ColorMatrixFilter(
				[1, 0, 0,  0,  amt,
				 0, 1, 0,  0,  amt,
				 0, 0, 1,  0,  amt,
				 0, 0, 0,  1,  0]
			));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		public static function contrast(amt:int=0):ColorMatrixFilter {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			amt = Math.min(Math.max(amt, -1), 1) * 2;
			
			return (new ColorMatrixFilter(
				[amt,   0,   0, 0, (amt * 64),
				   0, amt,   0, 0, (amt * 64),
				   0,   0, amt, 0, (amt * 64),
				   0,   0,   0, 1, 0]
			));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		public static function greyscale():ColorMatrixFilter {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			return (new ColorMatrixFilter(
				[R_LUM, G_LUM, B_LUM, 0 ,0,
				 R_LUM, G_LUM, B_LUM, 0 ,0,
				 R_LUM, G_LUM, B_LUM, 0 ,0,
				 A_LUM, A_LUM, A_LUM, 1 ,0]
			));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		public static function negative():ColorMatrixFilter {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			return (new ColorMatrixFilter(
				[-1,  0,  0,  0,  255,
				  0, -1,  0,  0,  255,
				  0,  0, -1,  0,  255,
				  0,  0,  0,  1,  0]
			));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		public static function saturate(amt:Number=0):ColorMatrixFilter {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			amt = Math.min(Math.max(amt, 0), 2);
			
			// add luminosity matrix to the adjusted saturation matrix
			var sum_arr:Array = Matrices.add(LUM_MATRIX, Matrices.multiplyFactor(SAT_MATRIX, amt));
			
			// concatinate w/ the identity
			var concat_arr:Array = Matrices.concat(new Point(5, 4), 
				[sum_arr[0], sum_arr[1], sum_arr[2], 0, 0,
				 sum_arr[3], sum_arr[4], sum_arr[5], 0, 0,
				 sum_arr[6], sum_arr[7], sum_arr[8], 0, 0,
				          0,          0,          0, 1, 0], 
				Matrices.genIdenty(new Point(5, 4))
			);
			
			// force alpha to 1
			concat_arr[18] = 1;
			
			// apply filter
			return (new ColorMatrixFilter(concat_arr));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function hue(amt:Number=0):ColorMatrixFilter {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			amt = Math.sin(Angle.degreesToRadians((Math.min(Math.max(-1, amt), 1) + 1) * 180));
			
			// add luminosity matrix to the adjusted saturation matrix
			var sum_arr:Array = Matrices.add(LUM_MATRIX, Matrices.add(Matrices.multiplyFactor(SAT_MATRIX, amt), Matrices.multiplyFactor(HUE_MATRIX, amt)));
			
			
			// concatinate w/ the identity
			var concat_arr:Array = Matrices.concat(new Point(5, 4), 
				[sum_arr[0], sum_arr[1], sum_arr[2], 0, 0,
				 sum_arr[3], sum_arr[4], sum_arr[5], 0, 0,
				 sum_arr[6], sum_arr[7], sum_arr[8], 0, 0,
				          0,          0,          0, 1, 0], 
				Matrices.genIdenty(new Point(5, 4))
			);
			
			// force alpha to 1
			concat_arr[18] = 1;
			
			return (new ColorMatrixFilter(concat_arr));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}