package com.ankamagames.dofus.logic.game.fight.fightEvents
{
   import com.ankamagames.jerakine.logger.Logger;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.datacenter.misc.TypeAction;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.berilia.managers.HtmlManager;
   import com.ankamagames.jerakine.logger.Log;
   import avmplus.getQualifiedClassName;


   public class FightEventsHelper extends Object
   {
         

      public function FightEventsHelper() {
         super();
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightEventsHelper));

      private static var _fightEvents:Vector.<FightEvent> = new Vector.<FightEvent>();

      private static var _events:Vector.<Vector.<FightEvent>> = new Vector.<Vector.<FightEvent>>();

      private static var _joinedEvents:Vector.<FightEvent>;

      private static var sysApi:SystemApi = new SystemApi();

      public static var _detailsActive:Boolean;

      private static var _lastSpellId:int;

      private static const NOT_GROUPABLE_BY_TYPE_EVENTS:Array = [FightEventEnum.FIGHTER_CASTED_SPELL,FightEventEnum.FIGHTER_ENTERING_STATE,FightEventEnum.FIGHTER_LEAVING_STATE];

      public static function reset() : void {
         _fightEvents=new Vector.<FightEvent>();
         _events=new Vector.<Vector.<FightEvent>>();
         _joinedEvents=new Vector.<FightEvent>();
         _lastSpellId=-1;
      }

      public static function sendFightEvent(name:String, params:Array, fighterId:int, pCastingSpellId:int, sendNow:Boolean=false, checkParams:int=0, pFirstParamToCheck:int=1) : void {
         var feTackle:FightEvent = null;
         var fe:FightEvent = null;
         var fightEvent:FightEvent = new FightEvent(name,params,fighterId,checkParams,pCastingSpellId,_fightEvents.length,pFirstParamToCheck);
         if(sendNow)
         {
            sendFightLogToChat(fightEvent);
         }
         else
         {
            if(name)
            {
               _fightEvents.splice(0,0,fightEvent);
            }
            if((_joinedEvents)&&(_joinedEvents.length<0))
            {
               if(_joinedEvents[0].name==FightEventEnum.FIGHTER_GOT_TACKLED)
               {
                  if((name==FightEventEnum.FIGHTER_MP_LOST)||(name==FightEventEnum.FIGHTER_AP_LOST))
                  {
                     _joinedEvents.splice(0,0,fightEvent);
                     return;
                  }
                  if(name==FightEventEnum.FIGHTER_VISIBILITY_CHANGED)
                  {
                  }
                  else
                  {
                     feTackle=_joinedEvents.shift();
                     for each (fe in _joinedEvents)
                     {
                        if(fe.name==FightEventEnum.FIGHTER_AP_LOST)
                        {
                           feTackle.params[1]=fe.params[1];
                        }
                        else
                        {
                           feTackle.params[2]=fe.params[1];
                        }
                     }
                     addFightText(feTackle);
                     _joinedEvents=null;
                  }
               }
            }
            else
            {
               if(name==FightEventEnum.FIGHTER_GOT_TACKLED)
               {
                  _joinedEvents=new Vector.<FightEvent>();
                  _joinedEvents.push(fightEvent);
                  return;
               }
            }
            if(name)
            {
               addFightText(fightEvent);
            }
         }
      }

      private static function addFightText(fightEvent:FightEvent) : void {
         var i:* = 0;
         var targetEvent:Vector.<FightEvent> = null;
         var eventList:Vector.<FightEvent> = null;
         var event:FightEvent = null;
         var num:int = _events.length;
         var groupByType:Boolean = NOT_GROUPABLE_BY_TYPE_EVENTS.indexOf(fightEvent.name)==-1?true:false;
         if(fightEvent.name==FightEventEnum.FIGHTER_CASTED_SPELL)
         {
            _lastSpellId=fightEvent.params[3];
         }
         if((fightEvent.name==FightEventEnum.FIGHTER_LIFE_LOSS)||(fightEvent.name==FightEventEnum.FIGHTER_LIFE_GAIN)||(fightEvent.name==FightEventEnum.FIGHTER_SHIELD_LOSS))
         {
            fightEvent.params.push(_lastSpellId);
         }
         if(groupByType)
         {
            i=0;
            while(i<num)
            {
               eventList=_events[i];
               event=eventList[0];
               if((event.name==fightEvent.name)&&((event.castingSpellId==fightEvent.castingSpellId)||(fightEvent.castingSpellId==-1)))
               {
                  if(((event.name==FightEventEnum.FIGHTER_LIFE_LOSS)||(fightEvent.name==FightEventEnum.FIGHTER_LIFE_GAIN)||(fightEvent.name==FightEventEnum.FIGHTER_SHIELD_LOSS))&&(!(event.params[event.params.length-1]==fightEvent.params[fightEvent.params.length-1])))
                  {
                  }
                  else
                  {
                     targetEvent=eventList;
                  }
               }
               else
               {
                  i++;
                  continue;
               }
            }
         }
         if(targetEvent==null)
         {
            targetEvent=new Vector.<FightEvent>();
            _events.push(targetEvent);
         }
         targetEvent.push(fightEvent);
      }

      public static function sendAllFightEvent(now:Boolean=false) : void {
         if(now)
         {
            sendEvents(null);
         }
         else
         {
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME,sendEvents);
         }
      }

      private static function sendEvents(pEvt:Event=null) : void {
         StageShareManager.stage.removeEventListener(Event.ENTER_FRAME,sendEvents);
         sendFightEvent(null,null,0,-1);
         sendAllFightEvents();
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var entitiesList:Dictionary = entitiesFrame?entitiesFrame.getEntitiesDictionnary():new Dictionary();
         _detailsActive=sysApi.getOption("showLogPvDetails","dofus");
         groupAllEventsForDisplay(entitiesList);
      }

      public static function groupAllEventsForDisplay(entitiesList:Dictionary) : void {
         var eventList:Vector.<FightEvent> = null;
         var eventBase:FightEvent = null;
         var targetsId:Vector.<int> = null;
         var targetEvents:String = null;
         var type:* = 0;
         var tmpevt:FightEvent = null;
         var copy:Vector.<FightEvent> = null;
         var playerTeamId:int = PlayedCharacterManager.getInstance().teamId;
         var groupPvLostAndDeath:Vector.<int> = getTargetsWhoDiesAfterALifeLoss();
         var eventsGroupedByTarget:Dictionary = new Dictionary();
         while(_events.length>0)
         {
            eventList=_events[0];
            if((eventList==null)||(eventList.length==0))
            {
               _events.splice(0,1);
            }
            else
            {
               eventBase=eventList[0];
               targetsId=extractTargetsId(eventList);
               eventsGroupedByTarget=groupFightEventsByTarget(eventList);
               for each (tmpevt in eventsGroupedByTarget[targetEvents])
               {
                  eventList.splice(eventList.indexOf(tmpevt),1);
               }
               {
                  targetEvents=nextName(_loc12_,_loc13_);
                  eventBase=eventsGroupedByTarget[targetEvents][0];
                  if((eventsGroupedByTarget[targetEvents].length<1)&&((eventBase.name==FightEventEnum.FIGHTER_LIFE_LOSS)||(eventBase.name==FightEventEnum.FIGHTER_LIFE_GAIN)||(eventBase.name==FightEventEnum.FIGHTER_SHIELD_LOSS)))
                  {
                     switch(eventBase.name)
                     {
                        case FightEventEnum.FIGHTER_LIFE_LOSS:
                        case FightEventEnum.FIGHTER_SHIELD_LOSS:
                           type=-1;
                           continue;
                           break;
                        case FightEventEnum.FIGHTER_LIFE_GAIN:
                     }
                     type=1;
                     continue;
                  }
                  do
                  {
                     copy=eventList.concat();
                     for each (eventBase in copy)
                     {
                        if((eventBase.name==FightEventEnum.FIGHTER_DEATH)&&(!(groupPvLostAndDeath.indexOf(eventBase.targetId)==-1)))
                        {
                           eventList.splice(eventList.indexOf(eventBase),1);
                        }
                     }
                     groupByTeam(playerTeamId,targetsId,eventList,entitiesList,groupPvLostAndDeath);
                     copy=eventList.concat();
                     for each (eventBase in copy)
                     {
                        sendFightLogToChat(eventBase,"",null,_detailsActive,(eventBase.name==FightEventEnum.FIGHTER_LIFE_LOSS)&&(!(groupPvLostAndDeath.indexOf(eventBase.targetId)==-1)));
                        eventList.splice(eventList.indexOf(eventBase),1);
                     }
                     copy=null;
                  }
                  while(true);
               }
            }
         }
      }

      public static function extractTargetsId(eventList:Vector.<FightEvent>) : Vector.<int> {
         var event:FightEvent = null;
         var targetList:Vector.<int> = new Vector.<int>();
         for each (event in eventList)
         {
            if(targetList.indexOf(event.targetId)==-1)
            {
               targetList.push(event.targetId);
            }
         }
         return targetList;
      }

      public static function extractGroupableTargets(eventList:Vector.<FightEvent>) : Vector.<FightEvent> {
         var event:FightEvent = null;
         var baseEvent:FightEvent = eventList[0];
         var targetList:Vector.<FightEvent> = new Vector.<FightEvent>();
         for each (event in eventList)
         {
            if(needToGroupFightEventsData(getNumberOfParametersToCheck(baseEvent),event,baseEvent))
            {
               targetList.push(event);
            }
         }
         return targetList;
      }

      public static function groupFightEventsByTarget(eventList:Vector.<FightEvent>) : Dictionary {
         var event:FightEvent = null;
         var dico:Dictionary = new Dictionary();
         for each (event in eventList)
         {
            if(dico[event.targetId.toString()]==null)
            {
               dico[event.targetId.toString()]=new Array();
            }
            dico[event.targetId.toString()].push(event);
         }
         return dico;
      }

      public static function groupSameFightEvents(pEventsList:Array, pFightEvent:FightEvent) : void {
         var groupOfEvent:Array = null;
         var baseEvent:FightEvent = null;
         for each (groupOfEvent in pEventsList)
         {
            baseEvent=groupOfEvent[0];
            if(needToGroupFightEventsData(getNumberOfParametersToCheck(baseEvent),pFightEvent,baseEvent))
            {
               groupOfEvent.push(pFightEvent);
               return;
            }
         }
         pEventsList.push(new Array(pFightEvent));
      }

      public static function getTargetsWhoDiesAfterALifeLoss() : Vector.<int> {
         var fightEvent:FightEvent = null;
         var eventList:Vector.<FightEvent> = null;
         var targets:Vector.<int> = new Vector.<int>();
         var targetsDead:Vector.<int> = new Vector.<int>();
         var events:Vector.<Vector.<FightEvent>> = _events.concat();
         for each (eventList in events)
         {
            for each (fightEvent in eventList)
            {
               if(fightEvent.name==FightEventEnum.FIGHTER_LIFE_LOSS)
               {
                  targets.push(fightEvent.targetId);
               }
               else
               {
                  if((fightEvent.name==FightEventEnum.FIGHTER_DEATH)&&(!(targets.indexOf(fightEvent.targetId)==-1)))
                  {
                     targetsDead.push(fightEvent.targetId);
                  }
               }
            }
         }
         return targetsDead;
      }

      private static function groupByElements(pvgroup:Array, pType:int, activeDetails:Boolean=true, pAddDeathInTheSameMsg:Boolean=false, pCastingSpellId:int=-1) : void {
         var previousElement:* = 0;
         var fe:FightEvent = null;
         var fightEventName:String = null;
         var fightEventText:String = null;
         var ttptsStr:String = "";
         var ttpts:int = 0;
         var isSameElement:Boolean = true;
         for each (fe in pvgroup)
         {
            if((!(pCastingSpellId==-1))&&(!(pCastingSpellId==fe.castingSpellId)))
            {
            }
            else
            {
               if((previousElement)&&(!(fe.params[2]==previousElement)))
               {
                  isSameElement=false;
               }
               previousElement=fe.params[2];
               ttpts=ttpts+fe.params[1];
               if(pType==-1)
               {
                  ttptsStr=ttptsStr+(formateColorsForFightDamages(fe.params[1],fe.params[2])+" + ");
               }
               else
               {
                  ttptsStr=ttptsStr+(fe.params[1]+" + ");
               }
            }
         }
         fightEventName=pAddDeathInTheSameMsg?"fightLifeLossAndDeath":pvgroup[0].name;
         var newparams:Array = new Array();
         newparams[0]=pvgroup[0].params[0];
         if(pType==-1)
         {
            fightEventText=formateColorsForFightDamages("-"+ttpts.toString(),isSameElement?previousElement:-1);
         }
         else
         {
            fightEventText=ttpts.toString();
         }
         if((activeDetails)&&(pvgroup.length<1))
         {
            fightEventText=fightEventText+("</b> ("+ttptsStr.substr(0,ttptsStr.length-3)+")<b>");
         }
         newparams[1]=fightEventText;
         KernelEventsManager.getInstance().processCallback(HookList.FightText,fightEventName,newparams,[newparams[0]]);
      }

      private static function groupByTeam(playerTeamId:int, targets:Vector.<int>, pEventList:Vector.<FightEvent>, pEntitiesList:Dictionary, groupPvLostAndDeath:Vector.<int>) : Boolean {
         var event:FightEvent = null;
         var list:Vector.<int> = null;
         var listToConcat:Vector.<FightEvent> = null;
         var evt:FightEvent = null;
         var team:String = null;
         var t:* = undefined;
         if(pEventList.length==0)
         {
            return false;
         }
         var tmpEventList:Vector.<FightEvent> = pEventList.concat();
         while(tmpEventList.length>1)
         {
            listToConcat=getGroupedListEvent(tmpEventList);
            if(listToConcat.length<=1)
            {
            }
            else
            {
               list=new Vector.<int>();
               for each (event in listToConcat)
               {
                  list.push(event.targetId);
               }
               evt=listToConcat[0];
               team=groupEntitiesByTeam(playerTeamId,list,pEntitiesList);
               switch(team)
               {
                  case "all":
                  case "allies":
                  case "enemies":
                     removeEventFromEventsList(pEventList,listToConcat);
                     if((evt.name=="fighterLifeLoss")&&(!(groupPvLostAndDeath.indexOf(listToConcat[0].targetId)==-1)))
                     {
                        sendFightLogToChat(evt,team,null,true,true);
                     }
                     else
                     {
                        sendFightLogToChat(evt,team);
                     }
                     break;
                  case "other":
                     removeEventFromEventsList(pEventList,listToConcat);
                     if((evt.name=="fighterLifeLoss")&&(!(groupPvLostAndDeath.indexOf(listToConcat[0].targetId)==-1)))
                     {
                        sendFightLogToChat(evt,null,list,true,true);
                     }
                     else
                     {
                        sendFightLogToChat(evt,null,list);
                     }
                     break;
                  case "none":
                     trace("probleme de regroupement");
                     break;
                  default:
                     for each (t in pEntitiesList)
                     {
                        if((!(team.indexOf("allies")==-1))&&(t.teamId==playerTeamId)||(!(team.indexOf("enemies")==-1))&&(!(t.teamId==playerTeamId)))
                        {
                           list.splice(list.indexOf(t.contextualId),1);
                        }
                     }
                     removeEventFromEventsList(pEventList,listToConcat);
                     if((evt.name=="fighterLifeLoss")&&(!(groupPvLostAndDeath.indexOf(listToConcat[0].targetId)==-1)))
                     {
                        sendFightLogToChat(evt,team,list,true,true);
                     }
                     else
                     {
                        sendFightLogToChat(evt,team,list);
                     }
               }
            }
         }
         return false;
      }

      public static function getGroupedListEvent(pInEventList:Vector.<FightEvent>) : Vector.<FightEvent> {
         var event:FightEvent = null;
         var baseEvent:FightEvent = pInEventList[0];
         var listToConcat:Vector.<FightEvent> = new Vector.<FightEvent>();
         listToConcat.push(baseEvent);
         for each (event in pInEventList)
         {
            if((listToConcat.indexOf(event)==-1)&&(needToGroupFightEventsData(getNumberOfParametersToCheck(baseEvent),event,baseEvent)))
            {
               listToConcat.push(event);
            }
         }
         removeEventFromEventsList(pInEventList,listToConcat);
         return listToConcat;
      }

      public static function removeEventFromEventsList(pEventList:Vector.<FightEvent>, pListToRemove:Vector.<FightEvent>) : void {
         var event:FightEvent = null;
         for each (event in pListToRemove)
         {
            pEventList.splice(pEventList.indexOf(event),1);
         }
      }

      public static function groupEntitiesByTeam(playerTeamId:int, targetList:Vector.<int>, entitiesList:Dictionary) : String {
         var fighterInfos:GameFightFighterInformations = null;
         var returnData:String = null;
         var alliesCount:int = 0;
         var enemiesCount:int = 0;
         var nbTotalAllies:int = 0;
         var nbTotalEnemies:int = 0;
         for each (fighterInfos in entitiesList)
         {
            if(fighterInfos==null)
            {
            }
            else
            {
               if(fighterInfos.teamId==playerTeamId)
               {
                  nbTotalAllies++;
               }
               else
               {
                  nbTotalEnemies++;
               }
               if((fighterInfos.alive)&&(!(targetList.indexOf(fighterInfos.contextualId)==-1)))
               {
                  if(fighterInfos.teamId==playerTeamId)
                  {
                     alliesCount++;
                  }
                  else
                  {
                     enemiesCount++;
                  }
               }
            }
         }
         returnData="";
         if((nbTotalAllies==alliesCount)&&(nbTotalEnemies==enemiesCount))
         {
            return "all";
         }
         if((alliesCount<1)&&(alliesCount==nbTotalAllies))
         {
            returnData=returnData+((!(returnData=="")?",":"")+"allies");
            if((enemiesCount<0)&&(enemiesCount>nbTotalEnemies))
            {
               returnData=returnData+",other";
            }
         }
         if((enemiesCount<1)&&(enemiesCount==nbTotalEnemies))
         {
            returnData=returnData+((!(returnData=="")?",":"")+"enemies");
            if((alliesCount<0)&&(alliesCount>nbTotalAllies))
            {
               returnData=returnData+",other";
            }
         }
         if((returnData=="")&&(targetList.length<1))
         {
            returnData=returnData+((!(returnData=="")?",":"")+"other");
         }
         return returnData==""?"none":returnData;
      }

      private static function getNumberOfParametersToCheck(baseEvent:FightEvent) : int {
         var numParam:int = baseEvent.params.length;
         if(numParam>baseEvent.checkParams)
         {
            numParam=baseEvent.checkParams;
         }
         return numParam;
      }

      private static function needToGroupFightEventsData(pNbParams:int, pFightEvent:FightEvent, pBaseEvent:FightEvent) : Boolean {
         var paramId:* = 0;
         if(pFightEvent.castingSpellId!=pBaseEvent.castingSpellId)
         {
            return false;
         }
         paramId=pFightEvent.firstParamToCheck;
         while(paramId<pNbParams)
         {
            if(pFightEvent.params[paramId]!=pBaseEvent.params[paramId])
            {
               return false;
            }
            paramId++;
         }
         return true;
      }

      private static function sendAllFightEvents() : void {
         var i:int = _fightEvents.length-1;
         while(i>=0)
         {
            if(_fightEvents[i])
            {
               _log.warn("sending "+_fightEvents[i].name);
               KernelEventsManager.getInstance().processCallback(HookList.FightEvent,_fightEvents[i].name,_fightEvents[i].params,[_fightEvents[i].targetId]);
            }
            i--;
         }
         clearData();
      }

      public static function clearData() : void {
         _fightEvents=new Vector.<FightEvent>();
      }

      private static function sendFightLogToChat(pFightEvent:FightEvent, pTargetsTeam:String="", pTargetsList:Vector.<int>=null, pActiveColoration:Boolean=true, pAddDeathInTheSameMsg:Boolean=false) : void {
         var name:String = (pFightEvent.name==FightEventEnum.FIGHTER_LIFE_LOSS)&&(pAddDeathInTheSameMsg)?"fightLifeLossAndDeath":pFightEvent.name;
         var params:Array = pFightEvent.params;
         if(pActiveColoration)
         {
            if((pFightEvent.name==FightEventEnum.FIGHTER_LIFE_LOSS)||(pFightEvent.name==FightEventEnum.FIGHTER_SHIELD_LOSS))
            {
               params[1]=formateColorsForFightDamages("-"+params[1],params[2]);
            }
         }
         KernelEventsManager.getInstance().processCallback(HookList.FightText,name,params,pTargetsList,pTargetsTeam);
      }

      private static function formateColorsForFightDamages(inText:String, actionId:int) : String {
         var newText:String = null;
         var color:String = "";
         var typeAction:TypeAction = TypeAction.getTypeActionById(actionId);
         var elementId:int = typeAction==null?-1:typeAction.elementId;
         switch(elementId)
         {
            case -1:
               color=XmlConfig.getInstance().getEntry("colors.fight.text.multi");
               break;
            case 0:
               color=XmlConfig.getInstance().getEntry("colors.fight.text.neutral");
               break;
            case 1:
               color=XmlConfig.getInstance().getEntry("colors.fight.text.earth");
               break;
            case 2:
               color=XmlConfig.getInstance().getEntry("colors.fight.text.fire");
               break;
            case 3:
               color=XmlConfig.getInstance().getEntry("colors.fight.text.water");
               break;
            case 4:
               color=XmlConfig.getInstance().getEntry("colors.fight.text.air");
               break;
            case 5:
         }
         color="";
         if(color!="")
         {
            newText=HtmlManager.addTag(inText,HtmlManager.SPAN,{color:color});
         }
         else
         {
            newText=inText;
         }
         return newText;
      }

      public static function get fightEvents() : Vector.<FightEvent> {
         return _fightEvents;
      }

      public static function get events() : Vector.<Vector.<FightEvent>> {
         return _events;
      }

      public static function get joinedEvents() : Vector.<FightEvent> {
         return _joinedEvents;
      }


   }

}