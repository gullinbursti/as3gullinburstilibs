package cc.gullinbursti.audio {
	
	import cc.gullinbursti.math.geom.BasicWaveform;
	
	
	/**
	 * 
	 * @author:		Gullinbursti
	 * @class:		BasicSoundWave
	 * @package:	cc.gullinbursti.audio
	 * @created:	6:31:34 PM Nov 21, 2010
	 */
	public class BasicSoundWave extends BasicWaveform {
		
		
		public static const EMPTY_SET:String = "EMPTY_SET";
		public static const SINUSOID:String = "SINUSOID";
		public static const SQUARE:String = "SQUARE";
		public static const PULSE:String = "PULSE";
		public static const TRIANGLE:String = "TRIANGLE";
		public static const SAWTOOTH:String = "SAWTOOTH";
		public static const SAWTOOTH_INV:String = "SAWTOOTH_INV";
		public static const NOISE:String = "NOISE";
		
		
		
		public static const SAMPLE_RATE:uint = 44100;
		public static const WAVELET_SIZE:uint = 2048;
		public static const BASE_FREQ:Number = 44100 / WAVELET_SIZE;
		
		public static const BUFFER_SIZE:uint = 4096;
		
		public static const PI_2X:Number = Math.PI * 2;
		public static const PI_2X_OVR_RATE:Number = PI_2X / SAMPLE_RATE;
		
		
		protected var _freq:Number;
		protected var _vol:Number;
		protected var _stp:int;
		protected var _wavlet_vec:Vector.<Number>;
		
		protected var _preset_arr:Array;
		
		
		public function BasicSoundWave(freq:Number=0, amp:Number=0, phase:Number=0) {
			super(freq, amp, phase);
			
			_vol = 0.1;
			_freq = 440;
			
			_preset_arr = new Array();
			_preset_arr.push({name:EMPTY_SET, vals:{}});
			
			_preset_arr.push({name:SINUSOID, vals:[
				0.5, 0, 0, 0, 0, 0, 0, 0
			]});
			
			_preset_arr.push({name:SQUARE, vals:[
				0, 0.5, 0, 0, 0, 0, 0, 0
			]});
			
			_preset_arr.push({name:SAWTOOTH, vals:[
				0, 0, 0.5, 0, 0, 0, 0, 0
			]});
			
			_preset_arr.push({name:TRIANGLE, vals:[
				0, 0, 0, 0.5, 0, .0, 0, 0
			]});
			
			_preset_arr.push({name:PULSE, vals:[
				0, 0, 0, 0, 0, .0, 0.9, 0.5
			]});
		}
	}
}