package cc.gullinbursti.audio.waveforms {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author:		Gullinbursti
	 * @class:		SinusoidAudioWave
	 * @package:	cc.gullinbursti.audio.generate
	 * @created:	11:09:19 PM Nov 26, 2010
	 */
	// <[!] class delaration [!]>
	public class SinusoidAudioWaveform extends AbstractAudioWaveform implements IAudioWaveform {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function SinusoidAudioWaveform(freq:Number=440, amp:Number=1.0, phase:Number=0, stereo:Boolean=true) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			super(freq, amp, phase, stereo);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		override public function step():void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			_phase = _ang / SAMPLE_RATE * PI_2X;
			
			//var samp:Number = Math.sin(_wave_phase * freq);
			//var samp:Number = Math.sin(_wave_phase * 440 * Math.pow(2, _note_ind / 12))
			
			_sample.x = Math.sin(_phase * _freq);//Math.sin(PI_2X * _freq * _ind / SAMPLE_RATE) * _amp;
			
			if (_isStereo)
				_sample.y = Math.sin(_phase * _freq);//Math.sin(PI_2X * _freq * _ind / SAMPLE_RATE) * _amp;
				
			else
				_sample.y = _sample.x;
			
			
			_sample_arr[_ind] = _sample;
			
			trace ("[>=<] SinusoidAudioWaveform.step("+_ind+", "+_sample_arr[_ind]+") [>=<]");
			
			super.step();
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯

		override public function sampleAt(ind:int):Point {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			//trace ("[>=<] SinusoidAudioWaveform.sampleAt("+ind+", "+_sample_arr[ind]+") [>=<]");
			
			_sample.x = Math.sin(PI_2X * _freq * (ind) / SAMPLE_RATE) * _amp;
			
			if (_isStereo)
				_sample.y = Math.sin(PI_2X * _freq * (ind) / SAMPLE_RATE) * _amp;
				
			else
				_sample.y = _sample.x;
			
			//_sample_arr[ind] = _sample;
			
			return (_sample);
			
			//return (super.sampleAt(ind));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯


	}
}