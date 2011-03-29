package cc.gullinbursti.lang {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	
	import flash.filters.ConvolutionFilter;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	/**
	 * @class   ConvolutionFilters
	 * @package cc.gullinbursti.lang
	 
	 * @author  "mattH" -//» ¯'gü|l¡ñ·ßµrS†í._
	 * @created Feb 8, 2011 @ 1:15:07 AM
	 * 
	 * @brief 
	 */
	// <[!] class delaration [¡]>
	public class ConvolutionFilters {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function ConvolutionFilters() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function blur(amt:int=1):ConvolutionFilter {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			amt = Math.min(Math.max(amt, 0), 4);
			
			var dim:int = (amt * 2) + 1;
			var col:int = 0;
			var row:int = 0;
			
			var half:int = (dim * 0.5) << 0;
			var max:int;
			var val:int;
			var flt_arr:Array = new Array();
			
			
			for (var i:int=0; i<(dim*dim); i++) {
				col = i % dim;
				row = i / dim;
				max = (BasicMath.powr2(row+1));
				trace ("row:["+row+"] col:["+col+"] half:["+half+"] max:["+max+"]")
				
				if (col <= half)
					val = BasicMath.powr2(col-1) << 0;
				
				else
					val = BasicMath.powr2((col - half) - 1) << 0;
				
				
				flt_arr.push(val);
			}
			
			trace (flt_arr);
			trace (Math.pow(2, -1))
			
			return(new ConvolutionFilter(7, 7,
				[000, 001, 002, 004, 002, 001, 000,
				 001, 002, 004, 008, 004, 002, 001,
				 002, 004, 008, 016, 008, 004, 002,
				 004, 008, 016, 032, 016, 008, 004,
				 002, 004, 008, 016, 008, 004, 002,
				 001, 002, 004, 008, 004, 002, 001,
				 000, 001, 002, 004, 002, 001, 000], 192
			));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		
		public static function edges(amt:int=0):ConvolutionFilter {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			amt = Math.min(Math.max(amt, 0), 255);
			
			
			return(new ConvolutionFilter(3, 3, 
				[0, -1,  0, 
				-1,  4, -1, 
				 0, -1,  0]
			));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		
		public static function emboss(amt:int=0):ConvolutionFilter {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			amt = Math.min(Math.max(amt, 0), 255);
			
			
			
			return(new ConvolutionFilter(3, 3, 
				[-2, -1,  0, 
				 -1,  1,  1, 
				  0,  1,  2]
			));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		public static function motionBlur(amt:int=0, isHorizontal:Boolean=true):ConvolutionFilter {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			amt = Math.min(Math.max(amt, 0), 255);
			
			return(new ConvolutionFilter(3, 3,
				[0, 1, 0,
				 1, 2, 1,
				 0, 1, 0]
			));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
		
		
		public static function sharpen(amt:int=0):ConvolutionFilter {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			amt = Math.min(Math.max(amt, 0), 255);
			
			return(new ConvolutionFilter(3, 3, 
				[0, -1,  0, 
				-1,  5, -1, 
				 0, -1,  0]
			));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
	}
}