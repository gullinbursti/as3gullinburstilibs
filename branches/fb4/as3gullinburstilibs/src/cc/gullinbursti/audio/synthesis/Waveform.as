package cc.gullinbursti.audio.synthesis {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.audio.MusicTheory;
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.math.geom.Trig;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [!]>
	public class Waveform extends MusicTheory {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		public function Waveform() {	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// 
		public static function sine(freq:Number):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var wavePt_arr:Array = new Array();
			
			for (var i:int=0; i<360; i++) {
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
	}
}