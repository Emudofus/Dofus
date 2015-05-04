package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountStableErrorMessage;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   
   public class MountDialogFrame extends Object implements Frame
   {
      
      public function MountDialogFrame()
      {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MountDialogFrame));
      
      public static function get mountFrame() : MountFrame
      {
         return Kernel.getWorker().getFrame(MountFrame) as MountFrame;
      }
      
      private var _inStable:Boolean = false;
      
      public function get priority() : int
      {
         return 0;
      }
      
      public function get inStable() : Boolean
      {
         return this._inStable;
      }
      
      public function pushed() : Boolean
      {
         this._inStable = true;
         this.sendStartOkMount();
         return true;
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:ExchangeLeaveMessage = null;
         switch(true)
         {
            case param1 is ExchangeMountStableErrorMessage:
               return true;
            case param1 is ExchangeLeaveMessage:
               _loc2_ = param1 as ExchangeLeaveMessage;
               if(_loc2_.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
               {
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         this._inStable = false;
         KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave,true);
         return true;
      }
      
      private function sendStartOkMount() : void
      {
         KernelEventsManager.getInstance().processCallback(MountHookList.ExchangeStartOkMount,mountFrame.stableList,mountFrame.paddockList);
      }
   }
}
