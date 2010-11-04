package cc.gullinbursti.audio {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
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
	public class BasicAudioWave extends MusicTheory {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const MIN_SAMPLES:uint = 0x0800; // 2048
		public static const MAX_SAMPLES:uint = 0x2000; // 8192
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function BasicAudioWave() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// 
		public static function sine(freq:Number, samp:uint=MAX_SAMPLES/2):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var wavePt_arr:Array = new Array();
			
			for (var i:int=0; i<samp; i++) {
				//trace ((Trig.sinDeg(i) * freq));
				wavePt_arr.push(Trig.sinDeg(i) * freq);
			}
			
			
			return (wavePt_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// 
		public static function square(freq:Number):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var wavePt_arr:Array = new Array();
			
			for (var i:int=0; i<360; i++) {
				var wave_val:Number = Trig.sinDeg(i);
				
				if (i < 180)
					wave_val = freq;
					
				else
					wave_val = -freq;
				
				//trace (i, wave_val);
				wavePt_arr.push(wave_val);
				
			}
			
			return (wavePt_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// 
		public static function pulse(freq:Number, ratio:Number=0.5):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var wavePt_arr:Array = new Array();
			
			for (var i:int=0; i<360; i++) {
				var wave_val:Number = Trig.sinDeg(i);
				
				if (i < 360 * ratio)
					wave_val = freq;
					
				else
					wave_val = -freq;
				
				//trace (i, wave_val);
				wavePt_arr.push(wave_val);
				
			}
			
			return (wavePt_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// 
		public static function triangle(freq:Number):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var wavePt_arr:Array = new Array();
			var wave_val:Number = 0;
			var wave_inc:Number = freq / 90;
			
			for (var i:int=0; i<360; i++) {
				
				if (i < 90 || i > 270)
					wave_val += wave_inc;
					
				else
					wave_val -= wave_inc;
				
				//trace (i, wave_val);
				wavePt_arr.push(wave_val);
				
			}
			
			return (wavePt_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// 
		public static function sawtooth(freq:Number):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var wavePt_arr:Array = new Array();
			var wave_val:Number = 0;
			var wave_inc:Number = freq / 180;
			
			for (var i:int=0; i<360; i++) {
				
				if (i == 180)
					wave_val = -freq;
					
				else
					wave_val += wave_inc;
				
				//trace (i, wave_val);
				wavePt_arr.push(wave_val);
				
			}
			
			return (wavePt_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		// 
		public static function noise(samp:uint=MAX_SAMPLES/2):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var wavePt_arr:Array = new Array();
			
			for (var i:int=0; i<samp; i++)
				wavePt_arr.push(Randomness.generateFloat(-1, 1));
			
			return (wavePt_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		// 
		public static function clone(wave:Array):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var wavePt_arr:Array = new Array();
			
			for (var i:int=0; i<360; i++)
				wavePt_arr.push(wave[i]);
			
			
			return (wavePt_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// 
		public static function graph(wave:Array, size:Rectangle=null):BitmapData {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!size)
				size = new Rectangle(0, 0, 360, 128);
			
			var bmpData:BitmapData = new BitmapData(360, 128, true, 0x00000000);
				bmpData.fillRect(size, 0xff808080);
			
			for (var i:int=0; i<wave.length; i++) {
				bmpData.setPixel32(i, wave[i], 0xff00ff00);
			}
			
			return (bmpData);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}