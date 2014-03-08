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
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ExternalGameFrame));
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:KrosmasterTokenRequestAction = null;
         var _loc3_:KrosmasterAuthTokenRequestMessage = null;
         var _loc4_:KrosmasterAuthTokenErrorMessage = null;
         var _loc5_:KrosmasterAuthTokenMessage = null;
         var _loc6_:KrosmasterInventoryRequestAction = null;
         var _loc7_:KrosmasterInventoryRequestMessage = null;
         var _loc8_:KrosmasterInventoryErrorMessage = null;
         var _loc9_:KrosmasterInventoryMessage = null;
         var _loc10_:KrosmasterTransferRequestAction = null;
         var _loc11_:KrosmasterTransferRequestMessage = null;
         var _loc12_:KrosmasterTransferMessage = null;
         var _loc13_:KrosmasterPlayingStatusAction = null;
         var _loc14_:KrosmasterPlayingStatusMessage = null;
         switch(true)
         {
            case param1 is KrosmasterTokenRequestAction:
               _loc2_ = param1 as KrosmasterTokenRequestAction;
               _loc3_ = new KrosmasterAuthTokenRequestMessage();
               _loc3_.initKrosmasterAuthTokenRequestMessage();
               ConnectionsHandler.getConnection().send(_loc3_);
               return true;
            case param1 is KrosmasterAuthTokenErrorMessage:
               _loc4_ = param1 as KrosmasterAuthTokenErrorMessage;
               KernelEventsManager.getInstance().processCallback(HookList.KrosmasterAuthTokenError,_loc4_.reason);
               return true;
            case param1 is KrosmasterAuthTokenMessage:
               _loc5_ = param1 as KrosmasterAuthTokenMessage;
               KernelEventsManager.getInstance().processCallback(HookList.KrosmasterAuthToken,_loc5_.token);
               return true;
            case param1 is KrosmasterInventoryRequestAction:
               _loc6_ = param1 as KrosmasterInventoryRequestAction;
               _loc7_ = new KrosmasterInventoryRequestMessage();
               _loc7_.initKrosmasterInventoryRequestMessage();
               ConnectionsHandler.getConnection().send(_loc7_);
               return true;
            case param1 is KrosmasterInventoryErrorMessage:
               _loc8_ = param1 as KrosmasterInventoryErrorMessage;
               KernelEventsManager.getInstance().processCallback(HookList.KrosmasterInventoryError,_loc8_.reason);
               return true;
            case param1 is KrosmasterInventoryMessage:
               _loc9_ = param1 as KrosmasterInventoryMessage;
               KernelEventsManager.getInstance().processCallback(HookList.KrosmasterInventory,_loc9_.figures);
               return true;
            case param1 is KrosmasterTransferRequestAction:
               _loc10_ = param1 as KrosmasterTransferRequestAction;
               _loc11_ = new KrosmasterTransferRequestMessage();
               _loc11_.initKrosmasterTransferRequestMessage(_loc10_.figureId);
               ConnectionsHandler.getConnection().send(_loc11_);
               return true;
            case param1 is KrosmasterTransferMessage:
               _loc12_ = param1 as KrosmasterTransferMessage;
               KernelEventsManager.getInstance().processCallback(HookList.KrosmasterTransfer,_loc12_.uid,_loc12_.failure);
               return true;
            case param1 is KrosmasterPlayingStatusAction:
               _loc13_ = param1 as KrosmasterPlayingStatusAction;
               _loc14_ = new KrosmasterPlayingStatusMessage();
               _loc14_.initKrosmasterPlayingStatusMessage(_loc13_.playing);
               ConnectionsHandler.getConnection().send(_loc14_);
               return true;
            default:
               return false;
         }
      }
   }
}
