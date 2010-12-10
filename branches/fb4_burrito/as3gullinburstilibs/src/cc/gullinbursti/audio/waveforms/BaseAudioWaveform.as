package cc.gullinbursti.audio.waveforms {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.math.geom.BasicWaveform;
	import cc.gullinbursti.math.geom.Trig;
	import cc.gullinbursti.math.probility.Randomness;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [!]>
	public class BaseAudioWaveform extends BasicWaveform {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const EMPTY_SET:String = "EMPTY_SET";
		public static const SINUSOID:String = "SINUSOID";
		public static const SQUARE:String = "SQUARE";
		public static const PULSE:String = "PULSE";
		public static const TRIANGLE:String = "TRIANGLE";
		public static const SAWTOOTH:String = "SAWTOOTH";
		public static const SAWTOOTH_INV:String = "SAWTOOTH_INV";
		public static const NOISE:String = "NOISE";
		
		public static const SAMPLE_RATE:uint = 44100;
		public static const BIT_RATE:uint = 2048;
		public static const BASE_FREQ:uint = 440;
		
		public static const PI_2X:Number = Math.PI * 2;
		public static const PI_2X_OVR_RATE:Number = PI_2X / SAMPLE_RATE;
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function BaseAudioWaveform() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
	}
}