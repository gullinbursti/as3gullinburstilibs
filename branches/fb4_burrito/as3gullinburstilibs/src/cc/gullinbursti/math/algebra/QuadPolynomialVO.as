package cc.gullinbursti.math.algebra {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.interfaces.IValueObject;
	
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class QuadPolynomialVO extends PolynomialVO implements IValueObject {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
	
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.	
		public var discriminant:Number;
		public var root_pt:Point;
		public var isReal:Boolean;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function QuadPolynomialVO(a_num:Number=0, b_num:Number=0, c_num:Number=0, h_num:Number=0, k_num:Number=0, discrim:Number=0, roots:Point=null, real_root:Boolean=true) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			super(a_num, b_num, c_num, h_num, k_num);
			
			discriminant = discrim;
			root_pt = roots.clone();
			
			isReal = real_root;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		override public function toString():String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var ret_str:String = "\PolynomialVO:\n";
				ret_str += "[=-=-=-=-=-=-=-=-=-=-=-=-=-=-=]\n";
				ret_str += "a: ["+a+"]\n";
				ret_str += "b: ["+b+"]\n";
				ret_str += "c: ["+c+"]\n";
				ret_str += "h: ["+h+"]\n";
				ret_str += "k: ["+k+"]\n";
				ret_str += "discriminant: ["+discriminant+"]\n";
				ret_str += "root_pt: ["+root_pt+"]\n";
				ret_str += "isReal: ["+isReal+"]\n";
				ret_str += "[=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=]\n\n";
			
			return (ret_str);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}