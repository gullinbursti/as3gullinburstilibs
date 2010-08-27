package cc.gullinbursti.audio.generate {
	import cc.gullinbursti.lang.Numbers;
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [!]>
	public class AbstractWave implements ISoundWave {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		
		public static const SAMPLE_RATE:uint = 44100;
		public static const BIT_RATE:uint = 4096;
		
		protected var bounds_arr:Array;
		protected var freq:Numberl
		protected var sample_rate:uint;
		protected var bit_rate:uint;
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		// <*] class constructor [*>
		public function AbstractWave(f:Number, bit:uint=BIT_RATE, samp:Number=SAMPLE_RATE) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			bounds_arr = bounds(f, samp, bit);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public function clone(wave:ISoundWave):ISoundWave {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (new AbstractWave())
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function invert(wave:ISoundWave):ISoundWave {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (new AbstractWave())
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function invertSample(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Numbers.invert(val));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function waveSample(freq:Number, pos:Number, rate:Number=SAMPLE_RATE):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Math.sin(freq * phaseAmt(pos, rate)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function bounds(freq:Number, samples:int, rate:Number):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var pos_flag:int=0;
			
			var min:Number = 0;
			var mid:Number = 0;
			var max:Number = 0;
			
			var steps:Number = 0;
			var slope:Number = 0;
			
			for (var i:int=1; i<samples; i++) {
				var prev:Number = waveSample(freq, i-1);
				var curr:Number = waveSample(freq, i);
				
				var val_arr:Array = new Array();
				
				switch (pos_flag) {
					case 0:
						if (curr < prev) {
							pos_flag++;
							max = prev;
						}
						break;
					
					case 1:
						if (prev > 0 && curr < 0) {
							pos_flag++;
							mid = Math.min(prev, curr);
						}
						break;
					
					case 2:
						if (curr > prev) {
							pos_flag++;
							min = prev;
						}
						break;
				}
				
				if (min != 0 && mid != 0 && max != 0) {
					slope = Math.abs(max - min) / i;
					break;
				}
			}
			
			return ([min, mid, max, slope, i]);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		protected function phaseAmt(pos:Number, rate:int=SAMPLE_RATE):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return ((pos / rate) * (Math.PI * 2));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}