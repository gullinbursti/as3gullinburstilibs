package cc.gullinbursti.converts {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Energy {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		// <*] class constructor [*>	
		public function Energy() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		/**
		 * joule J
		 * newton-meter n-m
		 * foot-pounds ft-lb
		 * calorie cal
		 * (kilo)watt-hour (k)W-h
		 * btu
		 */
		
		
		
		// btu = J * 0.0009478171
		public static function joulesToBTUs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.0009478171);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// btu = cal * 0.003968321
		public static function caloriesToBTUs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.003968321);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// btu = W-h * 3.412142
		public static function wattHrsToBTUs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 3.412142);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// btu = kW-h * 3412.142
		public static function kwattHrsToBTUs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (wattHrsToBTUs(val) * 1000);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// btu = ft-lb * 0.001285067
		public static function ftlbsToBTUs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.001285067);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// btu = n-m * 0.0009478171
		public static function newtonMetersToBTUs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.0009478171);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// J = BTU * 1055.056
		public static function btusToJoules(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 1055.056);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// J = cal * 4.1868
		public static function caloriesToJoules(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 4.1868);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// J = W-h * 3600
		public static function wattHrsToJoules(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 3600);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// J = kW-h * 3600000
		public static function kwattHrsToJoules(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (wattHrsToJoules(val) * 1000);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// J = ft-lb * 1.355818
		public static function ftlbsToJoules(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 1.355818);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// J = n-m * 1
		public static function newtonMetersToJoules(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 1);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// n-m = BTU * 1055.056
		public static function btusToNewtonMeters(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (btusToJoules(val));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// n-m = cal * 4.1868
		public static function caloriesToNewtonMeters(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (caloriesToJoules(val));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// n-m = W-h * 3600
		public static function wattHrsToNewtonMeters(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (wattHrsToJoules(val));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// n-m = kW-h * 3600000
		public static function kwattHrsToNewtonMeters(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (wattHrsToJoules(val) * 1000);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// n-m = ft-lb * 1.355818
		public static function ftlbsToNewtonMeters(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (ftlbsToJoules((val * 1.355818)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// n-m = J * 1
		public static function joulesToNewtonMeters(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 1);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// ft-lb = BTU * 778.1693
		public static function btusToFtlbs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 778.1693);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// ft-lb = cal * 3.088025
		public static function caloriesToFtlbs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 3.088025);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// ft-lb = W-h * 2655.224
		public static function wattHrsToFtlbs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 2655.224);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// ft-lb = kW-h * 3600000
		public static function kwattHrsToFtlbs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (wattHrsToFtlbs(val) * 1000);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// ft-lb = n-m * 0.7375622
		public static function newtonMetersToFtlbs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.7375622);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// ft-lb = J * 0.7375622
		public static function joulesToFtlbs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.7375622);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// cal = BTU * 251.9958
		public static function btusToCalories(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 251.9958);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// cal = ft-lb * 0.3238315
		public static function ftlbsToCalories(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.3238315);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// cal = W-h * 859.8452
		public static function wattHrsToCalories(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 859.8452);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// cal = kW-h * 859845.2
		public static function kwattHrsToCalories(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (wattHrsToCalories(val) * 1000);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// cal = n-m * 0.2388459
		public static function newtonMetersToCalories(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.2388459);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// cal = J * 0.2388459
		public static function joulesToCalories(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.2388459);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// W-h = BTU * 0.2930711
		public static function btusToWattHrs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.2930711);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// W-h = ft-lb * 0.000766161
		public static function ftlbsToWattHrs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.000766161);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// W-h = cal * 0.001163
		public static function caloriesWattHrs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.001163);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// W-h = kW-h * 1000
		public static function kwattHrsToWattHrs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 1000);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// W-h = n-m * 0.0002777778
		public static function newtonMetersToWattHrs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.0002777778);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// W-h = J * 0.0002777778
		public static function joulesToWattHrs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.0002777778);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// kW-h = BTU * 0.2930711
		public static function btusToKwattHrs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (wattHrsToKwattHrs(btusToWattHrs(val)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// kW-h = ft-lb * 0.000766161
		public static function ftlbsToKwattHrs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (wattHrsToKwattHrs(ftlbsToWattHrs(val)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// kW-h = cal * 0.001163
		public static function caloriesKwattHrs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (wattHrsToKwattHrs(caloriesWattHrs(val)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// kW-h = W-h * 0.001
		public static function wattHrsToKwattHrs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.001);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// kW-h = n-m * 0.0002777778
		public static function newtonMetersToKwattHrs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (wattHrsToKwattHrs(newtonMetersToWattHrs(val)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// kW-h = J * 0.0002777778
		public static function joulesToKwattHrs(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (wattHrsToKwattHrs(joulesToWattHrs(val)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}