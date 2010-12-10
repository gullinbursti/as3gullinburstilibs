package cc.gullinbursti.audio.waveforms {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	
	import flash.geom.Point;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author:		Gullinbursti
	 * @class:		AbstractAudioWave
	 * @package:	cc.gullinbursti.audio.generate
	 * @created:	6:46:59 PM Nov 26, 2010
	 */
	// <[!] class delaration [!]>
	public class AbstractAudioWaveform extends BaseAudioWaveform implements IAudioWaveform {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const SAMPLE_RATE:uint = 44100;
		public static const BIT_RATE:uint = 2048;
		
		public static const PI_2X:Number = Math.PI * 2;
		public static const PI_2X_OVR_RATE:Number = PI_2X / SAMPLE_RATE;
		
		protected var _freq:Number;
		protected var _ind:int;
		protected var _amp:Number;
		protected var _phase:Number;
		protected var _ang:Number;
		protected var _isStereo:Boolean;
		
		protected var _sample_arr:Array;
		protected var _sample:Point;
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function AbstractAudioWaveform(freq:Number=440, amp:Number=1.0, phase:Number=0, stereo:Boolean=true) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_freq = freq;
			_amp = amp;
			_phase = phase;
			_isStereo = stereo;
			
			_ang = 0;
			_ind = 0;
			
			_sample = new Point();
			_sample_arr = new Array();
			
			for (var i:int=0; i<BIT_RATE; i++)
				step();
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public function sampleAt(ind:int):Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//trace ("[>=<] AbstractAudioWaveform.sampleAt("+_sample_arr[ind]+") [>=<]");
			
			return (_sample_arr[ind] as Point);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function step():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//trace ("[>=<] AbstractAudioWaveform.step() [>=<]");
			
			_ang++;
			_ind++;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function clone():IAudioWaveform {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (new AbstractAudioWaveform(_freq, _amp, _phase, _isStereo) as IAudioWaveform);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function invert():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function set amp(val:Number):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_amp = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function get amp():Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (_amp);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function set freq(val:Number):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_freq = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function get freq():Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (_freq);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function set isStereo(bool:Boolean):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_isStereo = bool;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function get isStereo():Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (_isStereo);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function get ind():int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (_ind);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}