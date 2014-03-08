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
      
      public static function setPasswordHash(hash:String, len:uint) : void {
         _passwordHash = hash;
         _passwordLength = len;
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
      
      public function process(msg:Message) : Boolean {
         var input:Input = null;
         var commonMod:Object = null;
         switch(true)
         {
            case msg is ChangeMessage:
               input = ChangeMessage(msg).target as Input;
               if((input) && (this._cancelTarget[input.textfield]))
               {
                  this._cancelTarget[Input(ChangeMessage(msg).target).textfield] = false;
                  commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                  if(input.getUi().uiModule.trusted)
                  {
                     commonMod.openPopup(I18n.getUiText("ui.popup.warning"),I18n.getUiText("ui.popup.warning.password"),[I18n.getUiText("ui.common.ok")]);
                  }
                  else
                  {
                     commonMod.openPopup(I18n.getUiText("ui.popup.warning.pishing.title"),I18n.getUiText("ui.popup.warning.pishing.content"),[I18n.getUiText("ui.common.ok")]);
                     input.getUi().uiModule.enable = false;
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
      
      private function onTextInput(te:TextEvent) : void {
         var len:uint = 0;
         this._globalBuffer = this._globalBuffer + te.text;
         if(!(((te.target is TextField && TextField(te.target).parent is Input) && (Input(TextField(te.target).parent).getUi())) && (!Input(TextField(te.target).parent).getUi().uiModule.trusted)))
         {
            return;
         }
         this._globalModBuffer = this._globalModBuffer + te.text;
         if(!this._advancedInputBufferRef[te.target])
         {
            this._advancedInputBufferRef[te.target] = "";
         }
         var inputBuffer:String = this._advancedInputBufferRef[te.target];
         var oldBuffer:String = inputBuffer;
         inputBuffer = inputBuffer + te.text;
         if(inputBuffer.length >= _passwordLength)
         {
            len = inputBuffer.length - _passwordLength + 1;
            if(this.detectHash(inputBuffer,_passwordHash,_passwordLength))
            {
               te.preventDefault();
               this._cancelTarget[te.target] = true;
               this._advancedInputBufferRef[te.target] = oldBuffer;
               return;
            }
            inputBuffer = inputBuffer.substr(len);
         }
         if(this._globalBuffer.length >= _passwordLength)
         {
            len = this._globalBuffer.length - _passwordLength + 1;
            if(this.detectHash(this._globalBuffer,_passwordHash,_passwordLength))
            {
               te.preventDefault();
               this._cancelTarget[te.target] = true;
               return;
            }
            this._globalBuffer = this._globalBuffer.substr(len);
         }
         if(this._globalModBuffer.length >= _passwordLength)
         {
            len = this._globalModBuffer.length - _passwordLength + 1;
            if(this.detectHash(this._globalModBuffer,_passwordHash,_passwordLength))
            {
               te.preventDefault();
               this._cancelTarget[te.target] = true;
               return;
            }
            this._globalModBuffer = this._globalModBuffer.substr(len);
         }
         this._advancedInputBufferRef[te.target] = inputBuffer;
      }
      
      private function detectHash(input:String, hash:String, originalLength:uint) : Boolean {
         var len:uint = input.length - originalLength + 1;
         var i:uint = 0;
         while(i < len)
         {
            if(MD5.hash(input.substr(i,originalLength).toUpperCase()) == hash)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      protected function onChange(e:Event) : void {
         var len:uint = 0;
         var upperBuffer:String = null;
         var i:uint = 0;
         var ts:uint = getTimer();
         var tf:TextField = e.target as TextField;
         if(!tf)
         {
            return;
         }
         if(!this._inputBufferRef[e.target])
         {
            this._inputBufferRef[e.target] = "";
         }
         var inputBuffer:String = this._inputBufferRef[e.target];
         if(inputBuffer.length >= _passwordLength)
         {
            if(tf.text.substring(0,inputBuffer.length) == inputBuffer)
            {
               inputBuffer = tf.text.substring(inputBuffer.length - _passwordLength);
            }
            else
            {
               if(inputBuffer.substring(0,tf.text.length) == tf.text)
               {
                  inputBuffer = inputBuffer.substring(tf.text.length - _passwordLength);
               }
               else
               {
                  inputBuffer = tf.text;
               }
            }
         }
         else
         {
            inputBuffer = tf.text;
         }
         if(inputBuffer.length >= _passwordLength)
         {
            len = inputBuffer.length - _passwordLength + 1;
            upperBuffer = inputBuffer.toUpperCase();
            i = 0;
            while(i < len)
            {
               if(MD5.hash(upperBuffer.substr(i,_passwordLength)) == _passwordHash)
               {
                  tf.text = tf.text.split(inputBuffer.substr(i,_passwordLength)).join("");
                  this._cancelTarget[tf] = true;
                  break;
               }
               i++;
            }
         }
         inputBuffer = tf.text;
         this._inputBufferRef[e.target] = inputBuffer;
      }
   }
}
