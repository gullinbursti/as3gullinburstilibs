package cc.gullinbursti.math.discrete {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class Fibonacci extends BasicMath {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function Fibonacci() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function sequence(max:int, min:int=0):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: generate a sequence of Fibonacci #'s
				
			return (new Array());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function isValueOf(val:int):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: test value for Fibonacci # validity
			
			return (false);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isRatio(nom:int, denom:int, isSeq:Boolean=true):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			// TODO: test value pair if it's a ratio of Fibonacci #'s
			
			return (false);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}