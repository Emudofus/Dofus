package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.internalDatacenter.conquest.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.prism.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.prism.*;
    import com.ankamagames.dofus.network.messages.game.pvp.*;
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.dofus.network.types.game.prism.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class PrismFrame extends Object implements Frame
    {
        private var _subAreaBalanceValue:uint;
        private var _totalBalanceValue:uint;
        private var _nbSubOwned:uint;
        private var _subTotal:uint;
        private var _maxSub:uint;
        private var _subAreasInformation:Vector.<PrismSubAreaInformation>;
        private var _nbConqsOwned:uint;
        private var _conqsTotal:uint;
        private var _conquetesInformation:Vector.<VillageConquestPrismInformation>;
        private var _mapId:int = 0;
        private var _subareaId:int = 0;
        private var _worldX:int = 0;
        private var _worldY:int = 0;
        private var _fightId:uint = 0;
        private var _prismState:int = 0;
        private var _attackers:Array;
        private var _defenders:Array;
        private var _reserves:Array;
        private var _infoJoinLeave:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(PrismFrame));

        public function PrismFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get nbSubOwned() : uint
        {
            return this._nbSubOwned;
        }// end function

        public function get subTotal() : uint
        {
            return this._subTotal;
        }// end function

        public function get maxSub() : uint
        {
            return this._maxSub;
        }// end function

        public function get nbConqsOwned() : uint
        {
            return this._nbConqsOwned;
        }// end function

        public function get conqsTotal() : uint
        {
            return this._conqsTotal;
        }// end function

        public function get totalBalanceValue() : uint
        {
            return this._totalBalanceValue;
        }// end function

        public function get subAreaBalanceValue() : uint
        {
            return this._subAreaBalanceValue;
        }// end function

        public function get attackers() : Array
        {
            return this._attackers;
        }// end function

        public function get defenders() : Array
        {
            return this._defenders;
        }// end function

        public function get reserves() : Array
        {
            return this._reserves;
        }// end function

        public function get mapId() : int
        {
            return this._mapId;
        }// end function

        public function get subareaId() : int
        {
            return this._subareaId;
        }// end function

        public function get worldX() : int
        {
            return this._worldX;
        }// end function

        public function get worldY() : int
        {
            return this._worldY;
        }// end function

        public function _pickup_fighter(param1:Array, param2:uint) : PrismFightersWrapper
        {
            var _loc_5:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = false;
            for each (_loc_5 in param1)
            {
                
                if (_loc_5.playerCharactersInformations.id == param2)
                {
                    _loc_4 = true;
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            return param1.splice(_loc_3, 1)[0];
        }// end function

        public function pushed() : Boolean
        {
            this._infoJoinLeave = false;
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = false;
            var _loc_25:* = false;
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
            var _loc_39:* = null;
            var _loc_40:* = null;
            var _loc_41:* = null;
            var _loc_42:* = null;
            var _loc_43:* = null;
            var _loc_44:* = null;
            var _loc_45:* = null;
            switch(true)
            {
                case param1 is PrismFightJoinLeaveRequestAction:
                {
                    _loc_2 = param1 as PrismFightJoinLeaveRequestAction;
                    _loc_3 = new PrismFightJoinLeaveRequestMessage();
                    _loc_3.initPrismFightJoinLeaveRequestMessage(_loc_2.join);
                    ConnectionsHandler.getConnection().send(_loc_3);
                    return true;
                }
                case param1 is PrismFightSwapRequestAction:
                {
                    _loc_4 = param1 as PrismFightSwapRequestAction;
                    _loc_5 = PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentGrade;
                    _loc_6 = 0;
                    for each (_loc_41 in this._defenders)
                    {
                        
                        if (_loc_41.playerCharactersInformations.id == _loc_4.targetId)
                        {
                            _loc_6 = _loc_41.playerCharactersInformations.grade;
                            break;
                        }
                    }
                    if (_loc_5 <= _loc_6)
                    {
                        return true;
                    }
                    _loc_7 = new PrismFightSwapRequestMessage();
                    _loc_7.initPrismFightSwapRequestMessage(_loc_4.targetId);
                    ConnectionsHandler.getConnection().send(_loc_7);
                    return true;
                }
                case param1 is PrismInfoJoinLeaveRequestAction:
                {
                    _loc_8 = param1 as PrismInfoJoinLeaveRequestAction;
                    _loc_9 = new PrismInfoJoinLeaveRequestMessage();
                    _loc_9.initPrismInfoJoinLeaveRequestMessage(_loc_8.join);
                    this._infoJoinLeave = _loc_8.join;
                    if (_loc_8.join)
                    {
                        this._attackers = new Array();
                        this._reserves = new Array();
                        this._defenders = new Array();
                    }
                    ConnectionsHandler.getConnection().send(_loc_9);
                    return true;
                }
                case param1 is PrismWorldInformationRequestAction:
                {
                    _loc_10 = param1 as PrismWorldInformationRequestAction;
                    _loc_11 = new PrismWorldInformationRequestMessage();
                    _loc_11.initPrismWorldInformationRequestMessage(_loc_10.join);
                    ConnectionsHandler.getConnection().send(_loc_11);
                    return true;
                }
                case param1 is PrismBalanceRequestAction:
                {
                    _loc_12 = param1 as PrismBalanceRequestAction;
                    _loc_13 = new PrismBalanceRequestMessage();
                    _loc_13.initPrismBalanceRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_13);
                    return true;
                }
                case param1 is PrismCurrentBonusRequestAction:
                {
                    _loc_14 = param1 as PrismCurrentBonusRequestAction;
                    _loc_15 = new PrismCurrentBonusRequestMessage();
                    _loc_15.initPrismCurrentBonusRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_15);
                    return true;
                }
                case param1 is PrismAttackRequestAction:
                {
                    _loc_16 = param1 as PrismAttackRequestAction;
                    _loc_17 = new PrismAttackRequestMessage();
                    _loc_17.initPrismAttackRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_17);
                    return true;
                }
                case param1 is PrismUseRequestAction:
                {
                    _loc_18 = param1 as PrismUseRequestAction;
                    _loc_19 = new PrismUseRequestMessage();
                    _loc_19.initPrismUseRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_19);
                    return true;
                }
                case param1 is PrismBalanceResultMessage:
                {
                    _loc_20 = param1 as PrismBalanceResultMessage;
                    this._totalBalanceValue = _loc_20.totalBalanceValue;
                    this._subAreaBalanceValue = _loc_20.subAreaBalanceValue;
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismBalance, _loc_20.subAreaBalanceValue);
                    return true;
                }
                case param1 is PrismAlignmentBonusResultMessage:
                {
                    _loc_21 = param1 as PrismAlignmentBonusResultMessage;
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismAlignmentBonus, _loc_21.alignmentBonus.grademult, _loc_21.alignmentBonus.pctbonus);
                    return true;
                }
                case param1 is PrismFightDefendersStateMessage:
                {
                    _loc_22 = param1 as PrismFightDefendersStateMessage;
                    if (_loc_22.fightId != this._fightId)
                    {
                        this._fightId = _loc_22.fightId;
                    }
                    this._defenders = new Array();
                    for each (_loc_42 in _loc_22.mainFighters)
                    {
                        
                        this._defenders.push(PrismFightersWrapper.create(_loc_42));
                    }
                    this._reserves = new Array();
                    for each (_loc_43 in _loc_22.reserveFighters)
                    {
                        
                        this._reserves.push(PrismFightersWrapper.create(_loc_43));
                    }
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightUpdate, this._fightId, true, true, true);
                    return true;
                }
                case param1 is PrismFightDefenderAddMessage:
                {
                    _loc_23 = param1 as PrismFightDefenderAddMessage;
                    _loc_24 = false;
                    _loc_25 = false;
                    if (_loc_23.fightId != this._fightId)
                    {
                    }
                    if (_loc_23.inMain)
                    {
                        this._defenders.push(PrismFightersWrapper.create(_loc_23.fighterMovementInformations));
                        _loc_24 = true;
                    }
                    else
                    {
                        this._reserves.push(PrismFightersWrapper.create(_loc_23.fighterMovementInformations));
                        _loc_25 = true;
                    }
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightUpdate, this._fightId, false, _loc_24, _loc_25);
                    return true;
                }
                case param1 is PrismFightDefenderLeaveMessage:
                {
                    _loc_26 = param1 as PrismFightDefenderLeaveMessage;
                    if (_loc_26.fightId != this._fightId)
                    {
                    }
                    this._pickup_fighter(this._defenders, _loc_26.fighterToRemoveId);
                    if (_loc_26.successor != 0)
                    {
                        this._defenders.push(this._pickup_fighter(this._reserves, _loc_26.successor));
                    }
                    if (!this._infoJoinLeave && _loc_26.fighterToRemoveId == PlayedCharacterManager.getInstance().infos.id)
                    {
                        _loc_44 = I18n.getUiText("ui.prism.AutoDisjoin");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_44, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    }
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightUpdate, this._fightId, false, true, _loc_26.successor != 0);
                    return true;
                }
                case param1 is PrismFightDefendersSwapMessage:
                {
                    _loc_27 = param1 as PrismFightDefendersSwapMessage;
                    if (_loc_27.fightId != this._fightId)
                    {
                    }
                    _loc_28 = this._pickup_fighter(this._reserves, _loc_27.fighterId1);
                    _loc_29 = this._pickup_fighter(this._defenders, _loc_27.fighterId2);
                    this._reserves.push(_loc_29);
                    this._defenders.push(_loc_28);
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightUpdate, this._fightId, false, true, true);
                    return true;
                }
                case param1 is PrismFightAttackedMessage:
                {
                    _loc_30 = param1 as PrismFightAttackedMessage;
                    this._mapId = _loc_30.mapId;
                    this._subareaId = _loc_30.subAreaId;
                    this._worldX = _loc_30.worldX;
                    this._worldY = _loc_30.worldY;
                    _loc_31 = SubArea.getSubAreaById(this._subareaId);
                    _loc_32 = I18n.getUiText("ui.prism.attacked", [_loc_31.name, "{map," + this.worldX + "," + this.worldY + "}"]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_32, ChatActivableChannelsEnum.CHANNEL_ALIGN, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismAttacked);
                    return true;
                }
                case param1 is PrismFightAttackerAddMessage:
                {
                    _loc_33 = param1 as PrismFightAttackerAddMessage;
                    if (_loc_33.fightId != this._fightId)
                    {
                    }
                    for each (_loc_45 in _loc_33.charactersDescription)
                    {
                        
                        this._attackers.push(PrismFightersWrapper.create(_loc_45));
                    }
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightUpdate, this._fightId, true, false, false);
                    return true;
                }
                case param1 is PrismFightAttackerRemoveMessage:
                {
                    _loc_34 = param1 as PrismFightAttackerRemoveMessage;
                    if (_loc_34.fightId != this._fightId)
                    {
                    }
                    this._pickup_fighter(this._attackers, _loc_34.fighterToRemoveId);
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightUpdate, this._fightId, true, false, false);
                    return true;
                }
                case param1 is PrismWorldInformationMessage:
                {
                    _loc_35 = param1 as PrismWorldInformationMessage;
                    this._nbSubOwned = _loc_35.nbSubOwned;
                    this._subTotal = _loc_35.subTotal;
                    this._maxSub = _loc_35.maxSub;
                    this._subAreasInformation = _loc_35.subAreasInformation;
                    this._nbConqsOwned = _loc_35.nbConqsOwned;
                    this._conqsTotal = _loc_35.conqsTotal;
                    this._conquetesInformation = _loc_35.conquetesInformation;
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismWorldInformation, _loc_35.nbSubOwned, _loc_35.subTotal, _loc_35.maxSub, _loc_35.subAreasInformation, _loc_35.nbConqsOwned, _loc_35.conqsTotal, _loc_35.conquetesInformation);
                    return true;
                }
                case param1 is AlignmentSubAreaUpdateExtendedMessage:
                {
                    _loc_36 = param1 as AlignmentSubAreaUpdateExtendedMessage;
                    if (_loc_36.eventType == SubareaUpdateEventEnum.SUBAREA_EVENT_PRISM_ADDED)
                    {
                        KernelEventsManager.getInstance().processCallback(PrismHookList.PrismAdd, _loc_36.mapId, _loc_36.side, _loc_36.worldX, _loc_36.worldY, _loc_36.subAreaId);
                    }
                    else if (_loc_36.eventType == SubareaUpdateEventEnum.SUBAREA_EVENT_PRISM_REMOVED)
                    {
                        KernelEventsManager.getInstance().processCallback(PrismHookList.PrismRemoved, _loc_36.mapId);
                    }
                    return true;
                }
                case param1 is PrismInfoCloseMessage:
                {
                    _loc_37 = param1 as PrismInfoCloseMessage;
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismInfoClose);
                    return true;
                }
                case param1 is PrismInfoValidMessage:
                {
                    _loc_38 = param1 as PrismInfoValidMessage;
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismInfoValid, _loc_38.waitingForHelpInfo.timeLeftBeforeFight, _loc_38.waitingForHelpInfo.waitTimeForPlacement, _loc_38.waitingForHelpInfo.nbPositionForDefensors);
                    return true;
                }
                case param1 is PrismInfoInValidMessage:
                {
                    _loc_39 = param1 as PrismInfoInValidMessage;
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismInfoInvalid, _loc_39.reason);
                    return true;
                }
                case param1 is PrismFightStateUpdateMessage:
                {
                    _loc_40 = param1 as PrismFightStateUpdateMessage;
                    this._prismState = _loc_40.state;
                    this._defenders = new Array();
                    this._attackers = new Array();
                    this._reserves = new Array();
                    if (Kernel.getWorker().contains(RoleplayContextFrame))
                    {
                        KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightStateUpdate, _loc_40.state);
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

        public function pulled() : Boolean
        {
            return true;
        }// end function

        public function pushRoleplay() : void
        {
            KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightStateUpdate, this._prismState);
            return;
        }// end function

        public function pullRoleplay() : void
        {
            if (this._prismState != 0)
            {
                KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightStateUpdate, 0);
            }
            return;
        }// end function

        public function getSubAreasInformation(param1:uint) : PrismSubAreaWrapper
        {
            var _loc_2:* = this._subAreasInformation[param1];
            return PrismSubAreaWrapper.create(_loc_2.subAreaId, _loc_2.alignment, _loc_2.mapId, _loc_2.isInFight, _loc_2.isFightable, true, _loc_2.worldX, _loc_2.worldY);
        }// end function

        public function getConquetesInformation(param1:uint) : PrismConquestWrapper
        {
            var _loc_2:* = this._conquetesInformation[param1];
            return PrismConquestWrapper.create(_loc_2.areaId, _loc_2.areaAlignment, _loc_2.isEntered, _loc_2.isInRoom);
        }// end function

    }
}
