package utils.bluebox {
	import flash.events.MouseEvent;
	import acnecore.widgets.buttons.AcBaseButton;
	import acnecore.widgets.buttons.AcButtonEvent;
	import acnecore.widgets.buttons.AcButtonState;

	import com.greensock.TweenMax;

	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	/**
	 * @author Mathias
	 */
	public class Bluebox extends EventDispatcher {
		
		
		// Input Textfield
		private static var m_defaultInputText : String;
		private static var m_inputTextfield : TextField;
		
		
		public static function background(a_x : int, a_y : int, a_width : int, a_height : int, a_color : int = 0) : Sprite {
			var s : Sprite = new Sprite();
			
			s.graphics.beginFill(a_color == 0 ? 0xFF00FF : a_color, 1);
			s.graphics.drawRect(a_x, a_y, a_width, a_height);
			s.graphics.endFill();
			
			return s;
		}
		
		public static function header(a_label : String, a_x : int, a_y : int) : TextField {
			var txt:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.color = 0xFF0000;
			format.size = 25;
			txt.defaultTextFormat = format;
			txt.autoSize = TextFieldAutoSize.LEFT;
			
			txt.x = a_x;
			txt.y = a_y;
			txt.text = a_label;
			
			return txt;
		}

		public static function body(a_body : String, a_x : int, a_y : int, a_width : int) : TextField {
			var txt:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.color = 0xFF0000;
			format.size = 12;
			txt.defaultTextFormat = format;
			txt.autoSize = TextFieldAutoSize.LEFT;
							
			txt.multiline = true;
			txt.wordWrap = true;
			txt.width = a_width;
			
			txt.x = a_x;
			txt.y = a_y;
			txt.text = a_body;
			
			return txt;
		}		

		public static function button(a_label : String, a_x : int, a_y : int, onClickFunction:Function) : AcBaseButton {
			var btn : AcBaseButton = new AcBaseButton();
			btn.mouseChildren = false;
			btn.name = a_label;
			var bg : Sprite = new Sprite();

			var txt:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.color = 0xFF0000;
			format.size = 12;
			txt.defaultTextFormat = format;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.text = a_label;
						
			bg.graphics.beginFill(0xCCCCCC, 1);
			bg.graphics.drawRect(0, 0, txt.textWidth * 1.5, txt.textHeight * 1.5);
			bg.graphics.endFill();
			
			txt.x = Math.round(bg.width / 2 - txt.textWidth / 2);
			txt.y = Math.round(bg.height / 2 - txt.textHeight / 2) - 2;
			
			btn.addEventListener(AcButtonEvent.CHANGE_STATE, onBaseButtonStateChange, false, 0, true);
			btn.addEventListener(MouseEvent.CLICK, onClickFunction);
			
			btn.addChild(bg);
			btn.addChild(txt);
			
			btn.x = a_x;
			btn.y = a_y;
			
			return btn;
		}
		
		public static function inputField(a_defaultText : String, a_width : int, a_x : int, a_y : int) : Sprite {
			var container : Sprite = new Sprite();
			
			var txt:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.color = 0xFFFFFF;
			format.size = 12;
			
			txt.autoSize = TextFieldAutoSize.NONE;
			txt.selectable = true;
			txt.type = TextFieldType.INPUT;
			txt.width = a_width;
			txt.defaultTextFormat = format;
			
			txt.text = a_defaultText;
			txt.height = txt.textHeight * 1.5;
			txt.x = a_x;
			txt.y = a_y;

			container.graphics.beginFill(0xFF0000, 1);
			container.graphics.drawRect(a_x, a_y, a_width * 1.2, txt.textHeight * 1.5);
			container.graphics.endFill();
			
			m_defaultInputText = a_defaultText;
			m_inputTextfield = txt;
			
			txt.addEventListener(FocusEvent.FOCUS_IN, onInputTextFieldFocusIn, false, 0, true);
			txt.addEventListener(FocusEvent.FOCUS_OUT, onInputTextFieldFocusOut, false, 0, true);
			
//			BindKey.addBinding(Keyboard.ENTER, onKeyPress);
			
			container.addChild(txt);
			
			return container;
		}
		
		public static function getInputFieldText() : String {
			return m_inputTextfield.text;
		}		
		////////////////////////////////////////////////////////////////////////////////////////
		// EVENT HANDLERS
		////////////////////////////////////////////////////////////////////////////////////////

		private static function onBaseButtonStateChange(event : AcButtonEvent) : void {
			var btn : AcBaseButton = event.target as AcBaseButton;
			
			TweenMax.killTweensOf(btn);
			
			switch(btn.state) {
				case AcButtonState.OVER:
					TweenMax.to(btn, 0.2, {alpha:0.8});
				break;
				case AcButtonState.PRESSED:
					TweenMax.to(btn, 0.2, {alpha:0.5});
				break;
				default:
					TweenMax.to(btn, 0.2, {alpha:1});
				break;				
			}
		}	
		
		private static function onInputTextFieldFocusOut(event : FocusEvent) : void {
			if(m_inputTextfield == null) return;
			if(m_inputTextfield.text == "") m_inputTextfield.text = m_defaultInputText;
		}

		private static function onInputTextFieldFocusIn(event : FocusEvent) : void {
			if(m_inputTextfield == null) return;
			if(m_inputTextfield.text == m_defaultInputText) m_inputTextfield.text = "";
		}
		
//		private static function onKeyPress() : void {
////			dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN));
//		}		
	}
}
