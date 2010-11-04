package cc.gullinbursti.converts {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Data {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		private static var base_amt:int = Math.pow(2, 10);
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		// <*] class constructor [*>
		public function Data() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		// 8 bits per byte
		public static function bitsToBytes(bits:int):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (bits * (1/8));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// 1 byte = 8 bits
		public static function bytesToBits(bytes:Number):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (Math.ceil(bytes * 8));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function bytesToKilo(bytes:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (scale(bytes, -1));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function bytesToMega(bytes:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (scale(bytes, -2));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function kiloToMega(bytes:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (scale(bytes, -1));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function kiloToBytes(bytes:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (scale(bytes, 1));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function kiloToGiga(bytes:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (scale(bytes, -2));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function gigaToKilo(bytes:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (scale(bytes, 2));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function megaToGiga(bytes:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (scale(bytes, -1));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function megaToKilo(bytes:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (scale(bytes, 1));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function gigaToMega(bytes:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (scale(bytes, 1));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function gigaToTera(bytes:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (scale(bytes, -1));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function teraToGiga(bytes:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (scale(bytes, 1));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		private static function scale(amt:int, times:int=0):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// return value
			var scaled_val:int = amt;
			
			// loop thru & multiply
			for (var i:int=0; i<Math.abs(times); i++) {
				
				// going lg » sm
				if (times > 0)
					scaled_val *= base_amt;
				
				// going sm » lg	
				else 
					scaled_val *= (1 / base_amt); 
			}
			
			
			return (scaled_val);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}