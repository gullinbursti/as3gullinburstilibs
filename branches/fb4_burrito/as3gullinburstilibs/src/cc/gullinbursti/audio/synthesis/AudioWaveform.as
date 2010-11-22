package cc.gullinbursti.audio.synthesis {
	
	import cc.gullinbursti.audio.BasicSoundWave;
	
	
	/**
	 * 
	 * @author:		Gullinbursti
	 * @class:		AudioWaveform
	 * @package:	cc.gullinbursti.audio.synthesis
	 * @created:	6:33:04 PM Nov 21, 2010
	 */
	public class AudioWaveform extends BasicSoundWave {
		
		
		public static const SINE:String = "SINE";
		public static const SQUARE:String = "SQUARE";
		public static const PULSE:String = "PULSE";
		public static const TRIANGLE:String = "TRIANGLE";
		public static const SAWTOOTH:String = "SAWTOOTH";
		public static const NOISE:String = "NOISE";
		
		
		public function AudioWaveform(freq:Number=0, amp:Number=0, phase:Number=0) {
			super(freq, amp, phase);
		}
	}
}