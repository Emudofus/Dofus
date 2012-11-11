package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.datacenter.effects.instances.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.actions.craft.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.dofus.network.messages.game.inventory.items.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.dofus.network.types.game.data.items.effects.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class CraftFrame extends Object implements Frame
    {
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
        static const _log:Logger = Log.getLogger(getQualifiedClassName(CraftFrame));
        private static const SMITHMAGIC_RUNE_ID:int = 78;
        private static const SMITHMAGIC_POTION_ID:int = 26;
        private static const SIGNATURE_RUNE_ID:int = 7508;

        public function CraftFrame()
        {
            this.playerList = new PlayerExchangeCraftList();
            this.otherPlayerList = new PlayerExchangeCraftList();
            this.paymentCraftList = new PaymentCraftList();
            this._crafterInfos = new PlayerInfo();
            this._customerInfos = new PlayerInfo();
            this.bagList = new Array();
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get crafterInfos() : PlayerInfo
        {
            return this._crafterInfos;
        }// end function

        public function get customerInfos() : PlayerInfo
        {
            return this._customerInfos;
        }// end function

        public function get skillId() : int
        {
            return this._skillId;
        }// end function

        private function get roleplayContextFrame() : RoleplayContextFrame
        {
            return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
        }// end function

        private function get commonExchangeFrame() : CommonExchangeManagementFrame
        {
            return Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
        }// end function

        public function processExchangeOkMultiCraftMessage(param1:ExchangeOkMultiCraftMessage) : void
        {
            PlayedCharacterManager.getInstance().isInExchange = true;
            var _loc_2:* = param1 as ExchangeOkMultiCraftMessage;
            if (_loc_2.role == ExchangeTypeEnum.MULTICRAFT_CRAFTER)
            {
                this.playerList.isCrafter = true;
                this.otherPlayerList.isCrafter = false;
                this._crafterInfos.id = PlayedCharacterManager.getInstance().infos.id;
                if (this.crafterInfos.id == _loc_2.initiatorId)
                {
                    this._customerInfos.id = _loc_2.otherId;
                }
                else
                {
                    this._customerInfos.id = _loc_2.initiatorId;
                }
            }
            else
            {
                this.playerList.isCrafter = false;
                this.otherPlayerList.isCrafter = true;
                this._customerInfos.id = PlayedCharacterManager.getInstance().infos.id;
                if (this.customerInfos.id == _loc_2.initiatorId)
                {
                    this._crafterInfos.id = _loc_2.otherId;
                }
                else
                {
                    this._crafterInfos.id = _loc_2.initiatorId;
                }
            }
            this._crafterInfos.look = EntityLookAdapter.getRiderLook(this.roleplayContextFrame.entitiesFrame.getEntityInfos(this.crafterInfos.id).look);
            this._crafterInfos.name = (this.roleplayContextFrame.entitiesFrame.getEntityInfos(this.crafterInfos.id) as GameRolePlayNamedActorInformations).name;
            this._customerInfos.look = EntityLookAdapter.getRiderLook(this.roleplayContextFrame.entitiesFrame.getEntityInfos(this.customerInfos.id).look);
            this._customerInfos.name = (this.roleplayContextFrame.entitiesFrame.getEntityInfos(this.customerInfos.id) as GameRolePlayNamedActorInformations).name;
            var _loc_3:* = "";
            var _loc_4:* = _loc_2.initiatorId;
            if (_loc_2.initiatorId == PlayedCharacterManager.getInstance().infos.id)
            {
                if (_loc_2.initiatorId == this.crafterInfos.id)
                {
                    this._isCrafter = true;
                    _loc_3 = this.customerInfos.name;
                }
                else
                {
                    this._isCrafter = false;
                    _loc_3 = this.crafterInfos.name;
                }
            }
            else if (_loc_2.otherId == this.crafterInfos.id)
            {
                this._isCrafter = false;
                _loc_3 = this.crafterInfos.name;
            }
            else
            {
                this._isCrafter = true;
                _loc_3 = this.customerInfos.name;
            }
            KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeMultiCraftRequest, _loc_2.role, _loc_3, _loc_4);
            return;
        }// end function

        public function processExchangeStartOkCraftWithInformationMessage(param1:ExchangeStartOkCraftWithInformationMessage) : void
        {
            PlayedCharacterManager.getInstance().isInExchange = true;
            var _loc_2:* = param1 as ExchangeStartOkCraftWithInformationMessage;
            this._skillId = _loc_2.skillId;
            var _loc_3:* = Recipe.getAllRecipesForSkillId(_loc_2.skillId, _loc_2.nbCase);
            this._isCrafter = true;
            var _loc_4:* = Skill.getSkillById(this._skillId);
            if (Skill.getSkillById(this._skillId).isForgemagus)
            {
                this._craftType = 1;
            }
            else if (_loc_4.isRepair)
            {
                this._craftType = 2;
            }
            else
            {
                this._craftType = 0;
            }
            KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkCraft, _loc_3, _loc_2.skillId, _loc_2.nbCase);
            return;
        }// end function

        public function pushed() : Boolean
        {
            this._success = false;
            return true;
        }// end function

        public function pulled() : Boolean
        {
            if (Kernel.getWorker().contains(CommonExchangeManagementFrame))
            {
                Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
            }
            KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave, this._success);
            this.playerList = new PlayerExchangeCraftList();
            this.otherPlayerList = new PlayerExchangeCraftList();
            this.bagList = new Array();
            this._crafterInfos = new PlayerInfo();
            this._customerInfos = new PlayerInfo();
            this.paymentCraftList = new PaymentCraftList();
            this._smithMagicOldObject = null;
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = false;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = false;
            var _loc_23:* = null;
            var _loc_24:* = 0;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = null;
            var _loc_30:* = null;
            var _loc_31:* = null;
            var _loc_32:* = null;
            var _loc_33:* = null;
            var _loc_34:* = null;
            var _loc_35:* = null;
            var _loc_36:* = null;
            var _loc_37:* = null;
            var _loc_38:* = null;
            var _loc_39:* = 0;
            var _loc_40:* = null;
            var _loc_41:* = null;
            var _loc_42:* = null;
            var _loc_43:* = null;
            var _loc_44:* = null;
            var _loc_45:* = null;
            var _loc_46:* = null;
            var _loc_47:* = null;
            var _loc_48:* = null;
            var _loc_49:* = null;
            var _loc_50:* = null;
            var _loc_51:* = null;
            var _loc_52:* = null;
            var _loc_53:* = null;
            var _loc_54:* = null;
            var _loc_55:* = null;
            var _loc_56:* = null;
            var _loc_57:* = null;
            var _loc_58:* = null;
            var _loc_59:* = null;
            var _loc_60:* = false;
            var _loc_61:* = null;
            var _loc_62:* = null;
            var _loc_63:* = null;
            var _loc_64:* = null;
            var _loc_65:* = null;
            var _loc_66:* = null;
            var _loc_67:* = null;
            var _loc_68:* = false;
            var _loc_69:* = null;
            var _loc_70:* = 0;
            var _loc_71:* = 0;
            var _loc_72:* = 0;
            var _loc_73:* = null;
            var _loc_74:* = null;
            var _loc_75:* = null;
            var _loc_76:* = false;
            var _loc_77:* = null;
            var _loc_78:* = null;
            var _loc_79:* = null;
            var _loc_80:* = null;
            var _loc_81:* = null;
            var _loc_82:* = null;
            switch(true)
            {
                case param1 is ExchangePlayerMultiCraftRequestAction:
                {
                    _loc_2 = param1 as ExchangePlayerMultiCraftRequestAction;
                    _loc_3 = new ExchangePlayerMultiCraftRequestMessage();
                    _loc_3.initExchangePlayerMultiCraftRequestMessage(_loc_2.exchangeType, _loc_2.target, _loc_2.skillId);
                    ConnectionsHandler.getConnection().send(_loc_3);
                    return true;
                }
                case param1 is ExchangeOkMultiCraftMessage:
                {
                    this.processExchangeOkMultiCraftMessage(param1 as ExchangeOkMultiCraftMessage);
                    return true;
                }
                case param1 is ExchangeItemGoldAddAsPaymentAction:
                {
                    _loc_4 = param1 as ExchangeItemGoldAddAsPaymentAction;
                    if (_loc_4.onlySuccess)
                    {
                        _loc_5 = PaymentTypeEnum.PAYMENT_ON_SUCCESS_ONLY;
                    }
                    else
                    {
                        _loc_5 = PaymentTypeEnum.PAYMENT_IN_ANY_CASE;
                    }
                    _loc_6 = new ExchangeItemGoldAddAsPaymentMessage();
                    _loc_6.initExchangeItemGoldAddAsPaymentMessage(_loc_5, _loc_4.kamas);
                    ConnectionsHandler.getConnection().send(_loc_6);
                    return true;
                }
                case param1 is ExchangeItemObjectAddAsPaymentAction:
                {
                    _loc_7 = param1 as ExchangeItemObjectAddAsPaymentAction;
                    if (_loc_7.onlySuccess)
                    {
                        _loc_8 = PaymentTypeEnum.PAYMENT_ON_SUCCESS_ONLY;
                        _loc_9 = this.paymentCraftList.objectsPaymentOnlySuccess;
                    }
                    else
                    {
                        _loc_8 = PaymentTypeEnum.PAYMENT_IN_ANY_CASE;
                        _loc_9 = this.paymentCraftList.objectsPaymentOnlySuccess;
                    }
                    _loc_11 = new ExchangeItemObjectAddAsPaymentMessage();
                    _loc_11.initExchangeItemObjectAddAsPaymentMessage(_loc_8, _loc_7.isAdd, _loc_7.objectUID, _loc_7.quantity);
                    ConnectionsHandler.getConnection().send(_loc_11);
                    return true;
                }
                case param1 is ExchangeReplayStopAction:
                {
                    _loc_12 = param1 as ExchangeReplayStopAction;
                    _loc_13 = new ExchangeReplayStopMessage();
                    _loc_13.initExchangeReplayStopMessage();
                    ConnectionsHandler.getConnection().send(_loc_13);
                    return true;
                }
                case param1 is ExchangeCraftResultMessage:
                {
                    _loc_14 = param1 as ExchangeCraftResultMessage;
                    _loc_15 = _loc_14.getMessageId();
                    _loc_18 = null;
                    _loc_19 = false;
                    switch(_loc_15)
                    {
                        case ExchangeCraftResultMessage.protocolId:
                        {
                            _loc_17 = I18n.getUiText("ui.craft.noResult");
                            break;
                        }
                        case ExchangeCraftResultWithObjectIdMessage.protocolId:
                        {
                            _loc_57 = param1 as ExchangeCraftResultWithObjectIdMessage;
                            _loc_18 = ItemWrapper.create(63, 0, _loc_57.objectGenericId, 1, null, false);
                            _loc_16 = Item.getItemById(_loc_57.objectGenericId).name;
                            _loc_17 = I18n.getUiText("ui.craft.failed");
                            _loc_19 = _loc_57.craftResult == 2;
                            break;
                        }
                        case ExchangeCraftResultMagicWithObjectDescMessage.protocolId:
                        {
                            _loc_58 = param1 as ExchangeCraftResultMagicWithObjectDescMessage;
                            _loc_59 = "";
                            _loc_60 = false;
                            _loc_61 = _loc_58.objectInfo.effects;
                            _loc_63 = new Array();
                            if (this._smithMagicOldObject)
                            {
                                for each (_loc_67 in this._smithMagicOldObject.effectsList)
                                {
                                    
                                    _loc_63.push(_loc_67);
                                    if (_loc_67 is ObjectEffectInteger || _loc_67 is ObjectEffectDice)
                                    {
                                        _loc_68 = false;
                                        for each (_loc_69 in _loc_61)
                                        {
                                            
                                            if ((_loc_69 is ObjectEffectInteger || _loc_69 is ObjectEffectDice) && _loc_69.actionId == _loc_67.actionId)
                                            {
                                                _loc_68 = true;
                                                _loc_70 = Effect.getEffectById(_loc_67.actionId).bonusType;
                                                _loc_71 = Effect.getEffectById(_loc_69.actionId).bonusType;
                                                if (_loc_69 is ObjectEffectInteger)
                                                {
                                                    _loc_70 = _loc_70 * ObjectEffectInteger(_loc_67).value;
                                                    _loc_71 = _loc_71 * ObjectEffectInteger(_loc_69).value;
                                                    if (_loc_71 != _loc_70)
                                                    {
                                                        _loc_72 = _loc_71 - _loc_70;
                                                        _loc_73 = new EffectInstanceInteger();
                                                        _loc_73.effectId = _loc_69.actionId;
                                                        if (_loc_72 > 0)
                                                        {
                                                            _loc_60 = true;
                                                        }
                                                        _loc_73.value = ObjectEffectInteger(_loc_69).value - ObjectEffectInteger(_loc_67).value;
                                                        _loc_59 = _loc_59 + (" " + _loc_73.description + ",");
                                                        _loc_59 = _loc_59.replace("+-", "-");
                                                        _loc_59 = _loc_59.replace("--", "+");
                                                        _loc_62 = _loc_73;
                                                    }
                                                    continue;
                                                }
                                                if (_loc_69 is ObjectEffectDice)
                                                {
                                                    _loc_70 = ObjectEffectDice(_loc_67).diceNum;
                                                    _loc_71 = ObjectEffectDice(_loc_69).diceNum;
                                                    if (_loc_71 != _loc_70)
                                                    {
                                                        _loc_72 = _loc_71 - _loc_70;
                                                        if (_loc_67.actionId == ActionIdConverter.ACTION_ITEM_CHANGE_DURABILITY)
                                                        {
                                                            _loc_59 = _loc_59 + (" +" + _loc_72 + ",");
                                                            _loc_72 = _loc_71;
                                                        }
                                                        _loc_74 = new EffectInstanceDice();
                                                        _loc_74.effectId = _loc_69.actionId;
                                                        if (_loc_72 > 0)
                                                        {
                                                            _loc_60 = true;
                                                        }
                                                        _loc_74.diceNum = _loc_72;
                                                        _loc_74.diceSide = _loc_72;
                                                        _loc_74.value = ObjectEffectDice(_loc_69).diceConst;
                                                        _loc_62 = _loc_74;
                                                        _loc_59 = _loc_59 + (" " + _loc_62.description + ",");
                                                        _loc_59 = _loc_59.replace("+-", "-");
                                                        _loc_59 = _loc_59.replace("--", "+");
                                                    }
                                                }
                                            }
                                        }
                                        if (!_loc_68)
                                        {
                                            _loc_73 = new EffectInstanceInteger();
                                            _loc_73.effectId = _loc_67.actionId;
                                            _loc_73.value = -ObjectEffectInteger(_loc_67).value;
                                            _loc_59 = _loc_59 + (" " + _loc_73.description + ",");
                                            _loc_59 = _loc_59.replace("+-", "-");
                                            _loc_59 = _loc_59.replace("--", "+");
                                            _loc_62 = _loc_73;
                                        }
                                    }
                                }
                            }
                            for each (_loc_75 in _loc_61)
                            {
                                
                                _loc_76 = true;
                                for each (_loc_77 in _loc_63)
                                {
                                    
                                    if (_loc_75 is ObjectEffectInteger || _loc_75 is ObjectEffectMinMax)
                                    {
                                        if (_loc_75.actionId == _loc_77.actionId)
                                        {
                                            _loc_76 = false;
                                            _loc_63.splice(_loc_63.indexOf(_loc_77), 1);
                                        }
                                        continue;
                                    }
                                    _loc_76 = false;
                                }
                                if (_loc_76)
                                {
                                    if (_loc_75 is ObjectEffectMinMax)
                                    {
                                        _loc_78 = new EffectInstanceMinMax();
                                        _loc_78.effectId = _loc_75.actionId;
                                        _loc_78.min = ObjectEffectMinMax(_loc_75).min;
                                        _loc_78.max = ObjectEffectMinMax(_loc_75).max;
                                        _loc_62 = _loc_78;
                                        _loc_60 = true;
                                        continue;
                                    }
                                    if (_loc_75 is ObjectEffectInteger)
                                    {
                                        _loc_73 = new EffectInstanceInteger();
                                        _loc_73.effectId = _loc_75.actionId;
                                        _loc_73.value = ObjectEffectInteger(_loc_75).value;
                                        if (_loc_73.value > 0)
                                        {
                                            _loc_60 = true;
                                        }
                                        _loc_59 = _loc_59 + (" " + _loc_73.description + ",");
                                        _loc_62 = _loc_73;
                                    }
                                }
                            }
                            _loc_64 = "";
                            if (_loc_58.magicPoolStatus == 2)
                            {
                                _loc_64 = " +" + I18n.getUiText("ui.craft.smithResidualMagic");
                            }
                            else if (_loc_58.magicPoolStatus == 3)
                            {
                                _loc_64 = " -" + I18n.getUiText("ui.craft.smithResidualMagic");
                            }
                            _loc_65 = "";
                            if (_loc_60)
                            {
                                _loc_65 = _loc_65 + (I18n.getUiText("ui.craft.success") + I18n.getUiText("ui.common.colon"));
                            }
                            else
                            {
                                _loc_65 = _loc_65 + (I18n.getUiText("ui.craft.failure") + I18n.getUiText("ui.common.colon"));
                            }
                            _loc_65 = _loc_65 + _loc_59;
                            if (_loc_64 != "")
                            {
                                _loc_65 = _loc_65 + _loc_64;
                            }
                            else
                            {
                                _loc_65 = _loc_65.substring(0, (_loc_65.length - 1));
                            }
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_65, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                            _loc_18 = ItemWrapper.create(63, _loc_58.objectInfo.objectUID, _loc_58.objectInfo.objectGID, 1, _loc_58.objectInfo.effects, false);
                            this._smithMagicOldObject = _loc_18.clone();
                            _loc_19 = _loc_58.craftResult == 2;
                            break;
                        }
                        case ExchangeCraftResultWithObjectDescMessage.protocolId:
                        {
                            _loc_66 = param1 as ExchangeCraftResultWithObjectDescMessage;
                            _loc_18 = ItemWrapper.create(63, _loc_66.objectInfo.objectUID, _loc_66.objectInfo.objectGID, 1, _loc_66.objectInfo.effects, false);
                            if (_loc_66.objectInfo.objectGID == 0)
                            {
                                break;
                            }
                            _loc_16 = HyperlinkItemManager.newChatItem(_loc_18);
                            switch(true)
                            {
                                case this._crafterInfos.id == PlayedCharacterManager.getInstance().id:
                                {
                                    _loc_17 = I18n.getUiText("ui.craft.successTarget", [_loc_16, this._customerInfos.name]);
                                    break;
                                }
                                case this._customerInfos.id == PlayedCharacterManager.getInstance().id:
                                {
                                    _loc_17 = I18n.getUiText("ui.craft.successOther", [this._crafterInfos.name, _loc_16]);
                                    break;
                                }
                                default:
                                {
                                    _loc_17 = I18n.getUiText("ui.craft.craftSuccessSelf", [_loc_16]);
                                    break;
                                    break;
                                }
                            }
                            _loc_19 = _loc_66.craftResult == 2;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (_loc_19)
                    {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CRAFT_OK);
                    }
                    else
                    {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CRAFT_KO);
                    }
                    if (_loc_17 && _loc_17 != "")
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_17, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    }
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeCraftResult, _loc_14.craftResult, _loc_18);
                    return true;
                }
                case param1 is ExchangeItemAutoCraftStopedMessage:
                {
                    _loc_20 = param1 as ExchangeItemAutoCraftStopedMessage;
                    _loc_21 = "";
                    _loc_22 = true;
                    switch(_loc_20.reason)
                    {
                        case ExchangeReplayStopReasonEnum.STOPPED_REASON_IMPOSSIBLE_CRAFT:
                        {
                            _loc_21 = I18n.getUiText("ui.craft.autoCraftStopedInvalidRecipe");
                            break;
                        }
                        case ExchangeReplayStopReasonEnum.STOPPED_REASON_MISSING_RESSOURCE:
                        {
                            _loc_21 = I18n.getUiText("ui.craft.autoCraftStopedNoRessource");
                            break;
                        }
                        case ExchangeReplayStopReasonEnum.STOPPED_REASON_OK:
                        {
                            _loc_21 = I18n.getUiText("ui.craft.autoCraftStopedOk");
                            break;
                        }
                        case ExchangeReplayStopReasonEnum.STOPPED_REASON_USER:
                        {
                            _loc_21 = I18n.getUiText("ui.craft.autoCraftStoped");
                            _loc_22 = false;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (_loc_22)
                    {
                        _loc_79 = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                        _loc_79.openPopup(I18n.getUiText("ui.popup.information"), _loc_21, [I18n.getUiText("ui.common.ok")]);
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_21, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeItemAutoCraftStoped, _loc_20.reason);
                    return true;
                }
                case param1 is ExchangeStartOkCraftMessage:
                {
                    _loc_23 = param1 as ExchangeStartOkCraftMessage;
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    _loc_24 = _loc_23.getMessageId();
                    switch(_loc_24)
                    {
                        case ExchangeStartOkCraftMessage.protocolId:
                        {
                            KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkCraft);
                            break;
                        }
                        case ExchangeStartOkCraftWithInformationMessage.protocolId:
                        {
                            this.processExchangeStartOkCraftWithInformationMessage(param1 as ExchangeStartOkCraftWithInformationMessage);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return true;
                }
                case param1 is ExchangeGoldPaymentForCraftMessage:
                {
                    _loc_25 = param1 as ExchangeGoldPaymentForCraftMessage;
                    if (this.commonExchangeFrame)
                    {
                        this.commonExchangeFrame.incrementEchangeSequence();
                    }
                    if (_loc_25.onlySuccess)
                    {
                        this.paymentCraftList.kamaPaymentOnlySuccess = _loc_25.goldSum;
                    }
                    else
                    {
                        this.paymentCraftList.kamaPayment = _loc_25.goldSum;
                    }
                    KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList, this.paymentCraftList, true);
                    return true;
                }
                case param1 is ExchangeItemPaymentForCraftMessage:
                {
                    _loc_26 = param1 as ExchangeItemPaymentForCraftMessage;
                    if (this.commonExchangeFrame)
                    {
                        this.commonExchangeFrame.incrementEchangeSequence();
                    }
                    _loc_27 = ItemWrapper.create(63, _loc_26.object.objectUID, _loc_26.object.objectGID, _loc_26.object.quantity, _loc_26.object.effects, false);
                    this.addObjetPayment(_loc_26.onlySuccess, _loc_27);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList, this.paymentCraftList, true);
                    return true;
                }
                case param1 is ExchangeRemovedPaymentForCraftMessage:
                {
                    _loc_28 = param1 as ExchangeRemovedPaymentForCraftMessage;
                    if (this.commonExchangeFrame)
                    {
                        this.commonExchangeFrame.incrementEchangeSequence();
                    }
                    this.removeObjetPayment(_loc_28.objectUID, _loc_28.onlySuccess);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList, this.paymentCraftList, true);
                    return true;
                }
                case param1 is ExchangeModifiedPaymentForCraftMessage:
                {
                    _loc_29 = param1 as ExchangeModifiedPaymentForCraftMessage;
                    if (this.commonExchangeFrame)
                    {
                        this.commonExchangeFrame.incrementEchangeSequence();
                    }
                    _loc_30 = ItemWrapper.getItemFromUId(_loc_29.object.objectUID);
                    _loc_31 = ItemWrapper.create(63, _loc_29.object.objectUID, _loc_29.object.objectGID, _loc_29.object.quantity, _loc_29.object.effects, false);
                    if (_loc_29.onlySuccess)
                    {
                        _loc_32 = this.paymentCraftList.objectsPaymentOnlySuccess;
                    }
                    else
                    {
                        _loc_32 = this.paymentCraftList.objectsPayment;
                    }
                    _loc_32.splice(_loc_32.indexOf(_loc_30), 1, _loc_31);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList, this.paymentCraftList, true);
                    return true;
                }
                case param1 is ExchangeClearPaymentForCraftMessage:
                {
                    _loc_33 = param1 as ExchangeClearPaymentForCraftMessage;
                    if (this.commonExchangeFrame)
                    {
                        this.commonExchangeFrame.incrementEchangeSequence();
                    }
                    switch(_loc_33.paymentType)
                    {
                        case PaymentTypeEnum.PAYMENT_IN_ANY_CASE:
                        {
                            this.paymentCraftList.kamaPayment = 0;
                            this.paymentCraftList.objectsPayment = new Array();
                            break;
                        }
                        case PaymentTypeEnum.PAYMENT_ON_SUCCESS_ONLY:
                        {
                            this.paymentCraftList.kamaPaymentOnlySuccess = 0;
                            this.paymentCraftList.objectsPaymentOnlySuccess = new Array();
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return true;
                }
                case param1 is ExchangeObjectModifiedInBagMessage:
                {
                    _loc_34 = param1 as ExchangeObjectModifiedInBagMessage;
                    for each (_loc_80 in this.bagList)
                    {
                        
                        if (_loc_80.objectUID == _loc_34.object.objectUID)
                        {
                            _loc_81 = ItemWrapper.create(63, _loc_34.object.objectUID, _loc_34.object.objectGID, _loc_34.object.quantity, _loc_34.object.effects, false);
                            this.bagList.splice(this.bagList.indexOf(_loc_80), 1, _loc_81);
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(CraftHookList.BagListUpdate, this.bagList, _loc_34.remote);
                    return true;
                }
                case param1 is ExchangeObjectPutInBagMessage:
                {
                    _loc_35 = param1 as ExchangeObjectPutInBagMessage;
                    _loc_36 = _loc_35.object;
                    _loc_37 = ItemWrapper.create(63, _loc_36.objectUID, _loc_36.objectGID, _loc_36.quantity, _loc_36.effects, false);
                    this.bagList.push(_loc_37);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.BagListUpdate, this.bagList, _loc_35.remote);
                    return true;
                }
                case param1 is ExchangeObjectRemovedFromBagMessage:
                {
                    _loc_38 = param1 as ExchangeObjectRemovedFromBagMessage;
                    _loc_39 = 0;
                    for each (_loc_82 in this.bagList)
                    {
                        
                        if (_loc_82.objectUID == _loc_38.objectUID)
                        {
                            this.bagList.splice(_loc_39, 1);
                            break;
                        }
                        _loc_39 = _loc_39 + 1;
                    }
                    KernelEventsManager.getInstance().processCallback(CraftHookList.BagListUpdate, this.bagList, _loc_38.remote);
                    return true;
                }
                case param1 is ExchangeObjectUseInWorkshopAction:
                {
                    _loc_40 = param1 as ExchangeObjectUseInWorkshopAction;
                    _loc_41 = new ExchangeObjectUseInWorkshopMessage();
                    _loc_41.initExchangeObjectUseInWorkshopMessage(_loc_40.objectUID, _loc_40.quantity);
                    ConnectionsHandler.getConnection().send(_loc_41);
                    return true;
                }
                case param1 is ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction:
                {
                    _loc_42 = param1 as ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction;
                    _loc_43 = new ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage();
                    _loc_43.initExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(_loc_42.allow);
                    ConnectionsHandler.getConnection().send(_loc_43);
                    return true;
                }
                case param1 is ExchangeMultiCraftCrafterCanUseHisRessourcesMessage:
                {
                    _loc_44 = param1 as ExchangeMultiCraftCrafterCanUseHisRessourcesMessage;
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeMultiCraftCrafterCanUseHisRessources, _loc_44.allowed);
                    return true;
                }
                case param1 is ExchangeStartOkMulticraftCrafterMessage:
                {
                    _loc_45 = param1 as ExchangeStartOkMulticraftCrafterMessage;
                    _loc_46 = Recipe.getAllRecipesForSkillId(_loc_45.skillId, _loc_45.maxCase);
                    this._skillId = _loc_45.skillId;
                    _loc_47 = Skill.getSkillById(this._skillId);
                    if (_loc_47.isForgemagus)
                    {
                        this._craftType = 1;
                    }
                    else if (_loc_47.isRepair)
                    {
                        this._craftType = 2;
                    }
                    else
                    {
                        this._craftType = 0;
                    }
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkMultiCraft, _loc_45.skillId, _loc_46, _loc_45.maxCase, this.crafterInfos, this.customerInfos);
                    return true;
                }
                case param1 is ExchangeStartOkMulticraftCustomerMessage:
                {
                    _loc_48 = param1 as ExchangeStartOkMulticraftCustomerMessage;
                    _loc_49 = Recipe.getAllRecipesForSkillId(_loc_48.skillId, _loc_48.maxCase);
                    this.crafterInfos.skillLevel = _loc_48.crafterJobLevel;
                    this._skillId = _loc_48.skillId;
                    _loc_50 = Skill.getSkillById(this._skillId);
                    if (_loc_50.isForgemagus)
                    {
                        this._craftType = 1;
                    }
                    else if (_loc_50.isRepair)
                    {
                        this._craftType = 2;
                    }
                    else
                    {
                        this._craftType = 0;
                    }
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkMultiCraft, _loc_48.skillId, _loc_49, _loc_48.maxCase, this.crafterInfos, this.customerInfos);
                    return true;
                }
                case param1 is ExchangeReplayAction:
                {
                    _loc_51 = param1 as ExchangeReplayAction;
                    _loc_52 = new ExchangeReplayMessage();
                    _loc_52.initExchangeReplayMessage(_loc_51.count);
                    ConnectionsHandler.getConnection().send(_loc_52);
                    return true;
                }
                case param1 is ExchangeReplayCountModifiedMessage:
                {
                    _loc_53 = param1 as ExchangeReplayCountModifiedMessage;
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeReplayCountModified, _loc_53.count);
                    return true;
                }
                case param1 is ExchangeItemAutoCraftRemainingMessage:
                {
                    _loc_54 = param1 as ExchangeItemAutoCraftRemainingMessage;
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeItemAutoCraftRemaining, _loc_54.count);
                    return true;
                }
                case param1 is ExchangeCraftSlotCountIncreasedMessage:
                {
                    _loc_55 = param1 as ExchangeCraftSlotCountIncreasedMessage;
                    _loc_46 = Recipe.getAllRecipesForSkillId(this._skillId, _loc_55.newMaxSlot);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeCraftSlotCountIncreased, _loc_55.newMaxSlot, _loc_46);
                    return true;
                }
                case param1 is ExchangeLeaveMessage:
                {
                    _loc_56 = param1 as ExchangeLeaveMessage;
                    if (_loc_56.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
                    {
                        PlayedCharacterManager.getInstance().isInExchange = false;
                        this._success = _loc_56.success;
                        Kernel.getWorker().removeFrame(this);
                    }
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private function resetLists() : void
        {
            this.paymentCraftList.kamaPayment = 0;
            this.paymentCraftList.kamaPaymentOnlySuccess = 0;
            this.paymentCraftList.objectsPayment = new Array();
            this.paymentCraftList.objectsPaymentOnlySuccess = new Array();
            return;
        }// end function

        public function addCraftComponent(param1:Boolean, param2:ItemWrapper) : void
        {
            var _loc_3:* = null;
            if (param1)
            {
                _loc_3 = this.otherPlayerList;
            }
            else
            {
                _loc_3 = this.playerList;
            }
            _loc_3.componentList.push(param2);
            this.sendUpdateHook(_loc_3);
            if (this._craftType != 0 && param2.typeId != SMITHMAGIC_RUNE_ID && param2.typeId != SMITHMAGIC_POTION_ID && param2.objectGID != SIGNATURE_RUNE_ID)
            {
                this._smithMagicOldObject = param2.clone();
            }
            return;
        }// end function

        public function modifyCraftComponent(param1:Boolean, param2:ItemWrapper) : void
        {
            var _loc_3:* = null;
            if (param1)
            {
                _loc_3 = this.otherPlayerList;
            }
            else
            {
                _loc_3 = this.playerList;
            }
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.componentList.length)
            {
                
                if (_loc_3.componentList[_loc_4].objectGID == param2.objectGID && _loc_3.componentList[_loc_4].objectUID == param2.objectUID)
                {
                    _loc_3.componentList.splice(_loc_4, 1, param2);
                }
                _loc_4++;
            }
            this.sendUpdateHook(_loc_3);
            return;
        }// end function

        public function removeCraftComponent(param1:Boolean, param2:uint) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = new PlayerExchangeCraftList();
            for each (_loc_5 in this.otherPlayerList.componentList)
            {
                
                if (_loc_5.objectUID == param2)
                {
                    this.otherPlayerList.componentList.splice(_loc_3, 1);
                    this.sendUpdateHook(this.otherPlayerList);
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            _loc_3 = 0;
            for each (_loc_6 in this.playerList.componentList)
            {
                
                if (_loc_6.objectUID == param2)
                {
                    this.playerList.componentList.splice(_loc_3, 1);
                    this.sendUpdateHook(this.playerList);
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function addObjetPayment(param1:Boolean, param2:ItemWrapper) : void
        {
            if (param1)
            {
                this.paymentCraftList.objectsPaymentOnlySuccess.push(param2);
            }
            else
            {
                this.paymentCraftList.objectsPayment.push(param2);
            }
            return;
        }// end function

        public function removeObjetPayment(param1:uint, param2:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = 0;
            if (param2)
            {
                _loc_4 = this.paymentCraftList.objectsPaymentOnlySuccess;
            }
            else
            {
                _loc_4 = this.paymentCraftList.objectsPayment;
            }
            for each (_loc_5 in _loc_4)
            {
                
                if (_loc_5.objectUID == param1)
                {
                    _loc_4.splice(_loc_3, 1);
                }
                _loc_3 = _loc_3 + 1;
            }
            KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList, this.paymentCraftList, true);
            return;
        }// end function

        private function sendUpdateHook(param1:PlayerExchangeCraftList) : void
        {
            switch(param1)
            {
                case this.otherPlayerList:
                {
                    KernelEventsManager.getInstance().processCallback(CraftHookList.OtherPlayerListUpdate, param1);
                    break;
                }
                case this.playerList:
                {
                    KernelEventsManager.getInstance().processCallback(CraftHookList.PlayerListUpdate, param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}

import __AS3__.vec.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.dofus.datacenter.effects.*;

import com.ankamagames.dofus.datacenter.effects.instances.*;

import com.ankamagames.dofus.datacenter.items.*;

import com.ankamagames.dofus.datacenter.jobs.*;

import com.ankamagames.dofus.internalDatacenter.items.*;

import com.ankamagames.dofus.kernel.*;

import com.ankamagames.dofus.kernel.net.*;

import com.ankamagames.dofus.logic.common.managers.*;

import com.ankamagames.dofus.logic.game.common.actions.craft.*;

import com.ankamagames.dofus.logic.game.common.managers.*;

import com.ankamagames.dofus.logic.game.fight.miscs.*;

import com.ankamagames.dofus.logic.game.roleplay.frames.*;

import com.ankamagames.dofus.misc.*;

import com.ankamagames.dofus.misc.lists.*;

import com.ankamagames.dofus.network.enums.*;

import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;

import com.ankamagames.dofus.network.messages.game.inventory.items.*;

import com.ankamagames.dofus.network.types.game.context.roleplay.*;

import com.ankamagames.dofus.network.types.game.data.items.*;

import com.ankamagames.dofus.network.types.game.data.items.effects.*;

import com.ankamagames.jerakine.data.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.messages.*;

import com.ankamagames.jerakine.types.enums.*;

import flash.utils.*;

class PaymentCraftList extends Object
{
    public var kamaPaymentOnlySuccess:uint;
    public var objectsPaymentOnlySuccess:Array;
    public var kamaPayment:uint;
    public var objectsPayment:Array;

    function PaymentCraftList() : void
    {
        this.kamaPaymentOnlySuccess = 0;
        this.objectsPaymentOnlySuccess = new Array();
        this.kamaPayment = 0;
        this.objectsPayment = new Array();
        return;
    }// end function

}


import __AS3__.vec.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.dofus.datacenter.effects.*;

import com.ankamagames.dofus.datacenter.effects.instances.*;

import com.ankamagames.dofus.datacenter.items.*;

import com.ankamagames.dofus.datacenter.jobs.*;

import com.ankamagames.dofus.internalDatacenter.items.*;

import com.ankamagames.dofus.kernel.*;

import com.ankamagames.dofus.kernel.net.*;

import com.ankamagames.dofus.logic.common.managers.*;

import com.ankamagames.dofus.logic.game.common.actions.craft.*;

import com.ankamagames.dofus.logic.game.common.managers.*;

import com.ankamagames.dofus.logic.game.fight.miscs.*;

import com.ankamagames.dofus.logic.game.roleplay.frames.*;

import com.ankamagames.dofus.misc.*;

import com.ankamagames.dofus.misc.lists.*;

import com.ankamagames.dofus.network.enums.*;

import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;

import com.ankamagames.dofus.network.messages.game.inventory.items.*;

import com.ankamagames.dofus.network.types.game.context.roleplay.*;

import com.ankamagames.dofus.network.types.game.data.items.*;

import com.ankamagames.dofus.network.types.game.data.items.effects.*;

import com.ankamagames.jerakine.data.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.messages.*;

import com.ankamagames.jerakine.types.enums.*;

import flash.utils.*;

class PlayerExchangeCraftList extends Object
{
    public var componentList:Array;
    public var isCrafter:Boolean;

    function PlayerExchangeCraftList() : void
    {
        this.componentList = new Array();
        this.isCrafter = false;
        return;
    }// end function

}


import __AS3__.vec.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.dofus.datacenter.effects.*;

import com.ankamagames.dofus.datacenter.effects.instances.*;

import com.ankamagames.dofus.datacenter.items.*;

import com.ankamagames.dofus.datacenter.jobs.*;

import com.ankamagames.dofus.internalDatacenter.items.*;

import com.ankamagames.dofus.kernel.*;

import com.ankamagames.dofus.kernel.net.*;

import com.ankamagames.dofus.logic.common.managers.*;

import com.ankamagames.dofus.logic.game.common.actions.craft.*;

import com.ankamagames.dofus.logic.game.common.managers.*;

import com.ankamagames.dofus.logic.game.fight.miscs.*;

import com.ankamagames.dofus.logic.game.roleplay.frames.*;

import com.ankamagames.dofus.misc.*;

import com.ankamagames.dofus.misc.lists.*;

import com.ankamagames.dofus.network.enums.*;

import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;

import com.ankamagames.dofus.network.messages.game.inventory.items.*;

import com.ankamagames.dofus.network.types.game.context.roleplay.*;

import com.ankamagames.dofus.network.types.game.data.items.*;

import com.ankamagames.dofus.network.types.game.data.items.effects.*;

import com.ankamagames.jerakine.data.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.messages.*;

import com.ankamagames.jerakine.types.enums.*;

import flash.utils.*;

class PlayerInfo extends Object
{
    public var id:uint;
    public var name:String;
    public var look:TiphonEntityLook;
    public var skillLevel:int;

    function PlayerInfo()
    {
        return;
    }// end function

}

