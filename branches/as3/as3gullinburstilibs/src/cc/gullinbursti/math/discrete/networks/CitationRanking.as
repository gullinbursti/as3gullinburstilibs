package cc.gullinbursti.math.discrete.networks {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 
	// <[!] class delaration [¡]>
	public class CitationRanking extends BasicNetworking {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		
		/**
		 * 
		 * Single member's worth when other worths are known:
		 * 
		 * 			 PR(B)	     PR(C)		 PR(D)
		 * PR(A) = --------- + --------- + --------- 
		 * 			 L(B)		 L(C)		 L(D)
		 * 
		 * 
		 * PR() = kudos worth
		 * L() = total outbounds for that member
		 * 
		 * 
		 * Find the value of any page:
		 * 
		 * 			   PR(ß)
		 * PR(∂) =  ∑ ------
		 * 		   ß∊∂  L(ß)
		 * 
		 * 
		 * ∂ = member's worth to calc
		 * ß = nornalized kudos /member
		 * 
		 */
		
		
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const INNATE_HP:Number = 0.25;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		// <*] class constructor [*>	
		public function CitationRanking() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		
		public static function kudosPerCitation(outbounds:int):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			// the reciprical of total outs
			return (1 / outbounds);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function indivKudosWorth(outbounds:int):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			// the reciprical of total outs
			return (1 / outbounds);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function indivKudosPittance(worth:Number, outbounds:int):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			// member's worth is divided by it's outs
			return (worth / outbounds);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}