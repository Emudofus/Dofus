package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeAcceptMessage;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeReadyAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeReadyMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectModifiedMessage;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectAddedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectRemovedMessage;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMoveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeIsReadyMessage;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeKamaModifiedMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.LeaveShopStockAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeAcceptAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeRefuseAction;
   
   public class CommonExchangeManagementFrame extends Object implements Frame
   {
      
      public function CommonExchangeManagementFrame(param1:uint) {
         super();
         this._exchangeType = param1;
         this._numCurrentSequence = 0;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CommonExchangeManagementFrame));
      
      private var _exchangeType:uint;
      
      private var _numCurrentSequence:int;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function get craftFrame() : CraftFrame {
         return Kernel.getWorker().getFrame(CraftFrame) as CraftFrame;
      }
      
      public function incrementEchangeSequence() : void {
         this._numCurrentSequence++;
      }
      
      public function resetEchangeSequence() : void {
         this._numCurrentSequence = 0;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:LeaveDialogRequestMessage = null;
         var _loc3_:BidHouseManagementFrame = null;
         var _loc4_:ExchangeAcceptMessage = null;
         var _loc5_:LeaveDialogRequestMessage = null;
         var _loc6_:ExchangeReadyAction = null;
         var _loc7_:ExchangeReadyMessage = null;
         var _loc8_:ExchangeObjectModifiedMessage = null;
         var _loc9_:ItemWrapper = null;
         var _loc10_:ExchangeObjectAddedMessage = null;
         var _loc11_:ItemWrapper = null;
         var _loc12_:ExchangeObjectRemovedMessage = null;
         var _loc13_:ExchangeObjectMoveAction = null;
         var _loc14_:ExchangeObjectMoveMessage = null;
         var _loc15_:ExchangeIsReadyMessage = null;
         var _loc16_:RoleplayEntitiesFrame = null;
         var _loc17_:String = null;
         var _loc18_:ExchangeKamaModifiedMessage = null;
         switch(true)
         {
            case param1 is LeaveShopStockAction:
               _loc2_ = new LeaveDialogRequestMessage();
               _loc2_.initLeaveDialogRequestMessage();
               _loc3_ = Kernel.getWorker().getFrame(BidHouseManagementFrame) as BidHouseManagementFrame;
               if(_loc3_)
               {
                  _loc3_.switching = false;
               }
               ConnectionsHandler.getConnection().send(_loc2_);
               return true;
            case param1 is ExchangeAcceptAction:
               _loc4_ = new ExchangeAcceptMessage();
               _loc4_.initExchangeAcceptMessage();
               ConnectionsHandler.getConnection().send(_loc4_);
               return true;
            case param1 is ExchangeRefuseAction:
               _loc5_ = new LeaveDialogRequestMessage();
               _loc5_.initLeaveDialogRequestMessage();
               ConnectionsHandler.getConnection().send(_loc5_);
               return true;
            case param1 is ExchangeReadyAction:
               _loc6_ = param1 as ExchangeReadyAction;
               _loc7_ = new ExchangeReadyMessage();
               _loc7_.initExchangeReadyMessage(_loc6_.isReady,this._numCurrentSequence);
               ConnectionsHandler.getConnection().send(_loc7_);
               return true;
            case param1 is ExchangeObjectModifiedMessage:
               _loc8_ = param1 as ExchangeObjectModifiedMessage;
               this._numCurrentSequence++;
               _loc9_ = ItemWrapper.create(_loc8_.object.position,_loc8_.object.objectUID,_loc8_.object.objectGID,_loc8_.object.quantity,_loc8_.object.effects,false);
               switch(this._exchangeType)
               {
                  case ExchangeTypeEnum.CRAFT:
                     this.craftFrame.modifyCraftComponent(_loc8_.remote,_loc9_);
                     break;
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectModified,_loc9_);
               return true;
            case param1 is ExchangeObjectAddedMessage:
               _loc10_ = param1 as ExchangeObjectAddedMessage;
               this._numCurrentSequence++;
               _loc11_ = ItemWrapper.create(_loc10_.object.position,_loc10_.object.objectUID,_loc10_.object.objectGID,_loc10_.object.quantity,_loc10_.object.effects,false);
               switch(this._exchangeType)
               {
                  case ExchangeTypeEnum.CRAFT:
                     this.craftFrame.addCraftComponent(_loc10_.remote,_loc11_);
                     break;
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectAdded,_loc11_);
               return true;
            case param1 is ExchangeObjectRemovedMessage:
               _loc12_ = param1 as ExchangeObjectRemovedMessage;
               this._numCurrentSequence++;
               switch(this._exchangeType)
               {
                  case ExchangeTypeEnum.CRAFT:
                     this.craftFrame.removeCraftComponent(_loc12_.remote,_loc12_.objectUID);
                     break;
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectRemoved,_loc12_.objectUID);
               return true;
            case param1 is ExchangeObjectMoveAction:
               _loc13_ = param1 as ExchangeObjectMoveAction;
               _loc14_ = new ExchangeObjectMoveMessage();
               _loc14_.initExchangeObjectMoveMessage(_loc13_.objectUID,_loc13_.quantity);
               ConnectionsHandler.getConnection().send(_loc14_);
               return true;
            case param1 is ExchangeIsReadyMessage:
               _loc15_ = param1 as ExchangeIsReadyMessage;
               _loc16_ = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               _loc17_ = (_loc16_.getEntityInfos(_loc15_.id) as GameRolePlayNamedActorInformations).name;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeIsReady,_loc17_,_loc15_.ready);
               return true;
            case param1 is ExchangeKamaModifiedMessage:
               _loc18_ = param1 as ExchangeKamaModifiedMessage;
               this._numCurrentSequence++;
               if(!_loc18_.remote)
               {
                  InventoryManager.getInstance().inventory.hiddedKamas = _loc18_.quantity;
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeKamaModified,_loc18_.quantity,_loc18_.remote);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         if(Kernel.getWorker().contains(CraftFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CraftFrame));
         }
         return true;
      }
   }
}
