package utils.filters {
	import flash.filters.ShaderFilter;
	import flash.geom.Rectangle;
	/**
	 * @author Svante
	 * @time 23 apr 2009 10.24.56
	 * @project forsvaret_rekryteringsportal
	 */
	public class GradientShaderFilter extends ShaderFilter {
		private var m_shader : GradientShader;
		
		public function GradientShaderFilter(a_rect : Rectangle,a_color1:uint,a_color2:uint,a_multiply:Number) {
			m_shader = new GradientShader(a_rect, a_color1,a_color2,a_multiply);
			super(m_shader);
			
		}
		public function set color1 (a_color1:uint):void {
			m_shader.color1 = a_color1;
		}
		public function get color1 ():uint {
			return m_shader.color1;
		}
		public function set color2 (a_color2:uint):void {
			m_shader.color2 = a_color2;
		}
		public function get color2 ():uint {
			return m_shader.color2;
		}
		public function set rect (a_rect:Rectangle):void {
			m_shader.rect = a_rect;
		}
		public function get rect ():Rectangle {
			return m_shader.rect;
		}
	}
}
