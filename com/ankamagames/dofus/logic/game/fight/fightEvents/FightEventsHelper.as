package com.ankamagames.dofus.logic.game.fight.fightEvents
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.misc.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.uiApi.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class FightEventsHelper extends Object
    {
        private static var _fightEvents:Vector.<FightEvent> = new Vector.<FightEvent>;
        private static var _events:Vector.<Vector.<FightEvent>> = new Vector.<Vector.<FightEvent>>;
        private static var _joinedEvents:Vector.<FightEvent>;

        public function FightEventsHelper()
        {
            return;
        }// end function

        public static function reset() : void
        {
            _fightEvents = new Vector.<FightEvent>;
            _events = new Vector.<Vector.<FightEvent>>;
            _joinedEvents = new Vector.<FightEvent>;
            return;
        }// end function

        public static function sendFightEvent(param1:String, param2:Array, param3:int, param4:int, param5:Boolean = false, param6:int = 0) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_7:* = new FightEvent(param1, param2, param3, param6, param4);
            if (param1)
            {
                _fightEvents.push(_loc_7);
            }
            if (param5)
            {
                sendFightLogToChat(_loc_7);
            }
            else
            {
                if (_joinedEvents && _joinedEvents.length > 0)
                {
                    if (_joinedEvents[0].name == FightEventEnum.FIGHTER_GOT_TACKLED)
                    {
                        if (param1 == FightEventEnum.FIGHTER_MP_LOST || param1 == FightEventEnum.FIGHTER_AP_LOST)
                        {
                            _joinedEvents.push(_loc_7);
                            return;
                        }
                        if (param1 == FightEventEnum.FIGHTER_VISIBILITY_CHANGED)
                        {
                        }
                        else
                        {
                            _loc_8 = _joinedEvents.shift();
                            for each (_loc_9 in _joinedEvents)
                            {
                                
                                if (_loc_9.name == FightEventEnum.FIGHTER_AP_LOST)
                                {
                                    _loc_8.params[1] = _loc_9.params[1];
                                    continue;
                                }
                                _loc_8.params[2] = _loc_9.params[1];
                            }
                            addFightText(_loc_8);
                            _joinedEvents = null;
                        }
                    }
                }
                else if (param1 == FightEventEnum.FIGHTER_GOT_TACKLED)
                {
                    _joinedEvents = new Vector.<FightEvent>;
                    _joinedEvents.push(_loc_7);
                    return;
                }
                if (param1)
                {
                    addFightText(_loc_7);
                }
            }
            return;
        }// end function

        private static function addFightText(event:FightEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = _events.length;
            _loc_3 = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_5 = _events[_loc_3];
                _loc_6 = _loc_5[0];
                if (_loc_6.name == event.name && (_loc_6.castingSpellId == event.castingSpellId || event.castingSpellId == -1))
                {
                    _loc_4 = _loc_5;
                    break;
                }
                _loc_3++;
            }
            if (_loc_4 == null)
            {
                _loc_4 = new Vector.<FightEvent>;
                _events.push(_loc_4);
            }
            _loc_4.push(event);
            return;
        }// end function

        public static function sendAllFightEvent(param1:Boolean = false) : void
        {
            if (param1)
            {
                sendEvents(null);
            }
            else
            {
                StageShareManager.stage.addEventListener(Event.ENTER_FRAME, sendEvents);
            }
            return;
        }// end function

        private static function sendEvents(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = false;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            sendFightEvent(null, null, 0, -1);
            sendAllFightEvents();
            var _loc_3:* = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            var _loc_4:* = _loc_3 ? (_loc_3.getEntitiesDictionnary()) : (new Dictionary());
            var _loc_5:* = PlayedCharacterManager.getInstance().teamId;
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, sendEvents);
            var _loc_6:* = getTargetsWhoDiesAfterALifeLoss();
            var _loc_7:* = new Dictionary();
            while (_events.length > 0)
            {
                
                _loc_8 = _events[0];
                if (_loc_8 == null || _loc_8.length == 0)
                {
                    _events.splice(0, 1);
                    continue;
                }
                _loc_9 = _loc_8[0];
                _loc_10 = extractTargetsId(_loc_8);
                if ((_loc_9.name == FightEventEnum.FIGHTER_LIFE_LOSS || _loc_9.name == FightEventEnum.FIGHTER_LIFE_GAIN) && groupByTeam(_loc_5, _loc_10, _loc_8, _loc_4))
                {
                    _events.splice(_events.indexOf(_loc_8), 1);
                    continue;
                }
                _loc_7 = groupFightEventsByTarget(_loc_8);
                _loc_11 = new SystemApi();
                _loc_12 = _loc_11.getOption("showLogPvDetails", "dofus");
                for (_loc_13 in _loc_7)
                {
                    
                    _loc_9 = _loc_7[_loc_13][0];
                    if (_loc_7[_loc_13].length > 1 && (_loc_9.name == FightEventEnum.FIGHTER_LIFE_LOSS || _loc_9.name == FightEventEnum.FIGHTER_LIFE_GAIN || _loc_9.name == FightEventEnum.FIGHTER_SHIELD_LOSS))
                    {
                        switch(_loc_9.name)
                        {
                            case FightEventEnum.FIGHTER_LIFE_LOSS:
                            case FightEventEnum.FIGHTER_SHIELD_LOSS:
                            {
                                _loc_14 = -1;
                                break;
                            }
                            case FightEventEnum.FIGHTER_LIFE_GAIN:
                            {
                                _loc_14 = 1;
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        groupByElements(_loc_7[_loc_13], _loc_14, _loc_12, _loc_6.indexOf(_loc_9.targetId) != -1, _loc_9.castingSpellId);
                        for each (_loc_15 in _loc_7[_loc_13])
                        {
                            
                            _loc_8.splice(_loc_8.indexOf(_loc_15), 1);
                        }
                        continue;
                    }
                    for each (_loc_9 in _loc_7[_loc_13])
                    {
                        
                        if (!(_loc_9.name == FightEventEnum.FIGHTER_DEATH && _loc_6.indexOf(_loc_9.targetId) != -1))
                        {
                            sendFightLogToChat(_loc_9, null, _loc_12, _loc_9.name == FightEventEnum.FIGHTER_LIFE_LOSS && _loc_6.indexOf(_loc_9.targetId) != -1);
                        }
                        _loc_8.splice(_loc_8.indexOf(_loc_9), 1);
                    }
                }
            }
            return;
        }// end function

        public static function extractTargetsId(param1:Vector.<FightEvent>) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = new Array();
            for each (_loc_3 in param1)
            {
                
                if (_loc_2.indexOf(_loc_3.targetId) == -1)
                {
                    _loc_2.push(_loc_3.targetId);
                }
            }
            return _loc_2;
        }// end function

        public static function groupFightEventsByTarget(param1:Vector.<FightEvent>) : Dictionary
        {
            var _loc_3:* = null;
            var _loc_2:* = new Dictionary();
            for each (_loc_3 in param1)
            {
                
                if (_loc_2[_loc_3.targetId.toString()] == null)
                {
                    _loc_2[_loc_3.targetId.toString()] = new Array();
                }
                _loc_2[_loc_3.targetId.toString()].push(_loc_3);
            }
            return _loc_2;
        }// end function

        public static function groupSameFightEvents(param1:Array, param2:FightEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            for each (_loc_3 in param1)
            {
                
                _loc_4 = _loc_3[0];
                if (needToGroupFightEventsData(getNumberOfParametersToCheck(_loc_4), param2, _loc_4))
                {
                    _loc_3.push(param2);
                    return;
                }
            }
            param1.push(new Array(param2));
            return;
        }// end function

        public static function getTargetsWhoDiesAfterALifeLoss() : Vector.<int>
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = new Vector.<int>;
            var _loc_2:* = new Vector.<int>;
            var _loc_5:* = _events.concat();
            for each (_loc_4 in _loc_5)
            {
                
                for each (_loc_3 in _loc_4)
                {
                    
                    if (_loc_3.name == FightEventEnum.FIGHTER_LIFE_LOSS)
                    {
                        _loc_1.push(_loc_3.targetId);
                        continue;
                    }
                    if (_loc_3.name == FightEventEnum.FIGHTER_DEATH && _loc_1.indexOf(_loc_3.targetId) != -1)
                    {
                        _loc_2.push(_loc_3.targetId);
                    }
                }
            }
            return _loc_2;
        }// end function

        private static function groupByElements(param1:Array, param2:int, param3:Boolean = true, param4:Boolean = false, param5:int = -1) : void
        {
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_13:* = null;
            var _loc_6:* = "";
            var _loc_7:* = 0;
            var _loc_8:* = true;
            for each (_loc_10 in param1)
            {
                
                if (param5 != -1 && param5 != _loc_10.castingSpellId)
                {
                    continue;
                }
                if (_loc_9 && _loc_10.params[2] != _loc_9)
                {
                    _loc_8 = false;
                }
                _loc_9 = _loc_10.params[2];
                _loc_7 = _loc_7 + _loc_10.params[1];
                if (param2 == -1)
                {
                    _loc_6 = _loc_6 + (formateColorsForFightDamages(_loc_10.params[1], _loc_10.params[2]) + " + ");
                    continue;
                }
                _loc_6 = _loc_6 + (_loc_10.params[1] + " + ");
            }
            _loc_11 = param4 ? ("fightLifeLossAndDeath") : (param1[0].name);
            var _loc_12:* = new Array();
            new Array()[0] = param1[0].params[0];
            if (param2 == -1)
            {
                _loc_13 = formateColorsForFightDamages("-" + _loc_7.toString(), _loc_8 ? (_loc_9) : (-1));
            }
            else
            {
                _loc_13 = _loc_7.toString();
            }
            if (param3 && param1.length > 1)
            {
                _loc_13 = _loc_13 + ("</b> (" + _loc_6.substr(0, _loc_6.length - 3) + ")<b>");
            }
            _loc_12[1] = _loc_13;
            KernelEventsManager.getInstance().processCallback(HookList.FightText, _loc_11, _loc_12, [_loc_12[0]]);
            return;
        }// end function

        private static function groupByTeam(param1:int, param2:Array, param3:Vector.<FightEvent>, param4:Dictionary) : Boolean
        {
            var _loc_6:* = null;
            var _loc_5:* = param3[0];
            for each (_loc_6 in param3)
            {
                
                if (!needToGroupFightEventsData(getNumberOfParametersToCheck(_loc_5), _loc_6, _loc_5))
                {
                    return false;
                }
            }
            switch(groupEntitiesByTeam(param1, param2, param4))
            {
                case "all":
                {
                    param2["all"] = true;
                    break;
                }
                case "allies":
                {
                    param2["allies"] = true;
                    break;
                }
                case "enemies":
                {
                    param2["enemies"] = true;
                    break;
                }
                case "none":
                {
                    return false;
                }
                default:
                {
                    break;
                }
            }
            sendFightLogToChat(_loc_5, param2);
            return true;
        }// end function

        public static function groupEntitiesByTeam(param1:int, param2:Array, param3:Dictionary) : String
        {
            var _loc_8:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            for each (_loc_8 in param3)
            {
                
                if (_loc_8.teamId == param1)
                {
                    _loc_6++;
                }
                else
                {
                    _loc_7++;
                }
                if (_loc_8.alive && param2.indexOf(_loc_8.contextualId) != -1)
                {
                    if (_loc_8.teamId == param1)
                    {
                        _loc_4++;
                        continue;
                    }
                    _loc_5++;
                }
            }
            if (_loc_6 == _loc_4 && _loc_7 == _loc_5)
            {
                return "all";
            }
            if (_loc_4 > 1 && _loc_4 == _loc_6)
            {
                return "allies";
            }
            if (_loc_5 > 1 && _loc_5 == _loc_7)
            {
                return "enemies";
            }
            return "none";
        }// end function

        private static function getNumberOfParametersToCheck(event:FightEvent) : int
        {
            var _loc_2:* = event.params.length;
            if (_loc_2 > event.checkParams)
            {
                _loc_2 = event.checkParams;
            }
            return _loc_2;
        }// end function

        private static function needToGroupFightEventsData(param1:int, param2:FightEvent, param3:FightEvent) : Boolean
        {
            var _loc_4:* = 0;
            _loc_4 = 1;
            while (_loc_4 < param1)
            {
                
                if (param2.params[_loc_4] != param3.params[_loc_4])
                {
                    return false;
                }
                _loc_4++;
            }
            return true;
        }// end function

        private static function sendAllFightEvents() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in _fightEvents)
            {
                
                KernelEventsManager.getInstance().processCallback(HookList.FightEvent, _loc_1.name, _loc_1.params, [_loc_1.targetId]);
            }
            clearData();
            return;
        }// end function

        public static function clearData() : void
        {
            _fightEvents = new Vector.<FightEvent>;
            return;
        }// end function

        private static function sendFightLogToChat(event:FightEvent, param2:Array = null, param3:Boolean = true, param4:Boolean = false) : void
        {
            var _loc_5:* = param4 ? ("fightLifeLossAndDeath") : (event.name);
            var _loc_6:* = event.params;
            if (param3)
            {
                if (event.name == FightEventEnum.FIGHTER_LIFE_LOSS || event.name == FightEventEnum.FIGHTER_SHIELD_LOSS)
                {
                    _loc_6[1] = formateColorsForFightDamages("-" + _loc_6[1], _loc_6[2]);
                }
            }
            KernelEventsManager.getInstance().processCallback(HookList.FightText, _loc_5, _loc_6, param2);
            return;
        }// end function

        private static function formateColorsForFightDamages(param1:String, param2:int) : String
        {
            var _loc_3:* = null;
            var _loc_4:* = "";
            var _loc_5:* = TypeAction.getTypeActionById(param2);
            var _loc_6:* = TypeAction.getTypeActionById(param2) == null ? (-1) : (_loc_5.elementId);
            switch(_loc_6)
            {
                case -1:
                {
                    _loc_4 = XmlConfig.getInstance().getEntry("colors.fight.text.multi");
                    break;
                }
                case 0:
                {
                    _loc_4 = XmlConfig.getInstance().getEntry("colors.fight.text.neutral");
                    break;
                }
                case 1:
                {
                    _loc_4 = XmlConfig.getInstance().getEntry("colors.fight.text.earth");
                    break;
                }
                case 2:
                {
                    _loc_4 = XmlConfig.getInstance().getEntry("colors.fight.text.fire");
                    break;
                }
                case 3:
                {
                    _loc_4 = XmlConfig.getInstance().getEntry("colors.fight.text.water");
                    break;
                }
                case 4:
                {
                    _loc_4 = XmlConfig.getInstance().getEntry("colors.fight.text.air");
                    break;
                }
                case 5:
                {
                }
                default:
                {
                    _loc_4 = "";
                    break;
                    break;
                }
            }
            if (_loc_4 != "")
            {
                _loc_3 = "<font color=\'" + _loc_4.replace("0x", "#") + "\'>" + param1 + "</font>";
            }
            else
            {
                _loc_3 = param1;
            }
            return _loc_3;
        }// end function

        public static function get fightEvents() : Vector.<FightEvent>
        {
            return _fightEvents;
        }// end function

        public static function get events() : Vector.<Vector.<FightEvent>>
        {
            return _events;
        }// end function

        public static function get joinedEvents() : Vector.<FightEvent>
        {
            return _joinedEvents;
        }// end function

    }
}
