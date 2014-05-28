package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeOkMultiCraftMessage;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkCraftWithInformationMessage;
   import com.ankamagames.dofus.datacenter.jobs.Recipe;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangePlayerMultiCraftRequestAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangePlayerMultiCraftRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeItemGoldAddAsPaymentAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeItemGoldAddAsPaymentMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeItemObjectAddAsPaymentAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeItemObjectAddAsPaymentMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeReplayStopAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeReplayStopMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeSetCraftRecipeAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeSetCraftRecipeMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftResultMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeItemAutoCraftStopedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkCraftMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeGoldPaymentForCraftMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeItemPaymentForCraftMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeRemovedPaymentForCraftMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeModifiedPaymentForCraftMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeClearPaymentForCraftMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectModifiedInBagMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectPutInBagMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectRemovedFromBagMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeObjectUseInWorkshopAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectUseInWorkshopMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeMultiCraftCrafterCanUseHisRessourcesMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkMulticraftCrafterMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkMulticraftCustomerMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeReplayAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeReplayMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeReplayCountModifiedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeItemAutoCraftRemainingMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftSlotCountIncreasedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftResultWithObjectIdMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftResultMagicWithObjectDescMessage;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftResultWithObjectDescMessage;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMinMax;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.enums.PaymentTypeEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectInteger;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectDice;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectMinMax;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkItemManager;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.dofus.network.enums.ExchangeReplayStopReasonEnum;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   
   public class CraftFrame extends Object implements Frame
   {
      
      public function CraftFrame() {
         this.playerList = new PlayerExchangeCraftList();
         this.otherPlayerList = new PlayerExchangeCraftList();
         this.paymentCraftList = new PaymentCraftList();
         this._crafterInfos = new PlayerInfo();
         this._customerInfos = new PlayerInfo();
         this.bagList = new Array();
         super();
      }
      
      protected static const _log:Logger;
      
      private static const SMITHMAGIC_RUNE_ID:int = 78;
      
      private static const SMITHMAGIC_POTION_ID:int = 26;
      
      private static const SIGNATURE_RUNE_ID:int = 7508;
      
      public var playerList:PlayerExchangeCraftList;
      
      public var otherPlayerList:PlayerExchangeCraftList;
      
      public var paymentCraftList:PaymentCraftList;
      
      private var _crafterInfos:PlayerInfo;
      
      private var _customerInfos:PlayerInfo;
      
      public var bagList:Array;
      
      private var _isCrafter:Boolean;
      
      private var _recipes:Array;
      
      private var _skillId:int;
      
      private var _craftType:int;
      
      private var _smithMagicOldObject:ItemWrapper;
      
      private var _success:Boolean;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      private function get socialFrame() : SocialFrame {
         return Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
      }
      
      public function get crafterInfos() : PlayerInfo {
         return this._crafterInfos;
      }
      
      public function get customerInfos() : PlayerInfo {
         return this._customerInfos;
      }
      
      public function get skillId() : int {
         return this._skillId;
      }
      
      private function get roleplayContextFrame() : RoleplayContextFrame {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      private function get commonExchangeFrame() : CommonExchangeManagementFrame {
         return Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
      }
      
      public function processExchangeOkMultiCraftMessage(msg:ExchangeOkMultiCraftMessage) : void {
         PlayedCharacterManager.getInstance().isInExchange = true;
         var eomcmsg:ExchangeOkMultiCraftMessage = msg as ExchangeOkMultiCraftMessage;
         if(eomcmsg.role == ExchangeTypeEnum.MULTICRAFT_CRAFTER)
         {
            this.playerList.isCrafter = true;
            this.otherPlayerList.isCrafter = false;
            this._crafterInfos.id = PlayedCharacterManager.getInstance().id;
            if(this.crafterInfos.id == eomcmsg.initiatorId)
            {
               this._customerInfos.id = eomcmsg.otherId;
            }
            else
            {
               this._customerInfos.id = eomcmsg.initiatorId;
            }
         }
         else
         {
            this.playerList.isCrafter = false;
            this.otherPlayerList.isCrafter = true;
            this._customerInfos.id = PlayedCharacterManager.getInstance().id;
            if(this.customerInfos.id == eomcmsg.initiatorId)
            {
               this._crafterInfos.id = eomcmsg.otherId;
            }
            else
            {
               this._crafterInfos.id = eomcmsg.initiatorId;
            }
         }
         var crafterEntity:GameContextActorInformations = this.roleplayContextFrame.entitiesFrame.getEntityInfos(this.crafterInfos.id);
         if(crafterEntity)
         {
            this._crafterInfos.look = EntityLookAdapter.getRiderLook(crafterEntity.look);
            this._crafterInfos.name = (crafterEntity as GameRolePlayNamedActorInformations).name;
         }
         else
         {
            this._crafterInfos.look = null;
            this._crafterInfos.name = "";
         }
         var customerEntity:GameContextActorInformations = this.roleplayContextFrame.entitiesFrame.getEntityInfos(this.customerInfos.id);
         if(customerEntity)
         {
            this._customerInfos.look = EntityLookAdapter.getRiderLook(customerEntity.look);
            this._customerInfos.name = (customerEntity as GameRolePlayNamedActorInformations).name;
         }
         else
         {
            this._customerInfos.look = null;
            this._customerInfos.name = "";
         }
         var otherName:String = "";
         var askerId:uint = eomcmsg.initiatorId;
         if(eomcmsg.initiatorId == PlayedCharacterManager.getInstance().id)
         {
            if(eomcmsg.initiatorId == this.crafterInfos.id)
            {
               this._isCrafter = true;
               otherName = this.customerInfos.name;
            }
            else
            {
               this._isCrafter = false;
               otherName = this.crafterInfos.name;
            }
         }
         else if(eomcmsg.otherId == this.crafterInfos.id)
         {
            this._isCrafter = false;
            otherName = this.crafterInfos.name;
         }
         else
         {
            this._isCrafter = true;
            otherName = this.customerInfos.name;
         }
         
         if(!this.socialFrame.isIgnored(otherName))
         {
            KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeMultiCraftRequest,eomcmsg.role,otherName,askerId);
         }
      }
      
      public function processExchangeStartOkCraftWithInformationMessage(msg:ExchangeStartOkCraftWithInformationMessage) : void {
         PlayedCharacterManager.getInstance().isInExchange = true;
         var esocwimsg:ExchangeStartOkCraftWithInformationMessage = msg as ExchangeStartOkCraftWithInformationMessage;
         this._skillId = esocwimsg.skillId;
         var recipes:Array = Recipe.getAllRecipesForSkillId(esocwimsg.skillId,esocwimsg.nbCase);
         this._isCrafter = true;
         var skill:Skill = Skill.getSkillById(this._skillId);
         if(skill.isForgemagus)
         {
            this._craftType = 1;
         }
         else if(skill.isRepair)
         {
            this._craftType = 2;
         }
         else
         {
            this._craftType = 0;
         }
         
         KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkCraft,recipes,esocwimsg.skillId,esocwimsg.nbCase);
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
         this.playerList = new PlayerExchangeCraftList();
         this.otherPlayerList = new PlayerExchangeCraftList();
         this.bagList = new Array();
         this._crafterInfos = new PlayerInfo();
         this._customerInfos = new PlayerInfo();
         this.paymentCraftList = new PaymentCraftList();
         this._smithMagicOldObject = null;
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function resetLists() : void {
         this.paymentCraftList.kamaPayment = 0;
         this.paymentCraftList.kamaPaymentOnlySuccess = 0;
         this.paymentCraftList.objectsPayment = new Array();
         this.paymentCraftList.objectsPaymentOnlySuccess = new Array();
      }
      
      public function addCraftComponent(pRemote:Boolean, pItemWrapper:ItemWrapper) : void {
         var playerExchangeCraftList:PlayerExchangeCraftList = null;
         if(pRemote)
         {
            playerExchangeCraftList = this.otherPlayerList;
         }
         else
         {
            playerExchangeCraftList = this.playerList;
         }
         playerExchangeCraftList.componentList.push(pItemWrapper);
         this.sendUpdateHook(playerExchangeCraftList);
         if((!(this._craftType == 0)) && (!(pItemWrapper.typeId == SMITHMAGIC_RUNE_ID)) && (!(pItemWrapper.typeId == SMITHMAGIC_POTION_ID)) && (!(pItemWrapper.objectGID == SIGNATURE_RUNE_ID)))
         {
            this._smithMagicOldObject = pItemWrapper.clone();
         }
      }
      
      public function modifyCraftComponent(pRemote:Boolean, pItemWrapper:ItemWrapper) : void {
         var playerExchangeCraftList:PlayerExchangeCraftList = null;
         if(pRemote)
         {
            playerExchangeCraftList = this.otherPlayerList;
         }
         else
         {
            playerExchangeCraftList = this.playerList;
         }
         var index:int = 0;
         while(index < playerExchangeCraftList.componentList.length)
         {
            if((playerExchangeCraftList.componentList[index].objectGID == pItemWrapper.objectGID) && (playerExchangeCraftList.componentList[index].objectUID == pItemWrapper.objectUID))
            {
               playerExchangeCraftList.componentList.splice(index,1,pItemWrapper);
            }
            index++;
         }
         this.sendUpdateHook(playerExchangeCraftList);
      }
      
      public function removeCraftComponent(pRemote:Boolean, pUID:uint) : void {
         var itemo:ItemWrapper = null;
         var itemp:ItemWrapper = null;
         var compt:uint = 0;
         var playerExchangeCraftList:PlayerExchangeCraftList = new PlayerExchangeCraftList();
         for each(itemo in this.otherPlayerList.componentList)
         {
            if(itemo.objectUID == pUID)
            {
               this.otherPlayerList.componentList.splice(compt,1);
               this.sendUpdateHook(this.otherPlayerList);
               break;
            }
            compt++;
         }
         compt = 0;
         for each(itemp in this.playerList.componentList)
         {
            if(itemp.objectUID == pUID)
            {
               this.playerList.componentList.splice(compt,1);
               this.sendUpdateHook(this.playerList);
               break;
            }
            compt++;
         }
      }
      
      public function addObjetPayment(pOnlySuccess:Boolean, pItemWrapper:ItemWrapper) : void {
         if(pOnlySuccess)
         {
            this.paymentCraftList.objectsPaymentOnlySuccess.push(pItemWrapper);
         }
         else
         {
            this.paymentCraftList.objectsPayment.push(pItemWrapper);
         }
      }
      
      public function removeObjetPayment(pUID:uint, pOnlySuccess:Boolean) : void {
         var objects:Array = null;
         var itemW:ItemWrapper = null;
         var compt:uint = 0;
         if(pOnlySuccess)
         {
            objects = this.paymentCraftList.objectsPaymentOnlySuccess;
         }
         else
         {
            objects = this.paymentCraftList.objectsPayment;
         }
         for each(itemW in objects)
         {
            if(itemW.objectUID == pUID)
            {
               objects.splice(compt,1);
            }
            compt++;
         }
         KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList,this.paymentCraftList,true);
      }
      
      private function sendUpdateHook(pPlayerExchangeCraftList:PlayerExchangeCraftList) : void {
         switch(pPlayerExchangeCraftList)
         {
            case this.otherPlayerList:
               KernelEventsManager.getInstance().processCallback(CraftHookList.OtherPlayerListUpdate,pPlayerExchangeCraftList);
               break;
            case this.playerList:
               KernelEventsManager.getInstance().processCallback(CraftHookList.PlayerListUpdate,pPlayerExchangeCraftList);
               break;
         }
      }
   }
}
class PaymentCraftList extends Object
{
   
   function PaymentCraftList() {
      super();
      this.kamaPaymentOnlySuccess = 0;
      this.objectsPaymentOnlySuccess = new Array();
      this.kamaPayment = 0;
      this.objectsPayment = new Array();
   }
   
   public var kamaPaymentOnlySuccess:uint;
   
   public var objectsPaymentOnlySuccess:Array;
   
   public var kamaPayment:uint;
   
   public var objectsPayment:Array;
}
class PlayerExchangeCraftList extends Object
{
   
   function PlayerExchangeCraftList() {
      super();
      this.componentList = new Array();
      this.isCrafter = false;
   }
   
   public var componentList:Array;
   
   public var isCrafter:Boolean;
}
import com.ankamagames.tiphon.types.look.TiphonEntityLook;

class PlayerInfo extends Object
{
   
   function PlayerInfo() {
      super();
   }
   
   public var id:uint;
   
   public var name:String;
   
   public var look:TiphonEntityLook;
   
   public var skillLevel:int;
}
