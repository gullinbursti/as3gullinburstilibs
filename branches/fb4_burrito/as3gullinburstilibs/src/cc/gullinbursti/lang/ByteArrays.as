package cc.gullinbursti.lang {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import flash.utils.ByteArray;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [!]>
	public class ByteArrays {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		private static const BASE64_CHARS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		// <*] class constructor [*>	
		public function ByteArrays() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function encBase64(src_ba:ByteArray):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var enc_str:String="";
			
			// data and output buffers
			var data_arr:Array;
			var output_arr:Array = new Array(4);
			
			// rewind
			src_ba.position = 0;
			
			// while there are still bytes to be processed
			while (src_ba.bytesAvailable > 0) {
				
				var i:int;
				
				// new data buffer, populate next 3 bytes from data
				data_arr = new Array();
				
				for (i=0; i<3 && src_ba.bytesAvailable>0; i++)
					data_arr[i] = src_ba.readUnsignedByte();
				
				
				// convert to char positions to buffer
				output_arr[0] = (data_arr[0] & 0xfc) >> 2;
				output_arr[1] = ((data_arr[0] & 0x03) << 4) | ((data_arr[1]) >> 4);
				output_arr[2] = ((data_arr[1] & 0x0f) << 2) | ((data_arr[2]) >> 6);
				output_arr[3] = data_arr[2] & 0x3f;
				
				// pad last chars to '=' until %4=0
				for (i=data_arr.length; i<3; i++)
					output_arr[i + 1] = 64;
				
				// loop & add base64 char to each pos
				for (i=0; i<output_arr.length; i++)
					enc_str += BASE64_CHARS.charAt(output_arr[i]);
			}
			
				
			return (enc_str);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function decBase64(enc_str:String):ByteArray {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// output ByteArray for decoded data
			var output_ba:ByteArray = new ByteArray();
			
			// data and output buffers
			var data_arr:Array = new Array(4);
			var output_arr:Array = new Array(3);
			
			// there;s data bytes left to be processed
			for (var i:int=0; i<enc_str.length; i+=4) {
				
				// fill buffer 4x w/ position of base-64 chars for encoded data
				for (var j:int=0; j<4 && i+j<enc_str.length; j++)
					data_arr[j] = BASE64_CHARS.indexOf(enc_str.charAt(i + j));
				
				// decode back into bytes
				output_arr[0] = (data_arr[0] << 2) + ((data_arr[1] & 0x30) >> 4);
				output_arr[1] = ((data_arr[1] & 0x0f) << 4) + ((data_arr[2] & 0x3c) >> 2);		
				output_arr[2] = ((data_arr[2] & 0x03) << 6) + data_arr[3];
				
				// add all non-padded bytes to decoded data
				for (var k:int=0; k<output_arr.length; k++) {
					if (data_arr[k+1] == 64) 
						break;
					
					output_ba.writeByte(output_arr[k]);
				}
			}
			
			// rewind
			output_ba.position = 0;
			
			
			return (output_ba);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}