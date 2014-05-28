package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedBidSellerMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInBid;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedBidBuyerMessage;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseSearchAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseListAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseTypeAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseTypeMessage;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseBuyAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseBuyMessage;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHousePriceAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHousePriceMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidPriceForSellerMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidPriceMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseItemAddOkMessage;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseItemRemoveOkMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseGenericItemAddedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseGenericItemRemovedMessage;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectModifyPricedAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectModifyPricedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseInListUpdatedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseInListAddedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseInListRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeTypesExchangerDescriptionForUserMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeTypesItemsExchangerDescriptionForUserMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidSearchOkMessage;
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidHouseStringSearchAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcGenericActionRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseSearchMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseListMessage;
   import com.ankamagames.dofus.network.types.game.data.items.BidExchangerObjectInfo;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidSwitchToBuyerModeAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidSwitchToSellerModeAction;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   
   public class BidHouseManagementFrame extends Object implements Frame
   {
      
      public function BidHouseManagementFrame() {
         super();
      }
      
      protected static const _log:Logger;
      
      private var _bidHouseObjects:Array;
      
      private var _vendorObjects:Array;
      
      private var _typeAsk:uint;
      
      private var _GIDAsk:uint;
      
      private var _NPCId:uint;
      
      private var _listItemsSearchMode:Array;
      
      private var _itemsTypesAllowed:Vector.<uint>;
      
      private var _switching:Boolean = false;
      
      private var _success:Boolean;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function get switching() : Boolean {
         return this._switching;
      }
      
      public function set switching(switching:Boolean) : void {
         this._switching = switching;
      }
      
      public function processExchangeStartedBidSellerMessage(msg:ExchangeStartedBidSellerMessage) : void {
         var objectInfo:ObjectItemToSellInBid = null;
         var iw:ItemWrapper = null;
         var price:uint = 0;
         var unsoldDelay:uint = 0;
         this._switching = false;
         var esbsmsg:ExchangeStartedBidSellerMessage = msg as ExchangeStartedBidSellerMessage;
         this._NPCId = esbsmsg.sellerDescriptor.npcContextualId;
         this.initSearchMode(esbsmsg.sellerDescriptor.types);
         this._vendorObjects = new Array();
         for each(objectInfo in esbsmsg.objectsInfos)
         {
            iw = ItemWrapper.create(63,objectInfo.objectUID,objectInfo.objectGID,objectInfo.quantity,objectInfo.effects);
            price = objectInfo.objectPrice;
            unsoldDelay = objectInfo.unsoldDelay;
            this._vendorObjects.push(new ItemSellByPlayer(iw,price,unsoldDelay));
         }
         this._vendorObjects.sortOn("unsoldDelay",Array.NUMERIC);
         this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedBidSeller,esbsmsg.sellerDescriptor,esbsmsg.objectsInfos);
         this._kernelEventsManager.processCallback(ExchangeHookList.SellerObjectListUpdate,this._vendorObjects);
      }
      
      public function processExchangeStartedBidBuyerMessage(msg:ExchangeStartedBidBuyerMessage) : void {
         var typeObject:uint = 0;
         this._switching = false;
         var esbbmsg:ExchangeStartedBidBuyerMessage = msg as ExchangeStartedBidBuyerMessage;
         this._NPCId = esbbmsg.buyerDescriptor.npcContextualId;
         this.initSearchMode(esbbmsg.buyerDescriptor.types);
         this._bidHouseObjects = new Array();
         for each(typeObject in esbbmsg.buyerDescriptor.types)
         {
            this._bidHouseObjects.push(new TypeObjectData(typeObject,null));
         }
         this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedBidBuyer,esbbmsg.buyerDescriptor);
      }
      
      public function process(msg:Message) : Boolean {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function pushed() : Boolean {
         this._success = false;
         return true;
      }
      
      public function pulled() : Boolean {
         if(!this.switching)
         {
            if(Kernel.getWorker().contains(CommonExchangeManagementFrame))
            {
               Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
            }
            KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave,this._success);
         }
         return true;
      }
      
      private function get _kernelEventsManager() : KernelEventsManager {
         return KernelEventsManager.getInstance();
      }
      
      private function getTypeObject(pType:uint) : TypeObjectData {
         var tod:TypeObjectData = null;
         if(this._bidHouseObjects == null)
         {
            return null;
         }
         for each(tod in this._bidHouseObjects)
         {
            if(tod.typeObject == pType)
            {
               return tod;
            }
         }
         return null;
      }
      
      private function getGIDObject(pType:uint, pGID:uint) : GIDObjectData {
         var god:GIDObjectData = null;
         if(this._bidHouseObjects == null)
         {
            return null;
         }
         var typeObjectData:TypeObjectData = this.getTypeObject(pType);
         if(typeObjectData == null)
         {
            return null;
         }
         for each(god in typeObjectData.objects)
         {
            if(god.GIDObject == pGID)
            {
               return god;
            }
         }
         return null;
      }
      
      private function getGIDObjectIndex(pType:uint, pGID:uint) : int {
         var god:GIDObjectData = null;
         if(this._bidHouseObjects == null)
         {
            return -1;
         }
         var typeObjectData:TypeObjectData = this.getTypeObject(pType);
         if(typeObjectData == null)
         {
            return -1;
         }
         var index:int = 0;
         for each(god in typeObjectData.objects)
         {
            if(god.GIDObject == pGID)
            {
               return index;
            }
            index++;
         }
         return -1;
      }
      
      private function initSearchMode(types:Vector.<uint>) : void {
         var nTypes:* = 0;
         var reset:* = false;
         var i:* = 0;
         if(this._itemsTypesAllowed)
         {
            nTypes = types.length;
            if(nTypes == this._itemsTypesAllowed.length)
            {
               reset = false;
               i = 0;
               while(i < nTypes)
               {
                  if(types[i] != this._itemsTypesAllowed[i])
                  {
                     reset = true;
                     break;
                  }
                  i++;
               }
               if(reset)
               {
                  this._listItemsSearchMode = null;
               }
            }
            else
            {
               this._listItemsSearchMode = null;
            }
         }
         else
         {
            this._listItemsSearchMode = null;
         }
         this._itemsTypesAllowed = types;
      }
   }
}
import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;

class ItemSellByPlayer extends Object
{
   
   function ItemSellByPlayer(pItemWrapper:ItemWrapper, pPrice:int, pUnsoldDelay:uint) {
      super();
      this.itemWrapper = pItemWrapper;
      this.price = pPrice;
      this.unsoldDelay = pUnsoldDelay;
   }
   
   public var itemWrapper:ItemWrapper;
   
   public var price:int;
   
   public var unsoldDelay:uint;
}
import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;

class ItemSellByBid extends Object
{
   
   function ItemSellByBid(pItemWrapper:ItemWrapper, pPrices:Vector.<int>) {
      super();
      this.itemWrapper = pItemWrapper;
      this.prices = pPrices;
   }
   
   public var itemWrapper:ItemWrapper;
   
   public var prices:Vector.<int>;
}
class TypeObjectData extends Object
{
   
   function TypeObjectData(pTypeObject:uint, pObjects:Array) {
      super();
      this.objects = pObjects;
      this.typeObject = pTypeObject;
   }
   
   public var objects:Array;
   
   public var typeObject:uint;
}
class GIDObjectData extends Object
{
   
   function GIDObjectData(pGIDObject:uint, pObjects:Array) {
      super();
      this.objects = pObjects;
      this.GIDObject = pGIDObject;
   }
   
   public var objects:Array;
   
   public var GIDObject:uint;
}
