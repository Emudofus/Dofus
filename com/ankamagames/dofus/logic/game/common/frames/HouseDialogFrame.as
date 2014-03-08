package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.LockableUseCodeAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableUseCodeMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class HouseDialogFrame extends Object implements Frame
   {
      
      public function HouseDialogFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HouseDialogFrame));
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:LockableUseCodeAction = null;
         var _loc3_:LockableUseCodeMessage = null;
         var _loc4_:LeaveDialogMessage = null;
         switch(true)
         {
            case param1 is LockableUseCodeAction:
               _loc2_ = param1 as LockableUseCodeAction;
               _loc3_ = new LockableUseCodeMessage();
               _loc3_.initLockableUseCodeMessage(_loc2_.code);
               ConnectionsHandler.getConnection().send(_loc3_);
               return true;
            case param1 is LeaveDialogMessage:
               _loc4_ = param1 as LeaveDialogMessage;
               if(_loc4_.dialogType == DialogTypeEnum.DIALOG_PURCHASABLE || _loc4_.dialogType == DialogTypeEnum.DIALOG_LOCKABLE)
               {
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
         return true;
      }
   }
}
