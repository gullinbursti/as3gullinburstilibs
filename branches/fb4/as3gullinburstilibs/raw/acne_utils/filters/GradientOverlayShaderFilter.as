package utils.filters {
	import flash.filters.ShaderFilter;
	import flash.geom.Rectangle;
	/**
	 * @author Svante
	 * @time 23 apr 2009 10.24.56
	 * @project forsvaret_rekryteringsportal
	 */
	public class GradientOverlayShaderFilter extends ShaderFilter {
		private var m_shader : GradientOverlayShader;
		
		public function GradientOverlayShaderFilter(a_rect : Rectangle,a_color:uint,a_multiply:Number) {
			m_shader = new GradientOverlayShader(a_rect, a_color,a_multiply);
			super(m_shader);
			
		}
		public function set color (a_color:uint):void {
			m_shader.color = a_color;
		}
		public function get color ():uint {
			return m_shader.color;
		}
		public function set rect (a_rect:Rectangle):void {
			m_shader.rect = a_rect;
		}
		public function get rect ():Rectangle {
			return m_shader.rect;
		}
	}
}
