package cc.gullinbursti.math.discrete {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.interfaces.IValueObject;
	import cc.gullinbursti.lang.Arrays;
	
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class FactorizedVO implements IValueObject {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
	
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.	
		public var factors_arr:Array;
		public var factors_tot:int;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function FactorizedVO(factors:Array=null) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			if (factors) {
				factors_arr = factors;
				//factors_tot = factors_arr.length;
			
			} else
				factors_arr = new Array();
				
			
			factors_tot = factors_arr.length;
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public function addFactor(factor:Point):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			factors_arr.push(factor);
			factors_tot = factors_arr.length;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function sortFactors():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			factors_arr = Arrays.sortByNumber(factors_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		

		public function toString():String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var ret_str:String = "\FactorizedVO\n";
				ret_str += "[=-=-=-=-=-=-=-=-=-=-=-=-=-=-=]:\n";
				ret_str += "factors_arr: ["+factors_arr+"]\n";
				ret_str += "factors_tot: ["+factors_tot+"]\n";
				ret_str += "[=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=]_\n\n";
			
			return (ret_str);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}