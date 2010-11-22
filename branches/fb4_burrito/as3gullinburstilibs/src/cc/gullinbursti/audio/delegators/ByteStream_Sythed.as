package cc.gullinbursti.audio.delegators {
	
	import cc.gullinbursti.lang.Booleans;
	import cc.gullinbursti.lang.ByteArrays;
	
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	
	
	/**
	 * 
	 * @author:		Gullinbursti
	 * @class:		ByteStream_Sythed
	 * @package:	cc.gullinbursti.audio.delegators
	 * @created:	7:09:49 PM Nov 21, 2010
	 */
	public class ByteStream_Sythed extends ByteArrays {
		
		protected var _isPlaying:Boolean;
		protected var _byte_arr:ByteArray;
		protected var _snd_obj:Sound;
				
		public function ByteStream_Sythed(snd:Sound, ba:ByteArray, playing:Boolean=false) {
			
			_snd_obj = snd;
			_byte_arr = ba;
			_isPlaying = playing;
		}
		
		
		public function togglePlayback():Boolean {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			// flip
			Booleans.invert(_isPlaying);
			
			
			if (_isPlaying) {
				// add snd data evt
				
				_snd_obj.removeEventListener(SampleDataEvent.SAMPLE_DATA, hdlSound_SampleData);

			} else {
				// drop snd data evt
				
			}
				
			
			return (_isPlaying)
			
		}
		
		private function hdlSound_SampleData():void
		{
			// TODO Auto Generated method stub
		}
		
		//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯


	}
}