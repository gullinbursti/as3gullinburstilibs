package cc.gullinbursti.math.algebra {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.interfaces.IValueObject;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class PolynomialVO implements IValueObject {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
	
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public var a:Number;
		public var b:Number;
		public var c:Number;
		public var h:Number;
		public var k:Number;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function PolynomialVO(a_num:Number=0, b_num:Number=0, c_num:Number=0, h_num:Number=0, k_num:Number=0) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			a = a_num;
			b = b_num;
			c = c_num;
			
			h = h_num;
			k = k_num;
				 
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public function toString():String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var ret_str:String = "\PolynomialVO:\n";
				ret_str += "[=-=-=-=-=-=-=-=-=-=-=-=-=-=-=]\n";
				ret_str += "a: ["+a+"]\n";
				ret_str += "b: ["+b+"]\n";
				ret_str += "c: ["+c+"]\n";
				ret_str += "h: ["+h+"]\n";
				ret_str += "k: ["+k+"]\n";
				ret_str += "[=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=]\n\n";
			
			return (ret_str);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}