package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.roleplay.*;
    import com.ankamagames.dofus.logic.game.common.actions.spectator.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class SpectatorManagementFrame extends Object implements Frame
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SpectatorManagementFrame));

        public function SpectatorManagementFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
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
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = false;
            switch(true)
            {
                case param1 is OpenCurrentFightAction:
                {
                    _loc_2 = new MapRunningFightListRequestMessage();
                    _loc_2.initMapRunningFightListRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_2);
                    return true;
                }
                case param1 is MapRunningFightListMessage:
                {
                    _loc_3 = param1 as MapRunningFightListMessage;
                    _loc_4 = new Vector.<FightExternalInformations>;
                    for each (_loc_14 in _loc_3.fights)
                    {
                        
                        _loc_4.push(_loc_14);
                    }
                    _loc_4.sort(sortFights);
                    KernelEventsManager.getInstance().processCallback(HookList.MapRunningFightList, _loc_4);
                    return true;
                }
                case param1 is MapRunningFightDetailsRequestAction:
                {
                    _loc_5 = param1 as MapRunningFightDetailsRequestAction;
                    _loc_6 = new MapRunningFightDetailsRequestMessage();
                    _loc_6.initMapRunningFightDetailsRequestMessage(_loc_5.fightId);
                    ConnectionsHandler.getConnection().send(_loc_6);
                    return true;
                }
                case param1 is StopToListenRunningFightAction:
                {
                    _loc_7 = new StopToListenRunningFightRequestMessage();
                    _loc_7.initStopToListenRunningFightRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_7);
                    return true;
                }
                case param1 is MapRunningFightDetailsMessage:
                {
                    _loc_8 = param1 as MapRunningFightDetailsMessage;
                    _loc_9 = new Vector.<String>;
                    _loc_10 = new Vector.<uint>;
                    for each (_loc_15 in _loc_8.names)
                    {
                        
                        _loc_16 = _loc_15.split(",");
                        if (_loc_16[1])
                        {
                            _loc_17 = thirtySixToDecimal(_loc_16[0]);
                            _loc_18 = thirtySixToDecimal(_loc_16[1]);
                            _loc_9.push(TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc_17).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc_18).name);
                            _loc_10.push(2);
                            continue;
                        }
                        _loc_19 = int(_loc_15).toString() == _loc_15;
                        if (!_loc_19)
                        {
                            _loc_9.push(_loc_15);
                            _loc_10.push(0);
                            continue;
                        }
                        _loc_9.push(Monster.getMonsterById(uint(_loc_15)).name);
                        _loc_10.push(1);
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.MapRunningFightDetails, _loc_8.fightId, _loc_9, _loc_8.levels, _loc_8.teamSwap, _loc_8.alives, _loc_10);
                    return true;
                }
                case param1 is JoinAsSpectatorRequestAction:
                {
                    _loc_11 = param1 as JoinAsSpectatorRequestAction;
                    _loc_12 = new GameFightJoinRequestMessage();
                    _loc_12.initGameFightJoinRequestMessage(0, _loc_11.fightId);
                    ConnectionsHandler.getConnection().send(_loc_12);
                    return true;
                }
                case param1 is JoinFightRequestAction:
                {
                    _loc_13 = param1 as JoinFightRequestAction;
                    _loc_12 = new GameFightJoinRequestMessage();
                    _loc_12.initGameFightJoinRequestMessage(_loc_13.teamLeaderId, _loc_13.fightId);
                    ConnectionsHandler.getConnection().send(_loc_12);
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

        public static function thirtySixToDecimal(param1:String) : uint
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1.charCodeAt(_loc_3);
                if (_loc_4 >= 97)
                {
                    _loc_5 = _loc_4 - 97 + 10;
                }
                else
                {
                    _loc_5 = _loc_4 - 48;
                }
                _loc_2 = _loc_2 + _loc_5 * Math.pow(36, param1.length - _loc_3 - 1);
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        private static function sortFights(param1:FightExternalInformations, param2:FightExternalInformations) : int
        {
            if (param1.fightStart == param2.fightStart)
            {
                return 0;
            }
            if (param1.fightStart == 0)
            {
                return -1;
            }
            if (param2.fightStart == 0)
            {
                return 1;
            }
            return param2.fightStart - param1.fightStart;
        }// end function

    }
}
