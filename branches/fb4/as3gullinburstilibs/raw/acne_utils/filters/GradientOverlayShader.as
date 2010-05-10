package utils.filters {
	import flash.display.Shader;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	/**
	 * @author Svante
	 * @time 22 apr 2009 16.56.07
	 * @project forsvaret_rekryteringsportal
	 */
	public class GradientOverlayShader extends Shader {
		
		[Embed(source="pbj/gradientoverlay.pbj", mimeType="application/octet-stream")] 
		private const ShaderClassBytes : Class;
		private var m_rect : Rectangle;

		public function GradientOverlayShader(a_rect : Rectangle,a_color:uint,a_multiply:Number) {
			super(new ShaderClassBytes() as ByteArray);
			
			color = a_color;
			multiply = a_multiply;
			rect = a_rect;
			
		}
		public function set multiply (a_multiply:Number):void {
			data.multiply.value = [a_multiply];
		}
		public function get multiply ():Number {
			return data.multiply.value[0];
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
		
		public function set rect (a_rect:Rectangle):void {
			m_rect = a_rect;
			data.xywh.value = [a_rect.x,a_rect.y,a_rect.width,a_rect.height];
		}
		public function get rect ():Rectangle {
			return m_rect;
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
