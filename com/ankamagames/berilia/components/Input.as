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
      
      public function set maxChars(param1:uint) : void {
         this._nMaxChars = param1;
         _tText.maxChars = this._nMaxChars;
      }
      
      public function set numberMax(param1:uint) : void {
         this._nNumberMax = param1;
      }
      
      public function get password() : Boolean {
         return this._bPassword;
      }
      
      public function set password(param1:Boolean) : void {
         this._bPassword = param1;
         if(this._bPassword)
         {
            _tText.displayAsPassword = true;
         }
      }
      
      public function get numberAutoFormat() : Boolean {
         return this._bNumberAutoFormat;
      }
      
      public function set numberAutoFormat(param1:Boolean) : void {
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
      
      public function get numberSeparator() : String {
         return this._numberSeparator;
      }
      
      public function set numberSeparator(param1:String) : void {
         this._numberSeparator = param1;
      }
      
      public function get restrictChars() : String {
         return this._sRestrictChars;
      }
      
      public function set restrictChars(param1:String) : void {
         this._sRestrictChars = param1;
         _tText.restrict = this._sRestrictChars;
      }
      
      public function get haveFocus() : Boolean {
         return Berilia.getInstance().docMain.stage.focus == _tText;
      }
      
      override public function set text(param1:String) : void {
         super.text = param1;
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
      
      override public function process(param1:Message) : Boolean {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
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
         return super.process(param1);
      }
      
      public function setSelection(param1:int, param2:int) : void {
         this._nSelectionStart = param1;
         this._nSelectionEnd = param2;
         _tText.setSelection(this._nSelectionStart,this._nSelectionEnd);
      }
      
      private function onTextChange(param1:Event) : void {
         var _loc2_:RegExp = null;
         var _loc3_:String = null;
         var _loc4_:* = NaN;
         if(this._nNumberMax > 0)
         {
            _loc2_ = new RegExp("[0-9 ]+","g");
            _loc3_ = this.removeSpace(_tText.text);
            _loc4_ = parseFloat(_loc3_);
            if(!isNaN(_loc4_) && (_loc2_.test(_tText.text)))
            {
               if(_loc4_ > this._nNumberMax)
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
      
      public function removeSpace(param1:String) : String {
         var _loc2_:String = null;
         var _loc3_:String = param1;
         var _loc4_:RegExp = new RegExp(regSpace);
         do
         {
               _loc2_ = _loc3_;
               _loc3_ = _loc2_.replace(_loc4_,"");
            }while(_loc2_ != _loc3_);
            
            do
            {
                  _loc2_ = _loc3_;
                  _loc3_ = _loc2_.replace(this._numberSeparator,"");
               }while(_loc2_ != _loc3_);
               
               return _loc2_;
            }
            
            private function onTimerFormatDelay(param1:TimerEvent) : void {
               var _loc7_:String = null;
               this._timerFormatDelay.removeEventListener(TimerEvent.TIMER,this.onTimerFormatDelay);
               var _loc2_:int = caretIndex;
               var _loc3_:String = _tText.text;
               var _loc4_:* = 0;
               this._nSelectionStart = _tText.selectionBeginIndex;
               this._nSelectionEnd = _tText.selectionEndIndex;
               _loc4_ = 0;
               while(_loc4_ < _tText.length-1)
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
                  while(_loc4_ < _loc7_.length-1)
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
