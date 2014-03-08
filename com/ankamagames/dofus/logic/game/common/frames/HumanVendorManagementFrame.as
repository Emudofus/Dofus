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
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HumanVendorManagementFrame));
      
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
      
      public function process(param1:Message) : Boolean {
         var _loc2_:ExchangeStartOkHumanVendorMessage = null;
         var _loc3_:* = undefined;
         var _loc4_:String = null;
         var _loc5_:ExchangeShopStockStartedMessage = null;
         var _loc6_:ExchangeObjectModifyPricedAction = null;
         var _loc7_:ExchangeObjectModifyPricedMessage = null;
         var _loc8_:ExchangeShopStockMovementUpdatedMessage = null;
         var _loc9_:ItemWrapper = null;
         var _loc10_:uint = 0;
         var _loc11_:* = false;
         var _loc12_:ExchangeShopStockMovementRemovedMessage = null;
         var _loc13_:ExchangeShopStockMultiMovementUpdatedMessage = null;
         var _loc14_:ExchangeShopStockMultiMovementRemovedMessage = null;
         var _loc15_:ExchangeLeaveMessage = null;
         var _loc16_:ObjectItemToSellInHumanVendorShop = null;
         var _loc17_:ItemWrapper = null;
         var _loc18_:ObjectItemToSell = null;
         var _loc19_:ItemWrapper = null;
         var _loc20_:Object = null;
         var _loc21_:* = 0;
         var _loc22_:Object = null;
         var _loc23_:ObjectItemToSell = null;
         var _loc24_:* = false;
         var _loc25_:uint = 0;
         switch(true)
         {
            case param1 is ExchangeStartOkHumanVendorMessage:
               _loc2_ = param1 as ExchangeStartOkHumanVendorMessage;
               _loc3_ = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc2_.sellerId);
               PlayedCharacterManager.getInstance().isInExchange = true;
               if(_loc3_ == null)
               {
                  _log.error("Impossible de trouver le personnage vendeur dans l\'entitiesFrame");
                  return true;
               }
               _loc4_ = (_loc3_ as GameRolePlayMerchantInformations).name;
               this._shopStock = new Array();
               for each (_loc16_ in _loc2_.objectsInfos)
               {
                  _loc17_ = ItemWrapper.create(0,_loc16_.objectUID,_loc16_.objectGID,_loc16_.quantity,_loc16_.effects);
                  this._shopStock.push(
                     {
                        "itemWrapper":_loc17_,
                        "price":_loc16_.objectPrice
                     });
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeStartOkHumanVendor,_loc4_,this._shopStock);
               return true;
            case param1 is ExchangeShopStockStartedMessage:
               _loc5_ = param1 as ExchangeShopStockStartedMessage;
               PlayedCharacterManager.getInstance().isInExchange = true;
               this._shopStock = new Array();
               for each (_loc18_ in _loc5_.objectsInfos)
               {
                  _loc19_ = ItemWrapper.create(0,_loc18_.objectUID,_loc18_.objectGID,_loc18_.quantity,_loc18_.effects,false);
                  _loc20_ = Item.getItemById(_loc19_.objectGID).category;
                  this._shopStock.push(
                     {
                        "itemWrapper":_loc19_,
                        "price":_loc18_.objectPrice,
                        "category":_loc20_
                     });
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockStarted,this._shopStock);
               return true;
            case param1 is ExchangeObjectModifyPricedAction:
               _loc6_ = param1 as ExchangeObjectModifyPricedAction;
               _loc7_ = new ExchangeObjectModifyPricedMessage();
               _loc7_.initExchangeObjectModifyPricedMessage(_loc6_.objectUID,_loc6_.quantity,_loc6_.price);
               ConnectionsHandler.getConnection().send(_loc7_);
               return true;
            case param1 is ExchangeShopStockMovementUpdatedMessage:
               _loc8_ = param1 as ExchangeShopStockMovementUpdatedMessage;
               _loc9_ = ItemWrapper.create(0,_loc8_.objectInfo.objectUID,_loc8_.objectInfo.objectGID,_loc8_.objectInfo.quantity,_loc8_.objectInfo.effects,false);
               _loc10_ = _loc8_.objectInfo.objectPrice;
               _loc11_ = true;
               _loc21_ = 0;
               while(_loc21_ < this._shopStock.length)
               {
                  if(this._shopStock[_loc21_].itemWrapper.objectUID == _loc9_.objectUID)
                  {
                     if(_loc9_.quantity > this._shopStock[_loc21_].itemWrapper.quantity)
                     {
                        KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockAddQuantity);
                     }
                     else
                     {
                        KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockRemoveQuantity);
                     }
                     _loc22_ = Item.getItemById(_loc9_.objectGID).category;
                     this._shopStock.splice(_loc21_,1,
                        {
                           "itemWrapper":_loc9_,
                           "price":_loc10_,
                           "category":_loc22_
                        });
                     _loc11_ = false;
                     break;
                  }
                  _loc21_++;
               }
               if(_loc11_)
               {
                  _loc20_ = Item.getItemById(_loc9_.objectGID).category;
                  this._shopStock.push(
                     {
                        "itemWrapper":_loc9_,
                        "price":_loc8_.objectInfo.objectPrice,
                        "category":_loc20_
                     });
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate,this._shopStock,_loc9_);
               return true;
            case param1 is ExchangeShopStockMovementRemovedMessage:
               _loc12_ = param1 as ExchangeShopStockMovementRemovedMessage;
               _loc21_ = 0;
               while(_loc21_ < this._shopStock.length)
               {
                  if(this._shopStock[_loc21_].itemWrapper.objectUID == _loc12_.objectId)
                  {
                     this._shopStock.splice(_loc21_,1);
                     break;
                  }
                  _loc21_++;
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate,this._shopStock,null);
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockMovementRemoved,_loc12_.objectId);
               return true;
            case param1 is ExchangeShopStockMultiMovementUpdatedMessage:
               _loc13_ = param1 as ExchangeShopStockMultiMovementUpdatedMessage;
               for each (_loc23_ in _loc13_.objectInfoList)
               {
                  _loc9_ = ItemWrapper.create(0,_loc23_.objectUID,_loc8_.objectInfo.objectGID,_loc23_.quantity,_loc23_.effects,false);
                  _loc24_ = true;
                  _loc21_ = 0;
                  while(_loc21_ < this._shopStock.length)
                  {
                     if(this._shopStock[_loc21_].itemWrapper.objectUID == _loc9_.objectUID)
                     {
                        _loc20_ = Item.getItemById(_loc9_.objectGID).category;
                        this._shopStock.splice(_loc21_,1,
                           {
                              "itemWrapper":_loc9_,
                              "price":_loc8_.objectInfo.objectPrice,
                              "category":_loc20_
                           });
                        _loc24_ = false;
                        break;
                     }
                     _loc21_++;
                  }
                  if(_loc24_)
                  {
                     this._shopStock.push(
                        {
                           "itemWrapper":_loc9_,
                           "price":_loc8_.objectInfo.objectPrice
                        });
                  }
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate,this._shopStock);
               return true;
            case param1 is ExchangeShopStockMultiMovementRemovedMessage:
               _loc14_ = param1 as ExchangeShopStockMultiMovementRemovedMessage;
               for each (_loc25_ in _loc14_.objectIdList)
               {
                  _loc21_ = 0;
                  while(_loc21_ < this._shopStock.length)
                  {
                     if(this._shopStock[_loc21_].itemWrapper.objectUID == _loc25_)
                     {
                        this._shopStock.splice(_loc21_,1);
                        break;
                     }
                     _loc21_++;
                  }
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockMouvmentRemoveOk,_loc12_.objectId);
               return true;
            case param1 is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case param1 is ExchangeLeaveMessage:
               _loc15_ = param1 as ExchangeLeaveMessage;
               if(_loc15_.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
               {
                  PlayedCharacterManager.getInstance().isInExchange = false;
                  this._success = _loc15_.success;
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
