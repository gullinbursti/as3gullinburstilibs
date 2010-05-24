package cc.gullinbursti.renderers {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	
	// <[!] class delaration [¡]>
	public class TextShadowDrawer extends TextField {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function TextShadowDrawer(src_txt:TextField, xDist:Number=2, yDist:Number=2, colr:uint=0x181a1e, alph:Number=1) {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			super();  
			
			var shadow_txt:TextField = new TextField();
				this.autoSize = src_txt.autoSize;
				this.defaultTextFormat = src_txt.getTextFormat();
				this.textColor = colr;
				this.multiline = src_txt.multiline;
				this.wordWrap = src_txt.wordWrap;
				this.selectable = false;
				this.embedFonts = true;
				this.htmlText = src_txt.htmlText;
				this.text = src_txt.text;
				this.x = src_txt.x + xDist;
				this.y = src_txt.y + yDist;
				this.width = src_txt.width;
				this.alpha = alph;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
	}
}