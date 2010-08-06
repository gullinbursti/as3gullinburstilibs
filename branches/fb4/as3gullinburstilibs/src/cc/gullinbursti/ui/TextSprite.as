package cc.gullinbursti.ui {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.events.UIEvent;
	import cc.gullinbursti.lang.Strings;
	import cc.gullinbursti.lang.TextFields;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	// <[!] class delaration [!]>
	public class TextSprite extends Sprite {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		
		private var _txt:TextField;
		private var _txtFormat:TextFormat;
		private var _txtAlign:TextFormatAlign;
		private var _autoSize:String;
		private var _font:String;
		private var _fontSize:uint;
		private var _color:uint;
		
		private var _txtArea:Point;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		// <*] class constructor [*>
		public function TextSprite(fontName:String, fontSize:uint, txtCopy:String, color:uint=0x000000, isBtn:Boolean=false, txtAlign:String=TextFormatAlign.CENTER) {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			super();
			_autoSize = TextFieldAutoSize.LEFT;
			
			var txtFrmt_new:TextFormat = new TextFormat(fontName, fontSize, color, null, null, null, null, null, txtAlign);
			
			
			_txt = new TextField();
			_txt.cacheAsBitmap = true;
			_txt.autoSize = _autoSize;
			_txt.embedFonts = true;
			_txt.textColor = color;
			
			//_txt.defaultTextFormat = new TextFormat(fontName, fontSize, color, null, null, null, null, null, txtAlign);
			_txt.selectable = false;
			_txt.mouseWheelEnabled = true;
			
			_txt.antiAliasType = AntiAliasType.ADVANCED;
			_txt.gridFitType = GridFitType.SUBPIXEL;
			//_txt.sharpness = 400;
			//_txt.thickness = 100;
			
			_txt.setTextFormat(txtFrmt_new);
			_txt.defaultTextFormat = txtFrmt_new
			
			_txt.text = txtCopy;
			
			_txtArea = new Point();
			_txtArea.x = TextFields.getTextBounds(_txt).textWidth;
			_txtArea.y = TextFields.getTextBounds(_txt).textHeight;
			
			
			_txt.addEventListener(TextEvent.TEXT_INPUT, hdlText_Input);
			
			this.buttonMode = isBtn;
			this.useHandCursor = isBtn;
			
			this.mouseChildren = false;
			this.addChild(_txt);
			
			var pt:Point = new Point(_txt.x, _txt.y); 
			
			
			//trace("NEW TXTSPRITE: _txt:["+pt+"] txtArea:["+_txtArea+"] calc:["+TextFields.getTextBounds(_txt)+"]");
			
			
			if (txtAlign == TextFormatAlign.CENTER) {
				_txt.x = -_txtArea.x / 2;
				_txt.y = -_txtArea.y / 2;
			}
			
			var g:Graphics = this.graphics;
			/*
				g.lineStyle(1, 0xff0000);
				g.drawCircle(0, 0, 16);
				
				g.moveTo(0, 0);
				g.lineStyle(2, 0x0000ff);
				g.lineTo(_txtArea.x, _txtArea.y);
			*/
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
	
		public function getTxtField ():TextField {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (_txt);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function getTotalChars ():int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (_txt.length);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	
		public function getAntiAlias ():Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (new Point(_txt.sharpness, _txt.thickness));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function getTextArea ():Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (_txtArea);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function getCursorIndex ():int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (_txt.caretIndex);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function getScrollRectBounds():Rectangle {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (_txt.scrollRect);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function getTxtScrollPos():Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (new Point(_txt.scrollH, _txt.scrollV));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function getTxtMaxScrollPos():Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (new Point(_txt.maxScrollH, _txt.maxScrollV));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function getTxtLines():int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (_txt.numLines);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function getCharAtIndex(ind:int):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (_txt.text.charAt(ind));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function getTxtScrollPosWithMax():Rectangle {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (new Rectangle(_txt.scrollH, _txt.scrollV, _txt.maxScrollH, _txt.maxScrollV));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		
		public function setAntiAlias (val:Point):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.sharpness = Math.min(Math.max(val.x, -400), 400);
			_txt.thickness = Math.min(Math.max(val.y, -200), 200);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function setLabel (val:String):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.text = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function setHTML (val:String):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (_txt.length > 0)
				_txt.text = "";
		
			_txt.htmlText = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function setTxtPos (val:int):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.x = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function setMaxChars (val:int):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.maxChars = val
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function setTxtAlign (alignType:String):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/* var txtFrmt:TextFormat = _txt.getTextFormat();
				txtFrmt.underline = val;
				
			this.applyNewFormat(txtFrmt); */
		
			_txt.defaultTextFormat.align = alignType;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function setTxtSize (val:int):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var txtFrmt:TextFormat = _txt.getTextFormat();
				txtFrmt.size = val;
				
			this.applyNewFormat(txtFrmt);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function setLineSpacing (val:int):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			_txt.defaultTextFormat.leading = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function setLetterKerning (val:Number):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.defaultTextFormat.letterSpacing = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function setHilitedChars(pt:Point):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.setSelection(pt.x, pt.y);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function setTxtMargins (pt:Point):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.defaultTextFormat.leftMargin = pt.x;
			_txt.defaultTextFormat.rightMargin = pt.y;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function setAsMultiline (val:int):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.multiline = true;
			_txt.wordWrap = true;
			_txt.width = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function pixelAntiAlias ():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			setAntiAlias(new Point(400, 100));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function stdAntiAlias ():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			setAntiAlias(new Point());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function toggleBtnBehavior (val:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			this.buttonMode = val;
			this.useHandCursor = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function toggleKerning (val:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.defaultTextFormat.kerning = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function toggleUnderlined (val:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			_txt.defaultTextFormat.underline = val;
			
			/* var txtFrmt:TextFormat = _txt.getTextFormat();
				txtFrmt.underline = val;
				
			this.applyNewFormat(txtFrmt); */
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function toggleBolded (val:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.defaultTextFormat.bold = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function toggleItaliced (val:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.defaultTextFormat.italic = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function togglePasswdTxt (val:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.displayAsPassword = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function toggleBulleted (val:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.defaultTextFormat.bullet = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function toggleSelectable (val:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.selectable = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function toggleRichTxtPasting (val:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.useRichTextClipboard = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function toggleDblClickEnabled (val:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.doubleClickEnabled = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function toggleWordWrapping (val:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.wordWrap = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function toggleMultiLined (val:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.multiline = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function toggleWhitespaceShow (val:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.condenseWhite = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function toggleAutoSelectOnFocused (val:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.alwaysShowSelection = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function toggleProhibitedChars (val:String=""):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// "abcdefg" only a,b,c,d,e,f,g
			// "A-Z" only A-Z
			// "A-Z^Q" A-Z, except Q
			// "\u0020-\u007E" range of unicode
			
		
			_txt.restrict = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function findNReplace(search_str:String, replace_str:String, isRepeat:Boolean=true):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			Strings.findNReplace(_txt.text, search_str, replace_str, isRepeat);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function replaceSelectedText(replace_str:String):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			_txt.replaceSelectedText(replace_str);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function applyNewFormat(txtFrmt_upd:TextFormat):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			_txt.setTextFormat(txtFrmt_upd);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		private function hdlText_Input(e:TextEvent):void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			dispatchEvent(new UIEvent(UIEvent.TEXTFIELD_KEYPRESS, e));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		/*
		public function get (): {
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function set ():void {
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		*/
	}
}