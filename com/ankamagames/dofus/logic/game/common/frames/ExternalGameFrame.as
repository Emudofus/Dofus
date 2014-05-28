package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.KrosmasterTokenRequestAction;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterAuthTokenRequestMessage;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterAuthTokenErrorMessage;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterAuthTokenMessage;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.KrosmasterInventoryRequestAction;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterInventoryRequestMessage;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterInventoryErrorMessage;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterInventoryMessage;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.KrosmasterTransferRequestAction;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterTransferRequestMessage;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterTransferMessage;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.KrosmasterPlayingStatusAction;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterPlayingStatusMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class ExternalGameFrame extends Object implements Frame
   {
      
      public function ExternalGameFrame() {
         super();
      }
      
      protected static const _log:Logger;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var ktora:KrosmasterTokenRequestAction = null;
         var katrmsg:KrosmasterAuthTokenRequestMessage = null;
         var katemsg:KrosmasterAuthTokenErrorMessage = null;
         var katmsg:KrosmasterAuthTokenMessage = null;
         var kira:KrosmasterInventoryRequestAction = null;
         var kirmsg:KrosmasterInventoryRequestMessage = null;
         var kiemsg:KrosmasterInventoryErrorMessage = null;
         var kimsg:KrosmasterInventoryMessage = null;
         var ktra:KrosmasterTransferRequestAction = null;
         var ktrmsg:KrosmasterTransferRequestMessage = null;
         var ktmsg:KrosmasterTransferMessage = null;
         var kpsa:KrosmasterPlayingStatusAction = null;
         var kpsmsg:KrosmasterPlayingStatusMessage = null;
         switch(true)
         {
            case msg is KrosmasterTokenRequestAction:
               ktora = msg as KrosmasterTokenRequestAction;
               katrmsg = new KrosmasterAuthTokenRequestMessage();
               katrmsg.initKrosmasterAuthTokenRequestMessage();
               ConnectionsHandler.getConnection().send(katrmsg);
               return true;
            case msg is KrosmasterAuthTokenErrorMessage:
               katemsg = msg as KrosmasterAuthTokenErrorMessage;
               KernelEventsManager.getInstance().processCallback(HookList.KrosmasterAuthTokenError,katemsg.reason);
               return true;
            case msg is KrosmasterAuthTokenMessage:
               katmsg = msg as KrosmasterAuthTokenMessage;
               KernelEventsManager.getInstance().processCallback(HookList.KrosmasterAuthToken,katmsg.token);
               return true;
            case msg is KrosmasterInventoryRequestAction:
               kira = msg as KrosmasterInventoryRequestAction;
               kirmsg = new KrosmasterInventoryRequestMessage();
               kirmsg.initKrosmasterInventoryRequestMessage();
               ConnectionsHandler.getConnection().send(kirmsg);
               return true;
            case msg is KrosmasterInventoryErrorMessage:
               kiemsg = msg as KrosmasterInventoryErrorMessage;
               KernelEventsManager.getInstance().processCallback(HookList.KrosmasterInventoryError,kiemsg.reason);
               return true;
            case msg is KrosmasterInventoryMessage:
               kimsg = msg as KrosmasterInventoryMessage;
               KernelEventsManager.getInstance().processCallback(HookList.KrosmasterInventory,kimsg.figures);
               return true;
            case msg is KrosmasterTransferRequestAction:
               ktra = msg as KrosmasterTransferRequestAction;
               ktrmsg = new KrosmasterTransferRequestMessage();
               ktrmsg.initKrosmasterTransferRequestMessage(ktra.figureId);
               ConnectionsHandler.getConnection().send(ktrmsg);
               return true;
            case msg is KrosmasterTransferMessage:
               ktmsg = msg as KrosmasterTransferMessage;
               KernelEventsManager.getInstance().processCallback(HookList.KrosmasterTransfer,ktmsg.uid,ktmsg.failure);
               return true;
            case msg is KrosmasterPlayingStatusAction:
               kpsa = msg as KrosmasterPlayingStatusAction;
               kpsmsg = new KrosmasterPlayingStatusMessage();
               kpsmsg.initKrosmasterPlayingStatusMessage(kpsa.playing);
               ConnectionsHandler.getConnection().send(kpsmsg);
               return true;
            default:
               return false;
         }
      }
   }
}
