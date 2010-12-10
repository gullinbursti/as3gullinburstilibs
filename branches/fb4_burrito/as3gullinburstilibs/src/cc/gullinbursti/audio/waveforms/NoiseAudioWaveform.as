package cc.gullinbursti.audio.waveforms {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.probility.Randomness;
	
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author:		Gullinbursti
	 * @class:		NoiseAudioWave
	 * @package:	cc.gullinbursti.audio.generate
	 * @created:	11:48:21 PM Nov 26, 2010
	 */
	// <[!] class delaration [!]>
	public class NoiseAudioWaveform extends AbstractAudioWaveform implements IAudioWaveform {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function NoiseAudioWaveform(freq:Number=0, amp:Number=1.0, phase:Number=0, stereo:Boolean=true) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			super(freq, amp, phase, stereo);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		override public function step():void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			_phase %= 360;
			
			sampleAt(_ind);
			super.step();
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		override public function sampleAt(ind:int):Point {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			//trace ("[>=<] NoiseAudioWaveform.sampleAt("+ind+") [>=<]");
			
			_sample.x = Randomness.generateFloat(-1, 1, 10);
			
			if (_isStereo)
				_sample.y = Randomness.generateFloat(-1, 1, 10);
				
			else
				_sample.y = _sample.x;
			
			
			_sample_arr[_ind] = _sample;
			
			return (super.sampleAt(ind));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}