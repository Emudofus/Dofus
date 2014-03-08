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
   import __AS3__.vec.*;
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
         for each (objectInfo in esbsmsg.objectsInfos)
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
         for each (typeObject in esbbmsg.buyerDescriptor.types)
         {
            this._bidHouseObjects.push(new TypeObjectData(typeObject,null));
         }
         this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedBidBuyer,esbbmsg.buyerDescriptor);
      }
      
      public function process(msg:Message) : Boolean {
         var ebhsa:ExchangeBidHouseSearchAction = null;
         var ebhla:ExchangeBidHouseListAction = null;
         var ebhta:ExchangeBidHouseTypeAction = null;
         var ebhtmsg:ExchangeBidHouseTypeMessage = null;
         var ebhba:ExchangeBidHouseBuyAction = null;
         var ebhbmsg:ExchangeBidHouseBuyMessage = null;
         var ebhpa:ExchangeBidHousePriceAction = null;
         var ebhpmsg:ExchangeBidHousePriceMessage = null;
         var ebpfsmsg:ExchangeBidPriceForSellerMessage = null;
         var ebpmsg:ExchangeBidPriceMessage = null;
         var ebhiaomsg:ExchangeBidHouseItemAddOkMessage = null;
         var item:Item = null;
         var iwrapper:ItemWrapper = null;
         var priceObject:uint = 0;
         var unsoldDelay:uint = 0;
         var ebhiromsg:ExchangeBidHouseItemRemoveOkMessage = null;
         var comptSellItem:uint = 0;
         var ebhgiamsg:ExchangeBidHouseGenericItemAddedMessage = null;
         var typeObjectDt:TypeObjectData = null;
         var ebhgirmsg:ExchangeBidHouseGenericItemRemovedMessage = null;
         var typeObjectD:TypeObjectData = null;
         var gidIndex:* = 0;
         var eompa:ExchangeObjectModifyPricedAction = null;
         var eomfpmsg:ExchangeObjectModifyPricedMessage = null;
         var ebhilumsg:ExchangeBidHouseInListUpdatedMessage = null;
         var utypeObjects:TypeObjectData = null;
         var ugodat:GIDObjectData = null;
         var ebhilamsg:ExchangeBidHouseInListAddedMessage = null;
         var typeObjects:TypeObjectData = null;
         var godat:GIDObjectData = null;
         var ebhilrmsg:ExchangeBidHouseInListRemovedMessage = null;
         var GID:uint = 0;
         var GIDobj:GIDObjectData = null;
         var comptGID:uint = 0;
         var etedfumsg:ExchangeTypesExchangerDescriptionForUserMessage = null;
         var tod:TypeObjectData = null;
         var etiedfumsg:ExchangeTypesItemsExchangerDescriptionForUserMessage = null;
         var goData0:GIDObjectData = null;
         var goData:GIDObjectData = null;
         var ebsomsg:ExchangeBidSearchOkMessage = null;
         var bhssa:BidHouseStringSearchAction = null;
         var searchText:String = null;
         var i:* = 0;
         var nItems:* = 0;
         var time:* = 0;
         var itemsMatch:Vector.<uint> = null;
         var buyngarmsg:NpcGenericActionRequestMessage = null;
         var sellngarmsg:NpcGenericActionRequestMessage = null;
         var elm:ExchangeLeaveMessage = null;
         var ebhsmsg:ExchangeBidHouseSearchMessage = null;
         var ebhlmsg:ExchangeBidHouseListMessage = null;
         var ebhlmsg2:ExchangeBidHouseListMessage = null;
         var objectToSell:ItemSellByPlayer = null;
         var ugoda:GIDObjectData = null;
         var objectUpdate:ItemSellByBid = null;
         var objectsuPrice:Vector.<int> = null;
         var priceu:uint = 0;
         var goda:GIDObjectData = null;
         var itemwra:ItemWrapper = null;
         var objectsPrice:Vector.<int> = null;
         var pric:uint = 0;
         var newGIDObject:GIDObjectData = null;
         var itemwra2:ItemWrapper = null;
         var objectsPrice2:Vector.<int> = null;
         var pric2:uint = 0;
         var isbbid:ItemSellByBid = null;
         var tod1:TypeObjectData = null;
         var tempObjects:Array = null;
         var objectGIDD:GIDObjectData = null;
         var objectGID:uint = 0;
         var tod0:TypeObjectData = null;
         var goTest:GIDObjectData = null;
         var objectInfo:BidExchangerObjectInfo = null;
         var itemW:ItemWrapper = null;
         var objectsPrices:Vector.<int> = null;
         var pri:uint = 0;
         var lsItems:Array = null;
         var currentItem:Object = null;
         var currentName:String = null;
         switch(true)
         {
            case msg is ExchangeBidHouseSearchAction:
               ebhsa = msg as ExchangeBidHouseSearchAction;
               if((!(this._typeAsk == ebhsa.type)) || (this._typeAsk == ebhsa.type))
               {
                  ebhsmsg = new ExchangeBidHouseSearchMessage();
                  ebhsmsg.initExchangeBidHouseSearchMessage(ebhsa.type,ebhsa.genId);
                  this._typeAsk = ebhsa.type;
                  this._GIDAsk = ebhsa.genId;
                  ConnectionsHandler.getConnection().send(ebhsmsg);
               }
               return true;
            case msg is ExchangeBidHouseListAction:
               ebhla = msg as ExchangeBidHouseListAction;
               if(this._GIDAsk != ebhla.id)
               {
                  this._GIDAsk = ebhla.id;
                  ebhlmsg = new ExchangeBidHouseListMessage();
                  ebhlmsg.initExchangeBidHouseListMessage(ebhla.id);
                  ConnectionsHandler.getConnection().send(ebhlmsg);
               }
               else
               {
                  ebhlmsg2 = new ExchangeBidHouseListMessage();
                  ebhlmsg2.initExchangeBidHouseListMessage(ebhla.id);
                  ConnectionsHandler.getConnection().send(ebhlmsg2);
               }
               return true;
            case msg is ExchangeBidHouseTypeAction:
               ebhta = msg as ExchangeBidHouseTypeAction;
               ebhtmsg = new ExchangeBidHouseTypeMessage();
               if(this._typeAsk != ebhta.type)
               {
                  this._typeAsk = ebhta.type;
                  ebhtmsg.initExchangeBidHouseTypeMessage(ebhta.type);
                  ConnectionsHandler.getConnection().send(ebhtmsg);
               }
               else
               {
                  ebhtmsg.initExchangeBidHouseTypeMessage(ebhta.type);
                  ConnectionsHandler.getConnection().send(ebhtmsg);
               }
               return true;
            case msg is ExchangeBidHouseBuyAction:
               ebhba = msg as ExchangeBidHouseBuyAction;
               ebhbmsg = new ExchangeBidHouseBuyMessage();
               ebhbmsg.initExchangeBidHouseBuyMessage(ebhba.uid,ebhba.qty,ebhba.price);
               ConnectionsHandler.getConnection().send(ebhbmsg);
               return true;
            case msg is ExchangeBidHousePriceAction:
               ebhpa = msg as ExchangeBidHousePriceAction;
               ebhpmsg = new ExchangeBidHousePriceMessage();
               ebhpmsg.initExchangeBidHousePriceMessage(ebhpa.genId);
               ConnectionsHandler.getConnection().send(ebhpmsg);
               return true;
            case msg is ExchangeBidPriceForSellerMessage:
               ebpfsmsg = msg as ExchangeBidPriceForSellerMessage;
               this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeBidPriceForSeller,ebpfsmsg.genericId,ebpfsmsg.averagePrice,ebpfsmsg.minimalPrices,ebpfsmsg.allIdentical);
               return true;
            case msg is ExchangeBidPriceMessage:
               ebpmsg = msg as ExchangeBidPriceMessage;
               this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeBidPrice,ebpmsg.genericId,ebpmsg.averagePrice);
               return true;
            case msg is ExchangeBidHouseItemAddOkMessage:
               ebhiaomsg = msg as ExchangeBidHouseItemAddOkMessage;
               item = Item.getItemById(ebhiaomsg.itemInfo.objectGID);
               iwrapper = ItemWrapper.create(63,ebhiaomsg.itemInfo.objectUID,ebhiaomsg.itemInfo.objectGID,ebhiaomsg.itemInfo.quantity,ebhiaomsg.itemInfo.effects);
               priceObject = ebhiaomsg.itemInfo.objectPrice;
               unsoldDelay = ebhiaomsg.itemInfo.unsoldDelay;
               this._vendorObjects.push(new ItemSellByPlayer(iwrapper,priceObject,unsoldDelay));
               this._kernelEventsManager.processCallback(ExchangeHookList.SellerObjectListUpdate,this._vendorObjects);
               return true;
            case msg is ExchangeBidHouseItemRemoveOkMessage:
               ebhiromsg = msg as ExchangeBidHouseItemRemoveOkMessage;
               comptSellItem = 0;
               for each (objectToSell in this._vendorObjects)
               {
                  if(objectToSell.itemWrapper.objectUID == ebhiromsg.sellerId)
                  {
                     this._vendorObjects.splice(comptSellItem,1);
                  }
                  comptSellItem++;
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.SellerObjectListUpdate,this._vendorObjects);
               return true;
            case msg is ExchangeBidHouseGenericItemAddedMessage:
               ebhgiamsg = msg as ExchangeBidHouseGenericItemAddedMessage;
               typeObjectDt = this.getTypeObject(this._typeAsk);
               typeObjectDt.objects.push(new GIDObjectData(ebhgiamsg.objGenericId,new Array()));
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,typeObjectDt.objects);
               return true;
            case msg is ExchangeBidHouseGenericItemRemovedMessage:
               ebhgirmsg = msg as ExchangeBidHouseGenericItemRemovedMessage;
               typeObjectD = this.getTypeObject(this._typeAsk);
               gidIndex = this.getGIDObjectIndex(this._typeAsk,ebhgirmsg.objGenericId);
               if(gidIndex == -1)
               {
                  return true;
               }
               typeObjectD.objects.splice(gidIndex,1);
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,typeObjectD.objects);
               return true;
            case msg is ExchangeObjectModifyPricedAction:
               eompa = msg as ExchangeObjectModifyPricedAction;
               eomfpmsg = new ExchangeObjectModifyPricedMessage();
               eomfpmsg.initExchangeObjectModifyPricedMessage(eompa.objectUID,eompa.quantity,eompa.price);
               ConnectionsHandler.getConnection().send(eomfpmsg);
               return true;
            case msg is ExchangeBidHouseInListUpdatedMessage:
               ebhilumsg = msg as ExchangeBidHouseInListUpdatedMessage;
               utypeObjects = this.getTypeObject(this._typeAsk);
               for each (ugoda in utypeObjects.objects)
               {
                  if(ugoda.GIDObject == ebhilumsg.objGenericId)
                  {
                     ugodat = ugoda;
                     for each (objectUpdate in ugoda.objects)
                     {
                        if(objectUpdate.itemWrapper.objectUID == ebhilumsg.itemUID)
                        {
                           objectUpdate.itemWrapper.update(63,ebhilumsg.itemUID,ebhilumsg.objGenericId,1,ebhilumsg.effects);
                           objectsuPrice = new Vector.<int>();
                           for each (priceu in ebhilumsg.prices)
                           {
                              objectsuPrice.push(priceu as int);
                           }
                           objectUpdate.prices = objectsuPrice;
                        }
                     }
                  }
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate,ugodat.objects);
               return true;
            case msg is ExchangeBidHouseInListAddedMessage:
               ebhilamsg = msg as ExchangeBidHouseInListAddedMessage;
               typeObjects = this.getTypeObject(this._typeAsk);
               for each (goda in typeObjects.objects)
               {
                  if(goda.GIDObject == ebhilamsg.objGenericId)
                  {
                     godat = goda;
                     if(goda.objects == null)
                     {
                        goda.objects = new Array();
                     }
                     itemwra = ItemWrapper.create(63,ebhilamsg.itemUID,ebhilamsg.objGenericId,1,ebhilamsg.effects);
                     objectsPrice = new Vector.<int>();
                     for each (pric in ebhilamsg.prices)
                     {
                        objectsPrice.push(pric as int);
                     }
                     goda.objects.push(new ItemSellByBid(itemwra,objectsPrice));
                  }
               }
               if(!godat)
               {
                  newGIDObject = new GIDObjectData(ebhilamsg.objGenericId,new Array());
                  godat = newGIDObject;
                  itemwra2 = ItemWrapper.create(63,ebhilamsg.itemUID,ebhilamsg.objGenericId,1,ebhilamsg.effects);
                  objectsPrice2 = new Vector.<int>();
                  for each (pric2 in ebhilamsg.prices)
                  {
                     objectsPrice2.push(pric2 as int);
                  }
                  newGIDObject.objects.push(new ItemSellByBid(itemwra2,objectsPrice2));
                  typeObjects.objects.push(newGIDObject);
                  this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,typeObjects.objects);
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate,godat.objects);
               return true;
            case msg is ExchangeBidHouseInListRemovedMessage:
               ebhilrmsg = msg as ExchangeBidHouseInListRemovedMessage;
               GID = 0;
               GIDobj = this.getGIDObject(this._typeAsk,this._GIDAsk);
               comptGID = 0;
               if(GIDobj == null)
               {
                  return true;
               }
               for each (isbbid in GIDobj.objects)
               {
                  if(ebhilrmsg.itemUID == isbbid.itemWrapper.objectUID)
                  {
                     GIDobj.objects.splice(comptGID,1);
                  }
                  comptGID++;
               }
               if(GIDobj.objects.length == 0)
               {
                  tod1 = this.getTypeObject(this._typeAsk);
                  tempObjects = new Array();
                  for each (objectGIDD in tod1.objects)
                  {
                     if(objectGIDD.GIDObject != this._GIDAsk)
                     {
                        tempObjects.push(objectGIDD);
                     }
                  }
                  tod1.objects = tempObjects;
                  this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,tod1.objects);
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate,GIDobj.objects);
               return true;
            case msg is ExchangeTypesExchangerDescriptionForUserMessage:
               etedfumsg = msg as ExchangeTypesExchangerDescriptionForUserMessage;
               tod = this.getTypeObject(this._typeAsk);
               tod.objects = new Array();
               for each (objectGID in etedfumsg.typeDescription)
               {
                  tod.objects.push(new GIDObjectData(objectGID,new Array()));
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,tod.objects);
               return true;
            case msg is ExchangeTypesItemsExchangerDescriptionForUserMessage:
               etiedfumsg = msg as ExchangeTypesItemsExchangerDescriptionForUserMessage;
               goData0 = this.getGIDObject(this._typeAsk,this._GIDAsk);
               if(!goData0)
               {
                  tod0 = this.getTypeObject(this._typeAsk);
                  goTest = new GIDObjectData(this._GIDAsk,new Array());
                  if(!tod0.objects)
                  {
                     tod0.objects = new Array();
                  }
                  if(tod0.objects.indexOf(goTest) == -1)
                  {
                     tod0.objects.push(goTest);
                  }
               }
               goData = this.getGIDObject(this._typeAsk,this._GIDAsk);
               if(goData)
               {
                  goData.objects = new Array();
                  for each (objectInfo in etiedfumsg.itemTypeDescriptions)
                  {
                     itemW = ItemWrapper.create(63,objectInfo.objectUID,this._GIDAsk,1,objectInfo.effects);
                     objectsPrices = new Vector.<int>();
                     for each (pri in objectInfo.prices)
                     {
                        objectsPrices.push(pri as int);
                     }
                     goData.objects.push(new ItemSellByBid(itemW,objectsPrices));
                  }
                  this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate,goData.objects,false,true);
               }
               else
               {
                  this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate,null,false,true);
               }
               return true;
            case msg is ExchangeBidSearchOkMessage:
               ebsomsg = msg as ExchangeBidSearchOkMessage;
               return true;
            case msg is BidHouseStringSearchAction:
               bhssa = msg as BidHouseStringSearchAction;
               searchText = bhssa.searchString;
               time = getTimer();
               itemsMatch = new Vector.<uint>();
               if(this._listItemsSearchMode == null)
               {
                  this._listItemsSearchMode = new Array();
                  lsItems = Item.getItems();
                  nItems = lsItems.length;
                  i = 0;
                  while(i < nItems)
                  {
                     currentItem = lsItems[i];
                     if((currentItem) && (!(this._itemsTypesAllowed.indexOf(currentItem.typeId) == -1)))
                     {
                        if(currentItem.name)
                        {
                           this._listItemsSearchMode.push(currentItem.name.toLowerCase(),currentItem.id);
                        }
                     }
                     i++;
                  }
                  _log.debug("Initialisation recherche HDV en " + (getTimer() - time) + " ms.");
               }
               nItems = this._listItemsSearchMode.length;
               i = 0;
               while(i < nItems)
               {
                  currentName = this._listItemsSearchMode[i];
                  if(currentName.indexOf(searchText) != -1)
                  {
                     itemsMatch.push(this._listItemsSearchMode[i + 1]);
                  }
                  i = i + 2;
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,itemsMatch,true);
               return true;
            case msg is BidSwitchToBuyerModeAction:
               this._switching = true;
               buyngarmsg = new NpcGenericActionRequestMessage();
               buyngarmsg.initNpcGenericActionRequestMessage(this._NPCId,6,PlayedCharacterManager.getInstance().currentMap.mapId);
               ConnectionsHandler.getConnection().send(buyngarmsg);
               return true;
            case msg is BidSwitchToSellerModeAction:
               this._switching = true;
               sellngarmsg = new NpcGenericActionRequestMessage();
               sellngarmsg.initNpcGenericActionRequestMessage(this._NPCId,5,PlayedCharacterManager.getInstance().currentMap.mapId);
               ConnectionsHandler.getConnection().send(sellngarmsg);
               return true;
            case msg is ExchangeLeaveMessage:
               elm = msg as ExchangeLeaveMessage;
               if(elm.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
               {
                  PlayedCharacterManager.getInstance().isInExchange = false;
                  this._success = elm.success;
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
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
      
      private function getTypeObject(pType:uint) : TypeObjectData {
         var tod:TypeObjectData = null;
         if(this._bidHouseObjects == null)
         {
            return null;
         }
         for each (tod in this._bidHouseObjects)
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
         for each (god in typeObjectData.objects)
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
         for each (god in typeObjectData.objects)
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
import __AS3__.vec.Vector;

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
