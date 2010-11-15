package cc.gullinbursti.converts {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	/**
	 * @class   SI
	 * @package cc.gullinbursti.converts
	 
	 * @author  "mattH" -//» ¯'gü|l¡ñ·ßµrS†í._ <mailto:code.gullinbursti.cc>
	 * @created Nov 15, 2010 @ 8:23:45 AM
	 * 
	 * @brief 
	 */
	// <[!] class delaration [¡]>
	public class SI {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const INC_PREFIXES:Array = new Array(
			["deca", BasicMath.powr10(1)],
			["hecto", BasicMath.powr10(2)],
			["kilo", BasicMath.powr10(3)],
			["mega", BasicMath.powr10(6)],
			["giga", BasicMath.powr10(9)],
			["tera", BasicMath.powr10(12)],
			["peta", BasicMath.powr10(15)],
			["exa", BasicMath.powr10(18)],
			["zetta", BasicMath.powr10(21)],
			["yotta", BasicMath.powr10(24)]
		);
		
		
		public static const DEC_PREFIXES:Array = new Array(
			["deci", BasicMath.powr10(-1)],
			["centi", BasicMath.powr10(-2)],
			["milli", BasicMath.powr10(-3)],
			["micro", BasicMath.powr10(-6)],
			["nano", BasicMath.powr10(-9)],
			["pico", BasicMath.powr10(-12)],
			["femto", BasicMath.powr10(-15)],
			["atto", BasicMath.powr10(-18)],
			["zepto", BasicMath.powr10(-21)],
			["yocto", BasicMath.powr10(-24)]
		);
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function SI() {/*..\(^_^)/..*/}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
	}
}