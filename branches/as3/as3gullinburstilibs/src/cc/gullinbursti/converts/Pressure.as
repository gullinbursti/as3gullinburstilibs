package cc.gullinbursti.converts {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Pressure {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		/**
		 * psi
		 * atmospheres
		 * bars
		 * inches Hg
		 * pascals
		 */
		
		
		// <*] class constructor [*>
		public function Pressure() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// psi = atmospheres * 14.69595
		public static function atmospheresToPsi(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 14.69595);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// psi = bars * 14.50377
		public static function barsToPsi(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 14.50377);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// psi = inHg * 0.4911541
		public static function inHgToPsi(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.4911541);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// psi = pascals * 0.0001450377
		public static function pascalsToPsi(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.0001450377);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// atmospheres = psi * 0.06804596
		public static function psiToAtmospheres(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.06804596);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// atmospheres = bars * 0.9869233
		public static function barsToAtmospheres(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.9869233);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// atmospheres = inHg * 0.03342106
		public static function inHgToAtmospheres(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.03342106);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// atmospheres = pascals * 0.000009869233
		public static function pascalsToAtmospheres(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.000009869233);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// bars = atmospheres * 1.01325
		public static function atmospheresToBars(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 1.01325);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// bars = psi * 0.06894757
		public static function psiToBars(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.06894757);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// bars = inHg * 0.0386389
		public static function inHgToBars(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.4911541);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// bars = pascals * 0.00001
		public static function pascalsToBars(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.00001);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// inHg = atmospheres * 29.92126
		public static function atmospheresToInchesHg(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 29.92126);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// inHg = psi * 2.036021
		public static function psiToInchesHg(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 2.036021);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// inHg = bars * 29.52998
		public static function barsToInchesHg(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 29.52998);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// inHg = pascals * 0.0002952998
		public static function pascalsToInchesHg(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 0.0002952998);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// pascals = atmospheres * 101325
		public static function atmospheresToPascals(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 101325);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// pascals = psi * 6894.757
		public static function psiToPascals(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 6894.757);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// pascals = bars * 100000
		public static function barsToPascals(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 100000);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		// pascals = inHg * 3386389
		public static function inHgToPascals(val:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (val * 3386389);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯

	}
}