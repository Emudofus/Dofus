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

        public static function sendFightEvent(param1:String, param2:Array, param3:int, param4:int, param5:Boolean = false, param6:int = 0) : void
        {
            var _loc_8:FightEvent = null;
            var _loc_9:FightEvent = null;
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
            var _loc_3:int = 0;
            var _loc_4:Vector.<FightEvent> = null;
            var _loc_5:Vector.<FightEvent> = null;
            var _loc_6:FightEvent = null;
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
            var _loc_2:FightEvent = null;
            var _loc_10:Vector.<FightEvent> = null;
            var _loc_11:Array = null;
            var _loc_12:Array = null;
            var _loc_13:Boolean = false;
            var _loc_14:Array = null;
            var _loc_15:FightEvent = null;
            var _loc_16:int = 0;
            var _loc_17:Array = null;
            var _loc_18:FightEvent = null;
            var _loc_19:SystemApi = null;
            var _loc_20:Boolean = false;
            sendFightEvent(null, null, 0, -1);
            _fightEvents = sendAllFightEvents();
            var _loc_3:* = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            var _loc_4:* = _loc_3 ? (_loc_3.getEntitiesDictionnary()) : (new Dictionary());
            var _loc_5:* = PlayedCharacterManager.getInstance().teamId;
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, sendEvents);
            var _loc_6:* = getTargetsWhoDiesAfterALifeLoss();
            var _loc_7:* = new Dictionary();
            var _loc_8:* = new Dictionary();
            var _loc_9:* = new Dictionary();
            for each (_loc_10 in _events)
            {
                
                _loc_11 = new Array();
                for each (_loc_2 in _loc_10)
                {
                    
                    if (_loc_2.targetId == 0 || _loc_10.length == 1)
                    {
                        if (_loc_2.name == FightEventEnum.FIGHTER_LIFE_LOSS)
                        {
                            sendFightLogToChat(_loc_2, null, true, _loc_6.indexOf(_loc_2.targetId) != -1);
                        }
                        else if (_loc_2.name == FightEventEnum.FIGHTER_LIFE_GAIN)
                        {
                            sendFightLogToChat(_loc_2, null, true, false);
                        }
                        else if (_loc_2.name == FightEventEnum.FIGHTER_SHIELD_LOSS)
                        {
                            sendFightLogToChat(_loc_2, null, true, false);
                        }
                        else if (_loc_2.name == FightEventEnum.FIGHTER_DEATH && _loc_6.indexOf(_loc_2.targetId) != -1)
                        {
                            continue;
                        }
                        else
                        {
                            sendFightLogToChat(_loc_2);
                        }
                        continue;
                    }
                    _loc_13 = false;
                    for each (_loc_14 in _loc_11)
                    {
                        
                        _loc_15 = _loc_14[0];
                        _loc_16 = getNumberOfParametersToCheck(_loc_15);
                        if (needToGroupFightEventsData(_loc_16, _loc_2, _loc_15))
                        {
                            _loc_14.push(_loc_2);
                            _loc_13 = true;
                            break;
                        }
                    }
                    if (!_loc_13)
                    {
                        _loc_11.push(new Array(_loc_2));
                    }
                }
                for each (_loc_12 in _loc_11)
                {
                    
                    _loc_17 = new Array();
                    for each (_loc_18 in _loc_12)
                    {
                        
                        if (_loc_17.indexOf(_loc_18.targetId) == -1)
                        {
                            _loc_17.push(_loc_18.targetId);
                        }
                        if (_loc_18.name == FightEventEnum.FIGHTER_LIFE_LOSS)
                        {
                            if (_loc_7[_loc_18.targetId.toString()] == null)
                            {
                                _loc_7[_loc_18.targetId.toString()] = new Array();
                            }
                            _loc_7[_loc_18.targetId.toString()].push(_loc_18);
                            continue;
                        }
                        if (_loc_18.name == FightEventEnum.FIGHTER_LIFE_GAIN)
                        {
                            if (_loc_8[_loc_18.targetId.toString()] == null)
                            {
                                _loc_8[_loc_18.targetId.toString()] = new Array();
                            }
                            _loc_8[_loc_18.targetId.toString()].push(_loc_18);
                            continue;
                        }
                        if (_loc_18.name == FightEventEnum.FIGHTER_SHIELD_LOSS)
                        {
                            if (_loc_9[_loc_18.targetId.toString()] == null)
                            {
                                _loc_9[_loc_18.targetId.toString()] = new Array();
                            }
                            _loc_9[_loc_18.targetId.toString()].push(_loc_18);
                        }
                    }
                    if (_loc_18.name == FightEventEnum.FIGHTER_DEATH && _loc_6.indexOf(_loc_18.targetId) != -1)
                    {
                        continue;
                    }
                    _loc_19 = new SystemApi();
                    _loc_20 = _loc_19.getOption("showLogPvDetails", "dofus");
                    if (_loc_18.name == FightEventEnum.FIGHTER_LIFE_LOSS && _loc_7[_loc_18.targetId.toString()] != null && _loc_7[_loc_18.targetId.toString()].length > 1)
                    {
                        groupByElements(_loc_7, -1, _loc_20, _loc_6.indexOf(_loc_18.targetId) != -1, _loc_18.castingSpellId);
                        continue;
                    }
                    if (_loc_18.name == FightEventEnum.FIGHTER_LIFE_GAIN && _loc_8[_loc_18.targetId.toString()] != null && _loc_8[_loc_18.targetId.toString()].length > 1)
                    {
                        groupByElements(_loc_8, 1, _loc_20, false, _loc_18.castingSpellId);
                        continue;
                    }
                    if (_loc_18.name == FightEventEnum.FIGHTER_SHIELD_LOSS && _loc_9[_loc_18.targetId.toString()] != null && _loc_9[_loc_18.targetId.toString()].length > 1)
                    {
                        groupByElements(_loc_9, -1, _loc_20, false, _loc_18.castingSpellId);
                        continue;
                    }
                    if (_loc_3 && _loc_17.length > 1)
                    {
                        if (_loc_18.name == FightEventEnum.FIGHTER_LIFE_LOSS || !groupByTeam(_loc_5, _loc_17, _loc_18, _loc_4))
                        {
                            if (_loc_18.name == FightEventEnum.FIGHTER_LIFE_LOSS)
                            {
                                for each (_loc_18 in _loc_12)
                                {
                                    
                                    sendFightLogToChat(_loc_18, null, _loc_20, _loc_6.indexOf(_loc_18.targetId) != -1);
                                }
                            }
                            else
                            {
                                sendFightLogToChat(_loc_18, _loc_17, _loc_20);
                            }
                        }
                        continue;
                    }
                    if (_loc_18.name == FightEventEnum.FIGHTER_LIFE_LOSS)
                    {
                        sendFightLogToChat(_loc_18, null, _loc_20, _loc_6.indexOf(_loc_18.targetId) != -1);
                        continue;
                    }
                    sendFightLogToChat(_loc_18, null, _loc_20);
                }
            }
            _events = new Vector.<Vector.<FightEvent>>;
            return;
        }// end function

        private static function getTargetsWhoDiesAfterALifeLoss() : Vector.<int>
        {
            var _loc_3:FightEvent = null;
            var _loc_4:Vector.<FightEvent> = null;
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

        private static function groupByElements(param1:Dictionary, param2:int, param3:Boolean = true, param4:Boolean = false, param5:int = -1) : void
        {
            var _loc_6:Array = null;
            var _loc_7:String = null;
            var _loc_8:int = 0;
            var _loc_9:Boolean = false;
            var _loc_10:int = 0;
            var _loc_11:FightEvent = null;
            var _loc_12:String = null;
            var _loc_13:Array = null;
            var _loc_14:String = null;
            for each (_loc_6 in param1)
            {
                
                _loc_7 = "";
                _loc_8 = 0;
                _loc_9 = true;
                for each (_loc_11 in _loc_6)
                {
                    
                    if (param5 != -1 && param5 != _loc_11.castingSpellId)
                    {
                        continue;
                    }
                    if (_loc_10 && _loc_11.params[2] != _loc_10)
                    {
                        _loc_9 = false;
                    }
                    _loc_10 = _loc_11.params[2];
                    _loc_8 = _loc_8 + _loc_11.params[1];
                    if (param2 == -1)
                    {
                        _loc_7 = _loc_7 + (formateColorsForFightDamages(_loc_11.params[1], _loc_11.params[2]) + " + ");
                        continue;
                    }
                    _loc_7 = _loc_7 + (_loc_11.params[1] + " + ");
                }
                _loc_12 = param4 ? ("fightLifeLossAndDeath") : (_loc_6[0].name);
                _loc_13 = new Array();
                _loc_13[0] = _loc_6[0].params[0];
                if (param2 == -1)
                {
                    _loc_14 = formateColorsForFightDamages("-" + _loc_8.toString(), _loc_9 ? (_loc_10) : (-1));
                }
                else
                {
                    _loc_14 = _loc_8.toString();
                }
                if (param3 && _loc_6.length > 1)
                {
                    _loc_14 = _loc_14 + ("</b> (" + _loc_7.substr(0, _loc_7.length - 3) + ")<b>");
                }
                _loc_13[1] = _loc_14;
                KernelEventsManager.getInstance().processCallback(HookList.FightText, _loc_12, _loc_13, [_loc_13[0]]);
            }
            return;
        }// end function

        private static function groupByTeam(param1:int, param2:Array, param3:FightEvent, param4:Dictionary) : Boolean
        {
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
            sendFightLogToChat(param3, param2);
            return true;
        }// end function

        private static function groupEntitiesByTeam(param1:int, param2:Array, param3:Dictionary) : String
        {
            var _loc_8:GameFightFighterInformations = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
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
            var _loc_4:int = 0;
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

        private static function sendAllFightEvents() : Vector.<FightEvent>
        {
            var _loc_1:FightEvent = null;
            for each (_loc_1 in _fightEvents)
            {
                
                KernelEventsManager.getInstance().processCallback(HookList.FightEvent, _loc_1.name, _loc_1.params, [_loc_1.targetId]);
            }
            return new Vector.<FightEvent>;
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
            var _loc_3:String = null;
            var _loc_4:String = "";
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

    }
}
