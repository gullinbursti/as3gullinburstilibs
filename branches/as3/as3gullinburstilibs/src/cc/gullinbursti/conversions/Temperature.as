package cc.gullinbursti.conversions {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class Temperature {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
		
		public function Temperature() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		// °C = (°F - 32) * (5 / 9)
		public static function fehrenheitToCelsius(temp:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return ((temp - 32) * (9 / 5));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// °F = (°C * (9 / 5)) + 32
		public static function celsiusToFehrenheit(temp:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return ((temp * (9 / 5)) + 32);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// °K = ((°F - 32) * (5 / 9)) - 273
		public static function fehrenheitToKelvin(temp:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (celsiusToKelvin(fehrenheitToCelsius(temp)));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// °K = °C + 273 
		public static function celsiusToKelvin(temp:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (temp - 273);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// °F = ((°K + 273) * (9 / 5)) + 32
		public static function kelvinToFehrenheit(temp:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (celsiusToFehrenheit(kelvinToCelsius(temp)));	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// °C = °K + 273
		public static function kelvinToCelsius(temp:Number):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (temp + 273);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		

	}
}