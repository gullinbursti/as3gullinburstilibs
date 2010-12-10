package cc.gullinbursti.audio.delegators {
	
	import cc.gullinbursti.audio.generate.SoundWavelet;
	import cc.gullinbursti.audio.waveforms.NoiseAudioWaveform;
	import cc.gullinbursti.audio.waveforms.SinusoidAudioWaveform;
	import cc.gullinbursti.lang.Booleans;
	import cc.gullinbursti.lang.ByteArrays;
	
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	
	
	/**
	 * 
	 * @author:		Gullinbursti
	 * @class:		SynthSoundDelegator
	 * @package:	cc.gullinbursti.audio.delegators
	 * @created:	7:09:49 PM Nov 21, 2010
	 */
	public class SynthSoundDelegator extends ByteArrays {
		
		protected var _isPlaying:Boolean;
		
		protected var _snd_obj:Sound;
		protected var _snd_chan:SoundChannel;
		
		private var _soundWavelet:SoundWavelet;
		
		
		public function SynthSoundDelegator(playing:Boolean=false) {
			
			_snd_obj = new Sound();
			
			_isPlaying = playing;
			_soundWavelet = new SoundWavelet([new SinusoidAudioWaveform(800)]);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function togglePlayback():Boolean {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			// flip
			_isPlaying = !_isPlaying;
			
			
			if (_isPlaying) {
				
				// add snd data evt
				_snd_obj.addEventListener(SampleDataEvent.SAMPLE_DATA, hdlSound_SampleData);
				_snd_chan = _snd_obj.play();

			} else {
				
				// drop snd data evt
				_snd_chan.stop();
				_snd_obj.removeEventListener(SampleDataEvent.SAMPLE_DATA, hdlSound_SampleData);
				_snd_chan = null;
			}
				
			
			return (_isPlaying)
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		private function hdlSound_SampleData(e:SampleDataEvent):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			_soundWavelet.onSampleData(e.data);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯


	}
}