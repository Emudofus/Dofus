package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkHumanVendorMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeShopStockStartedMessage;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectModifyPricedAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectModifyPricedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeShopStockMovementUpdatedMessage;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeShopStockMovementRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeShopStockMultiMovementUpdatedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeShopStockMultiMovementRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInHumanVendorShop;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSell;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   
   public class HumanVendorManagementFrame extends Object implements Frame
   {
      
      public function HumanVendorManagementFrame() {
         super();
         this._shopStock = new Array();
      }
      
      protected static const _log:Logger;
      
      private var _success:Boolean = false;
      
      private var _shopStock:Array;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      private function get roleplayContextFrame() : RoleplayContextFrame {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      private function get commonExchangeManagementFrame() : CommonExchangeManagementFrame {
         return Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
      }
      
      public function pushed() : Boolean {
         this._success = false;
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var esohvmsg:ExchangeStartOkHumanVendorMessage = null;
         var player:* = undefined;
         var playerName:String = null;
         var esostmsg:ExchangeShopStockStartedMessage = null;
         var eompa:ExchangeObjectModifyPricedAction = null;
         var eomfpmsg:ExchangeObjectModifyPricedMessage = null;
         var essmamsg:ExchangeShopStockMovementUpdatedMessage = null;
         var itemWrapper:ItemWrapper = null;
         var newPrice:uint = 0;
         var newItem:* = false;
         var essmrmsg:ExchangeShopStockMovementRemovedMessage = null;
         var essmmumsg:ExchangeShopStockMultiMovementUpdatedMessage = null;
         var essmmrmsg:ExchangeShopStockMultiMovementRemovedMessage = null;
         var elm:ExchangeLeaveMessage = null;
         var objectToSell:ObjectItemToSellInHumanVendorShop = null;
         var iwrapper:ItemWrapper = null;
         var object:ObjectItemToSell = null;
         var iw:ItemWrapper = null;
         var cat:Object = null;
         var i:* = 0;
         var cate:Object = null;
         var objectInfo:ObjectItemToSell = null;
         var newItem2:* = false;
         var objectId:uint = 0;
         switch(true)
         {
            case msg is ExchangeStartOkHumanVendorMessage:
               esohvmsg = msg as ExchangeStartOkHumanVendorMessage;
               player = this.roleplayContextFrame.entitiesFrame.getEntityInfos(esohvmsg.sellerId);
               PlayedCharacterManager.getInstance().isInExchange = true;
               if(player == null)
               {
                  _log.error("Impossible de trouver le personnage vendeur dans l\'entitiesFrame");
                  return true;
               }
               playerName = (player as GameRolePlayMerchantInformations).name;
               this._shopStock = new Array();
               for each(objectToSell in esohvmsg.objectsInfos)
               {
                  iwrapper = ItemWrapper.create(0,objectToSell.objectUID,objectToSell.objectGID,objectToSell.quantity,objectToSell.effects);
                  this._shopStock.push(
                     {
                        "itemWrapper":iwrapper,
                        "price":objectToSell.objectPrice
                     });
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeStartOkHumanVendor,playerName,this._shopStock);
               return true;
            case msg is ExchangeShopStockStartedMessage:
               esostmsg = msg as ExchangeShopStockStartedMessage;
               PlayedCharacterManager.getInstance().isInExchange = true;
               this._shopStock = new Array();
               for each(object in esostmsg.objectsInfos)
               {
                  iw = ItemWrapper.create(0,object.objectUID,object.objectGID,object.quantity,object.effects,false);
                  cat = Item.getItemById(iw.objectGID).category;
                  this._shopStock.push(
                     {
                        "itemWrapper":iw,
                        "price":object.objectPrice,
                        "category":cat
                     });
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockStarted,this._shopStock);
               return true;
            case msg is ExchangeObjectModifyPricedAction:
               eompa = msg as ExchangeObjectModifyPricedAction;
               eomfpmsg = new ExchangeObjectModifyPricedMessage();
               eomfpmsg.initExchangeObjectModifyPricedMessage(eompa.objectUID,eompa.quantity,eompa.price);
               ConnectionsHandler.getConnection().send(eomfpmsg);
               return true;
            case msg is ExchangeShopStockMovementUpdatedMessage:
               essmamsg = msg as ExchangeShopStockMovementUpdatedMessage;
               itemWrapper = ItemWrapper.create(0,essmamsg.objectInfo.objectUID,essmamsg.objectInfo.objectGID,essmamsg.objectInfo.quantity,essmamsg.objectInfo.effects,false);
               newPrice = essmamsg.objectInfo.objectPrice;
               newItem = true;
               i = 0;
               while(i < this._shopStock.length)
               {
                  if(this._shopStock[i].itemWrapper.objectUID == itemWrapper.objectUID)
                  {
                     if(itemWrapper.quantity > this._shopStock[i].itemWrapper.quantity)
                     {
                        KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockAddQuantity);
                     }
                     else
                     {
                        KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockRemoveQuantity);
                     }
                     cate = Item.getItemById(itemWrapper.objectGID).category;
                     this._shopStock.splice(i,1,
                        {
                           "itemWrapper":itemWrapper,
                           "price":newPrice,
                           "category":cate
                        });
                     newItem = false;
                     break;
                  }
                  i++;
               }
               if(newItem)
               {
                  cat = Item.getItemById(itemWrapper.objectGID).category;
                  this._shopStock.push(
                     {
                        "itemWrapper":itemWrapper,
                        "price":essmamsg.objectInfo.objectPrice,
                        "category":cat
                     });
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate,this._shopStock,itemWrapper);
               return true;
            case msg is ExchangeShopStockMovementRemovedMessage:
               essmrmsg = msg as ExchangeShopStockMovementRemovedMessage;
               i = 0;
               while(i < this._shopStock.length)
               {
                  if(this._shopStock[i].itemWrapper.objectUID == essmrmsg.objectId)
                  {
                     this._shopStock.splice(i,1);
                     break;
                  }
                  i++;
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate,this._shopStock,null);
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockMovementRemoved,essmrmsg.objectId);
               return true;
            case msg is ExchangeShopStockMultiMovementUpdatedMessage:
               essmmumsg = msg as ExchangeShopStockMultiMovementUpdatedMessage;
               for each(objectInfo in essmmumsg.objectInfoList)
               {
                  itemWrapper = ItemWrapper.create(0,objectInfo.objectUID,essmamsg.objectInfo.objectGID,objectInfo.quantity,objectInfo.effects,false);
                  newItem2 = true;
                  i = 0;
                  while(i < this._shopStock.length)
                  {
                     if(this._shopStock[i].itemWrapper.objectUID == itemWrapper.objectUID)
                     {
                        cat = Item.getItemById(itemWrapper.objectGID).category;
                        this._shopStock.splice(i,1,
                           {
                              "itemWrapper":itemWrapper,
                              "price":essmamsg.objectInfo.objectPrice,
                              "category":cat
                           });
                        newItem2 = false;
                        break;
                     }
                     i++;
                  }
                  if(newItem2)
                  {
                     this._shopStock.push(
                        {
                           "itemWrapper":itemWrapper,
                           "price":essmamsg.objectInfo.objectPrice
                        });
                  }
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate,this._shopStock);
               return true;
            case msg is ExchangeShopStockMultiMovementRemovedMessage:
               essmmrmsg = msg as ExchangeShopStockMultiMovementRemovedMessage;
               loop6:
               for each(objectId in essmmrmsg.objectIdList)
               {
                  i = 0;
                  while(i < this._shopStock.length)
                  {
                     if(this._shopStock[i].itemWrapper.objectUID == objectId)
                     {
                        this._shopStock.splice(i,1);
                        continue loop6;
                     }
                     i++;
                  }
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockMouvmentRemoveOk,essmrmsg.objectId);
               return true;
            case msg is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
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
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         if(Kernel.getWorker().contains(CommonExchangeManagementFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
         }
         KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave,this._success);
         this._shopStock = null;
         return true;
      }
   }
}
