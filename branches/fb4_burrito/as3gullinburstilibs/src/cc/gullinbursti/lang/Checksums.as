package cc.gullinbursti.lang {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author:		Gullinbursti
	 * @class:		Checksums
	 * @package:	cc.gullinbursti.lang
	 * @created:	3:32:07 PM Mar 19, 2011
	 */
	// <[!] class delaration [!]>
	public class Checksums {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function Checksums() {/* …\(^_^)/… */}
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function simple (data:String=""):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		private static function bytesum(data:String=""):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			var sum:uint = 0;
			
			for (var i:int=0; i<data.length; i++)
				sum += 1;
			
			return (0);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function adler32 (data:String=""):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function fletcher4 (data:String=""):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function fletcher8 (data:String=""):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function fletcher16 (data:String=""):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function fletcher32 (data:String=""):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function luhn (data:String=""):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function sum8 (data:String=""):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function sum16 (data:String=""):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function sum24 (data:String=""):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function sum32 (data:String=""):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function verhoeff (data:String=""):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function xor8 (data:String=""):uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}