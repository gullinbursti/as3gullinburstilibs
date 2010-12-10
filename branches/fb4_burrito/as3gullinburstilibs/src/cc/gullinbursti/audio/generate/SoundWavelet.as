package cc.gullinbursti.audio.generate {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.audio.waveforms.BaseAudioWaveform;
	import cc.gullinbursti.audio.waveforms.IAudioWaveform;
	import cc.gullinbursti.math.geom.BasicWaveform;
	import cc.gullinbursti.math.probility.Randomness;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.geom.Point;
	import flash.utils.ByteArray;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author:		Gullinbursti
	 * @class:		BasicSoundWave
	 * @package:	cc.gullinbursti.audio
	 * @created:	6:31:34 PM Nov 21, 2010
	 */
	// <[!] class delaration [!]>
	public class SoundWavelet extends BaseAudioWaveform {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const SAMPLE_RATE:uint = 44100;
		public static const WAVELET_SIZE:uint = 2048;
		public static const BASE_FREQ:Number = 44100 / WAVELET_SIZE;
		
		public static const BUFFER_SIZE:uint = 4096;
		
		public static const PI_2X:Number = Math.PI * 2;
		public static const PI_2X_OVR_RATE:Number = PI_2X / SAMPLE_RATE;
		
		private var _frame_sprite:Sprite;
		
		protected var _lWavlet_vec:Vector.<Number>;
		protected var _rWavlet_vec:Vector.<Number>;
		
		protected var _vol:Number;
		protected var _step:int;
		protected var _acc:Number;
		
		protected var _waveform_arr:Array;
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function SoundWavelet(waveforms:Array=null, vol:Number=1.0) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_vol = vol;
			
			_acc = 0;
			_lWavlet_vec = new Vector.<Number>(WAVELET_SIZE);
			_rWavlet_vec = new Vector.<Number>(WAVELET_SIZE);
			
			_frame_sprite = new Sprite();
			_waveform_arr = new Array();
			
			updStep();
			
			
			for (var i:int=0; i<waveforms.length; i++)
				addWaveform(waveforms[i] as IAudioWaveform);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		
		public function addWaveform(iAudioWave:IAudioWaveform):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			_waveform_arr.push(iAudioWave);
			queueChange();
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		protected function queueChange():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_frame_sprite.addEventListener(Event.ENTER_FRAME, hdlFrame);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		private function hdlFrame(e:Event):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			updWavelet();
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		private function updStep():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_step = ( BASE_FREQ / SAMPLE_RATE ) * WAVELET_SIZE;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		private function updWavelet():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			trace ("[>=<] SoundWavelet.updWavelet() [>=<]");
			
			_lWavlet_vec.slice(0);
			_rWavlet_vec.slice(0);
			
			for (var i:int=0; i<_waveform_arr.length; i++) {
				
				for (var j:int=0; j<WAVELET_SIZE; j++) {
					
					var samp_l:Number = 0;
					var samp_r:Number = 0;
					
					samp_l = (_waveform_arr[i] as IAudioWaveform).sampleAt(j).x;
					samp_r = (_waveform_arr[i] as IAudioWaveform).sampleAt(j).y;
					
					_lWavlet_vec[j] = Math.min(Math.max(-1, samp_l), 1);
					_rWavlet_vec[j] = Math.min(Math.max(-1, samp_r), 1);
					
					samp_l = _lWavlet_vec[j];
					samp_r = _rWavlet_vec[j];
					
					//trace ("[>=<] SoundWavelet.updWavelet(["+(j)+", "+i+"] "+(_rWavlet_vec[j])+") [>=<]");
				}
			}
			
			_frame_sprite.removeEventListener(Event.ENTER_FRAME, hdlFrame);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function onSampleData(ba:ByteArray):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			//trace ("[>=<] SoundWavelet.onSampleData("+_acc+": "+_lWavlet_vec[_acc]+", "+_rWavlet_vec[_acc]+") [>=<]");
			
			for (var i:int=0; i<BUFFER_SIZE; i++) {
				
				//_lWavlet_vec[_acc] *= _vol;
				//_rWavlet_vec[_acc] *= _vol;
				
				//trace ("[>=<] SoundWavelet.onSampleData("+_acc+": ");//+_lWavlet_vec[_acc]+", "+_rWavlet_vec[_acc]+") [>=<]");
				
				ba.writeFloat(_lWavlet_vec[_acc]);
				ba.writeFloat(_rWavlet_vec[_acc]);
				
				//ba.writeFloat(Randomness.generateFloat(-1, 1, 10)* _vol);
				//ba.writeFloat(Randomness.generateFloat(-1, 1, 10)* _vol);
				
				_acc = Math.round(_acc + _step < _lWavlet_vec.length ? _acc + _step : 0);
			}
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}