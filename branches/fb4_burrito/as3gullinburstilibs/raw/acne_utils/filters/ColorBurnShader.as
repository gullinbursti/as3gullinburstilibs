package utils.filters {
	import flash.display.Shader;
	import flash.utils.ByteArray;
	/**
	 * @author Svante
	 * @time 22 apr 2009 16.56.07
	 * @project forsvaret_rekryteringsportal
	 */
	public class ColorBurnShader extends Shader {
		
		[Embed(source="pbj/ColorBurn.pbj", mimeType="application/octet-stream")] 
		private const ShaderClassBytes : Class;

		public function ColorBurnShader(a_color:uint,a_amount:Number) {
			super(new ShaderClassBytes() as ByteArray);
			
			color = a_color;
			amount = a_amount;
			
		}
		public function set amount (a_multiply:Number):void {
			data.amount.value = [a_multiply];
		}
		public function get amount ():Number {
			return data.amount.value[0];
		}
		
		public function set color(a_color:uint):void {
			var c : Array = uintToPixle4(a_color);
			data.color.value = c;
		}
		public function get color():uint {
			var c : Array = data.color.value;
			var r : Number = c[0]*0xFF;
			var g : Number = c[1]*0xFF;
			var b : Number = c[2]*0xFF;
			
			var rgb : uint = (r << 16) + (g << 8 ) + b;
			
			return rgb;
		}
		
		private function uintToPixle4(a_c:uint) : Array {
			var a : Number = Math.round ( (	(a_c >> 24 & 0xFF)/0xFF) *100) /100;
			var r : Number = Math.round ( (	(a_c >> 16 &0xFF)/0xFF) *100) /100;
			var g : Number = Math.round ( (	(a_c >> 8 & 0xFF)/0xFF) *100) /100;
			var b : Number = Math.round ( (	(a_c >> 0 & 0xFF)/0xFF) *100) /100;
			
			return [r,g,b,a];
		}
	}
}
