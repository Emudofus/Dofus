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
   import __AS3__.vec.Vector;
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
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CraftFrame));
      
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
         else
         {
            if(eomcmsg.otherId == this.crafterInfos.id)
            {
               this._isCrafter = false;
               otherName = this.crafterInfos.name;
            }
            else
            {
               this._isCrafter = true;
               otherName = this.customerInfos.name;
            }
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
         else
         {
            if(skill.isRepair)
            {
               this._craftType = 2;
            }
            else
            {
               this._craftType = 0;
            }
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
         var epmcra:ExchangePlayerMultiCraftRequestAction = null;
         var epmcrmsg:ExchangePlayerMultiCraftRequestMessage = null;
         var eigaapa:ExchangeItemGoldAddAsPaymentAction = null;
         var paymentType:uint = 0;
         var eigaapmsg:ExchangeItemGoldAddAsPaymentMessage = null;
         var eioaapa:ExchangeItemObjectAddAsPaymentAction = null;
         var paymentTypeObject:uint = 0;
         var objectlist:Array = null;
         var itemWr:ItemWrapper = null;
         var eioaapmsg:ExchangeItemObjectAddAsPaymentMessage = null;
         var ersa:ExchangeReplayStopAction = null;
         var rsmsg:ExchangeReplayStopMessage = null;
         var escra:ExchangeSetCraftRecipeAction = null;
         var escrmsg:ExchangeSetCraftRecipeMessage = null;
         var ecrmsg:ExchangeCraftResultMessage = null;
         var messageId:uint = 0;
         var objectName:String = null;
         var craftResultMessage:String = null;
         var itemW:ItemWrapper = null;
         var success:* = false;
         var eiacsmsg:ExchangeItemAutoCraftStopedMessage = null;
         var autoCraftStopedMessage:String = null;
         var showPopup:* = false;
         var esocmsg:ExchangeStartOkCraftMessage = null;
         var msgId:uint = 0;
         var egpfcmsg:ExchangeGoldPaymentForCraftMessage = null;
         var eipfcmsg:ExchangeItemPaymentForCraftMessage = null;
         var itemWrapper:ItemWrapper = null;
         var erpfcmsg:ExchangeRemovedPaymentForCraftMessage = null;
         var empfcmsg:ExchangeModifiedPaymentForCraftMessage = null;
         var itTemp:ItemWrapper = null;
         var newItemWra:ItemWrapper = null;
         var objectLis:Array = null;
         var ecpfcmsg:ExchangeClearPaymentForCraftMessage = null;
         var eomiwmsg:ExchangeObjectModifiedInBagMessage = null;
         var eopiwmsg:ExchangeObjectPutInBagMessage = null;
         var obj:ObjectItem = null;
         var obAdded:ItemWrapper = null;
         var eorfwmsg:ExchangeObjectRemovedFromBagMessage = null;
         var compt:uint = 0;
         var eosiwa:ExchangeObjectUseInWorkshopAction = null;
         var eouiwmsg:ExchangeObjectUseInWorkshopMessage = null;
         var emcsccuhra:ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction = null;
         var emcsccuhrmsg:ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage = null;
         var emcccuhrmsg:ExchangeMultiCraftCrafterCanUseHisRessourcesMessage = null;
         var esomcmsg:ExchangeStartOkMulticraftCrafterMessage = null;
         var recipes:Array = null;
         var skill:Skill = null;
         var esomcustomermsg:ExchangeStartOkMulticraftCustomerMessage = null;
         var recipesCrafter:Array = null;
         var skill2:Skill = null;
         var era:ExchangeReplayAction = null;
         var ermsg:ExchangeReplayMessage = null;
         var ercmmsg:ExchangeReplayCountModifiedMessage = null;
         var eiacrmsg:ExchangeItemAutoCraftRemainingMessage = null;
         var ecscimsg:ExchangeCraftSlotCountIncreasedMessage = null;
         var elm:ExchangeLeaveMessage = null;
         var ecrwoimsg:ExchangeCraftResultWithObjectIdMessage = null;
         var ecrmwodmsg:ExchangeCraftResultMagicWithObjectDescMessage = null;
         var smithText:String = null;
         var successS:* = false;
         var newEffects:Vector.<ObjectEffect> = null;
         var effect:EffectInstance = null;
         var sameEffectsCount:Array = null;
         var residualMagicText:String = null;
         var finalText:String = null;
         var ecrwodmsg:ExchangeCraftResultWithObjectDescMessage = null;
         var oldEffect:ObjectEffect = null;
         var sameEffectExists:* = false;
         var newEffect:ObjectEffect = null;
         var oldValue:* = 0;
         var newValue:* = 0;
         var result:* = 0;
         var effectInteger:EffectInstanceInteger = null;
         var effectDice:EffectInstanceDice = null;
         var newEffect2:ObjectEffect = null;
         var reallyNew:* = false;
         var oldEffect2:ObjectEffect = null;
         var effectMinMax:EffectInstanceMinMax = null;
         var commonMod:Object = null;
         var op:ItemWrapper = null;
         var ops:ItemWrapper = null;
         var iwrapper:ItemWrapper = null;
         var newItemWr:ItemWrapper = null;
         var iw:ItemWrapper = null;
         switch(true)
         {
            case msg is ExchangePlayerMultiCraftRequestAction:
               epmcra = msg as ExchangePlayerMultiCraftRequestAction;
               epmcrmsg = new ExchangePlayerMultiCraftRequestMessage();
               epmcrmsg.initExchangePlayerMultiCraftRequestMessage(epmcra.exchangeType,epmcra.target,epmcra.skillId);
               ConnectionsHandler.getConnection().send(epmcrmsg);
               return true;
            case msg is ExchangeOkMultiCraftMessage:
               this.processExchangeOkMultiCraftMessage(msg as ExchangeOkMultiCraftMessage);
               return true;
            case msg is ExchangeItemGoldAddAsPaymentAction:
               eigaapa = msg as ExchangeItemGoldAddAsPaymentAction;
               if(eigaapa.onlySuccess)
               {
                  paymentType = PaymentTypeEnum.PAYMENT_ON_SUCCESS_ONLY;
               }
               else
               {
                  paymentType = PaymentTypeEnum.PAYMENT_IN_ANY_CASE;
               }
               eigaapmsg = new ExchangeItemGoldAddAsPaymentMessage();
               eigaapmsg.initExchangeItemGoldAddAsPaymentMessage(paymentType,eigaapa.kamas);
               ConnectionsHandler.getConnection().send(eigaapmsg);
               return true;
            case msg is ExchangeItemObjectAddAsPaymentAction:
               eioaapa = msg as ExchangeItemObjectAddAsPaymentAction;
               if(eioaapa.onlySuccess)
               {
                  paymentTypeObject = PaymentTypeEnum.PAYMENT_ON_SUCCESS_ONLY;
                  objectlist = this.paymentCraftList.objectsPaymentOnlySuccess;
               }
               else
               {
                  paymentTypeObject = PaymentTypeEnum.PAYMENT_IN_ANY_CASE;
                  objectlist = this.paymentCraftList.objectsPaymentOnlySuccess;
               }
               eioaapmsg = new ExchangeItemObjectAddAsPaymentMessage();
               eioaapmsg.initExchangeItemObjectAddAsPaymentMessage(paymentTypeObject,eioaapa.isAdd,eioaapa.objectUID,eioaapa.quantity);
               ConnectionsHandler.getConnection().send(eioaapmsg);
               return true;
            case msg is ExchangeReplayStopAction:
               ersa = msg as ExchangeReplayStopAction;
               rsmsg = new ExchangeReplayStopMessage();
               rsmsg.initExchangeReplayStopMessage();
               ConnectionsHandler.getConnection().send(rsmsg);
               return true;
            case msg is ExchangeSetCraftRecipeAction:
               escra = msg as ExchangeSetCraftRecipeAction;
               escrmsg = new ExchangeSetCraftRecipeMessage();
               escrmsg.initExchangeSetCraftRecipeMessage(escra.recipeId);
               ConnectionsHandler.getConnection().send(escrmsg);
               return true;
            case msg is ExchangeCraftResultMessage:
               ecrmsg = msg as ExchangeCraftResultMessage;
               messageId = ecrmsg.getMessageId();
               itemW = null;
               success = false;
               switch(messageId)
               {
                  case ExchangeCraftResultMessage.protocolId:
                     craftResultMessage = I18n.getUiText("ui.craft.noResult");
                     break;
                  case ExchangeCraftResultWithObjectIdMessage.protocolId:
                     ecrwoimsg = msg as ExchangeCraftResultWithObjectIdMessage;
                     itemW = ItemWrapper.create(63,0,ecrwoimsg.objectGenericId,1,null,false);
                     objectName = Item.getItemById(ecrwoimsg.objectGenericId).name;
                     craftResultMessage = I18n.getUiText("ui.craft.failed");
                     success = ecrwoimsg.craftResult == 2;
                     break;
                  case ExchangeCraftResultMagicWithObjectDescMessage.protocolId:
                     ecrmwodmsg = msg as ExchangeCraftResultMagicWithObjectDescMessage;
                     smithText = "";
                     successS = false;
                     newEffects = ecrmwodmsg.objectInfo.effects;
                     sameEffectsCount = new Array();
                     if(this._smithMagicOldObject)
                     {
                        for each (oldEffect in this._smithMagicOldObject.effectsList)
                        {
                           sameEffectsCount.push(oldEffect);
                           if((oldEffect is ObjectEffectInteger) || (oldEffect is ObjectEffectDice))
                           {
                              sameEffectExists = false;
                              for each (newEffect in newEffects)
                              {
                                 if(((newEffect is ObjectEffectInteger) || (newEffect is ObjectEffectDice)) && (newEffect.actionId == oldEffect.actionId))
                                 {
                                    sameEffectExists = true;
                                    oldValue = Effect.getEffectById(oldEffect.actionId).bonusType;
                                    newValue = Effect.getEffectById(newEffect.actionId).bonusType;
                                    if(newEffect is ObjectEffectInteger)
                                    {
                                       oldValue = oldValue * ObjectEffectInteger(oldEffect).value;
                                       newValue = newValue * ObjectEffectInteger(newEffect).value;
                                       if(newValue != oldValue)
                                       {
                                          result = newValue - oldValue;
                                          effectInteger = new EffectInstanceInteger();
                                          effectInteger.effectId = newEffect.actionId;
                                          if(result > 0)
                                          {
                                             successS = true;
                                          }
                                          effectInteger.value = ObjectEffectInteger(newEffect).value - ObjectEffectInteger(oldEffect).value;
                                          smithText = smithText + (" " + effectInteger.description + ",");
                                          smithText = smithText.replace("+-","-");
                                          smithText = smithText.replace("--","+");
                                          effect = effectInteger;
                                       }
                                    }
                                    else
                                    {
                                       if(newEffect is ObjectEffectDice)
                                       {
                                          oldValue = ObjectEffectDice(oldEffect).diceNum;
                                          newValue = ObjectEffectDice(newEffect).diceNum;
                                          if(newValue != oldValue)
                                          {
                                             result = newValue - oldValue;
                                             if(oldEffect.actionId == ActionIdConverter.ACTION_ITEM_CHANGE_DURABILITY)
                                             {
                                                smithText = smithText + (" +" + result + ",");
                                                result = newValue;
                                             }
                                             effectDice = new EffectInstanceDice();
                                             effectDice.effectId = newEffect.actionId;
                                             if(result > 0)
                                             {
                                                successS = true;
                                             }
                                             effectDice.diceNum = result;
                                             effectDice.diceSide = result;
                                             effectDice.value = ObjectEffectDice(newEffect).diceConst;
                                             effect = effectDice;
                                             smithText = smithText + (" " + effect.description + ",");
                                             smithText = smithText.replace("+-","-");
                                             smithText = smithText.replace("--","+");
                                          }
                                       }
                                    }
                                 }
                              }
                              if(!sameEffectExists)
                              {
                                 effectInteger = new EffectInstanceInteger();
                                 effectInteger.effectId = oldEffect.actionId;
                                 effectInteger.value = -ObjectEffectInteger(oldEffect).value;
                                 smithText = smithText + (" " + effectInteger.description + ",");
                                 smithText = smithText.replace("+-","-");
                                 smithText = smithText.replace("--","+");
                                 effect = effectInteger;
                              }
                           }
                        }
                     }
                     for each (newEffect2 in newEffects)
                     {
                        reallyNew = true;
                        for each (oldEffect2 in sameEffectsCount)
                        {
                           if((newEffect2 is ObjectEffectInteger) || (newEffect2 is ObjectEffectMinMax))
                           {
                              if(newEffect2.actionId == oldEffect2.actionId)
                              {
                                 reallyNew = false;
                                 sameEffectsCount.splice(sameEffectsCount.indexOf(oldEffect2),1);
                              }
                           }
                           else
                           {
                              reallyNew = false;
                           }
                        }
                        if(reallyNew)
                        {
                           if(newEffect2 is ObjectEffectMinMax)
                           {
                              effectMinMax = new EffectInstanceMinMax();
                              effectMinMax.effectId = newEffect2.actionId;
                              effectMinMax.min = ObjectEffectMinMax(newEffect2).min;
                              effectMinMax.max = ObjectEffectMinMax(newEffect2).max;
                              effect = effectMinMax;
                              successS = true;
                           }
                           else
                           {
                              if(newEffect2 is ObjectEffectInteger)
                              {
                                 effectInteger = new EffectInstanceInteger();
                                 effectInteger.effectId = newEffect2.actionId;
                                 effectInteger.value = ObjectEffectInteger(newEffect2).value;
                                 if(effectInteger.value > 0)
                                 {
                                    successS = true;
                                 }
                                 smithText = smithText + (" " + effectInteger.description + ",");
                                 effect = effectInteger;
                              }
                           }
                        }
                     }
                     residualMagicText = "";
                     if(ecrmwodmsg.magicPoolStatus == 2)
                     {
                        residualMagicText = " +" + I18n.getUiText("ui.craft.smithResidualMagic");
                     }
                     else
                     {
                        if(ecrmwodmsg.magicPoolStatus == 3)
                        {
                           residualMagicText = " -" + I18n.getUiText("ui.craft.smithResidualMagic");
                        }
                     }
                     finalText = "";
                     if(successS)
                     {
                        finalText = finalText + (I18n.getUiText("ui.craft.success") + I18n.getUiText("ui.common.colon"));
                     }
                     else
                     {
                        finalText = finalText + (I18n.getUiText("ui.craft.failure") + I18n.getUiText("ui.common.colon"));
                     }
                     finalText = finalText + smithText;
                     if(residualMagicText != "")
                     {
                        finalText = finalText + residualMagicText;
                     }
                     else
                     {
                        finalText = finalText.substring(0,finalText.length - 1);
                     }
                     if((smithText == "") && (residualMagicText == ""))
                     {
                        finalText = finalText.substring(0,finalText.length - (I18n.getUiText("ui.common.colon").length - 1));
                     }
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,finalText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                     itemW = ItemWrapper.create(63,ecrmwodmsg.objectInfo.objectUID,ecrmwodmsg.objectInfo.objectGID,1,ecrmwodmsg.objectInfo.effects,false);
                     this._smithMagicOldObject = itemW.clone();
                     success = ecrmwodmsg.craftResult == 2;
                     break;
                  case ExchangeCraftResultWithObjectDescMessage.protocolId:
                     ecrwodmsg = msg as ExchangeCraftResultWithObjectDescMessage;
                     itemW = ItemWrapper.create(63,ecrwodmsg.objectInfo.objectUID,ecrwodmsg.objectInfo.objectGID,1,ecrwodmsg.objectInfo.effects,false);
                     if(ecrwodmsg.objectInfo.objectGID == 0)
                     {
                        break;
                     }
                     objectName = HyperlinkItemManager.newChatItem(itemW);
                     switch(true)
                     {
                        case this._crafterInfos.id == PlayedCharacterManager.getInstance().id:
                           craftResultMessage = I18n.getUiText("ui.craft.successTarget",[objectName,this._customerInfos.name]);
                           break;
                        case this._customerInfos.id == PlayedCharacterManager.getInstance().id:
                           craftResultMessage = I18n.getUiText("ui.craft.successOther",[this._crafterInfos.name,objectName]);
                           break;
                     }
                     success = ecrwodmsg.craftResult == 2;
                     break;
               }
               if(success)
               {
                  SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CRAFT_OK);
               }
               else
               {
                  SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CRAFT_KO);
               }
               if((craftResultMessage) && (!(craftResultMessage == "")))
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,craftResultMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeCraftResult,ecrmsg.craftResult,itemW);
               return true;
            case msg is ExchangeItemAutoCraftStopedMessage:
               eiacsmsg = msg as ExchangeItemAutoCraftStopedMessage;
               autoCraftStopedMessage = "";
               showPopup = true;
               switch(eiacsmsg.reason)
               {
                  case ExchangeReplayStopReasonEnum.STOPPED_REASON_IMPOSSIBLE_CRAFT:
                     autoCraftStopedMessage = I18n.getUiText("ui.craft.autoCraftStopedInvalidRecipe");
                     break;
                  case ExchangeReplayStopReasonEnum.STOPPED_REASON_MISSING_RESSOURCE:
                     autoCraftStopedMessage = I18n.getUiText("ui.craft.autoCraftStopedNoRessource");
                     break;
                  case ExchangeReplayStopReasonEnum.STOPPED_REASON_OK:
                     autoCraftStopedMessage = I18n.getUiText("ui.craft.autoCraftStopedOk");
                     break;
                  case ExchangeReplayStopReasonEnum.STOPPED_REASON_USER:
                     autoCraftStopedMessage = I18n.getUiText("ui.craft.autoCraftStoped");
                     showPopup = false;
                     break;
               }
               if(showPopup)
               {
                  commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                  commonMod.openPopup(I18n.getUiText("ui.popup.information"),autoCraftStopedMessage,[I18n.getUiText("ui.common.ok")]);
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,autoCraftStopedMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeItemAutoCraftStoped,eiacsmsg.reason);
               return true;
            case msg is ExchangeStartOkCraftMessage:
               esocmsg = msg as ExchangeStartOkCraftMessage;
               PlayedCharacterManager.getInstance().isInExchange = true;
               msgId = esocmsg.getMessageId();
               switch(msgId)
               {
                  case ExchangeStartOkCraftMessage.protocolId:
                     KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkCraft);
                     break;
                  case ExchangeStartOkCraftWithInformationMessage.protocolId:
                     this.processExchangeStartOkCraftWithInformationMessage(msg as ExchangeStartOkCraftWithInformationMessage);
                     break;
               }
               return true;
            case msg is ExchangeGoldPaymentForCraftMessage:
               egpfcmsg = msg as ExchangeGoldPaymentForCraftMessage;
               if(this.commonExchangeFrame)
               {
                  this.commonExchangeFrame.incrementEchangeSequence();
               }
               if(egpfcmsg.onlySuccess)
               {
                  this.paymentCraftList.kamaPaymentOnlySuccess = egpfcmsg.goldSum;
               }
               else
               {
                  this.paymentCraftList.kamaPayment = egpfcmsg.goldSum;
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList,this.paymentCraftList,true);
               return true;
            case msg is ExchangeItemPaymentForCraftMessage:
               eipfcmsg = msg as ExchangeItemPaymentForCraftMessage;
               if(this.commonExchangeFrame)
               {
                  this.commonExchangeFrame.incrementEchangeSequence();
               }
               itemWrapper = ItemWrapper.create(63,eipfcmsg.object.objectUID,eipfcmsg.object.objectGID,eipfcmsg.object.quantity,eipfcmsg.object.effects,false);
               this.addObjetPayment(eipfcmsg.onlySuccess,itemWrapper);
               KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList,this.paymentCraftList,true);
               return true;
            case msg is ExchangeRemovedPaymentForCraftMessage:
               erpfcmsg = msg as ExchangeRemovedPaymentForCraftMessage;
               if(this.commonExchangeFrame)
               {
                  this.commonExchangeFrame.incrementEchangeSequence();
               }
               this.removeObjetPayment(erpfcmsg.objectUID,erpfcmsg.onlySuccess);
               KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList,this.paymentCraftList,true);
               return true;
            case msg is ExchangeModifiedPaymentForCraftMessage:
               empfcmsg = msg as ExchangeModifiedPaymentForCraftMessage;
               if(this.commonExchangeFrame)
               {
                  this.commonExchangeFrame.incrementEchangeSequence();
               }
               itTemp = ItemWrapper.getItemFromUId(empfcmsg.object.objectUID);
               newItemWra = ItemWrapper.create(63,empfcmsg.object.objectUID,empfcmsg.object.objectGID,empfcmsg.object.quantity,empfcmsg.object.effects,false);
               if(empfcmsg.onlySuccess)
               {
                  objectLis = this.paymentCraftList.objectsPaymentOnlySuccess;
               }
               else
               {
                  objectLis = this.paymentCraftList.objectsPayment;
               }
               objectLis.splice(objectLis.indexOf(itTemp),1,newItemWra);
               KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList,this.paymentCraftList,true);
               return true;
            case msg is ExchangeClearPaymentForCraftMessage:
               ecpfcmsg = msg as ExchangeClearPaymentForCraftMessage;
               if(this.commonExchangeFrame)
               {
                  this.commonExchangeFrame.incrementEchangeSequence();
               }
               switch(ecpfcmsg.paymentType)
               {
                  case PaymentTypeEnum.PAYMENT_IN_ANY_CASE:
                     this.paymentCraftList.kamaPayment = 0;
                     for each (op in this.paymentCraftList.objectsPayment)
                     {
                        InventoryManager.getInstance().inventory.removeItemMask(op.objectUID,"paymentAlways");
                     }
                     this.paymentCraftList.objectsPayment = new Array();
                     break;
                  case PaymentTypeEnum.PAYMENT_ON_SUCCESS_ONLY:
                     this.paymentCraftList.kamaPaymentOnlySuccess = 0;
                     for each (ops in this.paymentCraftList.objectsPaymentOnlySuccess)
                     {
                        InventoryManager.getInstance().inventory.removeItemMask(ops.objectUID,"paymentSuccess");
                     }
                     this.paymentCraftList.objectsPaymentOnlySuccess = new Array();
                     break;
               }
               return true;
            case msg is ExchangeObjectModifiedInBagMessage:
               eomiwmsg = msg as ExchangeObjectModifiedInBagMessage;
               for each (iwrapper in this.bagList)
               {
                  if(iwrapper.objectUID == eomiwmsg.object.objectUID)
                  {
                     newItemWr = ItemWrapper.create(63,eomiwmsg.object.objectUID,eomiwmsg.object.objectGID,eomiwmsg.object.quantity,eomiwmsg.object.effects,false);
                     this.bagList.splice(this.bagList.indexOf(iwrapper),1,newItemWr);
                     break;
                  }
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.BagListUpdate,this.bagList,eomiwmsg.remote);
               return true;
            case msg is ExchangeObjectPutInBagMessage:
               eopiwmsg = msg as ExchangeObjectPutInBagMessage;
               obj = eopiwmsg.object;
               obAdded = ItemWrapper.create(63,obj.objectUID,obj.objectGID,obj.quantity,obj.effects,false);
               this.bagList.push(obAdded);
               KernelEventsManager.getInstance().processCallback(CraftHookList.BagListUpdate,this.bagList,eopiwmsg.remote);
               return true;
            case msg is ExchangeObjectRemovedFromBagMessage:
               eorfwmsg = msg as ExchangeObjectRemovedFromBagMessage;
               compt = 0;
               for each (iw in this.bagList)
               {
                  if(iw.objectUID == eorfwmsg.objectUID)
                  {
                     this.bagList.splice(compt,1);
                     break;
                  }
                  compt++;
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.BagListUpdate,this.bagList,eorfwmsg.remote);
               return true;
            case msg is ExchangeObjectUseInWorkshopAction:
               eosiwa = msg as ExchangeObjectUseInWorkshopAction;
               eouiwmsg = new ExchangeObjectUseInWorkshopMessage();
               eouiwmsg.initExchangeObjectUseInWorkshopMessage(eosiwa.objectUID,eosiwa.quantity);
               ConnectionsHandler.getConnection().send(eouiwmsg);
               return true;
            case msg is ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction:
               emcsccuhra = msg as ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction;
               emcsccuhrmsg = new ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage();
               emcsccuhrmsg.initExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(emcsccuhra.allow);
               ConnectionsHandler.getConnection().send(emcsccuhrmsg);
               return true;
            case msg is ExchangeMultiCraftCrafterCanUseHisRessourcesMessage:
               emcccuhrmsg = msg as ExchangeMultiCraftCrafterCanUseHisRessourcesMessage;
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeMultiCraftCrafterCanUseHisRessources,emcccuhrmsg.allowed);
               return true;
            case msg is ExchangeStartOkMulticraftCrafterMessage:
               esomcmsg = msg as ExchangeStartOkMulticraftCrafterMessage;
               recipes = Recipe.getAllRecipesForSkillId(esomcmsg.skillId,esomcmsg.maxCase);
               this._skillId = esomcmsg.skillId;
               skill = Skill.getSkillById(this._skillId);
               if(skill.isForgemagus)
               {
                  this._craftType = 1;
               }
               else
               {
                  if(skill.isRepair)
                  {
                     this._craftType = 2;
                  }
                  else
                  {
                     this._craftType = 0;
                  }
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkMultiCraft,esomcmsg.skillId,recipes,esomcmsg.maxCase,this.crafterInfos,this.customerInfos);
               return true;
            case msg is ExchangeStartOkMulticraftCustomerMessage:
               esomcustomermsg = msg as ExchangeStartOkMulticraftCustomerMessage;
               recipesCrafter = Recipe.getAllRecipesForSkillId(esomcustomermsg.skillId,esomcustomermsg.maxCase);
               this.crafterInfos.skillLevel = esomcustomermsg.crafterJobLevel;
               this._skillId = esomcustomermsg.skillId;
               skill2 = Skill.getSkillById(this._skillId);
               if(skill2.isForgemagus)
               {
                  this._craftType = 1;
               }
               else
               {
                  if(skill2.isRepair)
                  {
                     this._craftType = 2;
                  }
                  else
                  {
                     this._craftType = 0;
                  }
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkMultiCraft,esomcustomermsg.skillId,recipesCrafter,esomcustomermsg.maxCase,this.crafterInfos,this.customerInfos);
               return true;
            case msg is ExchangeReplayAction:
               era = msg as ExchangeReplayAction;
               ermsg = new ExchangeReplayMessage();
               ermsg.initExchangeReplayMessage(era.count);
               ConnectionsHandler.getConnection().send(ermsg);
               return true;
            case msg is ExchangeReplayCountModifiedMessage:
               ercmmsg = msg as ExchangeReplayCountModifiedMessage;
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeReplayCountModified,ercmmsg.count);
               return true;
            case msg is ExchangeItemAutoCraftRemainingMessage:
               eiacrmsg = msg as ExchangeItemAutoCraftRemainingMessage;
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeItemAutoCraftRemaining,eiacrmsg.count);
               return true;
            case msg is ExchangeCraftSlotCountIncreasedMessage:
               ecscimsg = msg as ExchangeCraftSlotCountIncreasedMessage;
               recipes = Recipe.getAllRecipesForSkillId(this._skillId,ecscimsg.newMaxSlot);
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeCraftSlotCountIncreased,ecscimsg.newMaxSlot,recipes);
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
         for each (itemo in this.otherPlayerList.componentList)
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
         for each (itemp in this.playerList.componentList)
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
         for each (itemW in objects)
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
