package com.ankamagames.berilia.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.berilia.types.shortcut.Bind;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.berilia.Berilia;
   import flash.system.IME;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.text.TextFieldType;
   import com.ankamagames.jerakine.replay.LogFrame;
   import com.ankamagames.jerakine.replay.LogTypeEnum;
   import com.ankamagames.jerakine.replay.KeyboardShortcut;


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

      public function get isProcessingDirectInteraction() : Boolean {
         return this._isProcessingDirectInteraction;
      }

      public function get priority() : int {
         return Priority.NORMAL;
      }

      public function process(msg:Message) : Boolean {
         var kdmsg:KeyboardKeyDownMessage = null;
         var kumsg:KeyboardKeyUpMessage = null;
         var keyCode:* = 0;
         var charCode:* = 0;
         var sShortcut:String = null;
         var imeActive:* = false;
         var bind:Bind = null;
         var shortcut:Bind = null;
         var sh:Shortcut = null;
         var tf:TextField = null;
         var focusAsTextField:TextField = null;
         this._isProcessingDirectInteraction=false;
         if(!shortcutsEnabled)
         {
            return false;
         }
         switch(true)
         {
            case msg is KeyboardKeyDownMessage:
               kdmsg=KeyboardKeyDownMessage(msg);
               shiftKey=kdmsg.keyboardEvent.shiftKey;
               ctrlKey=kdmsg.keyboardEvent.ctrlKey;
               altKey=kdmsg.keyboardEvent.altKey;
               this._lastCtrlKey=false;
               return false;
               break;
            case msg is KeyboardKeyUpMessage:
               kumsg=KeyboardKeyUpMessage(msg);
               shiftKey=kumsg.keyboardEvent.shiftKey;
               ctrlKey=kumsg.keyboardEvent.ctrlKey;
               altKey=kumsg.keyboardEvent.altKey;
               keyCode=kumsg.keyboardEvent.keyCode;
               if(keyCode==Keyboard.CONTROL)
               {
                  this._lastCtrlKey=true;
               }
               else
               {
                  if(this._lastCtrlKey)
                  {
                     this._lastCtrlKey=false;
                     return false;
                  }
               }
               this._isProcessingDirectInteraction=true;
               if((kumsg.keyboardEvent.shiftKey)&&(kumsg.keyboardEvent.keyCode==52))
               {
                  charCode=39;
               }
               else
               {
                  if((kumsg.keyboardEvent.shiftKey)&&(kumsg.keyboardEvent.keyCode==54))
                  {
                     charCode=45;
                  }
                  else
                  {
                     charCode=kumsg.keyboardEvent.charCode;
                  }
               }
               sShortcut=BindsManager.getInstance().getShortcutString(kumsg.keyboardEvent.keyCode,charCode);
               if((FocusHandler.getInstance().getFocus() is TextField)&&(Berilia.getInstance().useIME)&&(IME.enabled))
               {
                  tf=FocusHandler.getInstance().getFocus() as TextField;
                  if(tf.parent is Input)
                  {
                     imeActive=!(tf.text==Input(tf.parent).lastTextOnInput);
                     if((!imeActive)&&(Input(tf.parent).imeActive))
                     {
                        Input(tf.parent).imeActive=false;
                        imeActive=true;
                     }
                     else
                     {
                        Input(tf.parent).imeActive=imeActive;
                     }
                  }
               }
               else
               {
                  IME.enabled=false;
               }
               if((sShortcut==null)||(imeActive))
               {
                  this._isProcessingDirectInteraction=false;
                  return true;
               }
               bind=new Bind(sShortcut,"",kumsg.keyboardEvent.altKey,kumsg.keyboardEvent.ctrlKey,kumsg.keyboardEvent.shiftKey);
               shortcut=BindsManager.getInstance().getBind(bind);
               if(shortcut!=null)
               {
                  sh=Shortcut.getShortcutByName(shortcut.targetedShortcut);
               }
               if((BindsManager.getInstance().canBind(bind))&&((!(sh==null))&&(!sh.disable)||(sh==null)))
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.KeyboardShortcut,bind,kumsg.keyboardEvent.keyCode);
               }
               if((!(shortcut==null))&&(sh)&&(!sh.disable))
               {
                  if(!Shortcut.getShortcutByName(shortcut.targetedShortcut))
                  {
                     break;
                  }
                  focusAsTextField=StageShareManager.stage.focus as TextField;
                  if((focusAsTextField)&&(focusAsTextField.type==TextFieldType.INPUT))
                  {
                     if(!Shortcut.getShortcutByName(shortcut.targetedShortcut).textfieldEnabled)
                     {
                        break;
                     }
                  }
                  LogFrame.log(LogTypeEnum.SHORTCUT,new KeyboardShortcut(shortcut.targetedShortcut));
                  BindsManager.getInstance().processCallback(shortcut,shortcut.targetedShortcut);
               }
               this._isProcessingDirectInteraction=false;
               return false;
               break;
         }
         this._isProcessingDirectInteraction=false;
         return false;
      }

      public function pushed() : Boolean {
         return true;
      }

      public function pulled() : Boolean {
         return true;
      }
   }

}