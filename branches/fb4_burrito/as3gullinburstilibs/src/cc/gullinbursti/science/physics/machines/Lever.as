package cc.gullinbursti.science.physics.machines {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [!]>
	public class Lever extends SimpleMachine {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		private var fulcrum:Number;
		private var load:Number;
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function Lever(l:Number, w:Number, p:Number=Number.MAX_VALUE) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			super(l);
			
			load = w;
			fulcrum = p;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		/**
		 * Calculates the force required to equalize 
		 * @param amt The weight to lift
		 * @return The force needed
		 * 
		 */		
		public function applyLoad(amt:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return ((amt * fulcrum) / (len - fulcrum));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		/**
		 * Calculates the distance to the fulcrum 
		 * @param amt The force applied
		 * @return The position of the fulcrum
		 * 
		 */		
		public function findFulcrum(amt:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			for (var i:int=0; i<len; i++) {
				if (load * i == amt * (len-i))
					break;
			}
			
			
			return (i);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
	}
}