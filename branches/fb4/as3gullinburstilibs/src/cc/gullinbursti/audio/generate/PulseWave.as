package cc.gullinbursti.audio.generate {
	import flash.geom.Point;
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [!]>
	public class PulseWave extends AbstractWave implements ISoundWave {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		private var ratio_pt:Point;
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		// <*] class constructor [*>
		public function PulseWave(f:Number, ratio:Point, bit:uint=BIT_RATE, samp:Number=SAMPLE_RATE) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			super(f, samp, bit);
			ratio_pt = ratio.clone();
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		override public function waveSample(freq:Number, pos:Number, rate:Number=SAMPLE_RATE):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var pulse_val:Number = bounds_arr[2];
			var sine_val:Number = super.waveSample(freq, pos, rate);
			
			if (sine_val < bounds_arr[1])
				pulse_val = bounds_arr[0];
				
			else if (sine_val > bounds_arr[1])
				pulse_val = bounds_arr[2];
			
			return (pulse_val);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}