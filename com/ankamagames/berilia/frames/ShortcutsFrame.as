package com.ankamagames.berilia.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardMessage;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.berilia.Berilia;
   import flash.system.IME;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.types.shortcut.Bind;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.text.TextFieldType;
   import com.ankamagames.jerakine.replay.LogFrame;
   import com.ankamagames.jerakine.replay.LogTypeEnum;
   import com.ankamagames.jerakine.replay.KeyboardShortcut;
   import flash.events.Event;
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   
   public class ShortcutsFrame extends Object implements Frame
   {
      
      public function ShortcutsFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ShortcutsFrame));
      
      public static var shiftKey:Boolean = false;
      
      public static var ctrlKey:Boolean = false;
      
      public static var altKey:Boolean = false;
      
      public static var shortcutsEnabled:Boolean = true;
      
      private var _lastCtrlKey:Boolean = false;
      
      private var _isProcessingDirectInteraction:Boolean;
      
      private var _heldShortcuts:Vector.<String>;
      
      public function get isProcessingDirectInteraction() : Boolean {
         return this._isProcessingDirectInteraction;
      }
      
      public function get heldShortcuts() : Vector.<String> {
         return this._heldShortcuts;
      }
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function process(msg:Message) : Boolean {
         var kdmsg:KeyboardKeyDownMessage = null;
         var s:Shortcut = null;
         var kumsg:KeyboardKeyUpMessage = null;
         this._isProcessingDirectInteraction = false;
         if(!shortcutsEnabled)
         {
            return false;
         }
         switch(true)
         {
            case msg is KeyboardKeyDownMessage:
               kdmsg = KeyboardKeyDownMessage(msg);
               shiftKey = kdmsg.keyboardEvent.shiftKey;
               ctrlKey = kdmsg.keyboardEvent.ctrlKey;
               altKey = kdmsg.keyboardEvent.altKey;
               this._lastCtrlKey = false;
               s = this.getShortcut(kdmsg);
               if((s) && (s.holdKeys) && (this._heldShortcuts.indexOf(s.defaultBind.targetedShortcut) == -1))
               {
                  this.handleMessage(kdmsg);
                  this._heldShortcuts.push(s.defaultBind.targetedShortcut);
               }
               return false;
            case msg is KeyboardKeyUpMessage:
               kumsg = KeyboardKeyUpMessage(msg);
               shiftKey = kumsg.keyboardEvent.shiftKey;
               ctrlKey = kumsg.keyboardEvent.ctrlKey;
               altKey = kumsg.keyboardEvent.altKey;
               return this.handleMessage(kumsg);
         }
      }
      
      private function handleMessage(pKeyboardMessage:KeyboardMessage) : Boolean {
         var imeActive:* = false;
         var sh:Shortcut = null;
         var tf:TextField = null;
         var focusAsTextField:TextField = null;
         var heldShortcutIndex:* = 0;
         var keyCode:int = pKeyboardMessage.keyboardEvent.keyCode;
         if(keyCode == Keyboard.CONTROL)
         {
            this._lastCtrlKey = true;
         }
         else
         {
            if(this._lastCtrlKey)
            {
               this._lastCtrlKey = false;
               return false;
            }
         }
         this._isProcessingDirectInteraction = true;
         var sShortcut:String = BindsManager.getInstance().getShortcutString(pKeyboardMessage.keyboardEvent.keyCode,this.getCharCode(pKeyboardMessage));
         if((FocusHandler.getInstance().getFocus() is TextField) && (Berilia.getInstance().useIME) && (IME.enabled))
         {
            tf = FocusHandler.getInstance().getFocus() as TextField;
            if(tf.parent is Input)
            {
               imeActive = !(tf.text == Input(tf.parent).lastTextOnInput);
               if((!imeActive) && (Input(tf.parent).imeActive))
               {
                  Input(tf.parent).imeActive = false;
                  imeActive = true;
               }
               else
               {
                  Input(tf.parent).imeActive = imeActive;
               }
            }
         }
         else
         {
            IME.enabled = false;
         }
         if((sShortcut == null) || (imeActive))
         {
            this._isProcessingDirectInteraction = false;
            return true;
         }
         var bind:Bind = new Bind(sShortcut,"",pKeyboardMessage.keyboardEvent.altKey,pKeyboardMessage.keyboardEvent.ctrlKey,pKeyboardMessage.keyboardEvent.shiftKey);
         var shortcut:Bind = BindsManager.getInstance().getBind(bind);
         if(shortcut != null)
         {
            sh = Shortcut.getShortcutByName(shortcut.targetedShortcut);
         }
         if((BindsManager.getInstance().canBind(bind)) && ((!(sh == null)) && (!sh.disable) || (sh == null)))
         {
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.KeyboardShortcut,bind,pKeyboardMessage.keyboardEvent.keyCode);
         }
         if((!(shortcut == null)) && (sh) && (!sh.disable))
         {
            if(!Shortcut.getShortcutByName(shortcut.targetedShortcut))
            {
               return false;
            }
            if(sh.holdKeys)
            {
               heldShortcutIndex = this._heldShortcuts.indexOf(sh.defaultBind.targetedShortcut);
               if(heldShortcutIndex != -1)
               {
                  this._heldShortcuts.splice(heldShortcutIndex,1);
               }
            }
            focusAsTextField = StageShareManager.stage.focus as TextField;
            if((focusAsTextField) && (focusAsTextField.type == TextFieldType.INPUT))
            {
               if(!Shortcut.getShortcutByName(shortcut.targetedShortcut).textfieldEnabled)
               {
                  return false;
               }
            }
            LogFrame.log(LogTypeEnum.SHORTCUT,new com.ankamagames.jerakine.replay.KeyboardShortcut(shortcut.targetedShortcut));
            BindsManager.getInstance().processCallback(shortcut,shortcut.targetedShortcut);
         }
         this._isProcessingDirectInteraction = false;
         return false;
      }
      
      private function getShortcut(pKeyboardMessage:KeyboardMessage) : Shortcut {
         var sShortcut:String = BindsManager.getInstance().getShortcutString(pKeyboardMessage.keyboardEvent.keyCode,this.getCharCode(pKeyboardMessage));
         var bind:Bind = BindsManager.getInstance().getBind(new Bind(sShortcut,"",pKeyboardMessage.keyboardEvent.altKey,pKeyboardMessage.keyboardEvent.ctrlKey,pKeyboardMessage.keyboardEvent.shiftKey));
         return bind?Shortcut.getShortcutByName(bind.targetedShortcut):null;
      }
      
      private function getCharCode(pKeyboardMessage:KeyboardMessage) : int {
         var charCode:* = 0;
         if((pKeyboardMessage.keyboardEvent.shiftKey) && (pKeyboardMessage.keyboardEvent.keyCode == 52))
         {
            charCode = 39;
         }
         else
         {
            if((pKeyboardMessage.keyboardEvent.shiftKey) && (pKeyboardMessage.keyboardEvent.keyCode == 54))
            {
               charCode = 45;
            }
            else
            {
               charCode = pKeyboardMessage.keyboardEvent.charCode;
            }
         }
         return charCode;
      }
      
      private function onWindowDeactivate(pEvent:Event) : void {
         this._heldShortcuts.length = 0;
      }
      
      public function pushed() : Boolean {
         this._heldShortcuts = new Vector.<String>(0);
         if(AirScanner.hasAir())
         {
            StageShareManager.stage.nativeWindow.addEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         }
         return true;
      }
      
      public function pulled() : Boolean {
         if(AirScanner.hasAir())
         {
            StageShareManager.stage.nativeWindow.removeEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         }
         return true;
      }
   }
}
