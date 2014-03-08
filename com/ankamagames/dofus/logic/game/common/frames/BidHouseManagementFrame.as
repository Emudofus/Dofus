package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
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
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BidHouseManagementFrame));
      
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
      
      public function set switching(param1:Boolean) : void {
         this._switching = param1;
      }
      
      public function processExchangeStartedBidSellerMessage(param1:ExchangeStartedBidSellerMessage) : void {
         var _loc3_:ObjectItemToSellInBid = null;
         var _loc4_:ItemWrapper = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         this._switching = false;
         var _loc2_:ExchangeStartedBidSellerMessage = param1 as ExchangeStartedBidSellerMessage;
         this._NPCId = _loc2_.sellerDescriptor.npcContextualId;
         this.initSearchMode(_loc2_.sellerDescriptor.types);
         this._vendorObjects = new Array();
         for each (_loc3_ in _loc2_.objectsInfos)
         {
            _loc4_ = ItemWrapper.create(63,_loc3_.objectUID,_loc3_.objectGID,_loc3_.quantity,_loc3_.effects);
            _loc5_ = _loc3_.objectPrice;
            _loc6_ = _loc3_.unsoldDelay;
            this._vendorObjects.push(new ItemSellByPlayer(_loc4_,_loc5_,_loc6_));
         }
         this._vendorObjects.sortOn("unsoldDelay",Array.NUMERIC);
         this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedBidSeller,_loc2_.sellerDescriptor,_loc2_.objectsInfos);
         this._kernelEventsManager.processCallback(ExchangeHookList.SellerObjectListUpdate,this._vendorObjects);
      }
      
      public function processExchangeStartedBidBuyerMessage(param1:ExchangeStartedBidBuyerMessage) : void {
         var _loc3_:uint = 0;
         this._switching = false;
         var _loc2_:ExchangeStartedBidBuyerMessage = param1 as ExchangeStartedBidBuyerMessage;
         this._NPCId = _loc2_.buyerDescriptor.npcContextualId;
         this.initSearchMode(_loc2_.buyerDescriptor.types);
         this._bidHouseObjects = new Array();
         for each (_loc3_ in _loc2_.buyerDescriptor.types)
         {
            this._bidHouseObjects.push(new TypeObjectData(_loc3_,null));
         }
         this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedBidBuyer,_loc2_.buyerDescriptor);
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:ExchangeBidHouseSearchAction = null;
         var _loc3_:ExchangeBidHouseListAction = null;
         var _loc4_:ExchangeBidHouseTypeAction = null;
         var _loc5_:ExchangeBidHouseTypeMessage = null;
         var _loc6_:ExchangeBidHouseBuyAction = null;
         var _loc7_:ExchangeBidHouseBuyMessage = null;
         var _loc8_:ExchangeBidHousePriceAction = null;
         var _loc9_:ExchangeBidHousePriceMessage = null;
         var _loc10_:ExchangeBidPriceForSellerMessage = null;
         var _loc11_:ExchangeBidPriceMessage = null;
         var _loc12_:ExchangeBidHouseItemAddOkMessage = null;
         var _loc13_:Item = null;
         var _loc14_:ItemWrapper = null;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:ExchangeBidHouseItemRemoveOkMessage = null;
         var _loc18_:uint = 0;
         var _loc19_:ExchangeBidHouseGenericItemAddedMessage = null;
         var _loc20_:TypeObjectData = null;
         var _loc21_:ExchangeBidHouseGenericItemRemovedMessage = null;
         var _loc22_:TypeObjectData = null;
         var _loc23_:* = 0;
         var _loc24_:ExchangeObjectModifyPricedAction = null;
         var _loc25_:ExchangeObjectModifyPricedMessage = null;
         var _loc26_:ExchangeBidHouseInListUpdatedMessage = null;
         var _loc27_:TypeObjectData = null;
         var _loc28_:GIDObjectData = null;
         var _loc29_:ExchangeBidHouseInListAddedMessage = null;
         var _loc30_:TypeObjectData = null;
         var _loc31_:GIDObjectData = null;
         var _loc32_:ExchangeBidHouseInListRemovedMessage = null;
         var _loc33_:uint = 0;
         var _loc34_:GIDObjectData = null;
         var _loc35_:uint = 0;
         var _loc36_:ExchangeTypesExchangerDescriptionForUserMessage = null;
         var _loc37_:TypeObjectData = null;
         var _loc38_:ExchangeTypesItemsExchangerDescriptionForUserMessage = null;
         var _loc39_:GIDObjectData = null;
         var _loc40_:GIDObjectData = null;
         var _loc41_:ExchangeBidSearchOkMessage = null;
         var _loc42_:BidHouseStringSearchAction = null;
         var _loc43_:String = null;
         var _loc44_:* = 0;
         var _loc45_:* = 0;
         var _loc46_:* = 0;
         var _loc47_:Vector.<uint> = null;
         var _loc48_:NpcGenericActionRequestMessage = null;
         var _loc49_:NpcGenericActionRequestMessage = null;
         var _loc50_:ExchangeLeaveMessage = null;
         var _loc51_:ExchangeBidHouseSearchMessage = null;
         var _loc52_:ExchangeBidHouseListMessage = null;
         var _loc53_:ExchangeBidHouseListMessage = null;
         var _loc54_:ItemSellByPlayer = null;
         var _loc55_:GIDObjectData = null;
         var _loc56_:ItemSellByBid = null;
         var _loc57_:Vector.<int> = null;
         var _loc58_:uint = 0;
         var _loc59_:GIDObjectData = null;
         var _loc60_:ItemWrapper = null;
         var _loc61_:Vector.<int> = null;
         var _loc62_:uint = 0;
         var _loc63_:GIDObjectData = null;
         var _loc64_:ItemWrapper = null;
         var _loc65_:Vector.<int> = null;
         var _loc66_:uint = 0;
         var _loc67_:ItemSellByBid = null;
         var _loc68_:TypeObjectData = null;
         var _loc69_:Array = null;
         var _loc70_:GIDObjectData = null;
         var _loc71_:uint = 0;
         var _loc72_:TypeObjectData = null;
         var _loc73_:GIDObjectData = null;
         var _loc74_:BidExchangerObjectInfo = null;
         var _loc75_:ItemWrapper = null;
         var _loc76_:Vector.<int> = null;
         var _loc77_:uint = 0;
         var _loc78_:Array = null;
         var _loc79_:Object = null;
         var _loc80_:String = null;
         switch(true)
         {
            case param1 is ExchangeBidHouseSearchAction:
               _loc2_ = param1 as ExchangeBidHouseSearchAction;
               if(!(this._typeAsk == _loc2_.type) || this._typeAsk == _loc2_.type)
               {
                  _loc51_ = new ExchangeBidHouseSearchMessage();
                  _loc51_.initExchangeBidHouseSearchMessage(_loc2_.type,_loc2_.genId);
                  this._typeAsk = _loc2_.type;
                  this._GIDAsk = _loc2_.genId;
                  ConnectionsHandler.getConnection().send(_loc51_);
               }
               return true;
            case param1 is ExchangeBidHouseListAction:
               _loc3_ = param1 as ExchangeBidHouseListAction;
               if(this._GIDAsk != _loc3_.id)
               {
                  this._GIDAsk = _loc3_.id;
                  _loc52_ = new ExchangeBidHouseListMessage();
                  _loc52_.initExchangeBidHouseListMessage(_loc3_.id);
                  ConnectionsHandler.getConnection().send(_loc52_);
               }
               else
               {
                  _loc53_ = new ExchangeBidHouseListMessage();
                  _loc53_.initExchangeBidHouseListMessage(_loc3_.id);
                  ConnectionsHandler.getConnection().send(_loc53_);
               }
               return true;
            case param1 is ExchangeBidHouseTypeAction:
               _loc4_ = param1 as ExchangeBidHouseTypeAction;
               _loc5_ = new ExchangeBidHouseTypeMessage();
               if(this._typeAsk != _loc4_.type)
               {
                  this._typeAsk = _loc4_.type;
                  _loc5_.initExchangeBidHouseTypeMessage(_loc4_.type);
                  ConnectionsHandler.getConnection().send(_loc5_);
               }
               else
               {
                  _loc5_.initExchangeBidHouseTypeMessage(_loc4_.type);
                  ConnectionsHandler.getConnection().send(_loc5_);
               }
               return true;
            case param1 is ExchangeBidHouseBuyAction:
               _loc6_ = param1 as ExchangeBidHouseBuyAction;
               _loc7_ = new ExchangeBidHouseBuyMessage();
               _loc7_.initExchangeBidHouseBuyMessage(_loc6_.uid,_loc6_.qty,_loc6_.price);
               ConnectionsHandler.getConnection().send(_loc7_);
               return true;
            case param1 is ExchangeBidHousePriceAction:
               _loc8_ = param1 as ExchangeBidHousePriceAction;
               _loc9_ = new ExchangeBidHousePriceMessage();
               _loc9_.initExchangeBidHousePriceMessage(_loc8_.genId);
               ConnectionsHandler.getConnection().send(_loc9_);
               return true;
            case param1 is ExchangeBidPriceForSellerMessage:
               _loc10_ = param1 as ExchangeBidPriceForSellerMessage;
               this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeBidPriceForSeller,_loc10_.genericId,_loc10_.averagePrice,_loc10_.minimalPrices,_loc10_.allIdentical);
               return true;
            case param1 is ExchangeBidPriceMessage:
               _loc11_ = param1 as ExchangeBidPriceMessage;
               this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeBidPrice,_loc11_.genericId,_loc11_.averagePrice);
               return true;
            case param1 is ExchangeBidHouseItemAddOkMessage:
               _loc12_ = param1 as ExchangeBidHouseItemAddOkMessage;
               _loc13_ = Item.getItemById(_loc12_.itemInfo.objectGID);
               _loc14_ = ItemWrapper.create(63,_loc12_.itemInfo.objectUID,_loc12_.itemInfo.objectGID,_loc12_.itemInfo.quantity,_loc12_.itemInfo.effects);
               _loc15_ = _loc12_.itemInfo.objectPrice;
               _loc16_ = _loc12_.itemInfo.unsoldDelay;
               this._vendorObjects.push(new ItemSellByPlayer(_loc14_,_loc15_,_loc16_));
               this._kernelEventsManager.processCallback(ExchangeHookList.SellerObjectListUpdate,this._vendorObjects);
               return true;
            case param1 is ExchangeBidHouseItemRemoveOkMessage:
               _loc17_ = param1 as ExchangeBidHouseItemRemoveOkMessage;
               _loc18_ = 0;
               for each (_loc54_ in this._vendorObjects)
               {
                  if(_loc54_.itemWrapper.objectUID == _loc17_.sellerId)
                  {
                     this._vendorObjects.splice(_loc18_,1);
                  }
                  _loc18_++;
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.SellerObjectListUpdate,this._vendorObjects);
               return true;
            case param1 is ExchangeBidHouseGenericItemAddedMessage:
               _loc19_ = param1 as ExchangeBidHouseGenericItemAddedMessage;
               _loc20_ = this.getTypeObject(this._typeAsk);
               _loc20_.objects.push(new GIDObjectData(_loc19_.objGenericId,new Array()));
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,_loc20_.objects);
               return true;
            case param1 is ExchangeBidHouseGenericItemRemovedMessage:
               _loc21_ = param1 as ExchangeBidHouseGenericItemRemovedMessage;
               _loc22_ = this.getTypeObject(this._typeAsk);
               _loc23_ = this.getGIDObjectIndex(this._typeAsk,_loc21_.objGenericId);
               if(_loc23_ == -1)
               {
                  return true;
               }
               _loc22_.objects.splice(_loc23_,1);
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,_loc22_.objects);
               return true;
            case param1 is ExchangeObjectModifyPricedAction:
               _loc24_ = param1 as ExchangeObjectModifyPricedAction;
               _loc25_ = new ExchangeObjectModifyPricedMessage();
               _loc25_.initExchangeObjectModifyPricedMessage(_loc24_.objectUID,_loc24_.quantity,_loc24_.price);
               ConnectionsHandler.getConnection().send(_loc25_);
               return true;
            case param1 is ExchangeBidHouseInListUpdatedMessage:
               _loc26_ = param1 as ExchangeBidHouseInListUpdatedMessage;
               _loc27_ = this.getTypeObject(this._typeAsk);
               for each (_loc55_ in _loc27_.objects)
               {
                  if(_loc55_.GIDObject == _loc26_.objGenericId)
                  {
                     _loc28_ = _loc55_;
                     for each (_loc56_ in _loc55_.objects)
                     {
                        if(_loc56_.itemWrapper.objectUID == _loc26_.itemUID)
                        {
                           _loc56_.itemWrapper.update(63,_loc26_.itemUID,_loc26_.objGenericId,1,_loc26_.effects);
                           _loc57_ = new Vector.<int>();
                           for each (_loc58_ in _loc26_.prices)
                           {
                              _loc57_.push(_loc58_ as int);
                           }
                           _loc56_.prices = _loc57_;
                        }
                     }
                  }
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate,_loc28_.objects);
               return true;
            case param1 is ExchangeBidHouseInListAddedMessage:
               _loc29_ = param1 as ExchangeBidHouseInListAddedMessage;
               _loc30_ = this.getTypeObject(this._typeAsk);
               for each (_loc59_ in _loc30_.objects)
               {
                  if(_loc59_.GIDObject == _loc29_.objGenericId)
                  {
                     _loc31_ = _loc59_;
                     if(_loc59_.objects == null)
                     {
                        _loc59_.objects = new Array();
                     }
                     _loc60_ = ItemWrapper.create(63,_loc29_.itemUID,_loc29_.objGenericId,1,_loc29_.effects);
                     _loc61_ = new Vector.<int>();
                     for each (_loc62_ in _loc29_.prices)
                     {
                        _loc61_.push(_loc62_ as int);
                     }
                     _loc59_.objects.push(new ItemSellByBid(_loc60_,_loc61_));
                  }
               }
               if(!_loc31_)
               {
                  _loc63_ = new GIDObjectData(_loc29_.objGenericId,new Array());
                  _loc31_ = _loc63_;
                  _loc64_ = ItemWrapper.create(63,_loc29_.itemUID,_loc29_.objGenericId,1,_loc29_.effects);
                  _loc65_ = new Vector.<int>();
                  for each (_loc66_ in _loc29_.prices)
                  {
                     _loc65_.push(_loc66_ as int);
                  }
                  _loc63_.objects.push(new ItemSellByBid(_loc64_,_loc65_));
                  _loc30_.objects.push(_loc63_);
                  this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,_loc30_.objects);
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate,_loc31_.objects);
               return true;
            case param1 is ExchangeBidHouseInListRemovedMessage:
               _loc32_ = param1 as ExchangeBidHouseInListRemovedMessage;
               _loc33_ = 0;
               _loc34_ = this.getGIDObject(this._typeAsk,this._GIDAsk);
               _loc35_ = 0;
               if(_loc34_ == null)
               {
                  return true;
               }
               for each (_loc67_ in _loc34_.objects)
               {
                  if(_loc32_.itemUID == _loc67_.itemWrapper.objectUID)
                  {
                     _loc34_.objects.splice(_loc35_,1);
                  }
                  _loc35_++;
               }
               if(_loc34_.objects.length == 0)
               {
                  _loc68_ = this.getTypeObject(this._typeAsk);
                  _loc69_ = new Array();
                  for each (_loc70_ in _loc68_.objects)
                  {
                     if(_loc70_.GIDObject != this._GIDAsk)
                     {
                        _loc69_.push(_loc70_);
                     }
                  }
                  _loc68_.objects = _loc69_;
                  this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,_loc68_.objects);
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate,_loc34_.objects);
               return true;
            case param1 is ExchangeTypesExchangerDescriptionForUserMessage:
               _loc36_ = param1 as ExchangeTypesExchangerDescriptionForUserMessage;
               _loc37_ = this.getTypeObject(this._typeAsk);
               _loc37_.objects = new Array();
               for each (_loc71_ in _loc36_.typeDescription)
               {
                  _loc37_.objects.push(new GIDObjectData(_loc71_,new Array()));
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,_loc37_.objects);
               return true;
            case param1 is ExchangeTypesItemsExchangerDescriptionForUserMessage:
               _loc38_ = param1 as ExchangeTypesItemsExchangerDescriptionForUserMessage;
               _loc39_ = this.getGIDObject(this._typeAsk,this._GIDAsk);
               if(!_loc39_)
               {
                  _loc72_ = this.getTypeObject(this._typeAsk);
                  _loc73_ = new GIDObjectData(this._GIDAsk,new Array());
                  if(!_loc72_.objects)
                  {
                     _loc72_.objects = new Array();
                  }
                  if(_loc72_.objects.indexOf(_loc73_) == -1)
                  {
                     _loc72_.objects.push(_loc73_);
                  }
               }
               _loc40_ = this.getGIDObject(this._typeAsk,this._GIDAsk);
               if(_loc40_)
               {
                  _loc40_.objects = new Array();
                  for each (_loc74_ in _loc38_.itemTypeDescriptions)
                  {
                     _loc75_ = ItemWrapper.create(63,_loc74_.objectUID,this._GIDAsk,1,_loc74_.effects);
                     _loc76_ = new Vector.<int>();
                     for each (_loc77_ in _loc74_.prices)
                     {
                        _loc76_.push(_loc77_ as int);
                     }
                     _loc40_.objects.push(new ItemSellByBid(_loc75_,_loc76_));
                  }
                  this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate,_loc40_.objects,false,true);
               }
               else
               {
                  this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate,null,false,true);
               }
               return true;
            case param1 is ExchangeBidSearchOkMessage:
               _loc41_ = param1 as ExchangeBidSearchOkMessage;
               return true;
            case param1 is BidHouseStringSearchAction:
               _loc42_ = param1 as BidHouseStringSearchAction;
               _loc43_ = _loc42_.searchString;
               _loc46_ = getTimer();
               _loc47_ = new Vector.<uint>();
               if(this._listItemsSearchMode == null)
               {
                  this._listItemsSearchMode = new Array();
                  _loc78_ = Item.getItems();
                  _loc45_ = _loc78_.length;
                  _loc44_ = 0;
                  while(_loc44_ < _loc45_)
                  {
                     _loc79_ = _loc78_[_loc44_];
                     if((_loc79_) && !(this._itemsTypesAllowed.indexOf(_loc79_.typeId) == -1))
                     {
                        if(_loc79_.name)
                        {
                           this._listItemsSearchMode.push(_loc79_.name.toLowerCase(),_loc79_.id);
                        }
                     }
                     _loc44_++;
                  }
                  _log.debug("Initialisation recherche HDV en " + (getTimer() - _loc46_) + " ms.");
               }
               _loc45_ = this._listItemsSearchMode.length;
               _loc44_ = 0;
               while(_loc44_ < _loc45_)
               {
                  _loc80_ = this._listItemsSearchMode[_loc44_];
                  if(_loc80_.indexOf(_loc43_) != -1)
                  {
                     _loc47_.push(this._listItemsSearchMode[_loc44_ + 1]);
                  }
                  _loc44_ = _loc44_ + 2;
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,_loc47_,true);
               return true;
            case param1 is BidSwitchToBuyerModeAction:
               this._switching = true;
               _loc48_ = new NpcGenericActionRequestMessage();
               _loc48_.initNpcGenericActionRequestMessage(this._NPCId,6,PlayedCharacterManager.getInstance().currentMap.mapId);
               ConnectionsHandler.getConnection().send(_loc48_);
               return true;
            case param1 is BidSwitchToSellerModeAction:
               this._switching = true;
               _loc49_ = new NpcGenericActionRequestMessage();
               _loc49_.initNpcGenericActionRequestMessage(this._NPCId,5,PlayedCharacterManager.getInstance().currentMap.mapId);
               ConnectionsHandler.getConnection().send(_loc49_);
               return true;
            case param1 is ExchangeLeaveMessage:
               _loc50_ = param1 as ExchangeLeaveMessage;
               if(_loc50_.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
               {
                  PlayedCharacterManager.getInstance().isInExchange = false;
                  this._success = _loc50_.success;
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
            default:
               return false;
         }
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
      
      private function getTypeObject(param1:uint) : TypeObjectData {
         var _loc2_:TypeObjectData = null;
         if(this._bidHouseObjects == null)
         {
            return null;
         }
         for each (_loc2_ in this._bidHouseObjects)
         {
            if(_loc2_.typeObject == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getGIDObject(param1:uint, param2:uint) : GIDObjectData {
         var _loc4_:GIDObjectData = null;
         if(this._bidHouseObjects == null)
         {
            return null;
         }
         var _loc3_:TypeObjectData = this.getTypeObject(param1);
         if(_loc3_ == null)
         {
            return null;
         }
         for each (_loc4_ in _loc3_.objects)
         {
            if(_loc4_.GIDObject == param2)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      private function getGIDObjectIndex(param1:uint, param2:uint) : int {
         var _loc5_:GIDObjectData = null;
         if(this._bidHouseObjects == null)
         {
            return -1;
         }
         var _loc3_:TypeObjectData = this.getTypeObject(param1);
         if(_loc3_ == null)
         {
            return -1;
         }
         var _loc4_:* = 0;
         for each (_loc5_ in _loc3_.objects)
         {
            if(_loc5_.GIDObject == param2)
            {
               return _loc4_;
            }
            _loc4_++;
         }
         return -1;
      }
      
      private function initSearchMode(param1:Vector.<uint>) : void {
         var _loc2_:* = 0;
         var _loc3_:* = false;
         var _loc4_:* = 0;
         if(this._itemsTypesAllowed)
         {
            _loc2_ = param1.length;
            if(_loc2_ == this._itemsTypesAllowed.length)
            {
               _loc3_ = false;
               _loc4_ = 0;
               while(_loc4_ < _loc2_)
               {
                  if(param1[_loc4_] != this._itemsTypesAllowed[_loc4_])
                  {
                     _loc3_ = true;
                     break;
                  }
                  _loc4_++;
               }
               if(_loc3_)
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
         this._itemsTypesAllowed = param1;
      }
   }
}
import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;

class ItemSellByPlayer extends Object
{
   
   function ItemSellByPlayer(param1:ItemWrapper, param2:int, param3:uint) {
      super();
      this.itemWrapper = param1;
      this.price = param2;
      this.unsoldDelay = param3;
   }
   
   public var itemWrapper:ItemWrapper;
   
   public var price:int;
   
   public var unsoldDelay:uint;
}
import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
import __AS3__.vec.Vector;

class ItemSellByBid extends Object
{
   
   function ItemSellByBid(param1:ItemWrapper, param2:Vector.<int>) {
      super();
      this.itemWrapper = param1;
      this.prices = param2;
   }
   
   public var itemWrapper:ItemWrapper;
   
   public var prices:Vector.<int>;
}
class TypeObjectData extends Object
{
   
   function TypeObjectData(param1:uint, param2:Array) {
      super();
      this.objects = param2;
      this.typeObject = param1;
   }
   
   public var objects:Array;
   
   public var typeObject:uint;
}
class GIDObjectData extends Object
{
   
   function GIDObjectData(param1:uint, param2:Array) {
      super();
      this.objects = param2;
      this.GIDObject = param1;
   }
   
   public var objects:Array;
   
   public var GIDObject:uint;
}
