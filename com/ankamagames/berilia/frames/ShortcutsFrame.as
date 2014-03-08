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
      
      public function process(param1:Message) : Boolean {
         var _loc2_:KeyboardKeyDownMessage = null;
         var _loc3_:Shortcut = null;
         var _loc4_:KeyboardKeyUpMessage = null;
         this._isProcessingDirectInteraction = false;
         if(!shortcutsEnabled)
         {
            return false;
         }
         switch(true)
         {
            case param1 is KeyboardKeyDownMessage:
               _loc2_ = KeyboardKeyDownMessage(param1);
               shiftKey = _loc2_.keyboardEvent.shiftKey;
               ctrlKey = _loc2_.keyboardEvent.ctrlKey;
               altKey = _loc2_.keyboardEvent.altKey;
               this._lastCtrlKey = false;
               _loc3_ = this.getShortcut(_loc2_);
               if((_loc3_) && (_loc3_.holdKeys) && this._heldShortcuts.indexOf(_loc3_.defaultBind.targetedShortcut) == -1)
               {
                  this.handleMessage(_loc2_);
                  this._heldShortcuts.push(_loc3_.defaultBind.targetedShortcut);
               }
               return false;
            case param1 is KeyboardKeyUpMessage:
               _loc4_ = KeyboardKeyUpMessage(param1);
               shiftKey = _loc4_.keyboardEvent.shiftKey;
               ctrlKey = _loc4_.keyboardEvent.ctrlKey;
               altKey = _loc4_.keyboardEvent.altKey;
               return this.handleMessage(_loc4_);
            default:
               this._isProcessingDirectInteraction = false;
               return false;
         }
      }
      
      private function handleMessage(param1:KeyboardMessage) : Boolean {
         var _loc4_:* = false;
         var _loc7_:Shortcut = null;
         var _loc8_:TextField = null;
         var _loc9_:TextField = null;
         var _loc10_:* = 0;
         var _loc2_:int = param1.keyboardEvent.keyCode;
         if(_loc2_ == Keyboard.CONTROL)
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
         var _loc3_:String = BindsManager.getInstance().getShortcutString(param1.keyboardEvent.keyCode,this.getCharCode(param1));
         if(FocusHandler.getInstance().getFocus() is TextField && (Berilia.getInstance().useIME) && (IME.enabled))
         {
            _loc8_ = FocusHandler.getInstance().getFocus() as TextField;
            if(_loc8_.parent is Input)
            {
               _loc4_ = !(_loc8_.text == Input(_loc8_.parent).lastTextOnInput);
               if(!_loc4_ && (Input(_loc8_.parent).imeActive))
               {
                  Input(_loc8_.parent).imeActive = false;
                  _loc4_ = true;
               }
               else
               {
                  Input(_loc8_.parent).imeActive = _loc4_;
               }
            }
         }
         else
         {
            IME.enabled = false;
         }
         if(_loc3_ == null || (_loc4_))
         {
            this._isProcessingDirectInteraction = false;
            return true;
         }
         var _loc5_:Bind = new Bind(_loc3_,"",param1.keyboardEvent.altKey,param1.keyboardEvent.ctrlKey,param1.keyboardEvent.shiftKey);
         var _loc6_:Bind = BindsManager.getInstance().getBind(_loc5_);
         if(_loc6_ != null)
         {
            _loc7_ = Shortcut.getShortcutByName(_loc6_.targetedShortcut);
         }
         if((BindsManager.getInstance().canBind(_loc5_)) && (!(_loc7_ == null) && !_loc7_.disable || _loc7_ == null))
         {
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.KeyboardShortcut,_loc5_,param1.keyboardEvent.keyCode);
         }
         if((!(_loc6_ == null)) && (_loc7_) && !_loc7_.disable)
         {
            if(!Shortcut.getShortcutByName(_loc6_.targetedShortcut))
            {
               return false;
            }
            if(_loc7_.holdKeys)
            {
               _loc10_ = this._heldShortcuts.indexOf(_loc7_.defaultBind.targetedShortcut);
               if(_loc10_ != -1)
               {
                  this._heldShortcuts.splice(_loc10_,1);
               }
            }
            _loc9_ = StageShareManager.stage.focus as TextField;
            if((_loc9_) && _loc9_.type == TextFieldType.INPUT)
            {
               if(!Shortcut.getShortcutByName(_loc6_.targetedShortcut).textfieldEnabled)
               {
                  return false;
               }
            }
            LogFrame.log(LogTypeEnum.SHORTCUT,new com.ankamagames.jerakine.replay.KeyboardShortcut(_loc6_.targetedShortcut));
            BindsManager.getInstance().processCallback(_loc6_,_loc6_.targetedShortcut);
         }
         this._isProcessingDirectInteraction = false;
         return false;
      }
      
      private function getShortcut(param1:KeyboardMessage) : Shortcut {
         var _loc2_:String = BindsManager.getInstance().getShortcutString(param1.keyboardEvent.keyCode,this.getCharCode(param1));
         var _loc3_:Bind = BindsManager.getInstance().getBind(new Bind(_loc2_,"",param1.keyboardEvent.altKey,param1.keyboardEvent.ctrlKey,param1.keyboardEvent.shiftKey));
         return _loc3_?Shortcut.getShortcutByName(_loc3_.targetedShortcut):null;
      }
      
      private function getCharCode(param1:KeyboardMessage) : int {
         var _loc2_:* = 0;
         if((param1.keyboardEvent.shiftKey) && param1.keyboardEvent.keyCode == 52)
         {
            _loc2_ = 39;
         }
         else
         {
            if((param1.keyboardEvent.shiftKey) && param1.keyboardEvent.keyCode == 54)
            {
               _loc2_ = 45;
            }
            else
            {
               _loc2_ = param1.keyboardEvent.charCode;
            }
         }
         return _loc2_;
      }
      
      private function onWindowDeactivate(param1:Event) : void {
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
