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
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectsModifiedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectAddedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectsAddedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectsRemovedMessage;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMoveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeIsReadyMessage;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeKamaModifiedMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
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
      
      public function CommonExchangeManagementFrame(param1:uint)
      {
         super();
         this._exchangeType = param1;
         this._numCurrentSequence = 0;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CommonExchangeManagementFrame));
      
      private var _exchangeType:uint;
      
      private var _numCurrentSequence:int;
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get craftFrame() : CraftFrame
      {
         return Kernel.getWorker().getFrame(CraftFrame) as CraftFrame;
      }
      
      public function incrementEchangeSequence() : void
      {
         this._numCurrentSequence++;
      }
      
      public function resetEchangeSequence() : void
      {
         this._numCurrentSequence = 0;
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:LeaveDialogRequestMessage = null;
         var _loc3_:BidHouseManagementFrame = null;
         var _loc4_:ExchangeAcceptMessage = null;
         var _loc5_:LeaveDialogRequestMessage = null;
         var _loc6_:ExchangeReadyAction = null;
         var _loc7_:ExchangeReadyMessage = null;
         var _loc8_:ExchangeObjectModifiedMessage = null;
         var _loc9_:ItemWrapper = null;
         var _loc10_:ExchangeObjectsModifiedMessage = null;
         var _loc11_:Array = null;
         var _loc12_:ExchangeObjectAddedMessage = null;
         var _loc13_:ItemWrapper = null;
         var _loc14_:ExchangeObjectsAddedMessage = null;
         var _loc15_:Array = null;
         var _loc16_:ExchangeObjectRemovedMessage = null;
         var _loc17_:ExchangeObjectsRemovedMessage = null;
         var _loc18_:Array = null;
         var _loc19_:uint = 0;
         var _loc20_:ExchangeObjectMoveAction = null;
         var _loc21_:ItemWrapper = null;
         var _loc22_:ExchangeObjectMoveMessage = null;
         var _loc23_:ExchangeIsReadyMessage = null;
         var _loc24_:RoleplayEntitiesFrame = null;
         var _loc25_:String = null;
         var _loc26_:ExchangeKamaModifiedMessage = null;
         var _loc27_:ObjectItem = null;
         var _loc28_:ItemWrapper = null;
         var _loc29_:ObjectItem = null;
         var _loc30_:ItemWrapper = null;
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
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectModified,_loc9_,_loc8_.remote);
               return true;
            case param1 is ExchangeObjectsModifiedMessage:
               _loc10_ = param1 as ExchangeObjectsModifiedMessage;
               this._numCurrentSequence++;
               _loc11_ = new Array();
               for each(_loc27_ in _loc10_.object)
               {
                  _loc28_ = ItemWrapper.create(_loc27_.position,_loc27_.objectUID,_loc27_.objectGID,_loc27_.quantity,_loc27_.effects,false);
                  switch(this._exchangeType)
                  {
                     case ExchangeTypeEnum.CRAFT:
                        this.craftFrame.modifyCraftComponent(_loc10_.remote,_loc28_);
                        break;
                  }
                  _loc11_.push(_loc28_);
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectListModified,_loc11_,_loc10_.remote);
               return true;
            case param1 is ExchangeObjectAddedMessage:
               _loc12_ = param1 as ExchangeObjectAddedMessage;
               this._numCurrentSequence++;
               _loc13_ = ItemWrapper.create(_loc12_.object.position,_loc12_.object.objectUID,_loc12_.object.objectGID,_loc12_.object.quantity,_loc12_.object.effects,false);
               switch(this._exchangeType)
               {
                  case ExchangeTypeEnum.CRAFT:
                     this.craftFrame.addCraftComponent(_loc12_.remote,_loc13_);
                     break;
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectAdded,_loc13_,_loc12_.remote);
               return true;
            case param1 is ExchangeObjectsAddedMessage:
               _loc14_ = param1 as ExchangeObjectsAddedMessage;
               this._numCurrentSequence++;
               _loc15_ = new Array();
               for each(_loc29_ in _loc14_.object)
               {
                  _loc30_ = ItemWrapper.create(_loc29_.position,_loc29_.objectUID,_loc29_.objectGID,_loc29_.quantity,_loc29_.effects,false);
                  switch(this._exchangeType)
                  {
                     case ExchangeTypeEnum.CRAFT:
                        this.craftFrame.addCraftComponent(_loc14_.remote,_loc30_);
                        break;
                  }
                  _loc15_.push(_loc30_);
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectListAdded,_loc15_,_loc14_.remote);
               return true;
            case param1 is ExchangeObjectRemovedMessage:
               _loc16_ = param1 as ExchangeObjectRemovedMessage;
               this._numCurrentSequence++;
               switch(this._exchangeType)
               {
                  case ExchangeTypeEnum.CRAFT:
                     this.craftFrame.removeCraftComponent(_loc16_.remote,_loc16_.objectUID);
                     break;
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectRemoved,_loc16_.objectUID,_loc16_.remote);
               return true;
            case param1 is ExchangeObjectsRemovedMessage:
               _loc17_ = param1 as ExchangeObjectsRemovedMessage;
               this._numCurrentSequence++;
               _loc18_ = new Array();
               for each(_loc19_ in _loc17_.objectUID)
               {
                  switch(this._exchangeType)
                  {
                     case ExchangeTypeEnum.CRAFT:
                        this.craftFrame.removeCraftComponent(_loc16_.remote,_loc19_);
                        break;
                  }
                  _loc18_.push(_loc19_);
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectListRemoved,_loc18_,_loc17_.remote);
               return true;
            case param1 is ExchangeObjectMoveAction:
               _loc20_ = param1 as ExchangeObjectMoveAction;
               _loc21_ = InventoryManager.getInstance().inventory.getItem(_loc20_.objectUID);
               if(!_loc21_)
               {
                  _loc21_ = InventoryManager.getInstance().bankInventory.getItem(_loc20_.objectUID);
               }
               if((_loc21_) && _loc21_.quantity == Math.abs(_loc20_.quantity))
               {
                  TooltipManager.hide();
               }
               _loc22_ = new ExchangeObjectMoveMessage();
               _loc22_.initExchangeObjectMoveMessage(_loc20_.objectUID,_loc20_.quantity);
               ConnectionsHandler.getConnection().send(_loc22_);
               return true;
            case param1 is ExchangeIsReadyMessage:
               _loc23_ = param1 as ExchangeIsReadyMessage;
               _loc24_ = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               _loc25_ = (_loc24_.getEntityInfos(_loc23_.id) as GameRolePlayNamedActorInformations).name;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeIsReady,_loc25_,_loc23_.ready);
               return true;
            case param1 is ExchangeKamaModifiedMessage:
               _loc26_ = param1 as ExchangeKamaModifiedMessage;
               this._numCurrentSequence++;
               if(!_loc26_.remote)
               {
                  InventoryManager.getInstance().inventory.hiddedKamas = _loc26_.quantity;
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeKamaModified,_loc26_.quantity,_loc26_.remote);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         if(Kernel.getWorker().contains(CraftFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CraftFrame));
         }
         return true;
      }
   }
}
