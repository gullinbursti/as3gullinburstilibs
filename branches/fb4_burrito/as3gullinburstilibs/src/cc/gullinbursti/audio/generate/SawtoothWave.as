package cc.gullinbursti.audio.generate {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [!]>
	public class SawtoothWave extends AbstractWave implements ISoundWave {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		// <*] class constructor [*>
		public function SawtoothWave(f:Number, bit:uint=BIT_RATE, samp:Number=SAMPLE_RATE) {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			super(f, samp, bit);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		override public function waveSample(freq:Number, pos:Number, rate:Number=SAMPLE_RATE):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var isFlipped:Boolean = false;
			var saw_val:Number = bounds_arr[2];
			var sine_val:Number = super.waveSample(freq, pos, rate);
			
			var slope_inc:Number = Math.max(bounds_arr[0], (pos % bounds_arr[4] / 2) * bounds_arr[3]);
			
			if (sine_val == bounds_arr[1])
				isFlipped = true;
			
			
			if (sine_val == bounds_arr[1] && isFlipped)
				isFlipped = false;
			
			
			if (isFlipped)
				saw_val = bounds_arr[0] + slope_inc;
				
			else
				saw_val = slope_inc;
			
			
			
			return ((saw_val * 2) -1);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}