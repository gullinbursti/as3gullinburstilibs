package cc.gullinbursti.audio.calc {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	/**
	 * @class   Summate
	 * @package cc.gullinbursti.audio.calc
	 
	 * @author  "mattH" -//» ¯'gü|l¡ñ·ßµrS†í._ <mailto:code.gullinbursti.cc>
	 * @created Nov 15, 2010 @ 8:20:24 AM
	 * 
	 * @brief 
	 */
	// <[!] class delaration [¡]>
	public class Summate {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function Summate() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function dBFS(dB_arr:Array):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var dBFS:Number = 0;
			
			for (var i:int=0; i<dB_arr.length; i++)
				dBFS += Math.pow(10, (-dB_arr[i] / 20));
			
			dBFS = Math.log(dBFS);
			dBFS = 20 * dBFS / Math.log(10);
			
			return (dBFS);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}