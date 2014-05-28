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
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.LeaveShopStockAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeAcceptAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeRefuseAction;
   
   public class CommonExchangeManagementFrame extends Object implements Frame
   {
      
      public function CommonExchangeManagementFrame(pExchangeType:uint) {
         super();
         this._exchangeType = pExchangeType;
         this._numCurrentSequence = 0;
      }
      
      protected static const _log:Logger;
      
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
      
      public function process(msg:Message) : Boolean {
         var ldrmsg:LeaveDialogRequestMessage = null;
         var bidhouseManagementFrame:BidHouseManagementFrame = null;
         var exchangeAcceptMessage:ExchangeAcceptMessage = null;
         var ldrmsg2:LeaveDialogRequestMessage = null;
         var era:ExchangeReadyAction = null;
         var ermsg:ExchangeReadyMessage = null;
         var eommsg:ExchangeObjectModifiedMessage = null;
         var iwModified:ItemWrapper = null;
         var eoamsg:ExchangeObjectAddedMessage = null;
         var iwAdded:ItemWrapper = null;
         var eormsg:ExchangeObjectRemovedMessage = null;
         var eoma:ExchangeObjectMoveAction = null;
         var iw:ItemWrapper = null;
         var eomvmsg:ExchangeObjectMoveMessage = null;
         var eirmsg:ExchangeIsReadyMessage = null;
         var roleplayEntitiesFrame:RoleplayEntitiesFrame = null;
         var playerName:String = null;
         var ekmmsg:ExchangeKamaModifiedMessage = null;
         switch(true)
         {
            case msg is LeaveShopStockAction:
               ldrmsg = new LeaveDialogRequestMessage();
               ldrmsg.initLeaveDialogRequestMessage();
               bidhouseManagementFrame = Kernel.getWorker().getFrame(BidHouseManagementFrame) as BidHouseManagementFrame;
               if(bidhouseManagementFrame)
               {
                  bidhouseManagementFrame.switching = false;
               }
               ConnectionsHandler.getConnection().send(ldrmsg);
               return true;
            case msg is ExchangeAcceptAction:
               exchangeAcceptMessage = new ExchangeAcceptMessage();
               exchangeAcceptMessage.initExchangeAcceptMessage();
               ConnectionsHandler.getConnection().send(exchangeAcceptMessage);
               return true;
            case msg is ExchangeRefuseAction:
               ldrmsg2 = new LeaveDialogRequestMessage();
               ldrmsg2.initLeaveDialogRequestMessage();
               ConnectionsHandler.getConnection().send(ldrmsg2);
               return true;
            case msg is ExchangeReadyAction:
               era = msg as ExchangeReadyAction;
               ermsg = new ExchangeReadyMessage();
               ermsg.initExchangeReadyMessage(era.isReady,this._numCurrentSequence);
               ConnectionsHandler.getConnection().send(ermsg);
               return true;
            case msg is ExchangeObjectModifiedMessage:
               eommsg = msg as ExchangeObjectModifiedMessage;
               this._numCurrentSequence++;
               iwModified = ItemWrapper.create(eommsg.object.position,eommsg.object.objectUID,eommsg.object.objectGID,eommsg.object.quantity,eommsg.object.effects,false);
               switch(this._exchangeType)
               {
                  case ExchangeTypeEnum.CRAFT:
                     this.craftFrame.modifyCraftComponent(eommsg.remote,iwModified);
                     break;
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectModified,iwModified);
               return true;
            case msg is ExchangeObjectAddedMessage:
               eoamsg = msg as ExchangeObjectAddedMessage;
               this._numCurrentSequence++;
               iwAdded = ItemWrapper.create(eoamsg.object.position,eoamsg.object.objectUID,eoamsg.object.objectGID,eoamsg.object.quantity,eoamsg.object.effects,false);
               switch(this._exchangeType)
               {
                  case ExchangeTypeEnum.CRAFT:
                     this.craftFrame.addCraftComponent(eoamsg.remote,iwAdded);
                     break;
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectAdded,iwAdded);
               return true;
            case msg is ExchangeObjectRemovedMessage:
               eormsg = msg as ExchangeObjectRemovedMessage;
               this._numCurrentSequence++;
               switch(this._exchangeType)
               {
                  case ExchangeTypeEnum.CRAFT:
                     this.craftFrame.removeCraftComponent(eormsg.remote,eormsg.objectUID);
                     break;
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectRemoved,eormsg.objectUID);
               return true;
            case msg is ExchangeObjectMoveAction:
               eoma = msg as ExchangeObjectMoveAction;
               iw = InventoryManager.getInstance().inventory.getItem(eoma.objectUID);
               if(!iw)
               {
                  iw = InventoryManager.getInstance().bankInventory.getItem(eoma.objectUID);
               }
               if((iw) && (iw.quantity == Math.abs(eoma.quantity)))
               {
                  TooltipManager.hide();
               }
               eomvmsg = new ExchangeObjectMoveMessage();
               eomvmsg.initExchangeObjectMoveMessage(eoma.objectUID,eoma.quantity);
               ConnectionsHandler.getConnection().send(eomvmsg);
               return true;
            case msg is ExchangeIsReadyMessage:
               eirmsg = msg as ExchangeIsReadyMessage;
               roleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               playerName = (roleplayEntitiesFrame.getEntityInfos(eirmsg.id) as GameRolePlayNamedActorInformations).name;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeIsReady,playerName,eirmsg.ready);
               return true;
            case msg is ExchangeKamaModifiedMessage:
               ekmmsg = msg as ExchangeKamaModifiedMessage;
               this._numCurrentSequence++;
               if(!ekmmsg.remote)
               {
                  InventoryManager.getInstance().inventory.hiddedKamas = ekmmsg.quantity;
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeKamaModified,ekmmsg.quantity,ekmmsg.remote);
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
