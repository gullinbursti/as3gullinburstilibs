package cc.gullinbursti.audio.generate {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [!]>
	public class TriangleWave extends AbstractWave implements ISoundWave {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		// <*] class constructor [*>
		public function TriangleWave(f:Number, bit:uint=BIT_RATE, samp:Number=SAMPLE_RATE) {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			super(f, samp, bit);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		override public function waveSample(freq:Number, pos:Number, rate:Number=SAMPLE_RATE):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var isFlipped:Boolean = false;
			var isCrest:Boolean = true;
			
			var tri_val:Number = bounds_arr[2];
			var sine_val:Number = super.waveSample(freq, pos, rate);
			
			var slope_inc:Number = (pos % bounds_arr[4] / 2) * bounds_arr[3];
			
			if (sine_val == bounds_arr[2])
				isCrest = false;
			
			
			if (sine_val == bounds_arr[1] && !isCrest) {
				isFlipped = !isFlipped;
			}
			
			if (sine_val == bounds_arr[2] && !isCrest) {
				isCrest = true;
			}
			
			
			if (isCrest && !isFlipped)
				tri_val = slope_inc;
			
			if (isCrest && isFlipped)
				tri_val = bounds_arr[0] + slope_inc;
			
			
			if (!isCrest && isFlipped)
				tri_val = bounds_arr[2] - slope_inc;
			
			return ((tri_val * 2)-1);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}