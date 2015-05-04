package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockBuyRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.mount.PaddockBuyRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.PaddockBuyResultMessage;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockSellRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.mount.PaddockSellRequestMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   
   public class PaddockFrame extends Object implements Frame
   {
      
      public function PaddockFrame()
      {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(NpcDialogFrame));
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:PaddockBuyRequestAction = null;
         var _loc3_:PaddockBuyRequestMessage = null;
         var _loc4_:PaddockBuyResultMessage = null;
         var _loc5_:PaddockSellRequestAction = null;
         var _loc6_:PaddockSellRequestMessage = null;
         var _loc7_:LeaveDialogMessage = null;
         switch(true)
         {
            case param1 is PaddockBuyRequestAction:
               _loc2_ = param1 as PaddockBuyRequestAction;
               _loc3_ = new PaddockBuyRequestMessage();
               _loc3_.initPaddockBuyRequestMessage(_loc2_.proposedPrice);
               ConnectionsHandler.getConnection().send(_loc3_);
               return true;
            case param1 is PaddockBuyResultMessage:
               _loc4_ = param1 as PaddockBuyResultMessage;
               KernelEventsManager.getInstance().processCallback(HookList.PaddockBuyResult,_loc4_.paddockId,_loc4_.bought,_loc4_.realPrice);
               return true;
            case param1 is PaddockSellRequestAction:
               _loc5_ = param1 as PaddockSellRequestAction;
               _loc6_ = new PaddockSellRequestMessage();
               _loc6_.initPaddockSellRequestMessage(_loc5_.price);
               ConnectionsHandler.getConnection().send(_loc6_);
               return true;
            case param1 is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case param1 is LeaveDialogMessage:
               _loc7_ = param1 as LeaveDialogMessage;
               if(_loc7_.dialogType == DialogTypeEnum.DIALOG_PURCHASABLE)
               {
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
         return true;
      }
   }
}
