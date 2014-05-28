package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.UIComponent;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import flash.events.Event;
   import com.ankamagames.jerakine.replay.LogFrame;
   import com.ankamagames.jerakine.replay.LogTypeEnum;
   import com.ankamagames.jerakine.replay.KeyboardInput;
   import com.ankamagames.berilia.components.messages.ChangeMessage;
   import flash.display.InteractiveObject;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.text.TextFieldType;
   
   public class Input extends Label implements UIComponent
   {
      
      public function Input() {
         super();
         _bHtmlAllowed = false;
         _tText.selectable = true;
         _tText.type = TextFieldType.INPUT;
         _tText.restrict = this._sRestrictChars;
         _tText.maxChars = this._nMaxChars;
         _tText.mouseEnabled = true;
         _autoResize = false;
         this.numberSeparator = numberStrSeparator;
         _tText.addEventListener(Event.CHANGE,this.onTextChange);
      }
      
      private static const _strReplace:String = "NoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLog";
      
      private static var regSpace:RegExp;
      
      public static var numberStrSeparator:String;
      
      private var _nMaxChars:int;
      
      private var _nNumberMax:uint;
      
      private var _bPassword:Boolean = false;
      
      private var _sRestrictChars:String;
      
      private var _bNumberAutoFormat:Boolean = false;
      
      private var _numberSeparator:String = " ";
      
      private var _nSelectionStart:int;
      
      private var _nSelectionEnd:int;
      
      private var _lastTextOnInput:String;
      
      public var imeActive:Boolean;
      
      private var _timerFormatDelay:Timer;
      
      public var focusEventHandlerPriority:Boolean = true;
      
      public function get lastTextOnInput() : String {
         return this._lastTextOnInput;
      }
      
      public function get maxChars() : uint {
         return this._nMaxChars;
      }
      
      public function set maxChars(nValue:uint) : void {
         this._nMaxChars = nValue;
         _tText.maxChars = this._nMaxChars;
      }
      
      public function set numberMax(nValue:uint) : void {
         this._nNumberMax = nValue;
      }
      
      public function get password() : Boolean {
         return this._bPassword;
      }
      
      public function set password(bValue:Boolean) : void {
         this._bPassword = bValue;
         if(this._bPassword)
         {
            _tText.displayAsPassword = true;
         }
      }
      
      public function get numberAutoFormat() : Boolean {
         return this._bNumberAutoFormat;
      }
      
      public function set numberAutoFormat(bValue:Boolean) : void {
         this._bNumberAutoFormat = bValue;
         if(!bValue)
         {
            if(this._timerFormatDelay)
            {
               this._timerFormatDelay.stop();
               this._timerFormatDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerFormatDelay);
            }
         }
         else
         {
            this._timerFormatDelay = new Timer(1000,1);
            this._timerFormatDelay.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerFormatDelay);
         }
      }
      
      public function get numberSeparator() : String {
         return this._numberSeparator;
      }
      
      public function set numberSeparator(bValue:String) : void {
         this._numberSeparator = bValue;
      }
      
      public function get restrictChars() : String {
         return this._sRestrictChars;
      }
      
      public function set restrictChars(sValue:String) : void {
         this._sRestrictChars = sValue;
         _tText.restrict = this._sRestrictChars;
      }
      
      public function get haveFocus() : Boolean {
         return Berilia.getInstance().docMain.stage.focus == _tText;
      }
      
      override public function set text(sValue:String) : void {
         super.text = sValue;
         this.onTextChange(null);
      }
      
      override public function remove() : void {
         if(this._timerFormatDelay)
         {
            this._timerFormatDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerFormatDelay);
         }
         super.remove();
      }
      
      override public function free() : void {
         if(this._timerFormatDelay)
         {
            this._timerFormatDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerFormatDelay);
         }
         super.free();
      }
      
      override public function focus() : void {
         Berilia.getInstance().docMain.stage.focus = _tText;
         FocusHandler.getInstance().setFocus(_tText);
      }
      
      public function blur() : void {
         Berilia.getInstance().docMain.stage.focus = null;
         FocusHandler.getInstance().setFocus(null);
      }
      
      override public function process(msg:Message) : Boolean {
         var delta:* = 0;
         var inc:* = 0;
         var newValue:* = 0;
         if((msg is MouseClickMessage) && (MouseClickMessage(msg).target == this))
         {
            this.focus();
         }
         var tfIntValue:int = parseInt(text.split(" ").join("").split(" ").join("").split(this._numberSeparator).join(""));
         if((msg is MouseWheelMessage) && (!disabled) && (tfIntValue.toString(10) == text.split(" ").join("").split(" ").join("").split(this._numberSeparator).join("")))
         {
            delta = (msg as MouseWheelMessage).mouseEvent.delta > 0?1:-1;
            inc = Math.abs(tfIntValue) > 99?Math.pow(10,(tfIntValue + delta).toString(10).length - 2):1;
            if(ShortcutsFrame.ctrlKey)
            {
               inc = 1;
            }
            newValue = tfIntValue + delta * inc;
            newValue = newValue < 0?0:newValue;
            if((this._nNumberMax > 0) && (newValue > this._nNumberMax))
            {
               newValue = this._nNumberMax;
            }
            this.text = newValue.toString();
         }
         return super.process(msg);
      }
      
      public function setSelection(start:int, end:int) : void {
         this._nSelectionStart = start;
         this._nSelectionEnd = end;
         _tText.setSelection(this._nSelectionStart,this._nSelectionEnd);
      }
      
      private function onTextChange(e:Event) : void {
         var pattern0:RegExp = null;
         var tempString:String = null;
         var toInt:* = NaN;
         if(this._nNumberMax > 0)
         {
            pattern0 = new RegExp("[0-9 ]+","g");
            tempString = this.removeSpace(_tText.text);
            toInt = parseFloat(tempString);
            if((!isNaN(toInt)) && (pattern0.test(_tText.text)))
            {
               if(toInt > this._nNumberMax)
               {
                  _tText.text = this._nNumberMax + "";
               }
            }
         }
         if(this._lastTextOnInput != _tText.text)
         {
            LogFrame.log(LogTypeEnum.KEYBOARD_INPUT,new KeyboardInput(customUnicName,_strReplace.substr(0,_tText.text.length)));
         }
         this._lastTextOnInput = _tText.text;
         if(this._timerFormatDelay)
         {
            this._timerFormatDelay.reset();
            this._timerFormatDelay.start();
         }
         this._nSelectionStart = 0;
         this._nSelectionEnd = 0;
         Berilia.getInstance().handler.process(new ChangeMessage(InteractiveObject(this)));
      }
      
      public function removeSpace(spaced:String) : String {
         var str2:String = null;
         var tmp:String = spaced;
         var pattern1:RegExp = new RegExp(regSpace);
         do
         {
            str2 = tmp;
            tmp = str2.replace(pattern1,"");
         }
         while(str2 != tmp);
         
         do
         {
            str2 = tmp;
            tmp = str2.replace(this._numberSeparator,"");
         }
         while(str2 != tmp);
         
         return str2;
      }
      
		private function onTimerFormatDelay(e:TimerEvent) : void {
		   var newStringWithSpaces:String = null;
		   this._timerFormatDelay.removeEventListener(TimerEvent.TIMER,this.onTimerFormatDelay);
		   var caret:int = caretIndex;
		   var startText:String = _tText.text;
		   var i:int = 0;
		   this._nSelectionStart = _tText.selectionBeginIndex;
		   this._nSelectionEnd = _tText.selectionEndIndex;
		   i = 0;
		   while(i < _tText.length - 1)
		   {
			  if((startText.charAt(i) == this._numberSeparator) || (startText.charAt(i) == " "))
			  {
				 if(i < caret)
				 {
					caret--;
				 }
				 if(i < this._nSelectionStart)
				 {
					this._nSelectionStart--;
				 }
				 if(i < this._nSelectionEnd)
				 {
					this._nSelectionEnd--;
				 }
			  }
			  i++;
		   }
		   var tempString:String = this.removeSpace(startText);
		   var toInt:Number = parseFloat(tempString);
		   if((toInt) && (!isNaN(toInt)))
		   {
			  newStringWithSpaces = StringUtils.formateIntToString(toInt);
			  i = 0;
			  while(i < newStringWithSpaces.length - 1)
			  {
				 if(newStringWithSpaces.charAt(i) == this._numberSeparator)
				 {
					if(i < caret)
					{
					   caret++;
					}
					if(i < this._nSelectionStart)
					{
					   this._nSelectionStart++;
					}
					if(i < this._nSelectionEnd)
					{
					   this._nSelectionEnd++;
					}
				 }
				 i++;
			  }
			  super.text = newStringWithSpaces;
			  caretIndex = caret;
		   }
		   if(this._nSelectionStart != this._nSelectionEnd)
		   {
			  _tText.setSelection(this._nSelectionStart,this._nSelectionEnd);
		   }
		}
   }
}
