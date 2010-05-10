package utils.filters {
	import flash.display.Shader;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	/**
	 * @author Svante
	 * @time 22 apr 2009 16.56.07
	 * @project forsvaret_rekryteringsportal
	 */
	public class GradientShader extends Shader {
		
		[Embed(source="pbj/gradientfill.pbj", mimeType="application/octet-stream")] 
		private const ShaderClassBytes : Class;
		private var m_rect : Rectangle;

		public function GradientShader(a_rect : Rectangle,a_color1:uint,a_color2:uint,a_multiply:Number) {
			super(new ShaderClassBytes() as ByteArray);
			
			color1 = a_color1;
			color2 = a_color2;
			multiply = a_multiply;
			rect = a_rect;
			
		}
		public function set multiply (a_multiply:Number):void {
			data.multiply.value = [a_multiply];
		}
		public function get multiply ():Number {
			return data.multiply.value[0];
		}
		
		public function set color1 (a_color:uint):void {
			data.color1.value = uintToPixle4(a_color);
		}
		public function get color1 ():uint {
			return data.color1.value[0];
		}
		
		public function set color2 (a_color:uint):void {
			data.color2.value = uintToPixle4(a_color);
		}
		public function get color2 ():uint {
			return data.color2.value[0];
		}
		
		public function set rect (a_rect:Rectangle):void {
			m_rect = a_rect;
			data.xywh.value = [a_rect.x,a_rect.y,a_rect.width,a_rect.height];
		}
		public function get rect ():Rectangle {
			return m_rect;
		}

		private function uintToPixle4(a_c:uint) : Array {
//			var a : Number = Math.round ( (	(a_c >> 24 & 0xFF)/0xFF) *100) /100;
			var r : Number = Math.round ( (	(a_c >> 16 &0xFF)/0xFF) *100) /100;
			var g : Number = Math.round ( (	(a_c >> 8 & 0xFF)/0xFF) *100) /100;
			var b : Number = Math.round ( (	(a_c >> 0 & 0xFF)/0xFF) *100) /100;
			
			return [r,g,b,1];
		}
	}
}
