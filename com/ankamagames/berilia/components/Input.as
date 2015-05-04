package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.UIComponent;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import com.ankamagames.berilia.Berilia;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.events.KeyboardEvent;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import flash.ui.Keyboard;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.jerakine.replay.LogFrame;
   import com.ankamagames.jerakine.replay.LogTypeEnum;
   import com.ankamagames.jerakine.replay.KeyboardInput;
   import com.ankamagames.berilia.components.messages.ChangeMessage;
   import flash.display.InteractiveObject;
   import com.ankamagames.jerakine.data.XmlConfig;
   import flash.text.TextFieldType;
   
   public class Input extends Label implements UIComponent
   {
      
      public function Input()
      {
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
         _tText.addEventListener(TextEvent.TEXT_INPUT,this.onTextInput);
         _tText.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         _tText.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,1,true);
         this._inputHistory = new Vector.<InputEntry>(0);
         this._currentHyperlinkCodes = new Vector.<String>(0);
      }
      
      private static const UNDO_MAX_SIZE:uint = 10;
      
      private static const _strReplace:String = "NoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLog";
      
      private static var regSpace:RegExp = new RegExp("\\s","g");
      
      public static var numberStrSeparator:String;
      
      private var _nMaxChars:int;
      
      private var _nNumberMax:uint;
      
      private var _bPassword:Boolean = false;
      
      private var _sRestrictChars:String;
      
      private var _bNumberAutoFormat:Boolean = false;
      
      private var _numberSeparator:String = " ";
      
      private var _nSelectionStart:int;
      
      private var _nSelectionEnd:int;
      
      private var _isNumericInput:Boolean;
      
      private var _lastTextOnInput:String;
      
      public var imeActive:Boolean;
      
      private var _timerFormatDelay:Timer;
      
      private var _sendingText:Boolean;
      
      private var _chatHistoryText:Boolean;
      
      private var _inputHistory:Vector.<InputEntry>;
      
      private var _historyEntryHyperlinkCodes:Vector.<String>;
      
      private var _currentHyperlinkCodes:Vector.<String>;
      
      private var _historyCurrentIndex:int;
      
      private var _undoing:Boolean;
      
      private var _redoing:Boolean;
      
      private var _deleting:Boolean;
      
      public var focusEventHandlerPriority:Boolean = true;
      
      public function get lastTextOnInput() : String
      {
         return this._lastTextOnInput;
      }
      
      public function get maxChars() : uint
      {
         return this._nMaxChars;
      }
      
      public function set maxChars(param1:uint) : void
      {
         this._nMaxChars = param1;
         _tText.maxChars = this._nMaxChars;
      }
      
      public function set numberMax(param1:uint) : void
      {
         this._nNumberMax = param1;
      }
      
      public function get password() : Boolean
      {
         return this._bPassword;
      }
      
      public function set password(param1:Boolean) : void
      {
         this._bPassword = param1;
         if(this._bPassword)
         {
            _tText.displayAsPassword = true;
         }
      }
      
      public function get numberAutoFormat() : Boolean
      {
         return this._bNumberAutoFormat;
      }
      
      public function set numberAutoFormat(param1:Boolean) : void
      {
         this._bNumberAutoFormat = param1;
         if(!param1)
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
      
      public function get numberSeparator() : String
      {
         return this._numberSeparator;
      }
      
      public function set numberSeparator(param1:String) : void
      {
         this._numberSeparator = param1;
      }
      
      public function get restrictChars() : String
      {
         return this._sRestrictChars;
      }
      
      public function set restrictChars(param1:String) : void
      {
         this._sRestrictChars = param1;
         _tText.restrict = this._sRestrictChars;
         this._isNumericInput = this._sRestrictChars == "0-9" || this._sRestrictChars == "0-9  ";
      }
      
      public function get haveFocus() : Boolean
      {
         return Berilia.getInstance().docMain.stage.focus == _tText;
      }
      
      override public function set text(param1:String) : void
      {
         super.text = param1;
         this.onTextChange(null);
      }
      
      override public function appendText(param1:String, param2:String = null) : void
      {
         super.appendText(param1,param2);
         this.checkClearHistory();
         this._undoing = this._redoing = this._deleting = this._chatHistoryText = false;
         this.onTextChange(null);
      }
      
      override public function remove() : void
      {
         _tText.removeEventListener(Event.CHANGE,this.onTextChange);
         _tText.removeEventListener(TextEvent.TEXT_INPUT,this.onTextInput);
         _tText.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         _tText.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this._inputHistory.length = 0;
         this._currentHyperlinkCodes.length = 0;
         if(this._timerFormatDelay)
         {
            this._timerFormatDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerFormatDelay);
         }
         super.remove();
      }
      
      override public function free() : void
      {
         if(this._timerFormatDelay)
         {
            this._timerFormatDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerFormatDelay);
         }
         super.free();
      }
      
      private function undo() : void
      {
         if((this._deleting) && _tText.text.length == 0)
         {
            this._inputHistory.pop();
         }
         if(this._chatHistoryText)
         {
            return;
         }
         if(this._inputHistory.length > 0)
         {
            if(!this._undoing && !this._redoing)
            {
               this._historyCurrentIndex = this._inputHistory.length - 1;
            }
            else if(this._historyCurrentIndex > 0)
            {
               this._historyCurrentIndex--;
            }
            else
            {
               this._historyCurrentIndex = -1;
               _tText.text = this._isNumericInput?"0":"";
               this._historyEntryHyperlinkCodes = null;
               this._undoing = true;
               this._redoing = false;
               this._deleting = false;
               this.onTextChange(null);
               return;
            }
            
            if(this._historyCurrentIndex + 1 > this._inputHistory.length - 1 && !this.wasHistoryText())
            {
               this.addHistory(_tText.text);
            }
            _tText.text = this._inputHistory[this._historyCurrentIndex].text;
            this._historyEntryHyperlinkCodes = this._inputHistory[this._historyCurrentIndex].hyperlinkCodes;
            this._currentHyperlinkCodes.length = 0;
         }
         else
         {
            if(_tText.text.length > 0)
            {
               this.addHistory(_tText.text);
            }
            this._historyCurrentIndex = -1;
            _tText.text = this._isNumericInput?"0":"";
            this._historyEntryHyperlinkCodes = null;
         }
         caretIndex = -1;
         this._undoing = true;
         this._redoing = false;
         this._deleting = false;
         this.onTextChange(null);
      }
      
      private function redo() : void
      {
         if(this._chatHistoryText)
         {
            return;
         }
         if(this._inputHistory.length > 0 && this._historyCurrentIndex < this._inputHistory.length - 1)
         {
            _tText.text = this._inputHistory[++this._historyCurrentIndex].text;
            this._historyEntryHyperlinkCodes = this._inputHistory[this._historyCurrentIndex].hyperlinkCodes;
            this._currentHyperlinkCodes.length = 0;
            caretIndex = -1;
            this._redoing = true;
            this._undoing = false;
            this._deleting = false;
            this.onTextChange(null);
         }
      }
      
      private function addHistory(param1:String) : void
      {
         var _loc2_:Vector.<String> = this.getHyperLinkCodes();
         var _loc3_:InputEntry = new InputEntry(param1,_loc2_);
         if(this._inputHistory.length < UNDO_MAX_SIZE)
         {
            this._inputHistory.push(_loc3_);
         }
         else
         {
            this._inputHistory.shift();
            this._inputHistory.push(_loc3_);
            if(this._historyCurrentIndex > 0)
            {
               this._historyCurrentIndex--;
            }
         }
         this._historyEntryHyperlinkCodes = null;
         this._currentHyperlinkCodes.length = 0;
      }
      
      private function checkClearHistory() : Boolean
      {
         var _loc1_:* = 0;
         if(((this._undoing) || (this._redoing)) && (this.wasHistoryText()))
         {
            _loc1_ = this._historyCurrentIndex + 1;
            this._inputHistory.splice(_loc1_,this._inputHistory.length - _loc1_);
            this._historyCurrentIndex = this._inputHistory.length - 1;
            return true;
         }
         return false;
      }
      
      private function wasHistoryText() : Boolean
      {
         return this._inputHistory.length > 0 && (!(this._historyCurrentIndex == -1) && this._historyCurrentIndex <= this._inputHistory.length - 1 && this._lastTextOnInput == this._inputHistory[this._historyCurrentIndex].text || this._historyCurrentIndex == -1 && (this._lastTextOnInput == "" || this._lastTextOnInput == "0"));
      }
      
      private function deletePreviousWord() : void
      {
         var _loc1_:Array = _tText.text.split(" ");
         _loc1_.pop();
         _tText.text = _loc1_.join(" ");
         if(this.checkClearHistory())
         {
            this._inputHistory.pop();
         }
         this._undoing = this._deleting = this._redoing = this._chatHistoryText = false;
         this.onTextChange(null);
      }
      
      override public function focus() : void
      {
         Berilia.getInstance().docMain.stage.focus = _tText;
         FocusHandler.getInstance().setFocus(_tText);
      }
      
      public function blur() : void
      {
         Berilia.getInstance().docMain.stage.focus = null;
         FocusHandler.getInstance().setFocus(null);
      }
      
      override public function process(param1:Message) : Boolean
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:KeyboardKeyDownMessage = null;
         if(param1 is MouseClickMessage && MouseClickMessage(param1).target == this)
         {
            this.focus();
         }
         var _loc2_:int = parseInt(text.split(" ").join("").split(" ").join("").split(this._numberSeparator).join(""));
         if(param1 is MouseWheelMessage && !disabled && _loc2_.toString(10) == text.split(" ").join("").split(" ").join("").split(this._numberSeparator).join(""))
         {
            _loc3_ = (param1 as MouseWheelMessage).mouseEvent.delta > 0?1:-1;
            _loc4_ = Math.abs(_loc2_) > 99?Math.pow(10,(_loc2_ + _loc3_).toString(10).length - 2):1;
            if(ShortcutsFrame.ctrlKey)
            {
               _loc4_ = 1;
            }
            _loc5_ = _loc2_ + _loc3_ * _loc4_;
            _loc5_ = _loc5_ < 0?0:_loc5_;
            if(this._nNumberMax > 0 && _loc5_ > this._nNumberMax)
            {
               _loc5_ = this._nNumberMax;
            }
            this.text = _loc5_.toString();
         }
         if(!this.password && (this.haveFocus))
         {
            if(param1 is KeyboardKeyDownMessage)
            {
               _loc6_ = param1 as KeyboardKeyDownMessage;
               if((_loc6_.keyboardEvent.ctrlKey) && _loc6_.keyboardEvent.keyCode == Keyboard.Z && !_loc6_.keyboardEvent.shiftKey)
               {
                  this.undo();
               }
               else if((_loc6_.keyboardEvent.shiftKey) && (_loc6_.keyboardEvent.ctrlKey) && _loc6_.keyboardEvent.keyCode == Keyboard.Z)
               {
                  this.redo();
               }
               else if(!(_loc6_.keyboardEvent.keyCode == Keyboard.ENTER) && !(_loc6_.keyboardEvent.keyCode == Keyboard.BACKSPACE) && !_loc6_.keyboardEvent.ctrlKey && !((_loc6_.keyboardEvent.shiftKey) && _loc6_.keyboardEvent.keyCode == Keyboard.SHIFT) && !(_loc6_.keyboardEvent.keyCode == Keyboard.UP) && !(_loc6_.keyboardEvent.keyCode == Keyboard.DOWN))
               {
                  this._undoing = this._deleting = this._redoing = this._chatHistoryText = false;
               }
               
               
            }
         }
         return super.process(param1);
      }
      
      public function setSelection(param1:int, param2:int) : void
      {
         this._nSelectionStart = param1;
         this._nSelectionEnd = param2;
         _tText.setSelection(this._nSelectionStart,this._nSelectionEnd);
      }
      
      public function addHyperLinkCode(param1:String) : void
      {
         this._currentHyperlinkCodes.push(param1);
      }
      
      public function getHyperLinkCodes() : Vector.<String>
      {
         var _loc1_:Vector.<String> = null;
         if(!this._historyEntryHyperlinkCodes)
         {
            _loc1_ = this._currentHyperlinkCodes.concat();
         }
         else
         {
            _loc1_ = this._historyEntryHyperlinkCodes.concat(this._currentHyperlinkCodes);
         }
         return _loc1_;
      }
      
      private function onTextChange(param1:Event) : void
      {
         var _loc3_:RegExp = null;
         var _loc4_:String = null;
         var _loc5_:* = NaN;
         if(this._nNumberMax > 0)
         {
            _loc3_ = new RegExp("[0-9 ]+","g");
            _loc4_ = this.removeSpace(_tText.text);
            _loc5_ = parseFloat(_loc4_);
            if(!isNaN(_loc5_) && (_loc3_.test(_tText.text)))
            {
               if(_loc5_ > this._nNumberMax)
               {
                  _tText.text = this._nNumberMax + "";
               }
            }
         }
         var _loc2_:* = false;
         if(this._lastTextOnInput != null)
         {
            if(this._isNumericInput)
            {
               _loc2_ = StringUtils.kamasToString(StringUtils.stringToKamas(this._lastTextOnInput,""),"") == StringUtils.kamasToString(StringUtils.stringToKamas(_tText.text,""),"");
            }
            else
            {
               _loc2_ = this._lastTextOnInput == _tText.text;
            }
         }
         if(!_loc2_)
         {
            LogFrame.log(LogTypeEnum.KEYBOARD_INPUT,new KeyboardInput(customUnicName,_strReplace.substr(0,_tText.text.length)));
            if(!this._sendingText && !this._chatHistoryText)
            {
               this.checkClearHistory();
               if((this._lastTextOnInput && !this._deleting && !this._redoing) && (!this._undoing) && this._lastTextOnInput.length > _tText.text.length)
               {
                  this.addHistory(this._lastTextOnInput);
               }
               if((this._deleting) && _tText.text.length == 0)
               {
                  this.addHistory(this._isNumericInput?"0":"");
                  this._historyCurrentIndex = this._inputHistory.length - 1;
                  this._historyEntryHyperlinkCodes = null;
               }
            }
         }
         this._lastTextOnInput = _tText.text;
         this._sendingText = false;
         if(this._timerFormatDelay)
         {
            this._timerFormatDelay.reset();
            this._timerFormatDelay.start();
         }
         this._nSelectionStart = 0;
         this._nSelectionEnd = 0;
         Berilia.getInstance().handler.process(new ChangeMessage(InteractiveObject(this)));
      }
      
      private function onTextInput(param1:TextEvent) : void
      {
         if(param1.text.length > 1)
         {
            this.checkClearHistory();
            if(!this._undoing && !this._redoing && !this._deleting && !(this._lastTextOnInput == null) && _tText.text.length + param1.text.length > this._lastTextOnInput.length)
            {
               this.addHistory(this._lastTextOnInput);
            }
            this._undoing = this._deleting = this._redoing = this._chatHistoryText = false;
         }
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER && !(XmlConfig.getInstance().getEntry("config.lang.current") == "ja") && !((param1.altKey) || (param1.shiftKey) || (param1.ctrlKey) || (param1.hasOwnProperty("controlKey")) && (param1.controlKey) || (param1.hasOwnProperty("commandKey")) && (param1.commandKey)))
         {
            this._sendingText = true;
            this._inputHistory.length = 0;
            this._historyCurrentIndex = 0;
         }
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(!param1.altKey && !param1.shiftKey && (param1.ctrlKey) && param1.keyCode == Keyboard.Y)
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            this.redo();
         }
         else if(!param1.altKey && !param1.shiftKey && (param1.ctrlKey) && param1.keyCode == Keyboard.BACKSPACE)
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            this.deletePreviousWord();
         }
         else if(param1.keyCode == Keyboard.UP || param1.keyCode == Keyboard.DOWN)
         {
            this._chatHistoryText = true;
            this._undoing = this._redoing = this._deleting = false;
            this._inputHistory.length = 0;
            this._historyCurrentIndex = 0;
         }
         else if(param1.keyCode == Keyboard.BACKSPACE)
         {
            this._chatHistoryText = false;
            if(!this._deleting)
            {
               this._deleting = true;
               this._undoing = this._redoing = false;
               if(this._lastTextOnInput)
               {
                  this.addHistory(this._lastTextOnInput);
               }
            }
         }
         
         
         
      }
      
      public function removeSpace(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = param1;
         var _loc4_:RegExp = new RegExp(regSpace);
         do
         {
            _loc2_ = _loc3_;
            _loc3_ = _loc2_.replace(_loc4_,"");
         }
         while(_loc2_ != _loc3_);
         
         do
         {
            _loc2_ = _loc3_;
            _loc3_ = _loc2_.replace(this._numberSeparator,"");
         }
         while(_loc2_ != _loc3_);
         
         return _loc2_;
      }
      
      private function onTimerFormatDelay(param1:TimerEvent) : void
      {
         var _loc7_:String = null;
         this._timerFormatDelay.removeEventListener(TimerEvent.TIMER,this.onTimerFormatDelay);
         var _loc2_:int = caretIndex;
         var _loc3_:String = _tText.text;
         var _loc4_:* = 0;
         this._nSelectionStart = _tText.selectionBeginIndex;
         this._nSelectionEnd = _tText.selectionEndIndex;
         _loc4_ = 0;
         while(_loc4_ < _tText.length - 1)
         {
            if(_loc3_.charAt(_loc4_) == this._numberSeparator || _loc3_.charAt(_loc4_) == " ")
            {
               if(_loc4_ < _loc2_)
               {
                  _loc2_--;
               }
               if(_loc4_ < this._nSelectionStart)
               {
                  this._nSelectionStart--;
               }
               if(_loc4_ < this._nSelectionEnd)
               {
                  this._nSelectionEnd--;
               }
            }
            _loc4_++;
         }
         var _loc5_:String = this.removeSpace(_loc3_);
         var _loc6_:Number = parseFloat(_loc5_);
         if((_loc6_) && !isNaN(_loc6_))
         {
            _loc7_ = StringUtils.formateIntToString(_loc6_);
            _loc4_ = 0;
            while(_loc4_ < _loc7_.length - 1)
            {
               if(_loc7_.charAt(_loc4_) == this._numberSeparator)
               {
                  if(_loc4_ < _loc2_)
                  {
                     _loc2_++;
                  }
                  if(_loc4_ < this._nSelectionStart)
                  {
                     this._nSelectionStart++;
                  }
                  if(_loc4_ < this._nSelectionEnd)
                  {
                     this._nSelectionEnd++;
                  }
               }
               _loc4_++;
            }
            super.text = _loc7_;
            caretIndex = _loc2_;
         }
         if(this._nSelectionStart != this._nSelectionEnd)
         {
            _tText.setSelection(this._nSelectionStart,this._nSelectionEnd);
         }
      }
   }
}
class InputEntry extends Object
{
   
   function InputEntry(param1:String, param2:Vector.<String>)
   {
      super();
      this._text = param1;
      this._hyperlinkCodes = param2;
   }
   
   private var _text:String;
   
   private var _hyperlinkCodes:Vector.<String>;
   
   public function get text() : String
   {
      return this._text;
   }
   
   public function get hyperlinkCodes() : Vector.<String>
   {
      return this._hyperlinkCodes;
   }
}
