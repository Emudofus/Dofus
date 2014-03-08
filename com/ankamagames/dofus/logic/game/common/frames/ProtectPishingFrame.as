package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import flash.events.TextEvent;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.messages.ChangeMessage;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.text.TextField;
   import by.blooddy.crypto.MD5;
   import flash.utils.getTimer;
   
   public class ProtectPishingFrame extends Object implements Frame
   {
      
      public function ProtectPishingFrame() {
         this._inputBufferRef = new Dictionary(true);
         this._advancedInputBufferRef = new Dictionary(true);
         this._cancelTarget = new Dictionary(true);
         super();
      }
      
      private static var _passwordHash:String;
      
      private static var _passwordLength:uint;
      
      public static function setPasswordHash(param1:String, param2:uint) : void {
         _passwordHash = param1;
         _passwordLength = param2;
      }
      
      private var _inputBufferRef:Dictionary;
      
      private var _advancedInputBufferRef:Dictionary;
      
      private var _cancelTarget:Dictionary;
      
      private var _globalModBuffer:String;
      
      private var _globalBuffer:String;
      
      public function pushed() : Boolean {
         if((_passwordHash) && (_passwordLength))
         {
            StageShareManager.stage.addEventListener(Event.CHANGE,this.onChange);
            StageShareManager.stage.addEventListener(TextEvent.TEXT_INPUT,this.onTextInput);
         }
         return !(_passwordLength == 0);
      }
      
      public function pulled() : Boolean {
         if((_passwordHash) && (_passwordLength))
         {
            StageShareManager.stage.removeEventListener(Event.CHANGE,this.onChange);
            StageShareManager.stage.removeEventListener(TextEvent.TEXT_INPUT,this.onTextInput);
         }
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:Input = null;
         var _loc3_:Object = null;
         switch(true)
         {
            case param1 is ChangeMessage:
               _loc2_ = ChangeMessage(param1).target as Input;
               if((_loc2_) && (this._cancelTarget[_loc2_.textfield]))
               {
                  this._cancelTarget[Input(ChangeMessage(param1).target).textfield] = false;
                  _loc3_ = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                  if(_loc2_.getUi().uiModule.trusted)
                  {
                     _loc3_.openPopup(I18n.getUiText("ui.popup.warning"),I18n.getUiText("ui.popup.warning.password"),[I18n.getUiText("ui.common.ok")]);
                  }
                  else
                  {
                     _loc3_.openPopup(I18n.getUiText("ui.popup.warning.pishing.title"),I18n.getUiText("ui.popup.warning.pishing.content"),[I18n.getUiText("ui.common.ok")]);
                     _loc2_.getUi().uiModule.enable = false;
                  }
                  return true;
               }
               break;
         }
         return false;
      }
      
      public function get priority() : int {
         return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
      }
      
      private function onTextInput(param1:TextEvent) : void {
         var _loc4_:uint = 0;
         this._globalBuffer = this._globalBuffer + param1.text;
         if(!(((param1.target is TextField && TextField(param1.target).parent is Input) && (Input(TextField(param1.target).parent).getUi())) && (!Input(TextField(param1.target).parent).getUi().uiModule.trusted)))
         {
            return;
         }
         this._globalModBuffer = this._globalModBuffer + param1.text;
         if(!this._advancedInputBufferRef[param1.target])
         {
            this._advancedInputBufferRef[param1.target] = "";
         }
         var _loc2_:String = this._advancedInputBufferRef[param1.target];
         var _loc3_:String = _loc2_;
         _loc2_ = _loc2_ + param1.text;
         if(_loc2_.length >= _passwordLength)
         {
            _loc4_ = _loc2_.length - _passwordLength + 1;
            if(this.detectHash(_loc2_,_passwordHash,_passwordLength))
            {
               param1.preventDefault();
               this._cancelTarget[param1.target] = true;
               this._advancedInputBufferRef[param1.target] = _loc3_;
               return;
            }
            _loc2_ = _loc2_.substr(_loc4_);
         }
         if(this._globalBuffer.length >= _passwordLength)
         {
            _loc4_ = this._globalBuffer.length - _passwordLength + 1;
            if(this.detectHash(this._globalBuffer,_passwordHash,_passwordLength))
            {
               param1.preventDefault();
               this._cancelTarget[param1.target] = true;
               return;
            }
            this._globalBuffer = this._globalBuffer.substr(_loc4_);
         }
         if(this._globalModBuffer.length >= _passwordLength)
         {
            _loc4_ = this._globalModBuffer.length - _passwordLength + 1;
            if(this.detectHash(this._globalModBuffer,_passwordHash,_passwordLength))
            {
               param1.preventDefault();
               this._cancelTarget[param1.target] = true;
               return;
            }
            this._globalModBuffer = this._globalModBuffer.substr(_loc4_);
         }
         this._advancedInputBufferRef[param1.target] = _loc2_;
      }
      
      private function detectHash(param1:String, param2:String, param3:uint) : Boolean {
         var _loc4_:uint = param1.length - param3 + 1;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            if(MD5.hash(param1.substr(_loc5_,param3).toUpperCase()) == param2)
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
      
      protected function onChange(param1:Event) : void {
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         var _loc2_:uint = getTimer();
         var _loc3_:TextField = param1.target as TextField;
         if(!_loc3_)
         {
            return;
         }
         if(!this._inputBufferRef[param1.target])
         {
            this._inputBufferRef[param1.target] = "";
         }
         var _loc4_:String = this._inputBufferRef[param1.target];
         if(_loc4_.length >= _passwordLength)
         {
            if(_loc3_.text.substring(0,_loc4_.length) == _loc4_)
            {
               _loc4_ = _loc3_.text.substring(_loc4_.length - _passwordLength);
            }
            else
            {
               if(_loc4_.substring(0,_loc3_.text.length) == _loc3_.text)
               {
                  _loc4_ = _loc4_.substring(_loc3_.text.length - _passwordLength);
               }
               else
               {
                  _loc4_ = _loc3_.text;
               }
            }
         }
         else
         {
            _loc4_ = _loc3_.text;
         }
         if(_loc4_.length >= _passwordLength)
         {
            _loc5_ = _loc4_.length - _passwordLength + 1;
            _loc6_ = _loc4_.toUpperCase();
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               if(MD5.hash(_loc6_.substr(_loc7_,_passwordLength)) == _passwordHash)
               {
                  _loc3_.text = _loc3_.text.split(_loc4_.substr(_loc7_,_passwordLength)).join("");
                  this._cancelTarget[_loc3_] = true;
                  break;
               }
               _loc7_++;
            }
         }
         _loc4_ = _loc3_.text;
         this._inputBufferRef[param1.target] = _loc4_;
      }
   }
}
