package cc.gullinbursti.lang {
	import flash.filters.DisplacementMapFilter;
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	/**
	 * @class   DisplacementMapFilters
	 * @package cc.gullinbursti.lang
	 
	 * @author  "mattH" -//» ¯'gü|l¡ñ·ßµrS†í._
	 * @created Mar 28, 2011 @ 11:38:39 PM
	 * 
	 * @brief 
	 */
	// <[!] class delaration [¡]>
	public class DisplacementMapFilters {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function DisplacementMapFilters() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function emboss(amt:int=0):DisplacementMapFilter {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			
			return(new DisplacementMapFilter());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯ 
	}
}