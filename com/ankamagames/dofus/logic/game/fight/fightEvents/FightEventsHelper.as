package com.ankamagames.dofus.logic.game.fight.fightEvents
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import avmplus.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.events.Event;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.datacenter.misc.TypeAction;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.berilia.managers.HtmlManager;
    import __AS3__.vec.*;

    public class FightEventsHelper 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightEventsHelper));
        private static var _fightEvents:Vector.<FightEvent> = new Vector.<FightEvent>();
        private static var _events:Vector.<Vector.<FightEvent>> = new Vector.<Vector.<FightEvent>>();
        private static var _joinedEvents:Vector.<FightEvent>;
        private static var sysApi:SystemApi = new SystemApi();
        public static var _detailsActive:Boolean;
        private static var _lastSpellId:int;
        private static const NOT_GROUPABLE_BY_TYPE_EVENTS:Array = [FightEventEnum.FIGHTER_CASTED_SPELL];
        private static const SKIP_ENTITY_ALIVE_CHECK_EVENTS:Array = [FightEventEnum.FIGHTER_GOT_KILLED, FightEventEnum.FIGHTER_DEATH];


        public static function reset():void
        {
            _fightEvents = new Vector.<FightEvent>();
            _events = new Vector.<Vector.<FightEvent>>();
            _joinedEvents = new Vector.<FightEvent>();
            _lastSpellId = -1;
        }

        public static function sendFightEvent(name:String, params:Array, fighterId:int, pCastingSpellId:int, sendNow:Boolean=false, checkParams:int=0, pFirstParamToCheck:int=1):void
        {
            var _local_9:FightEvent;
            var _local_10:FightEvent;
            var fightEvent:FightEvent = new FightEvent(name, params, fighterId, checkParams, pCastingSpellId, _fightEvents.length, pFirstParamToCheck);
            if (sendNow)
            {
                KernelEventsManager.getInstance().processCallback(HookList.FightEvent, fightEvent.name, fightEvent.params, [fightEvent.targetId]);
                sendFightLogToChat(fightEvent);
            }
            else
            {
                if (name)
                {
                    _fightEvents.splice(0, 0, fightEvent);
                };
                if (((_joinedEvents) && ((_joinedEvents.length > 0))))
                {
                    if (_joinedEvents[0].name == FightEventEnum.FIGHTER_GOT_TACKLED)
                    {
                        if ((((name == FightEventEnum.FIGHTER_MP_LOST)) || ((name == FightEventEnum.FIGHTER_AP_LOST))))
                        {
                            _joinedEvents.splice(0, 0, fightEvent);
                            return;
                        };
                        if (name != FightEventEnum.FIGHTER_VISIBILITY_CHANGED)
                        {
                            _local_9 = _joinedEvents.shift();
                            for each (_local_10 in _joinedEvents)
                            {
                                if (_local_10.name == FightEventEnum.FIGHTER_AP_LOST)
                                {
                                    _local_9.params[1] = _local_10.params[1];
                                }
                                else
                                {
                                    _local_9.params[2] = _local_10.params[1];
                                };
                            };
                            addFightText(_local_9);
                            _joinedEvents = null;
                        };
                    };
                }
                else
                {
                    if (name == FightEventEnum.FIGHTER_GOT_TACKLED)
                    {
                        _joinedEvents = new Vector.<FightEvent>();
                        _joinedEvents.push(fightEvent);
                        return;
                    };
                };
                if (name)
                {
                    addFightText(fightEvent);
                };
            };
        }

        private static function addFightText(fightEvent:FightEvent):void
        {
            var i:int;
            var targetEvent:Vector.<FightEvent>;
            var eventList:Vector.<FightEvent>;
            var event:FightEvent;
            var num:int = _events.length;
            var groupByType:Boolean = (((NOT_GROUPABLE_BY_TYPE_EVENTS.indexOf(fightEvent.name) == -1)) ? true : false);
            if (fightEvent.name == FightEventEnum.FIGHTER_CASTED_SPELL)
            {
                _lastSpellId = fightEvent.params[3];
            };
            if ((((((fightEvent.name == FightEventEnum.FIGHTER_LIFE_LOSS)) || ((fightEvent.name == FightEventEnum.FIGHTER_LIFE_GAIN)))) || ((fightEvent.name == FightEventEnum.FIGHTER_SHIELD_LOSS))))
            {
                fightEvent.params.push(_lastSpellId);
            };
            if (fightEvent.name == FightEventEnum.FIGHTER_LIFE_LOSS)
            {
                i = 0;
                while (i < num)
                {
                    event = _events[i][0];
                    if ((((((event.name == FightEventEnum.FIGHTER_REDUCED_DAMAGES)) && ((event.castingSpellId == fightEvent.castingSpellId)))) && ((event.targetId == fightEvent.targetId))))
                    {
                        groupByType = false;
                        break;
                    };
                    i++;
                };
            };
            if (groupByType)
            {
                i = 0;
                while (i < num)
                {
                    eventList = _events[i];
                    event = eventList[0];
                    if ((((event.name == fightEvent.name)) && ((((event.castingSpellId == fightEvent.castingSpellId)) || ((fightEvent.castingSpellId == -1))))))
                    {
                        if ((((((((event.name == FightEventEnum.FIGHTER_LIFE_LOSS)) || ((fightEvent.name == FightEventEnum.FIGHTER_LIFE_GAIN)))) || ((fightEvent.name == FightEventEnum.FIGHTER_SHIELD_LOSS)))) && (!((event.params[(event.params.length - 1)] == fightEvent.params[(fightEvent.params.length - 1)])))))
                        {
                            break;
                        };
                        targetEvent = eventList;
                        break;
                    };
                    i++;
                };
            };
            if (targetEvent == null)
            {
                targetEvent = new Vector.<FightEvent>();
                _events.push(targetEvent);
            };
            targetEvent.push(fightEvent);
        }

        public static function sendAllFightEvent(now:Boolean=false):void
        {
            if (now)
            {
                sendEvents(null);
            }
            else
            {
                StageShareManager.stage.addEventListener(Event.ENTER_FRAME, sendEvents);
            };
        }

        private static function sendEvents(pEvt:Event=null):void
        {
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, sendEvents);
            sendFightEvent(null, null, 0, -1);
            sendAllFightEvents();
            var entitiesFrame:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            var entitiesList:Dictionary = ((entitiesFrame) ? entitiesFrame.getEntitiesDictionnary() : new Dictionary());
            _detailsActive = sysApi.getOption("showLogPvDetails", "dofus");
            groupAllEventsForDisplay(entitiesList);
        }

        public static function groupAllEventsForDisplay(entitiesList:Dictionary):void
        {
            var eventList:Vector.<FightEvent>;
            var eventBase:FightEvent;
            var targetsId:Vector.<int>;
            var targetEvents:String;
            var type:int;
            var tmpevt:FightEvent;
            var _local_11:Vector.<FightEvent>;
            var playerTeamId:int = PlayedCharacterManager.getInstance().teamId;
            var groupPvLostAndDeath:Vector.<int> = getTargetsWhoDiesAfterALifeLoss();
            var eventsGroupedByTarget:Dictionary = new Dictionary();
            while (_events.length > 0)
            {
                eventList = _events[0];
                if ((((eventList == null)) || ((eventList.length == 0))))
                {
                    _events.splice(0, 1);
                }
                else
                {
                    eventBase = eventList[0];
                    targetsId = extractTargetsId(eventList);
                    eventsGroupedByTarget = groupFightEventsByTarget(eventList);
                    for (targetEvents in eventsGroupedByTarget)
                    {
                        eventBase = eventsGroupedByTarget[targetEvents][0];
                        if ((((eventsGroupedByTarget[targetEvents].length > 1)) && ((((((eventBase.name == FightEventEnum.FIGHTER_LIFE_LOSS)) || ((eventBase.name == FightEventEnum.FIGHTER_LIFE_GAIN)))) || ((eventBase.name == FightEventEnum.FIGHTER_SHIELD_LOSS))))))
                        {
                            switch (eventBase.name)
                            {
                                case FightEventEnum.FIGHTER_LIFE_LOSS:
                                case FightEventEnum.FIGHTER_SHIELD_LOSS:
                                    type = -1;
                                    break;
                                case FightEventEnum.FIGHTER_LIFE_GAIN:
                                default:
                                    type = 1;
                            };
                            groupByElements(eventsGroupedByTarget[targetEvents], type, _detailsActive, !((groupPvLostAndDeath.indexOf(eventBase.targetId) == -1)), eventBase.castingSpellId);
                            for each (tmpevt in eventsGroupedByTarget[targetEvents])
                            {
                                eventList.splice(eventList.indexOf(tmpevt), 1);
                            };
                        }
                        else
                        {
                            _local_11 = eventList.concat();
                            for each (eventBase in _local_11)
                            {
                                if ((((eventBase.name == FightEventEnum.FIGHTER_DEATH)) && (!((groupPvLostAndDeath.indexOf(eventBase.targetId) == -1)))))
                                {
                                    eventList.splice(eventList.indexOf(eventBase), 1);
                                };
                            };
                            groupByTeam(playerTeamId, targetsId, eventList, entitiesList, groupPvLostAndDeath);
                            _local_11 = eventList.concat();
                            for each (eventBase in _local_11)
                            {
                                sendFightLogToChat(eventBase, "", null, _detailsActive, (((eventBase.name == FightEventEnum.FIGHTER_LIFE_LOSS)) && (!((groupPvLostAndDeath.indexOf(eventBase.targetId) == -1)))));
                                eventList.splice(eventList.indexOf(eventBase), 1);
                            };
                            _local_11 = null;
                        };
                    };
                };
            };
        }

        public static function extractTargetsId(eventList:Vector.<FightEvent>):Vector.<int>
        {
            var event:FightEvent;
            var targetList:Vector.<int> = new Vector.<int>();
            for each (event in eventList)
            {
                if (targetList.indexOf(event.targetId) == -1)
                {
                    targetList.push(event.targetId);
                };
            };
            return (targetList);
        }

        public static function extractGroupableTargets(eventList:Vector.<FightEvent>):Vector.<FightEvent>
        {
            var event:FightEvent;
            var baseEvent:FightEvent = eventList[0];
            var targetList:Vector.<FightEvent> = new Vector.<FightEvent>();
            for each (event in eventList)
            {
                if (needToGroupFightEventsData(getNumberOfParametersToCheck(baseEvent), event, baseEvent))
                {
                    targetList.push(event);
                };
            };
            return (targetList);
        }

        public static function groupFightEventsByTarget(eventList:Vector.<FightEvent>):Dictionary
        {
            var event:FightEvent;
            var dico:Dictionary = new Dictionary();
            for each (event in eventList)
            {
                if (dico[event.targetId.toString()] == null)
                {
                    dico[event.targetId.toString()] = new Array();
                };
                dico[event.targetId.toString()].push(event);
            };
            return (dico);
        }

        public static function groupSameFightEvents(pEventsList:Array, pFightEvent:FightEvent):void
        {
            var groupOfEvent:Array;
            var baseEvent:FightEvent;
            for each (groupOfEvent in pEventsList)
            {
                baseEvent = groupOfEvent[0];
                if (needToGroupFightEventsData(getNumberOfParametersToCheck(baseEvent), pFightEvent, baseEvent))
                {
                    groupOfEvent.push(pFightEvent);
                    return;
                };
            };
            pEventsList.push(new Array(pFightEvent));
        }

        public static function getTargetsWhoDiesAfterALifeLoss():Vector.<int>
        {
            var fightEvent:FightEvent;
            var eventList:Vector.<FightEvent>;
            var targets:Vector.<int> = new Vector.<int>();
            var targetsDead:Vector.<int> = new Vector.<int>();
            var events:Vector.<Vector.<FightEvent>> = _events.concat();
            for each (eventList in events)
            {
                for each (fightEvent in eventList)
                {
                    if (fightEvent.name == FightEventEnum.FIGHTER_LIFE_LOSS)
                    {
                        targets.push(fightEvent.targetId);
                    }
                    else
                    {
                        if ((((fightEvent.name == FightEventEnum.FIGHTER_DEATH)) && (!((targets.indexOf(fightEvent.targetId) == -1)))))
                        {
                            targetsDead.push(fightEvent.targetId);
                        };
                    };
                };
            };
            return (targetsDead);
        }

        private static function groupByElements(pvgroup:Array, pType:int, activeDetails:Boolean=true, pAddDeathInTheSameMsg:Boolean=false, pCastingSpellId:int=-1):void
        {
            var previousElement:int;
            var fe:FightEvent;
            var fightEventName:String;
            var fightEventText:String;
            var ttptsStr:String = "";
            var ttpts:int;
            var isSameElement:Boolean = true;
            for each (fe in pvgroup)
            {
                if (((!((pCastingSpellId == -1))) && (!((pCastingSpellId == fe.castingSpellId)))))
                {
                }
                else
                {
                    if (((previousElement) && (!((fe.params[2] == previousElement)))))
                    {
                        isSameElement = false;
                    };
                    previousElement = fe.params[2];
                    ttpts = (ttpts + fe.params[1]);
                    if (pType == -1)
                    {
                        ttptsStr = (ttptsStr + (formateColorsForFightDamages(fe.params[1], fe.params[2]) + " + "));
                    }
                    else
                    {
                        ttptsStr = (ttptsStr + (fe.params[1] + " + "));
                    };
                };
            };
            fightEventName = ((pAddDeathInTheSameMsg) ? "fightLifeLossAndDeath" : pvgroup[0].name);
            var newparams:Array = new Array();
            newparams[0] = pvgroup[0].params[0];
            if (pType == -1)
            {
                fightEventText = formateColorsForFightDamages(("-" + ttpts.toString()), ((isSameElement) ? previousElement : -1));
            }
            else
            {
                fightEventText = ttpts.toString();
            };
            if (((activeDetails) && ((pvgroup.length > 1))))
            {
                fightEventText = (fightEventText + (("</b> (" + ttptsStr.substr(0, (ttptsStr.length - 3))) + ")<b>"));
            };
            newparams[1] = fightEventText;
            KernelEventsManager.getInstance().processCallback(HookList.FightText, fightEventName, newparams, [newparams[0]]);
        }

        private static function groupByTeam(playerTeamId:int, targets:Vector.<int>, pEventList:Vector.<FightEvent>, pEntitiesList:Dictionary, groupPvLostAndDeath:Vector.<int>):Boolean
        {
            var event:FightEvent;
            var list:Vector.<int>;
            var listToConcat:Vector.<FightEvent>;
            var evt:FightEvent;
            var team:String;
            var t:Object;
            if (pEventList.length == 0)
            {
                return (false);
            };
            var tmpEventList:Vector.<FightEvent> = pEventList.concat();
            while (tmpEventList.length > 1)
            {
                listToConcat = getGroupedListEvent(tmpEventList);
                if (listToConcat.length > 1)
                {
                    list = new Vector.<int>();
                    for each (event in listToConcat)
                    {
                        list.push(event.targetId);
                    };
                    evt = listToConcat[0];
                    team = groupEntitiesByTeam(playerTeamId, list, pEntitiesList, (SKIP_ENTITY_ALIVE_CHECK_EVENTS.indexOf(pEventList[0].name) == -1));
                    switch (team)
                    {
                        case "all":
                        case "allies":
                        case "enemies":
                            removeEventFromEventsList(pEventList, listToConcat);
                            if ((((evt.name == "fighterLifeLoss")) && (!((groupPvLostAndDeath.indexOf(listToConcat[0].targetId) == -1)))))
                            {
                                sendFightLogToChat(evt, team, null, true, true);
                            }
                            else
                            {
                                sendFightLogToChat(evt, team);
                            };
                            break;
                        case "other":
                            removeEventFromEventsList(pEventList, listToConcat);
                            if ((((((evt.name == FightEventEnum.FIGHTER_TEMPORARY_BOOSTED)) && (evt.params[4]))) && ((evt.params[4] is EffectInstance))))
                            {
                                evt.params[1] = EffectInstance(evt.params[4]).description;
                                evt.params[2] = EffectInstance(evt.params[4]).duration;
                                evt.params[3] = EffectInstance(evt.params[4]).durationString;
                            };
                            if ((((evt.name == "fighterLifeLoss")) && (!((groupPvLostAndDeath.indexOf(listToConcat[0].targetId) == -1)))))
                            {
                                sendFightLogToChat(evt, "", list, true, true);
                            }
                            else
                            {
                                sendFightLogToChat(evt, "", list);
                            };
                            break;
                        case "none":
                            _log.warn("Failed to group FightEvents for the team 'none'");
                            break;
                        default:
                            for each (t in pEntitiesList)
                            {
                                if (((((!((team.indexOf("allies") == -1))) && ((t.teamId == playerTeamId)))) || (((!((team.indexOf("enemies") == -1))) && (!((t.teamId == playerTeamId)))))))
                                {
                                    list.splice(list.indexOf(t.contextualId), 1);
                                };
                            };
                            removeEventFromEventsList(pEventList, listToConcat);
                            if ((((evt.name == "fighterLifeLoss")) && (!((groupPvLostAndDeath.indexOf(listToConcat[0].targetId) == -1)))))
                            {
                                sendFightLogToChat(evt, team, list, true, true);
                            }
                            else
                            {
                                sendFightLogToChat(evt, team, list);
                            };
                    };
                };
            };
            return (false);
        }

        public static function getGroupedListEvent(pInEventList:Vector.<FightEvent>):Vector.<FightEvent>
        {
            var event:FightEvent;
            var baseEvent:FightEvent = pInEventList[0];
            var listToConcat:Vector.<FightEvent> = new Vector.<FightEvent>();
            listToConcat.push(baseEvent);
            for each (event in pInEventList)
            {
                if ((((listToConcat.indexOf(event) == -1)) && (needToGroupFightEventsData(getNumberOfParametersToCheck(baseEvent), event, baseEvent))))
                {
                    listToConcat.push(event);
                };
            };
            removeEventFromEventsList(pInEventList, listToConcat);
            return (listToConcat);
        }

        public static function removeEventFromEventsList(pEventList:Vector.<FightEvent>, pListToRemove:Vector.<FightEvent>):void
        {
            var event:FightEvent;
            for each (event in pListToRemove)
            {
                pEventList.splice(pEventList.indexOf(event), 1);
            };
        }

        public static function groupEntitiesByTeam(playerTeamId:int, targetList:Vector.<int>, entitiesList:Dictionary, checkAlive:Boolean=true):String
        {
            var fighterInfos:GameFightFighterInformations;
            var returnData:String;
            var alliesCount:int;
            var enemiesCount:int;
            var nbTotalAllies:int;
            var nbTotalEnemies:int;
            for each (fighterInfos in entitiesList)
            {
                if (fighterInfos != null)
                {
                    if (fighterInfos.teamId == playerTeamId)
                    {
                        nbTotalAllies++;
                    }
                    else
                    {
                        nbTotalEnemies++;
                    };
                    if (((((!(checkAlive)) || (((checkAlive) && (fighterInfos.alive))))) && (!((targetList.indexOf(fighterInfos.contextualId) == -1)))))
                    {
                        if (fighterInfos.teamId == playerTeamId)
                        {
                            alliesCount++;
                        }
                        else
                        {
                            enemiesCount++;
                        };
                    };
                };
            };
            returnData = "";
            if ((((nbTotalAllies == alliesCount)) && ((nbTotalEnemies == enemiesCount))))
            {
                return ("all");
            };
            if ((((alliesCount > 1)) && ((alliesCount == nbTotalAllies))))
            {
                returnData = (returnData + (((!((returnData == ""))) ? "," : "") + "allies"));
                if ((((enemiesCount > 0)) && ((enemiesCount < nbTotalEnemies))))
                {
                    returnData = (returnData + ",other");
                };
            };
            if ((((enemiesCount > 1)) && ((enemiesCount == nbTotalEnemies))))
            {
                returnData = (returnData + (((!((returnData == ""))) ? "," : "") + "enemies"));
                if ((((alliesCount > 0)) && ((alliesCount < nbTotalAllies))))
                {
                    returnData = (returnData + ",other");
                };
            };
            if ((((returnData == "")) && ((targetList.length > 1))))
            {
                returnData = (returnData + (((!((returnData == ""))) ? "," : "") + "other"));
            };
            return ((((returnData == "")) ? "none" : returnData));
        }

        private static function getNumberOfParametersToCheck(baseEvent:FightEvent):int
        {
            var numParam:int = baseEvent.params.length;
            if (numParam > baseEvent.checkParams)
            {
                numParam = baseEvent.checkParams;
            };
            return (numParam);
        }

        private static function needToGroupFightEventsData(pNbParams:int, pFightEvent:FightEvent, pBaseEvent:FightEvent):Boolean
        {
            var paramId:int;
            if (pFightEvent.castingSpellId != pBaseEvent.castingSpellId)
            {
                return (false);
            };
            paramId = pFightEvent.firstParamToCheck;
            while (paramId < pNbParams)
            {
                if (pFightEvent.params[paramId] != pBaseEvent.params[paramId])
                {
                    return (false);
                };
                paramId++;
            };
            return (true);
        }

        private static function sendAllFightEvents():void
        {
            var i:int = (_fightEvents.length - 1);
            while (i >= 0)
            {
                if (_fightEvents[i])
                {
                    KernelEventsManager.getInstance().processCallback(HookList.FightEvent, _fightEvents[i].name, _fightEvents[i].params, [_fightEvents[i].targetId]);
                };
                i--;
            };
            clearData();
        }

        public static function clearData():void
        {
            _fightEvents = new Vector.<FightEvent>();
        }

        private static function sendFightLogToChat(pFightEvent:FightEvent, pTargetsTeam:String="", pTargetsList:Vector.<int>=null, pActiveColoration:Boolean=true, pAddDeathInTheSameMsg:Boolean=false):void
        {
            var name:String = (((((pFightEvent.name == FightEventEnum.FIGHTER_LIFE_LOSS)) && (pAddDeathInTheSameMsg))) ? ("fightLifeLossAndDeath") : pFightEvent.name);
            var params:Array = pFightEvent.params.concat();
            if (pActiveColoration)
            {
                if ((((pFightEvent.name == FightEventEnum.FIGHTER_LIFE_LOSS)) || ((pFightEvent.name == FightEventEnum.FIGHTER_SHIELD_LOSS))))
                {
                    params[1] = formateColorsForFightDamages(("-" + params[1]), params[2]);
                };
            };
            KernelEventsManager.getInstance().processCallback(HookList.FightText, name, params, pTargetsList, pTargetsTeam);
        }

        private static function formateColorsForFightDamages(inText:String, actionId:int):String
        {
            var newText:String;
            var color:String = "";
            var typeAction:TypeAction = TypeAction.getTypeActionById(actionId);
            var elementId:int = (((typeAction)==null) ? -1 : typeAction.elementId);
            switch (elementId)
            {
                case -1:
                    color = XmlConfig.getInstance().getEntry("colors.fight.text.multi");
                    break;
                case 0:
                    color = XmlConfig.getInstance().getEntry("colors.fight.text.neutral");
                    break;
                case 1:
                    color = XmlConfig.getInstance().getEntry("colors.fight.text.earth");
                    break;
                case 2:
                    color = XmlConfig.getInstance().getEntry("colors.fight.text.fire");
                    break;
                case 3:
                    color = XmlConfig.getInstance().getEntry("colors.fight.text.water");
                    break;
                case 4:
                    color = XmlConfig.getInstance().getEntry("colors.fight.text.air");
                    break;
                case 5:
                default:
                    color = "";
            };
            if (color != "")
            {
                newText = HtmlManager.addTag(inText, HtmlManager.SPAN, {"color":color});
            }
            else
            {
                newText = inText;
            };
            return (newText);
        }

        public static function get fightEvents():Vector.<FightEvent>
        {
            return (_fightEvents);
        }

        public static function get events():Vector.<Vector.<FightEvent>>
        {
            return (_events);
        }

        public static function get joinedEvents():Vector.<FightEvent>
        {
            return (_joinedEvents);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.fightEvents

