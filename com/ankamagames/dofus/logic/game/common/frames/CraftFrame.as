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
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeOkMultiCraftMessage;
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
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectDice;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectInteger;
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
    import com.ankamagames.jerakine.messages.Message;

    public class CraftFrame implements Frame 
    {

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

        public function CraftFrame()
        {
            this.playerList = new PlayerExchangeCraftList();
            this.otherPlayerList = new PlayerExchangeCraftList();
            this.paymentCraftList = new PaymentCraftList();
            this._crafterInfos = new PlayerInfo();
            this._customerInfos = new PlayerInfo();
            this.bagList = new Array();
            super();
        }

        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        private function get socialFrame():SocialFrame
        {
            return ((Kernel.getWorker().getFrame(SocialFrame) as SocialFrame));
        }

        public function get crafterInfos():PlayerInfo
        {
            return (this._crafterInfos);
        }

        public function get customerInfos():PlayerInfo
        {
            return (this._customerInfos);
        }

        public function get skillId():int
        {
            return (this._skillId);
        }

        private function get roleplayContextFrame():RoleplayContextFrame
        {
            return ((Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame));
        }

        private function get commonExchangeFrame():CommonExchangeManagementFrame
        {
            return ((Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame));
        }

        public function processExchangeOkMultiCraftMessage(msg:ExchangeOkMultiCraftMessage):void
        {
            PlayedCharacterManager.getInstance().isInExchange = true;
            var eomcmsg:ExchangeOkMultiCraftMessage = (msg as ExchangeOkMultiCraftMessage);
            if (eomcmsg.role == ExchangeTypeEnum.MULTICRAFT_CRAFTER)
            {
                this.playerList.isCrafter = true;
                this.otherPlayerList.isCrafter = false;
                this._crafterInfos.id = PlayedCharacterManager.getInstance().id;
                if (this.crafterInfos.id == eomcmsg.initiatorId)
                {
                    this._customerInfos.id = eomcmsg.otherId;
                }
                else
                {
                    this._customerInfos.id = eomcmsg.initiatorId;
                };
            }
            else
            {
                this.playerList.isCrafter = false;
                this.otherPlayerList.isCrafter = true;
                this._customerInfos.id = PlayedCharacterManager.getInstance().id;
                if (this.customerInfos.id == eomcmsg.initiatorId)
                {
                    this._crafterInfos.id = eomcmsg.otherId;
                }
                else
                {
                    this._crafterInfos.id = eomcmsg.initiatorId;
                };
            };
            var crafterEntity:GameContextActorInformations = this.roleplayContextFrame.entitiesFrame.getEntityInfos(this.crafterInfos.id);
            if (crafterEntity)
            {
                this._crafterInfos.look = EntityLookAdapter.getRiderLook(crafterEntity.look);
                this._crafterInfos.name = (crafterEntity as GameRolePlayNamedActorInformations).name;
            }
            else
            {
                this._crafterInfos.look = null;
                this._crafterInfos.name = "";
            };
            var customerEntity:GameContextActorInformations = this.roleplayContextFrame.entitiesFrame.getEntityInfos(this.customerInfos.id);
            if (customerEntity)
            {
                this._customerInfos.look = EntityLookAdapter.getRiderLook(customerEntity.look);
                this._customerInfos.name = (customerEntity as GameRolePlayNamedActorInformations).name;
            }
            else
            {
                this._customerInfos.look = null;
                this._customerInfos.name = "";
            };
            var otherName:String = "";
            var askerId:uint = eomcmsg.initiatorId;
            if (eomcmsg.initiatorId == PlayedCharacterManager.getInstance().id)
            {
                if (eomcmsg.initiatorId == this.crafterInfos.id)
                {
                    this._isCrafter = true;
                    otherName = this.customerInfos.name;
                }
                else
                {
                    this._isCrafter = false;
                    otherName = this.crafterInfos.name;
                };
            }
            else
            {
                if (eomcmsg.otherId == this.crafterInfos.id)
                {
                    this._isCrafter = false;
                    otherName = this.crafterInfos.name;
                }
                else
                {
                    this._isCrafter = true;
                    otherName = this.customerInfos.name;
                };
            };
            if (!(this.socialFrame.isIgnored(otherName)))
            {
                KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeMultiCraftRequest, eomcmsg.role, otherName, askerId);
            };
        }

        public function processExchangeStartOkCraftWithInformationMessage(msg:ExchangeStartOkCraftWithInformationMessage):void
        {
            PlayedCharacterManager.getInstance().isInExchange = true;
            var esocwimsg:ExchangeStartOkCraftWithInformationMessage = (msg as ExchangeStartOkCraftWithInformationMessage);
            this._skillId = esocwimsg.skillId;
            var recipes:Array = Recipe.getAllRecipesForSkillId(esocwimsg.skillId, esocwimsg.nbCase);
            this._isCrafter = true;
            var skill:Skill = Skill.getSkillById(this._skillId);
            if (skill.isForgemagus)
            {
                this._craftType = 1;
            }
            else
            {
                if (skill.isRepair)
                {
                    this._craftType = 2;
                }
                else
                {
                    this._craftType = 0;
                };
            };
            KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkCraft, recipes, esocwimsg.skillId, esocwimsg.nbCase);
        }

        public function pushed():Boolean
        {
            this._success = false;
            return (true);
        }

        public function pulled():Boolean
        {
            if (Kernel.getWorker().contains(CommonExchangeManagementFrame))
            {
                Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
            };
            KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave, this._success);
            this.playerList = new PlayerExchangeCraftList();
            this.otherPlayerList = new PlayerExchangeCraftList();
            this.bagList = new Array();
            this._crafterInfos = new PlayerInfo();
            this._customerInfos = new PlayerInfo();
            this.paymentCraftList = new PaymentCraftList();
            this._smithMagicOldObject = null;
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:ExchangePlayerMultiCraftRequestAction;
            var _local_3:ExchangePlayerMultiCraftRequestMessage;
            var _local_4:ExchangeItemGoldAddAsPaymentAction;
            var _local_5:uint;
            var _local_6:ExchangeItemGoldAddAsPaymentMessage;
            var _local_7:ExchangeItemObjectAddAsPaymentAction;
            var _local_8:uint;
            var _local_9:Array;
            var _local_10:ItemWrapper;
            var _local_11:ExchangeItemObjectAddAsPaymentMessage;
            var _local_12:ExchangeReplayStopAction;
            var _local_13:ExchangeReplayStopMessage;
            var _local_14:ExchangeSetCraftRecipeAction;
            var _local_15:ExchangeSetCraftRecipeMessage;
            var _local_16:ExchangeCraftResultMessage;
            var _local_17:uint;
            var _local_18:String;
            var _local_19:String;
            var _local_20:ItemWrapper;
            var _local_21:Boolean;
            var _local_22:ExchangeItemAutoCraftStopedMessage;
            var _local_23:String;
            var _local_24:Boolean;
            var _local_25:ExchangeStartOkCraftMessage;
            var _local_26:uint;
            var _local_27:ExchangeGoldPaymentForCraftMessage;
            var _local_28:ExchangeItemPaymentForCraftMessage;
            var _local_29:ItemWrapper;
            var _local_30:ExchangeRemovedPaymentForCraftMessage;
            var _local_31:ExchangeModifiedPaymentForCraftMessage;
            var _local_32:ItemWrapper;
            var _local_33:ItemWrapper;
            var _local_34:Array;
            var _local_35:ExchangeClearPaymentForCraftMessage;
            var _local_36:ExchangeObjectModifiedInBagMessage;
            var _local_37:ExchangeObjectPutInBagMessage;
            var _local_38:ObjectItem;
            var _local_39:ItemWrapper;
            var _local_40:ExchangeObjectRemovedFromBagMessage;
            var _local_41:uint;
            var _local_42:ExchangeObjectUseInWorkshopAction;
            var _local_43:ExchangeObjectUseInWorkshopMessage;
            var _local_44:ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction;
            var _local_45:ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage;
            var _local_46:ExchangeMultiCraftCrafterCanUseHisRessourcesMessage;
            var _local_47:ExchangeStartOkMulticraftCrafterMessage;
            var _local_48:Array;
            var _local_49:Skill;
            var _local_50:ExchangeStartOkMulticraftCustomerMessage;
            var _local_51:Array;
            var _local_52:Skill;
            var _local_53:ExchangeReplayAction;
            var _local_54:ExchangeReplayMessage;
            var _local_55:ExchangeReplayCountModifiedMessage;
            var _local_56:ExchangeItemAutoCraftRemainingMessage;
            var _local_57:ExchangeCraftSlotCountIncreasedMessage;
            var _local_58:ExchangeLeaveMessage;
            var _local_59:ExchangeCraftResultWithObjectIdMessage;
            var _local_60:ExchangeCraftResultMagicWithObjectDescMessage;
            var _local_61:String;
            var _local_62:Boolean;
            var _local_63:Vector.<ObjectEffect>;
            var _local_64:EffectInstance;
            var _local_65:Array;
            var _local_66:String;
            var _local_67:String;
            var _local_68:ExchangeCraftResultWithObjectDescMessage;
            var oldEffect:ObjectEffect;
            var sameEffectExists:Boolean;
            var newEffect:ObjectEffect;
            var oldValue:int;
            var newValue:int;
            var result:int;
            var effectInteger:EffectInstanceInteger;
            var effectDice:EffectInstanceDice;
            var newEffect2:ObjectEffect;
            var reallyNew:Boolean;
            var oldEffect2:ObjectEffect;
            var effectMinMax:EffectInstanceMinMax;
            var commonMod:Object;
            var op:ItemWrapper;
            var ops:ItemWrapper;
            var iwrapper:ItemWrapper;
            var newItemWr:ItemWrapper;
            var iw:ItemWrapper;
            switch (true)
            {
                case (msg is ExchangePlayerMultiCraftRequestAction):
                    _local_2 = (msg as ExchangePlayerMultiCraftRequestAction);
                    _local_3 = new ExchangePlayerMultiCraftRequestMessage();
                    _local_3.initExchangePlayerMultiCraftRequestMessage(_local_2.exchangeType, _local_2.target, _local_2.skillId);
                    ConnectionsHandler.getConnection().send(_local_3);
                    return (true);
                case (msg is ExchangeOkMultiCraftMessage):
                    this.processExchangeOkMultiCraftMessage((msg as ExchangeOkMultiCraftMessage));
                    return (true);
                case (msg is ExchangeItemGoldAddAsPaymentAction):
                    _local_4 = (msg as ExchangeItemGoldAddAsPaymentAction);
                    if (_local_4.onlySuccess)
                    {
                        _local_5 = PaymentTypeEnum.PAYMENT_ON_SUCCESS_ONLY;
                    }
                    else
                    {
                        _local_5 = PaymentTypeEnum.PAYMENT_IN_ANY_CASE;
                    };
                    _local_6 = new ExchangeItemGoldAddAsPaymentMessage();
                    _local_6.initExchangeItemGoldAddAsPaymentMessage(_local_5, _local_4.kamas);
                    ConnectionsHandler.getConnection().send(_local_6);
                    return (true);
                case (msg is ExchangeItemObjectAddAsPaymentAction):
                    _local_7 = (msg as ExchangeItemObjectAddAsPaymentAction);
                    if (_local_7.onlySuccess)
                    {
                        _local_8 = PaymentTypeEnum.PAYMENT_ON_SUCCESS_ONLY;
                        _local_9 = this.paymentCraftList.objectsPaymentOnlySuccess;
                    }
                    else
                    {
                        _local_8 = PaymentTypeEnum.PAYMENT_IN_ANY_CASE;
                        _local_9 = this.paymentCraftList.objectsPaymentOnlySuccess;
                    };
                    _local_11 = new ExchangeItemObjectAddAsPaymentMessage();
                    _local_11.initExchangeItemObjectAddAsPaymentMessage(_local_8, _local_7.isAdd, _local_7.objectUID, _local_7.quantity);
                    ConnectionsHandler.getConnection().send(_local_11);
                    return (true);
                case (msg is ExchangeReplayStopAction):
                    _local_12 = (msg as ExchangeReplayStopAction);
                    _local_13 = new ExchangeReplayStopMessage();
                    _local_13.initExchangeReplayStopMessage();
                    ConnectionsHandler.getConnection().send(_local_13);
                    return (true);
                case (msg is ExchangeSetCraftRecipeAction):
                    _local_14 = (msg as ExchangeSetCraftRecipeAction);
                    _local_15 = new ExchangeSetCraftRecipeMessage();
                    _local_15.initExchangeSetCraftRecipeMessage(_local_14.recipeId);
                    ConnectionsHandler.getConnection().send(_local_15);
                    return (true);
                case (msg is ExchangeCraftResultMessage):
                    _local_16 = (msg as ExchangeCraftResultMessage);
                    _local_17 = _local_16.getMessageId();
                    _local_20 = null;
                    _local_21 = false;
                    switch (_local_17)
                    {
                        case ExchangeCraftResultMessage.protocolId:
                            _local_19 = I18n.getUiText("ui.craft.noResult");
                            break;
                        case ExchangeCraftResultWithObjectIdMessage.protocolId:
                            _local_59 = (msg as ExchangeCraftResultWithObjectIdMessage);
                            _local_20 = ItemWrapper.create(63, 0, _local_59.objectGenericId, 1, null, false);
                            _local_18 = Item.getItemById(_local_59.objectGenericId).name;
                            _local_19 = I18n.getUiText("ui.craft.failed");
                            _local_21 = (_local_59.craftResult == 2);
                            break;
                        case ExchangeCraftResultMagicWithObjectDescMessage.protocolId:
                            _local_60 = (msg as ExchangeCraftResultMagicWithObjectDescMessage);
                            _local_61 = "";
                            _local_62 = false;
                            _local_63 = _local_60.objectInfo.effects;
                            _local_65 = new Array();
                            if (this._smithMagicOldObject)
                            {
                                for each (oldEffect in this._smithMagicOldObject.effectsList)
                                {
                                    _local_65.push(oldEffect);
                                    if ((((oldEffect is ObjectEffectInteger)) || ((oldEffect is ObjectEffectDice))))
                                    {
                                        sameEffectExists = false;
                                        for each (newEffect in _local_63)
                                        {
                                            if ((((((newEffect is ObjectEffectInteger)) || ((newEffect is ObjectEffectDice)))) && ((newEffect.actionId == oldEffect.actionId))))
                                            {
                                                sameEffectExists = true;
                                                oldValue = Effect.getEffectById(oldEffect.actionId).bonusType;
                                                newValue = Effect.getEffectById(newEffect.actionId).bonusType;
                                                if ((((newEffect is ObjectEffectInteger)) && ((oldEffect is ObjectEffectInteger))))
                                                {
                                                    oldValue = (oldValue * ObjectEffectInteger(oldEffect).value);
                                                    newValue = (newValue * ObjectEffectInteger(newEffect).value);
                                                    if (newValue != oldValue)
                                                    {
                                                        result = (newValue - oldValue);
                                                        effectInteger = new EffectInstanceInteger();
                                                        effectInteger.effectId = newEffect.actionId;
                                                        if (result > 0)
                                                        {
                                                            _local_62 = true;
                                                        };
                                                        effectInteger.value = (ObjectEffectInteger(newEffect).value - ObjectEffectInteger(oldEffect).value);
                                                        _local_61 = (_local_61 + ((" " + effectInteger.description) + ","));
                                                        _local_61 = _local_61.replace("+-", "-");
                                                        _local_61 = _local_61.replace("--", "+");
                                                        _local_64 = effectInteger;
                                                    };
                                                }
                                                else
                                                {
                                                    if ((((newEffect is ObjectEffectDice)) && ((oldEffect is ObjectEffectDice))))
                                                    {
                                                        oldValue = ObjectEffectDice(oldEffect).diceNum;
                                                        newValue = ObjectEffectDice(newEffect).diceNum;
                                                        if (newValue != oldValue)
                                                        {
                                                            result = (newValue - oldValue);
                                                            if (oldEffect.actionId == ActionIdConverter.ACTION_ITEM_CHANGE_DURABILITY)
                                                            {
                                                                _local_61 = (_local_61 + ((" +" + result) + ","));
                                                                result = newValue;
                                                            };
                                                            effectDice = new EffectInstanceDice();
                                                            effectDice.effectId = newEffect.actionId;
                                                            if (result > 0)
                                                            {
                                                                _local_62 = true;
                                                            };
                                                            effectDice.diceNum = result;
                                                            effectDice.diceSide = result;
                                                            effectDice.value = ObjectEffectDice(newEffect).diceConst;
                                                            _local_64 = effectDice;
                                                            _local_61 = (_local_61 + ((" " + _local_64.description) + ","));
                                                            _local_61 = _local_61.replace("+-", "-");
                                                            _local_61 = _local_61.replace("--", "+");
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                        if (((!(sameEffectExists)) && ((oldEffect is ObjectEffectInteger))))
                                        {
                                            effectInteger = new EffectInstanceInteger();
                                            effectInteger.effectId = oldEffect.actionId;
                                            effectInteger.value = -(ObjectEffectInteger(oldEffect).value);
                                            _local_61 = (_local_61 + ((" " + effectInteger.description) + ","));
                                            _local_61 = _local_61.replace("+-", "-");
                                            _local_61 = _local_61.replace("--", "+");
                                            _local_64 = effectInteger;
                                            if (_local_64.description.substr(0, 2) == "--")
                                            {
                                                _local_62 = true;
                                            };
                                        };
                                    };
                                };
                            };
                            for each (newEffect2 in _local_63)
                            {
                                reallyNew = true;
                                for each (oldEffect2 in _local_65)
                                {
                                    if ((((newEffect2 is ObjectEffectInteger)) || ((newEffect2 is ObjectEffectMinMax))))
                                    {
                                        if (newEffect2.actionId == oldEffect2.actionId)
                                        {
                                            reallyNew = false;
                                            _local_65.splice(_local_65.indexOf(oldEffect2), 1);
                                            break;
                                        };
                                    }
                                    else
                                    {
                                        reallyNew = false;
                                    };
                                };
                                if (reallyNew)
                                {
                                    if ((newEffect2 is ObjectEffectMinMax))
                                    {
                                        effectMinMax = new EffectInstanceMinMax();
                                        effectMinMax.effectId = newEffect2.actionId;
                                        effectMinMax.min = ObjectEffectMinMax(newEffect2).min;
                                        effectMinMax.max = ObjectEffectMinMax(newEffect2).max;
                                        _local_64 = effectMinMax;
                                        _local_62 = true;
                                    }
                                    else
                                    {
                                        if ((newEffect2 is ObjectEffectInteger))
                                        {
                                            effectInteger = new EffectInstanceInteger();
                                            effectInteger.effectId = newEffect2.actionId;
                                            effectInteger.value = ObjectEffectInteger(newEffect2).value;
                                            if ((((effectInteger.value > 0)) && (!((effectInteger.description.charAt(0) == "-")))))
                                            {
                                                _local_62 = true;
                                            };
                                            _local_61 = (_local_61 + ((" " + effectInteger.description) + ","));
                                            _local_64 = effectInteger;
                                        };
                                    };
                                };
                            };
                            _local_66 = "";
                            if (_local_60.magicPoolStatus == 2)
                            {
                                _local_66 = (" +" + I18n.getUiText("ui.craft.smithResidualMagic"));
                            }
                            else
                            {
                                if (_local_60.magicPoolStatus == 3)
                                {
                                    _local_66 = (" -" + I18n.getUiText("ui.craft.smithResidualMagic"));
                                };
                            };
                            _local_67 = "";
                            if (_local_62)
                            {
                                _local_67 = (_local_67 + (I18n.getUiText("ui.craft.success") + I18n.getUiText("ui.common.colon")));
                            }
                            else
                            {
                                _local_67 = (_local_67 + (I18n.getUiText("ui.craft.failure") + I18n.getUiText("ui.common.colon")));
                            };
                            _local_67 = (_local_67 + _local_61);
                            if (_local_66 != "")
                            {
                                _local_67 = (_local_67 + _local_66);
                            }
                            else
                            {
                                _local_67 = _local_67.substring(0, (_local_67.length - 1));
                            };
                            if ((((_local_61 == "")) && ((_local_66 == ""))))
                            {
                                _local_67 = _local_67.substring(0, (_local_67.length - (I18n.getUiText("ui.common.colon").length - 1)));
                            };
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_67, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                            _local_20 = ItemWrapper.create(63, _local_60.objectInfo.objectUID, _local_60.objectInfo.objectGID, 1, _local_60.objectInfo.effects, false);
                            this._smithMagicOldObject = _local_20.clone();
                            _local_21 = (_local_60.craftResult == 2);
                            break;
                        case ExchangeCraftResultWithObjectDescMessage.protocolId:
                            _local_68 = (msg as ExchangeCraftResultWithObjectDescMessage);
                            _local_20 = ItemWrapper.create(63, _local_68.objectInfo.objectUID, _local_68.objectInfo.objectGID, 1, _local_68.objectInfo.effects, false);
                            if (_local_68.objectInfo.objectGID == 0)
                            {
                                break;
                            };
                            _local_18 = HyperlinkItemManager.newChatItem(_local_20);
                            switch (true)
                            {
                                case (this._crafterInfos.id == PlayedCharacterManager.getInstance().id):
                                    _local_19 = I18n.getUiText("ui.craft.successTarget", [_local_18, this._customerInfos.name]);
                                    break;
                                case (this._customerInfos.id == PlayedCharacterManager.getInstance().id):
                                    _local_19 = I18n.getUiText("ui.craft.successOther", [this._crafterInfos.name, _local_18]);
                                    break;
                                default:
                                    _local_19 = I18n.getUiText("ui.craft.craftSuccessSelf", [_local_18]);
                            };
                            _local_21 = (_local_68.craftResult == 2);
                            break;
                    };
                    if (_local_21)
                    {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CRAFT_OK);
                    }
                    else
                    {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CRAFT_KO);
                    };
                    if (((_local_19) && (!((_local_19 == "")))))
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_19, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeCraftResult, _local_16.craftResult, _local_20);
                    return (true);
                case (msg is ExchangeItemAutoCraftStopedMessage):
                    _local_22 = (msg as ExchangeItemAutoCraftStopedMessage);
                    _local_23 = "";
                    _local_24 = true;
                    switch (_local_22.reason)
                    {
                        case ExchangeReplayStopReasonEnum.STOPPED_REASON_IMPOSSIBLE_CRAFT:
                            _local_23 = I18n.getUiText("ui.craft.autoCraftStopedInvalidRecipe");
                            break;
                        case ExchangeReplayStopReasonEnum.STOPPED_REASON_MISSING_RESSOURCE:
                            _local_23 = I18n.getUiText("ui.craft.autoCraftStopedNoRessource");
                            break;
                        case ExchangeReplayStopReasonEnum.STOPPED_REASON_OK:
                            _local_23 = I18n.getUiText("ui.craft.autoCraftStopedOk");
                            break;
                        case ExchangeReplayStopReasonEnum.STOPPED_REASON_USER:
                            _local_23 = I18n.getUiText("ui.craft.autoCraftStoped");
                            _local_24 = false;
                            break;
                    };
                    if (_local_24)
                    {
                        commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                        commonMod.openPopup(I18n.getUiText("ui.popup.information"), _local_23, [I18n.getUiText("ui.common.ok")]);
                    };
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_23, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeItemAutoCraftStoped, _local_22.reason);
                    return (true);
                case (msg is ExchangeStartOkCraftMessage):
                    _local_25 = (msg as ExchangeStartOkCraftMessage);
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    _local_26 = _local_25.getMessageId();
                    switch (_local_26)
                    {
                        case ExchangeStartOkCraftMessage.protocolId:
                            KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkCraft);
                            break;
                        case ExchangeStartOkCraftWithInformationMessage.protocolId:
                            this.processExchangeStartOkCraftWithInformationMessage((msg as ExchangeStartOkCraftWithInformationMessage));
                            break;
                    };
                    return (true);
                case (msg is ExchangeGoldPaymentForCraftMessage):
                    _local_27 = (msg as ExchangeGoldPaymentForCraftMessage);
                    if (this.commonExchangeFrame)
                    {
                        this.commonExchangeFrame.incrementEchangeSequence();
                    };
                    if (_local_27.onlySuccess)
                    {
                        this.paymentCraftList.kamaPaymentOnlySuccess = _local_27.goldSum;
                    }
                    else
                    {
                        this.paymentCraftList.kamaPayment = _local_27.goldSum;
                    };
                    KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList, this.paymentCraftList, true);
                    return (true);
                case (msg is ExchangeItemPaymentForCraftMessage):
                    _local_28 = (msg as ExchangeItemPaymentForCraftMessage);
                    if (this.commonExchangeFrame)
                    {
                        this.commonExchangeFrame.incrementEchangeSequence();
                    };
                    _local_29 = ItemWrapper.create(63, _local_28.object.objectUID, _local_28.object.objectGID, _local_28.object.quantity, _local_28.object.effects, false);
                    this.addObjetPayment(_local_28.onlySuccess, _local_29);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList, this.paymentCraftList, true);
                    return (true);
                case (msg is ExchangeRemovedPaymentForCraftMessage):
                    _local_30 = (msg as ExchangeRemovedPaymentForCraftMessage);
                    if (this.commonExchangeFrame)
                    {
                        this.commonExchangeFrame.incrementEchangeSequence();
                    };
                    this.removeObjetPayment(_local_30.objectUID, _local_30.onlySuccess);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList, this.paymentCraftList, true);
                    return (true);
                case (msg is ExchangeModifiedPaymentForCraftMessage):
                    _local_31 = (msg as ExchangeModifiedPaymentForCraftMessage);
                    if (this.commonExchangeFrame)
                    {
                        this.commonExchangeFrame.incrementEchangeSequence();
                    };
                    _local_32 = ItemWrapper.getItemFromUId(_local_31.object.objectUID);
                    _local_33 = ItemWrapper.create(63, _local_31.object.objectUID, _local_31.object.objectGID, _local_31.object.quantity, _local_31.object.effects, false);
                    if (_local_31.onlySuccess)
                    {
                        _local_34 = this.paymentCraftList.objectsPaymentOnlySuccess;
                    }
                    else
                    {
                        _local_34 = this.paymentCraftList.objectsPayment;
                    };
                    _local_34.splice(_local_34.indexOf(_local_32), 1, _local_33);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList, this.paymentCraftList, true);
                    return (true);
                case (msg is ExchangeClearPaymentForCraftMessage):
                    _local_35 = (msg as ExchangeClearPaymentForCraftMessage);
                    if (this.commonExchangeFrame)
                    {
                        this.commonExchangeFrame.incrementEchangeSequence();
                    };
                    switch (_local_35.paymentType)
                    {
                        case PaymentTypeEnum.PAYMENT_IN_ANY_CASE:
                            this.paymentCraftList.kamaPayment = 0;
                            for each (op in this.paymentCraftList.objectsPayment)
                            {
                                InventoryManager.getInstance().inventory.removeItemMask(op.objectUID, "paymentAlways");
                            };
                            this.paymentCraftList.objectsPayment = new Array();
                            break;
                        case PaymentTypeEnum.PAYMENT_ON_SUCCESS_ONLY:
                            this.paymentCraftList.kamaPaymentOnlySuccess = 0;
                            for each (ops in this.paymentCraftList.objectsPaymentOnlySuccess)
                            {
                                InventoryManager.getInstance().inventory.removeItemMask(ops.objectUID, "paymentSuccess");
                            };
                            this.paymentCraftList.objectsPaymentOnlySuccess = new Array();
                            break;
                    };
                    return (true);
                case (msg is ExchangeObjectModifiedInBagMessage):
                    _local_36 = (msg as ExchangeObjectModifiedInBagMessage);
                    for each (iwrapper in this.bagList)
                    {
                        if (iwrapper.objectUID == _local_36.object.objectUID)
                        {
                            newItemWr = ItemWrapper.create(63, _local_36.object.objectUID, _local_36.object.objectGID, _local_36.object.quantity, _local_36.object.effects, false);
                            this.bagList.splice(this.bagList.indexOf(iwrapper), 1, newItemWr);
                            break;
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(CraftHookList.BagListUpdate, this.bagList, _local_36.remote);
                    return (true);
                case (msg is ExchangeObjectPutInBagMessage):
                    _local_37 = (msg as ExchangeObjectPutInBagMessage);
                    _local_38 = _local_37.object;
                    _local_39 = ItemWrapper.create(63, _local_38.objectUID, _local_38.objectGID, _local_38.quantity, _local_38.effects, false);
                    this.bagList.push(_local_39);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.BagListUpdate, this.bagList, _local_37.remote);
                    return (true);
                case (msg is ExchangeObjectRemovedFromBagMessage):
                    _local_40 = (msg as ExchangeObjectRemovedFromBagMessage);
                    _local_41 = 0;
                    for each (iw in this.bagList)
                    {
                        if (iw.objectUID == _local_40.objectUID)
                        {
                            this.bagList.splice(_local_41, 1);
                            break;
                        };
                        _local_41++;
                    };
                    KernelEventsManager.getInstance().processCallback(CraftHookList.BagListUpdate, this.bagList, _local_40.remote);
                    return (true);
                case (msg is ExchangeObjectUseInWorkshopAction):
                    _local_42 = (msg as ExchangeObjectUseInWorkshopAction);
                    _local_43 = new ExchangeObjectUseInWorkshopMessage();
                    _local_43.initExchangeObjectUseInWorkshopMessage(_local_42.objectUID, _local_42.quantity);
                    ConnectionsHandler.getConnection().send(_local_43);
                    return (true);
                case (msg is ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction):
                    _local_44 = (msg as ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction);
                    _local_45 = new ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage();
                    _local_45.initExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(_local_44.allow);
                    ConnectionsHandler.getConnection().send(_local_45);
                    return (true);
                case (msg is ExchangeMultiCraftCrafterCanUseHisRessourcesMessage):
                    _local_46 = (msg as ExchangeMultiCraftCrafterCanUseHisRessourcesMessage);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeMultiCraftCrafterCanUseHisRessources, _local_46.allowed);
                    return (true);
                case (msg is ExchangeStartOkMulticraftCrafterMessage):
                    _local_47 = (msg as ExchangeStartOkMulticraftCrafterMessage);
                    _local_48 = Recipe.getAllRecipesForSkillId(_local_47.skillId, _local_47.maxCase);
                    this._skillId = _local_47.skillId;
                    _local_49 = Skill.getSkillById(this._skillId);
                    if (_local_49.isForgemagus)
                    {
                        this._craftType = 1;
                    }
                    else
                    {
                        if (_local_49.isRepair)
                        {
                            this._craftType = 2;
                        }
                        else
                        {
                            this._craftType = 0;
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkMultiCraft, _local_47.skillId, _local_48, _local_47.maxCase, this.crafterInfos, this.customerInfos);
                    return (true);
                case (msg is ExchangeStartOkMulticraftCustomerMessage):
                    _local_50 = (msg as ExchangeStartOkMulticraftCustomerMessage);
                    _local_51 = Recipe.getAllRecipesForSkillId(_local_50.skillId, _local_50.maxCase);
                    this.crafterInfos.skillLevel = _local_50.crafterJobLevel;
                    this._skillId = _local_50.skillId;
                    _local_52 = Skill.getSkillById(this._skillId);
                    if (_local_52.isForgemagus)
                    {
                        this._craftType = 1;
                    }
                    else
                    {
                        if (_local_52.isRepair)
                        {
                            this._craftType = 2;
                        }
                        else
                        {
                            this._craftType = 0;
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkMultiCraft, _local_50.skillId, _local_51, _local_50.maxCase, this.crafterInfos, this.customerInfos);
                    return (true);
                case (msg is ExchangeReplayAction):
                    _local_53 = (msg as ExchangeReplayAction);
                    _local_54 = new ExchangeReplayMessage();
                    _local_54.initExchangeReplayMessage(_local_53.count);
                    ConnectionsHandler.getConnection().send(_local_54);
                    return (true);
                case (msg is ExchangeReplayCountModifiedMessage):
                    _local_55 = (msg as ExchangeReplayCountModifiedMessage);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeReplayCountModified, _local_55.count);
                    return (true);
                case (msg is ExchangeItemAutoCraftRemainingMessage):
                    _local_56 = (msg as ExchangeItemAutoCraftRemainingMessage);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeItemAutoCraftRemaining, _local_56.count);
                    return (true);
                case (msg is ExchangeCraftSlotCountIncreasedMessage):
                    _local_57 = (msg as ExchangeCraftSlotCountIncreasedMessage);
                    _local_48 = Recipe.getAllRecipesForSkillId(this._skillId, _local_57.newMaxSlot);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeCraftSlotCountIncreased, _local_57.newMaxSlot, _local_48);
                    return (true);
                case (msg is ExchangeLeaveMessage):
                    _local_58 = (msg as ExchangeLeaveMessage);
                    if (_local_58.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
                    {
                        PlayedCharacterManager.getInstance().isInExchange = false;
                        this._success = _local_58.success;
                        Kernel.getWorker().removeFrame(this);
                    };
                    return (true);
            };
            return (false);
        }

        private function resetLists():void
        {
            this.paymentCraftList.kamaPayment = 0;
            this.paymentCraftList.kamaPaymentOnlySuccess = 0;
            this.paymentCraftList.objectsPayment = new Array();
            this.paymentCraftList.objectsPaymentOnlySuccess = new Array();
        }

        public function addCraftComponent(pRemote:Boolean, pItemWrapper:ItemWrapper):void
        {
            var playerExchangeCraftList:PlayerExchangeCraftList;
            if (pRemote)
            {
                playerExchangeCraftList = this.otherPlayerList;
            }
            else
            {
                playerExchangeCraftList = this.playerList;
            };
            playerExchangeCraftList.componentList.push(pItemWrapper);
            this.sendUpdateHook(playerExchangeCraftList);
            if (((((((!((this._craftType == 0))) && (!((pItemWrapper.typeId == SMITHMAGIC_RUNE_ID))))) && (!((pItemWrapper.typeId == SMITHMAGIC_POTION_ID))))) && (!((pItemWrapper.objectGID == SIGNATURE_RUNE_ID)))))
            {
                this._smithMagicOldObject = pItemWrapper.clone();
            };
        }

        public function modifyCraftComponent(pRemote:Boolean, pItemWrapper:ItemWrapper):void
        {
            var playerExchangeCraftList:PlayerExchangeCraftList;
            if (pRemote)
            {
                playerExchangeCraftList = this.otherPlayerList;
            }
            else
            {
                playerExchangeCraftList = this.playerList;
            };
            var index:int;
            while (index < playerExchangeCraftList.componentList.length)
            {
                if ((((playerExchangeCraftList.componentList[index].objectGID == pItemWrapper.objectGID)) && ((playerExchangeCraftList.componentList[index].objectUID == pItemWrapper.objectUID))))
                {
                    playerExchangeCraftList.componentList.splice(index, 1, pItemWrapper);
                };
                index++;
            };
            this.sendUpdateHook(playerExchangeCraftList);
        }

        public function removeCraftComponent(pRemote:Boolean, pUID:uint):void
        {
            var itemo:ItemWrapper;
            var itemp:ItemWrapper;
            var compt:uint;
            var playerExchangeCraftList:PlayerExchangeCraftList = new PlayerExchangeCraftList();
            for each (itemo in this.otherPlayerList.componentList)
            {
                if (itemo.objectUID == pUID)
                {
                    this.otherPlayerList.componentList.splice(compt, 1);
                    this.sendUpdateHook(this.otherPlayerList);
                    break;
                };
                compt++;
            };
            compt = 0;
            for each (itemp in this.playerList.componentList)
            {
                if (itemp.objectUID == pUID)
                {
                    this.playerList.componentList.splice(compt, 1);
                    this.sendUpdateHook(this.playerList);
                    break;
                };
                compt++;
            };
        }

        public function addObjetPayment(pOnlySuccess:Boolean, pItemWrapper:ItemWrapper):void
        {
            if (pOnlySuccess)
            {
                this.paymentCraftList.objectsPaymentOnlySuccess.push(pItemWrapper);
            }
            else
            {
                this.paymentCraftList.objectsPayment.push(pItemWrapper);
            };
        }

        public function removeObjetPayment(pUID:uint, pOnlySuccess:Boolean):void
        {
            var objects:Array;
            var itemW:ItemWrapper;
            var compt:uint;
            if (pOnlySuccess)
            {
                objects = this.paymentCraftList.objectsPaymentOnlySuccess;
            }
            else
            {
                objects = this.paymentCraftList.objectsPayment;
            };
            for each (itemW in objects)
            {
                if (itemW.objectUID == pUID)
                {
                    objects.splice(compt, 1);
                };
                compt++;
            };
            KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList, this.paymentCraftList, true);
        }

        private function sendUpdateHook(pPlayerExchangeCraftList:PlayerExchangeCraftList):void
        {
            switch (pPlayerExchangeCraftList)
            {
                case this.otherPlayerList:
                    KernelEventsManager.getInstance().processCallback(CraftHookList.OtherPlayerListUpdate, pPlayerExchangeCraftList);
                    return;
                case this.playerList:
                    KernelEventsManager.getInstance().processCallback(CraftHookList.PlayerListUpdate, pPlayerExchangeCraftList);
                    return;
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

import com.ankamagames.tiphon.types.look.TiphonEntityLook;

class PaymentCraftList 
{

    public var kamaPaymentOnlySuccess:uint;
    public var objectsPaymentOnlySuccess:Array;
    public var kamaPayment:uint;
    public var objectsPayment:Array;

    public function PaymentCraftList():void
    {
        this.kamaPaymentOnlySuccess = 0;
        this.objectsPaymentOnlySuccess = new Array();
        this.kamaPayment = 0;
        this.objectsPayment = new Array();
    }

}
class PlayerExchangeCraftList 
{

    public var componentList:Array;
    public var isCrafter:Boolean;

    public function PlayerExchangeCraftList():void
    {
        this.componentList = new Array();
        this.isCrafter = false;
    }

}
class PlayerInfo 
{

    public var id:uint;
    public var name:String;
    public var look:TiphonEntityLook;
    public var skillLevel:int;


}

