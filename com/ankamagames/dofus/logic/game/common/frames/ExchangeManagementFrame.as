package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayMovementFrame;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeRequestedTradeMessage;
   import com.ankamagames.dofus.logic.game.common.actions.LeaveDialogAction;
   import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkNpcTradeMessage;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedWithStorageMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageInventoryContentMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkTaxCollectorMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageObjectUpdateMessage;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageObjectRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageObjectsUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageObjectsRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageKamasUpdateMessage;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveKamaAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMoveKamaMessage;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertAllToInvAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertAllToInvMessage;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListWithQuantityToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertExistingToInvAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertExistingToInvMessage;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertAllFromInvAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertAllFromInvMessage;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertExistingFromInvAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertExistingFromInvMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkNpcShopMessage;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedWithPodsMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertListToInvMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertListWithQuantityToInvMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertListFromInvMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInNpcShop;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   
   public class ExchangeManagementFrame extends Object implements Frame
   {
      
      public function ExchangeManagementFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ExchangeManagementFrame));
      
      private var _priority:int = 0;
      
      private var _sourceInformations:GameRolePlayNamedActorInformations;
      
      private var _targetInformations:GameRolePlayNamedActorInformations;
      
      private var _meReady:Boolean = false;
      
      private var _youReady:Boolean = false;
      
      private var _exchangeInventory:Array;
      
      private var _success:Boolean;
      
      public function get priority() : int {
         return this._priority;
      }
      
      public function set priority(param1:int) : void {
         this._priority = param1;
      }
      
      private function get roleplayContextFrame() : RoleplayContextFrame {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      private function get roleplayEntitiesFrame() : RoleplayEntitiesFrame {
         return Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
      }
      
      private function get roleplayMovementFrame() : RoleplayMovementFrame {
         return Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
      }
      
      public function initMountStock(param1:Vector.<ObjectItem>) : void {
         InventoryManager.getInstance().bankInventory.initializeFromObjectItems(param1);
         InventoryManager.getInstance().bankInventory.releaseHooks();
      }
      
      public function processExchangeRequestedTradeMessage(param1:ExchangeRequestedTradeMessage) : void {
         var _loc4_:SocialFrame = null;
         var _loc5_:LeaveDialogAction = null;
         if(param1.exchangeType != ExchangeTypeEnum.PLAYER_TRADE)
         {
            return;
         }
         this._sourceInformations = this.roleplayEntitiesFrame.getEntityInfos(param1.source) as GameRolePlayNamedActorInformations;
         this._targetInformations = this.roleplayEntitiesFrame.getEntityInfos(param1.target) as GameRolePlayNamedActorInformations;
         var _loc2_:String = this._sourceInformations.name;
         var _loc3_:String = this._targetInformations.name;
         if(param1.source == PlayedCharacterManager.getInstance().id)
         {
            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeRequestCharacterFromMe,_loc2_,_loc3_);
         }
         else
         {
            _loc4_ = Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
            if((_loc4_) && (_loc4_.isIgnored(_loc2_)))
            {
               _loc5_ = new LeaveDialogAction();
               Kernel.getWorker().process(_loc5_);
               return;
            }
            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeRequestCharacterToMe,_loc3_,_loc2_);
         }
      }
      
      public function processExchangeStartOkNpcTradeMessage(param1:ExchangeStartOkNpcTradeMessage) : void {
         var _loc2_:String = PlayedCharacterManager.getInstance().infos.name;
         var _loc3_:int = this.roleplayEntitiesFrame.getEntityInfos(param1.npcId).contextualId;
         var _loc4_:Npc = Npc.getNpcById(_loc3_);
         var _loc5_:String = Npc.getNpcById((this.roleplayEntitiesFrame.getEntityInfos(param1.npcId) as GameRolePlayNpcInformations).npcId).name;
         var _loc6_:TiphonEntityLook = EntityLookAdapter.getRiderLook(PlayedCharacterManager.getInstance().infos.entityLook);
         var _loc7_:TiphonEntityLook = EntityLookAdapter.getRiderLook(this.roleplayContextFrame.entitiesFrame.getEntityInfos(param1.npcId).look);
         var _loc8_:ExchangeStartOkNpcTradeMessage = param1 as ExchangeStartOkNpcTradeMessage;
         PlayedCharacterManager.getInstance().isInExchange = true;
         this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartOkNpcTrade,_loc8_.npcId,_loc2_,_loc5_,_loc6_,_loc7_);
         this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType,ExchangeTypeEnum.NPC_TRADE);
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:ExchangeStartedWithStorageMessage = null;
         var _loc5_:CommonExchangeManagementFrame = null;
         var _loc6_:* = 0;
         var _loc7_:ExchangeStartedMessage = null;
         var _loc8_:CommonExchangeManagementFrame = null;
         var _loc9_:StorageInventoryContentMessage = null;
         var _loc10_:ExchangeStartOkTaxCollectorMessage = null;
         var _loc11_:StorageObjectUpdateMessage = null;
         var _loc12_:ObjectItem = null;
         var _loc13_:ItemWrapper = null;
         var _loc14_:StorageObjectRemoveMessage = null;
         var _loc15_:StorageObjectsUpdateMessage = null;
         var _loc16_:StorageObjectsRemoveMessage = null;
         var _loc17_:StorageKamasUpdateMessage = null;
         var _loc18_:ExchangeObjectMoveKamaAction = null;
         var _loc19_:ExchangeObjectMoveKamaMessage = null;
         var _loc20_:ExchangeObjectTransfertAllToInvAction = null;
         var _loc21_:ExchangeObjectTransfertAllToInvMessage = null;
         var _loc22_:ExchangeObjectTransfertListToInvAction = null;
         var _loc23_:ExchangeObjectTransfertListWithQuantityToInvAction = null;
         var _loc24_:ExchangeObjectTransfertExistingToInvAction = null;
         var _loc25_:ExchangeObjectTransfertExistingToInvMessage = null;
         var _loc26_:ExchangeObjectTransfertAllFromInvAction = null;
         var _loc27_:ExchangeObjectTransfertAllFromInvMessage = null;
         var _loc28_:ExchangeObjectTransfertListFromInvAction = null;
         var _loc29_:ExchangeObjectTransfertExistingFromInvAction = null;
         var _loc30_:ExchangeObjectTransfertExistingFromInvMessage = null;
         var _loc31_:ExchangeStartOkNpcShopMessage = null;
         var _loc32_:GameContextActorInformations = null;
         var _loc33_:TiphonEntityLook = null;
         var _loc34_:Array = null;
         var _loc35_:ExchangeLeaveMessage = null;
         var _loc36_:String = null;
         var _loc37_:String = null;
         var _loc38_:TiphonEntityLook = null;
         var _loc39_:TiphonEntityLook = null;
         var _loc40_:ExchangeStartedWithPodsMessage = null;
         var _loc41_:* = 0;
         var _loc42_:* = 0;
         var _loc43_:* = 0;
         var _loc44_:* = 0;
         var _loc45_:* = 0;
         var _loc46_:ObjectItem = null;
         var _loc47_:ObjectItem = null;
         var _loc48_:ItemWrapper = null;
         var _loc49_:uint = 0;
         var _loc50_:ExchangeObjectTransfertListToInvMessage = null;
         var _loc51_:ExchangeObjectTransfertListWithQuantityToInvMessage = null;
         var _loc52_:ExchangeObjectTransfertListFromInvMessage = null;
         var _loc53_:ObjectItemToSellInNpcShop = null;
         var _loc54_:ItemWrapper = null;
         switch(true)
         {
            case param1 is ExchangeStartedWithStorageMessage:
               _loc4_ = param1 as ExchangeStartedWithStorageMessage;
               PlayedCharacterManager.getInstance().isInExchange = true;
               _loc5_ = Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
               if(_loc5_)
               {
                  _loc5_.resetEchangeSequence();
               }
               _loc6_ = _loc4_.storageMaxSlot;
               this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeBankStartedWithStorage,ExchangeTypeEnum.STORAGE,_loc6_);
               return false;
            case param1 is ExchangeStartedMessage:
               _loc7_ = param1 as ExchangeStartedMessage;
               PlayedCharacterManager.getInstance().isInExchange = true;
               _loc8_ = Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
               if(_loc8_)
               {
                  _loc8_.resetEchangeSequence();
               }
               switch(_loc7_.exchangeType)
               {
                  case ExchangeTypeEnum.PLAYER_TRADE:
                     _loc36_ = this._sourceInformations.name;
                     _loc37_ = this._targetInformations.name;
                     _loc38_ = EntityLookAdapter.getRiderLook(this._sourceInformations.look);
                     _loc39_ = EntityLookAdapter.getRiderLook(this._targetInformations.look);
                     if(_loc7_.getMessageId() == ExchangeStartedWithPodsMessage.protocolId)
                     {
                        _loc40_ = param1 as ExchangeStartedWithPodsMessage;
                     }
                     _loc41_ = -1;
                     _loc42_ = -1;
                     _loc43_ = -1;
                     _loc44_ = -1;
                     if(_loc40_ != null)
                     {
                        if(_loc40_.firstCharacterId == this._sourceInformations.contextualId)
                        {
                           _loc41_ = _loc40_.firstCharacterCurrentWeight;
                           _loc42_ = _loc40_.secondCharacterCurrentWeight;
                           _loc43_ = _loc40_.firstCharacterMaxWeight;
                           _loc44_ = _loc40_.secondCharacterMaxWeight;
                        }
                        else
                        {
                           _loc42_ = _loc40_.firstCharacterCurrentWeight;
                           _loc41_ = _loc40_.secondCharacterCurrentWeight;
                           _loc44_ = _loc40_.firstCharacterMaxWeight;
                           _loc43_ = _loc40_.secondCharacterMaxWeight;
                        }
                     }
                     if(PlayedCharacterManager.getInstance().id == _loc40_.firstCharacterId)
                     {
                        _loc45_ = _loc40_.secondCharacterId;
                     }
                     else
                     {
                        _loc45_ = _loc40_.firstCharacterId;
                     }
                     this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStarted,_loc36_,_loc37_,_loc38_,_loc39_,_loc41_,_loc42_,_loc43_,_loc44_,_loc45_);
                     this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType,_loc7_.exchangeType);
                     return true;
                  case ExchangeTypeEnum.STORAGE:
                     this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType,_loc7_.exchangeType);
                     return true;
                  case ExchangeTypeEnum.TAXCOLLECTOR:
                     this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType,_loc7_.exchangeType);
                     return true;
                  default:
                     return true;
               }
            case param1 is StorageInventoryContentMessage:
               _loc9_ = param1 as StorageInventoryContentMessage;
               InventoryManager.getInstance().bankInventory.kamas = _loc9_.kamas;
               InventoryManager.getInstance().bankInventory.initializeFromObjectItems(_loc9_.objects);
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return true;
            case param1 is ExchangeStartOkTaxCollectorMessage:
               _loc10_ = param1 as ExchangeStartOkTaxCollectorMessage;
               InventoryManager.getInstance().bankInventory.kamas = _loc10_.goldInfo;
               InventoryManager.getInstance().bankInventory.initializeFromObjectItems(_loc10_.objectsInfos);
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return true;
            case param1 is StorageObjectUpdateMessage:
               _loc11_ = param1 as StorageObjectUpdateMessage;
               _loc12_ = _loc11_.object;
               _loc13_ = ItemWrapper.create(_loc12_.position,_loc12_.objectUID,_loc12_.objectGID,_loc12_.quantity,_loc12_.effects);
               InventoryManager.getInstance().bankInventory.modifyItem(_loc13_);
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return true;
            case param1 is StorageObjectRemoveMessage:
               _loc14_ = param1 as StorageObjectRemoveMessage;
               InventoryManager.getInstance().bankInventory.removeItem(_loc14_.objectUID);
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return true;
            case param1 is StorageObjectsUpdateMessage:
               _loc15_ = param1 as StorageObjectsUpdateMessage;
               for each (_loc47_ in _loc15_.objectList)
               {
                  _loc48_ = ItemWrapper.create(_loc47_.position,_loc47_.objectUID,_loc47_.objectGID,_loc47_.quantity,_loc47_.effects);
                  InventoryManager.getInstance().bankInventory.modifyItem(_loc48_);
               }
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return true;
            case param1 is StorageObjectsRemoveMessage:
               _loc16_ = param1 as StorageObjectsRemoveMessage;
               for each (_loc49_ in _loc16_.objectUIDList)
               {
                  InventoryManager.getInstance().bankInventory.removeItem(_loc49_);
               }
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return true;
            case param1 is StorageKamasUpdateMessage:
               _loc17_ = param1 as StorageKamasUpdateMessage;
               InventoryManager.getInstance().bankInventory.kamas = _loc17_.kamasTotal;
               KernelEventsManager.getInstance().processCallback(InventoryHookList.StorageKamasUpdate,_loc17_.kamasTotal);
               return true;
            case param1 is ExchangeObjectMoveKamaAction:
               _loc18_ = param1 as ExchangeObjectMoveKamaAction;
               _loc19_ = new ExchangeObjectMoveKamaMessage();
               _loc19_.initExchangeObjectMoveKamaMessage(_loc18_.kamas);
               ConnectionsHandler.getConnection().send(_loc19_);
               return true;
            case param1 is ExchangeObjectTransfertAllToInvAction:
               _loc20_ = param1 as ExchangeObjectTransfertAllToInvAction;
               _loc21_ = new ExchangeObjectTransfertAllToInvMessage();
               _loc21_.initExchangeObjectTransfertAllToInvMessage();
               ConnectionsHandler.getConnection().send(_loc21_);
               return true;
            case param1 is ExchangeObjectTransfertListToInvAction:
               _loc22_ = param1 as ExchangeObjectTransfertListToInvAction;
               if(_loc22_.ids.length > ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.exchange.partialTransfert"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               if(_loc22_.ids.length >= ProtocolConstantsEnum.MIN_OBJ_COUNT_BY_XFERT)
               {
                  _loc50_ = new ExchangeObjectTransfertListToInvMessage();
                  _loc50_.initExchangeObjectTransfertListToInvMessage(_loc22_.ids.slice(0,ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT));
                  ConnectionsHandler.getConnection().send(_loc50_);
               }
               return true;
            case param1 is ExchangeObjectTransfertListWithQuantityToInvAction:
               _loc23_ = param1 as ExchangeObjectTransfertListWithQuantityToInvAction;
               if(_loc23_.ids.length > ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT / 2)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.exchange.partialTransfert"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               if(_loc23_.ids.length >= ProtocolConstantsEnum.MIN_OBJ_COUNT_BY_XFERT && _loc23_.ids.length == _loc23_.qtys.length)
               {
                  _loc51_ = new ExchangeObjectTransfertListWithQuantityToInvMessage();
                  _loc51_.initExchangeObjectTransfertListWithQuantityToInvMessage(_loc23_.ids.slice(0,ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT / 2),_loc23_.qtys.slice(0,ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT / 2));
                  ConnectionsHandler.getConnection().send(_loc51_);
               }
               return true;
            case param1 is ExchangeObjectTransfertExistingToInvAction:
               _loc24_ = param1 as ExchangeObjectTransfertExistingToInvAction;
               _loc25_ = new ExchangeObjectTransfertExistingToInvMessage();
               _loc25_.initExchangeObjectTransfertExistingToInvMessage();
               ConnectionsHandler.getConnection().send(_loc25_);
               return true;
            case param1 is ExchangeObjectTransfertAllFromInvAction:
               _loc26_ = param1 as ExchangeObjectTransfertAllFromInvAction;
               _loc27_ = new ExchangeObjectTransfertAllFromInvMessage();
               _loc27_.initExchangeObjectTransfertAllFromInvMessage();
               ConnectionsHandler.getConnection().send(_loc27_);
               return true;
            case param1 is ExchangeObjectTransfertListFromInvAction:
               _loc28_ = param1 as ExchangeObjectTransfertListFromInvAction;
               if(_loc28_.ids.length > ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.exchange.partialTransfert"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               if(_loc28_.ids.length >= ProtocolConstantsEnum.MIN_OBJ_COUNT_BY_XFERT)
               {
                  _loc52_ = new ExchangeObjectTransfertListFromInvMessage();
                  _loc52_.initExchangeObjectTransfertListFromInvMessage(_loc28_.ids.slice(0,ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT));
                  ConnectionsHandler.getConnection().send(_loc52_);
               }
               return true;
            case param1 is ExchangeObjectTransfertExistingFromInvAction:
               _loc29_ = param1 as ExchangeObjectTransfertExistingFromInvAction;
               _loc30_ = new ExchangeObjectTransfertExistingFromInvMessage();
               _loc30_.initExchangeObjectTransfertExistingFromInvMessage();
               ConnectionsHandler.getConnection().send(_loc30_);
               return true;
            case param1 is ExchangeStartOkNpcShopMessage:
               _loc31_ = param1 as ExchangeStartOkNpcShopMessage;
               PlayedCharacterManager.getInstance().isInExchange = true;
               Kernel.getWorker().process(ChangeWorldInteractionAction.create(false,true));
               _loc32_ = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc31_.npcSellerId);
               _loc33_ = EntityLookAdapter.fromNetwork(_loc32_.look);
               _loc34_ = new Array();
               for each (_loc53_ in _loc31_.objectsInfos)
               {
                  _loc54_ = ItemWrapper.create(63,0,_loc53_.objectGID,0,_loc53_.effects,false);
                  _loc34_.push(
                     {
                        "item":_loc54_,
                        "price":_loc53_.objectPrice,
                        "criterion":new GroupItemCriterion(_loc53_.buyCriterion)
                     });
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartOkNpcShop,_loc31_.npcSellerId,_loc34_,_loc33_,_loc31_.tokenId);
               return true;
            case param1 is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case param1 is ExchangeLeaveMessage:
               _loc35_ = param1 as ExchangeLeaveMessage;
               if(_loc35_.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
               {
                  PlayedCharacterManager.getInstance().isInExchange = false;
                  this._success = _loc35_.success;
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
            default:
               return false;
         }
      }
      
      private function proceedExchange() : void {
      }
      
      public function pushed() : Boolean {
         this._success = false;
         return true;
      }
      
      public function pulled() : Boolean {
         if(Kernel.getWorker().contains(CommonExchangeManagementFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
         }
         KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave,this._success);
         this._exchangeInventory = null;
         return true;
      }
      
      private function get _kernelEventsManager() : KernelEventsManager {
         return KernelEventsManager.getInstance();
      }
   }
}
