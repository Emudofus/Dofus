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
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertListFromInvMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInNpcShop;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.jerakine.network.IServerConnection;


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

      public function set priority(p:int) : void {
         this._priority=p;
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

      public function initMountStock(objectsInfos:Vector.<ObjectItem>) : void {
         InventoryManager.getInstance().bankInventory.initializeFromObjectItems(objectsInfos);
         InventoryManager.getInstance().bankInventory.releaseHooks();
      }

      public function processExchangeRequestedTradeMessage(msg:ExchangeRequestedTradeMessage) : void {
         var socialFrame:SocialFrame = null;
         var lda:LeaveDialogAction = null;
         if(msg.exchangeType!=ExchangeTypeEnum.PLAYER_TRADE)
         {
            return;
         }
         this._sourceInformations=this.roleplayEntitiesFrame.getEntityInfos(msg.source) as GameRolePlayNamedActorInformations;
         this._targetInformations=this.roleplayEntitiesFrame.getEntityInfos(msg.target) as GameRolePlayNamedActorInformations;
         var sourceName:String = this._sourceInformations.name;
         var targetName:String = this._targetInformations.name;
         if(msg.source==PlayedCharacterManager.getInstance().id)
         {
            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeRequestCharacterFromMe,sourceName,targetName);
         }
         else
         {
            socialFrame=Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
            if((socialFrame)&&(socialFrame.isIgnored(sourceName)))
            {
               lda=new LeaveDialogAction();
               Kernel.getWorker().process(lda);
               return;
            }
            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeRequestCharacterToMe,targetName,sourceName);
         }
      }

      public function processExchangeStartOkNpcTradeMessage(msg:ExchangeStartOkNpcTradeMessage) : void {
         var sourceName:String = PlayedCharacterManager.getInstance().infos.name;
         var NPCId:int = this.roleplayEntitiesFrame.getEntityInfos(msg.npcId).contextualId;
         var NPC:Npc = Npc.getNpcById(NPCId);
         var targetName:String = Npc.getNpcById((this.roleplayEntitiesFrame.getEntityInfos(msg.npcId) as GameRolePlayNpcInformations).npcId).name;
         var sourceLook:TiphonEntityLook = EntityLookAdapter.getRiderLook(PlayedCharacterManager.getInstance().infos.entityLook);
         var targetLook:TiphonEntityLook = EntityLookAdapter.getRiderLook(this.roleplayContextFrame.entitiesFrame.getEntityInfos(msg.npcId).look);
         var esonmsg:ExchangeStartOkNpcTradeMessage = msg as ExchangeStartOkNpcTradeMessage;
         PlayedCharacterManager.getInstance().isInExchange=true;
         this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartOkNpcTrade,esonmsg.npcId,sourceName,targetName,sourceLook,targetLook);
         this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType,ExchangeTypeEnum.NPC_TRADE);
      }

      public function process(msg:Message) : Boolean {
         var i:* = 0;
         var inventorySize:* = 0;
         var exwsmsg:ExchangeStartedWithStorageMessage = null;
         var commonExchangeFrame:CommonExchangeManagementFrame = null;
         var pods:* = 0;
         var esmsg:ExchangeStartedMessage = null;
         var commonExchangeFrame2:CommonExchangeManagementFrame = null;
         var sicmsg:StorageInventoryContentMessage = null;
         var esotcmsg:ExchangeStartOkTaxCollectorMessage = null;
         var soumsg:StorageObjectUpdateMessage = null;
         var object:ObjectItem = null;
         var itemChanged:ItemWrapper = null;
         var sormsg:StorageObjectRemoveMessage = null;
         var sosumsg:StorageObjectsUpdateMessage = null;
         var sosrmsg:StorageObjectsRemoveMessage = null;
         var skumsg:StorageKamasUpdateMessage = null;
         var eomka:ExchangeObjectMoveKamaAction = null;
         var eomkmsg:ExchangeObjectMoveKamaMessage = null;
         var eotatia:ExchangeObjectTransfertAllToInvAction = null;
         var eotatimsg:ExchangeObjectTransfertAllToInvMessage = null;
         var eotltia:ExchangeObjectTransfertListToInvAction = null;
         var eotetia:ExchangeObjectTransfertExistingToInvAction = null;
         var eotetimsg:ExchangeObjectTransfertExistingToInvMessage = null;
         var eotafia:ExchangeObjectTransfertAllFromInvAction = null;
         var eotafimsg:ExchangeObjectTransfertAllFromInvMessage = null;
         var eotlfia:ExchangeObjectTransfertListFromInvAction = null;
         var eotefia:ExchangeObjectTransfertExistingFromInvAction = null;
         var eotefimsg:ExchangeObjectTransfertExistingFromInvMessage = null;
         var esonmsg:ExchangeStartOkNpcShopMessage = null;
         var merchant:GameContextActorInformations = null;
         var merchantLook:TiphonEntityLook = null;
         var NPCShopItems:Array = null;
         var elm:ExchangeLeaveMessage = null;
         var sourceName:String = null;
         var targetName:String = null;
         var sourceLook:TiphonEntityLook = null;
         var targetLook:TiphonEntityLook = null;
         var eswpmsg:ExchangeStartedWithPodsMessage = null;
         var sourceCurrentPods:* = 0;
         var targetCurrentPods:* = 0;
         var sourceMaxPods:* = 0;
         var targetMaxPods:* = 0;
         var exchangeOtherCharacterId:* = 0;
         var sosuit:ObjectItem = null;
         var sosuobj:ObjectItem = null;
         var sosuic:ItemWrapper = null;
         var sosruid:uint = 0;
         var eotltimsg:ExchangeObjectTransfertListToInvMessage = null;
         var eotlfimsg:ExchangeObjectTransfertListFromInvMessage = null;
         var oitsins:ObjectItemToSellInNpcShop = null;
         var itemwra:ItemWrapper = null;
         switch(true)
         {
            case msg is ExchangeStartedWithStorageMessage:
               exwsmsg=msg as ExchangeStartedWithStorageMessage;
               PlayedCharacterManager.getInstance().isInExchange=true;
               commonExchangeFrame=Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
               if(commonExchangeFrame)
               {
                  commonExchangeFrame.resetEchangeSequence();
               }
               pods=exwsmsg.storageMaxSlot;
               this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeBankStartedWithStorage,ExchangeTypeEnum.STORAGE,pods);
               return true;
            case msg is ExchangeStartedMessage:
               esmsg=msg as ExchangeStartedMessage;
               PlayedCharacterManager.getInstance().isInExchange=true;
               commonExchangeFrame2=Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
               if(commonExchangeFrame2)
               {
                  commonExchangeFrame2.resetEchangeSequence();
               }
               switch(esmsg.exchangeType)
               {
                  case ExchangeTypeEnum.PLAYER_TRADE:
                     sourceName=this._sourceInformations.name;
                     targetName=this._targetInformations.name;
                     sourceLook=EntityLookAdapter.getRiderLook(this._sourceInformations.look);
                     targetLook=EntityLookAdapter.getRiderLook(this._targetInformations.look);
                     if(esmsg.getMessageId()==ExchangeStartedWithPodsMessage.protocolId)
                     {
                        eswpmsg=msg as ExchangeStartedWithPodsMessage;
                     }
                     sourceCurrentPods=-1;
                     targetCurrentPods=-1;
                     sourceMaxPods=-1;
                     targetMaxPods=-1;
                     if(eswpmsg!=null)
                     {
                        if(eswpmsg.firstCharacterId==this._sourceInformations.contextualId)
                        {
                           sourceCurrentPods=eswpmsg.firstCharacterCurrentWeight;
                           targetCurrentPods=eswpmsg.secondCharacterCurrentWeight;
                           sourceMaxPods=eswpmsg.firstCharacterMaxWeight;
                           targetMaxPods=eswpmsg.secondCharacterMaxWeight;
                        }
                        else
                        {
                           targetCurrentPods=eswpmsg.firstCharacterCurrentWeight;
                           sourceCurrentPods=eswpmsg.secondCharacterCurrentWeight;
                           targetMaxPods=eswpmsg.firstCharacterMaxWeight;
                           sourceMaxPods=eswpmsg.secondCharacterMaxWeight;
                        }
                     }
                     if(PlayedCharacterManager.getInstance().id==eswpmsg.firstCharacterId)
                     {
                        exchangeOtherCharacterId=eswpmsg.secondCharacterId;
                     }
                     else
                     {
                        exchangeOtherCharacterId=eswpmsg.firstCharacterId;
                     }
                     _log.debug("look : "+sourceLook.toString()+"    "+targetLook.toString());
                     this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStarted,sourceName,targetName,sourceLook,targetLook,sourceCurrentPods,targetCurrentPods,sourceMaxPods,targetMaxPods,exchangeOtherCharacterId);
                     this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType,esmsg.exchangeType);
                     return true;
                  case ExchangeTypeEnum.STORAGE:
                     this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType,esmsg.exchangeType);
                     return true;
                  case ExchangeTypeEnum.TAXCOLLECTOR:
                     this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType,esmsg.exchangeType);
                     return true;
                  default:
                     return false;
               }
            case msg is StorageInventoryContentMessage:
               sicmsg=msg as StorageInventoryContentMessage;
               InventoryManager.getInstance().bankInventory.kamas=sicmsg.kamas;
               InventoryManager.getInstance().bankInventory.initializeFromObjectItems(sicmsg.objects);
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return false;
            case msg is ExchangeStartOkTaxCollectorMessage:
               esotcmsg=msg as ExchangeStartOkTaxCollectorMessage;
               InventoryManager.getInstance().bankInventory.kamas=esotcmsg.goldInfo;
               InventoryManager.getInstance().bankInventory.initializeFromObjectItems(esotcmsg.objectsInfos);
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return false;
            case msg is StorageObjectUpdateMessage:
               soumsg=msg as StorageObjectUpdateMessage;
               object=soumsg.object;
               itemChanged=ItemWrapper.create(object.position,object.objectUID,object.objectGID,object.quantity,object.effects);
               InventoryManager.getInstance().bankInventory.modifyItem(itemChanged);
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return false;
            case msg is StorageObjectRemoveMessage:
               sormsg=msg as StorageObjectRemoveMessage;
               InventoryManager.getInstance().bankInventory.removeItem(sormsg.objectUID);
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return false;
            case msg is StorageObjectsUpdateMessage:
               sosumsg=msg as StorageObjectsUpdateMessage;
               for each (sosuobj in sosumsg.objectList)
               {
                  sosuic=ItemWrapper.create(sosuobj.position,sosuobj.objectUID,sosuobj.objectGID,sosuobj.quantity,sosuobj.effects);
                  InventoryManager.getInstance().bankInventory.modifyItem(sosuic);
               }
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return false;
            case msg is StorageObjectsRemoveMessage:
               sosrmsg=msg as StorageObjectsRemoveMessage;
               for each (sosruid in sosrmsg.objectUIDList)
               {
                  InventoryManager.getInstance().bankInventory.removeItem(sosruid);
               }
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return false;
            case msg is StorageKamasUpdateMessage:
               skumsg=msg as StorageKamasUpdateMessage;
               InventoryManager.getInstance().bankInventory.kamas=skumsg.kamasTotal;
               KernelEventsManager.getInstance().processCallback(InventoryHookList.StorageKamasUpdate,skumsg.kamasTotal);
               return false;
            case msg is ExchangeObjectMoveKamaAction:
               eomka=msg as ExchangeObjectMoveKamaAction;
               eomkmsg=new ExchangeObjectMoveKamaMessage();
               eomkmsg.initExchangeObjectMoveKamaMessage(eomka.kamas);
               this._serverConnection.send(eomkmsg);
               return true;
            case msg is ExchangeObjectTransfertAllToInvAction:
               eotatia=msg as ExchangeObjectTransfertAllToInvAction;
               eotatimsg=new ExchangeObjectTransfertAllToInvMessage();
               eotatimsg.initExchangeObjectTransfertAllToInvMessage();
               this._serverConnection.send(eotatimsg);
               return true;
            case msg is ExchangeObjectTransfertListToInvAction:
               eotltia=msg as ExchangeObjectTransfertListToInvAction;
               if(eotltia.ids.length>ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.exchange.partialTransfert"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               if(eotltia.ids.length>=ProtocolConstantsEnum.MIN_OBJ_COUNT_BY_XFERT)
               {
                  eotltimsg=new ExchangeObjectTransfertListToInvMessage();
                  eotltimsg.initExchangeObjectTransfertListToInvMessage(eotltia.ids.slice(0,ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT));
                  this._serverConnection.send(eotltimsg);
               }
               return true;
            case msg is ExchangeObjectTransfertExistingToInvAction:
               eotetia=msg as ExchangeObjectTransfertExistingToInvAction;
               eotetimsg=new ExchangeObjectTransfertExistingToInvMessage();
               eotetimsg.initExchangeObjectTransfertExistingToInvMessage();
               this._serverConnection.send(eotetimsg);
               return true;
            case msg is ExchangeObjectTransfertAllFromInvAction:
               eotafia=msg as ExchangeObjectTransfertAllFromInvAction;
               eotafimsg=new ExchangeObjectTransfertAllFromInvMessage();
               eotafimsg.initExchangeObjectTransfertAllFromInvMessage();
               this._serverConnection.send(eotafimsg);
               return true;
            case msg is ExchangeObjectTransfertListFromInvAction:
               eotlfia=msg as ExchangeObjectTransfertListFromInvAction;
               if(eotlfia.ids.length>ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.exchange.partialTransfert"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               if(eotlfia.ids.length>=ProtocolConstantsEnum.MIN_OBJ_COUNT_BY_XFERT)
               {
                  eotlfimsg=new ExchangeObjectTransfertListFromInvMessage();
                  eotlfimsg.initExchangeObjectTransfertListFromInvMessage(eotlfia.ids.slice(0,ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT));
                  this._serverConnection.send(eotlfimsg);
               }
               return true;
            case msg is ExchangeObjectTransfertExistingFromInvAction:
               eotefia=msg as ExchangeObjectTransfertExistingFromInvAction;
               eotefimsg=new ExchangeObjectTransfertExistingFromInvMessage();
               eotefimsg.initExchangeObjectTransfertExistingFromInvMessage();
               this._serverConnection.send(eotefimsg);
               return true;
            case msg is ExchangeStartOkNpcShopMessage:
               esonmsg=msg as ExchangeStartOkNpcShopMessage;
               PlayedCharacterManager.getInstance().isInExchange=true;
               Kernel.getWorker().process(ChangeWorldInteractionAction.create(false,true));
               merchant=this.roleplayContextFrame.entitiesFrame.getEntityInfos(esonmsg.npcSellerId);
               merchantLook=EntityLookAdapter.fromNetwork(merchant.look);
               NPCShopItems=new Array();
               for each (oitsins in esonmsg.objectsInfos)
               {
                  itemwra=ItemWrapper.create(63,0,oitsins.objectGID,0,oitsins.effects,false);
                  NPCShopItems.push(
                     {
                        item:itemwra,
                        price:oitsins.objectPrice,
                        criterion:new GroupItemCriterion(oitsins.buyCriterion)
                     }
                  );
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartOkNpcShop,esonmsg.npcSellerId,NPCShopItems,merchantLook,esonmsg.tokenId);
               return true;
            case msg is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case msg is ExchangeLeaveMessage:
               elm=msg as ExchangeLeaveMessage;
               if(elm.dialogType==DialogTypeEnum.DIALOG_EXCHANGE)
               {
                  PlayedCharacterManager.getInstance().isInExchange=false;
                  this._success=elm.success;
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
         this._success=false;
         return true;
      }

      public function pulled() : Boolean {
         if(Kernel.getWorker().contains(CommonExchangeManagementFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
         }
         KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave,this._success);
         this._exchangeInventory=null;
         return true;
      }

      private function get _kernelEventsManager() : KernelEventsManager {
         return KernelEventsManager.getInstance();
      }

      private function get _serverConnection() : IServerConnection {
         return ConnectionsHandler.getConnection();
      }
   }

}