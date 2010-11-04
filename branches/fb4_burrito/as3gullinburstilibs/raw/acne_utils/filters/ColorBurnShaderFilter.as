package utils.filters {
	import flash.filters.ShaderFilter;
	/**
	 * @author Svante
	 * @time 23 apr 2009 10.24.56
	 * @project forsvaret_rekryteringsportal
	 */
	public class ColorBurnShaderFilter extends ShaderFilter {
		private var m_shader : ColorBurnShader;
		
		public function ColorBurnShaderFilter(a_color:uint,a_amount:Number) {
			m_shader = new ColorBurnShader(a_color,a_amount);
			super(m_shader);
			
		}
		public function set color (a_color:uint):void {
			m_shader.color = a_color;
		}
		public function get color ():uint {
			return m_shader.color;
		}
		public function set amount (a_amount:Number):void {
			m_shader.amount = a_amount;
		}
		public function get amount ():Number {
			return m_shader.amount;
		}
	}
}
