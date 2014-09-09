package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestInfosRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenInventoryAction;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.dofus.network.enums.StatisticTypeEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.dofus.logic.game.common.actions.quest.GuidedModeQuitRequestAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightReadyAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightSpellCastAction;
   import com.ankamagames.dofus.logic.game.common.actions.GameContextQuitAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.NpcDialogReplyAction;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.berilia.api.ReadOnlyObject;
   import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   
   public class TutorialStats extends Object implements IUiStats
   {
      
      public function TutorialStats(pUi:UiRootContainer) {
         super();
         if(!pUi.getElement("ctr_joinTutorial").visible)
         {
            this.initTutorial();
         }
      }
      
      private static const _log:Logger;
      
      private static const START_QUEST_ID:uint = 489;
      
      private var _init:Boolean;
      
      private var _arrivalAction:StatsAction;
      
      private var _quitAction:StatsAction;
      
      public function process(pMessage:Message) : void {
         var mcmsg:MouseClickMessage = null;
         var qiraction:QuestInfosRequestAction = null;
         var oiaction:OpenInventoryAction = null;
         var simsg:SelectItemMessage = null;
         var grid:Grid = null;
         switch(true)
         {
            case pMessage is MouseClickMessage:
               mcmsg = pMessage as MouseClickMessage;
               switch(mcmsg.target.name)
               {
                  case "btn_continue":
                  case "btn_closePopup":
                     this.getStepAction(1042).restart();
                     break;
               }
               break;
            case pMessage is QuestInfosRequestAction:
               qiraction = pMessage as QuestInfosRequestAction;
               if(qiraction.questId == START_QUEST_ID)
               {
                  this.initTutorial();
               }
               break;
            case pMessage is GuidedModeQuitRequestAction:
               if(this._quitAction)
               {
                  this._quitAction.updateTimestamp();
                  this._quitAction.send();
               }
               this._init = false;
               break;
            case pMessage is OpenInventoryAction:
               oiaction = pMessage as OpenInventoryAction;
               if((oiaction.behavior == "bag") && (StatsAction.exists(StatisticTypeEnum.STEP0820_CLIC_BAG)))
               {
                  StatsAction.get(StatisticTypeEnum.STEP0820_CLIC_BAG).send();
                  StatsAction.get(StatisticTypeEnum.STEP0840_CLIC_RING).start();
               }
               break;
            case pMessage is SelectItemMessage:
               simsg = pMessage as SelectItemMessage;
               if(simsg.target is Grid)
               {
                  grid = simsg.target as Grid;
                  if((grid.selectedItem is ItemWrapper) && (!(simsg.selectMethod == SelectMethodEnum.AUTO)) && (grid.selectedItem.objectGID == 10785) && (StatsAction.exists(StatisticTypeEnum.STEP0840_CLIC_RING)))
                  {
                     StatsAction.get(StatisticTypeEnum.STEP0840_CLIC_RING).send();
                     StatsAction.get(StatisticTypeEnum.STEP0860_EQUIP_RING).start();
                  }
               }
               break;
            case pMessage is GameFightReadyAction:
               if(StatsAction.exists(StatisticTypeEnum.STEP1160_CLIC_READY))
               {
                  StatsAction.get(StatisticTypeEnum.STEP1160_CLIC_READY).send();
               }
               break;
            case pMessage is GameFightSpellCastAction:
               if(StatsAction.exists(StatisticTypeEnum.STEP1930_CHOSE_SPELL))
               {
                  StatsAction.get(StatisticTypeEnum.STEP1930_CHOSE_SPELL).send();
                  StatsAction.get(StatisticTypeEnum.STEP1960_USE_SPELL).start();
               }
               break;
            case pMessage is GameContextQuitAction:
               if(StatsAction.exists(StatisticTypeEnum.STEP2100_TUTO10_WIN_FIGHT))
               {
                  StatsAction.get(StatisticTypeEnum.STEP2050_TUTO10_LOSE_FIGHT).start();
                  StatsAction.get(StatisticTypeEnum.STEP2050_TUTO10_LOSE_FIGHT).send();
               }
               break;
            case pMessage is NpcDialogReplyAction:
               if(StatsAction.exists(StatisticTypeEnum.STEP2260_ACCEPT_MISSION))
               {
                  StatsAction.get(StatisticTypeEnum.STEP2260_ACCEPT_MISSION).send();
               }
               else if(StatsAction.exists(StatisticTypeEnum.STEP2640_END_DIALOG))
               {
                  StatsAction.get(StatisticTypeEnum.STEP2640_END_DIALOG).send();
               }
               
               break;
         }
      }
      
      public function onHook(pHook:Hook, pArgs:Array) : void {
         var stepDone:uint = 0;
         var item:ItemWrapper = null;
         var obj:ReadOnlyObject = null;
         var questFrame:QuestFrame = null;
         var currentQuestInfo:Object = null;
         var quest:Quest = null;
         var count:uint = 0;
         var i:* = 0;
         var nbSteps:uint = 0;
         var nextStepId:uint = 0;
         switch(pHook.name)
         {
            case QuestHookList.QuestInfosUpdated.name:
               if((pArgs[0] == START_QUEST_ID) && (pArgs[1] == true))
               {
                  questFrame = Kernel.getWorker().getFrame(QuestFrame) as QuestFrame;
                  currentQuestInfo = questFrame.getQuestInformations(START_QUEST_ID);
                  this.getStepAction(currentQuestInfo.stepId).start();
                  this.startSubSteps(currentQuestInfo.stepId);
               }
               break;
            case QuestHookList.QuestStepValidated.name:
               stepDone = pArgs[1];
               if(pArgs[0] == START_QUEST_ID)
               {
                  this.getStepAction(stepDone).send();
                  if(stepDone == 1046)
                  {
                     this.getStepAction(1051).start();
                  }
                  if(stepDone == 1060)
                  {
                     StatsAction.get(StatisticTypeEnum.STEP2350_EXIT_BAG).start();
                  }
                  quest = Quest.getQuestById(pArgs[0]);
                  nbSteps = quest.stepIds.length;
                  i = 0;
                  while(i < nbSteps)
                  {
                     if(quest.stepIds[i] == stepDone)
                     {
                        break;
                     }
                     i++;
                  }
                  if(i + 1 < nbSteps)
                  {
                     nextStepId = quest.stepIds[i + 1];
                     this.getStepAction(nextStepId).start();
                     this.startSubSteps(nextStepId);
                  }
               }
               break;
            case QuestHookList.QuestValidated.name:
               if(pArgs[0] == START_QUEST_ID)
               {
                  this.getStepAction(1059).send();
               }
               break;
            case InventoryHookList.EquipmentObjectMove.name:
               item = pArgs[0];
               if((item.objectGID == 10785) && (StatsAction.exists(StatisticTypeEnum.STEP0860_EQUIP_RING)))
               {
                  StatsAction.get(StatisticTypeEnum.STEP0860_EQUIP_RING).send();
                  StatsAction.get(StatisticTypeEnum.STEP0860_EXIT_BAG).start();
               }
               break;
            case BeriliaHookList.UiUnloaded.name:
               if(pArgs[0] == "storage")
               {
                  if(StatsAction.exists(StatisticTypeEnum.STEP0860_EXIT_BAG))
                  {
                     StatsAction.get(StatisticTypeEnum.STEP0860_EXIT_BAG).send();
                  }
                  else if(StatsAction.exists(StatisticTypeEnum.STEP2350_EXIT_BAG))
                  {
                     StatsAction.get(StatisticTypeEnum.STEP2350_EXIT_BAG).send();
                  }
                  
               }
               break;
            case FightHookList.GameEntityDisposition.name:
               if(pArgs[0] == PlayedCharacterManager.getInstance().id)
               {
                  if(StatsAction.exists(StatisticTypeEnum.STEP1130_CHOSE_POSITION))
                  {
                     StatsAction.get(StatisticTypeEnum.STEP1130_CHOSE_POSITION).send();
                     StatsAction.get(StatisticTypeEnum.STEP1160_CLIC_READY).start();
                  }
                  else if(StatsAction.exists(StatisticTypeEnum.STEP1100_TUTO6_CHOSE_START_POSITION))
                  {
                     StatsAction.get(StatisticTypeEnum.STEP1130_CHOSE_POSITION).start();
                     StatsAction.get(StatisticTypeEnum.STEP1130_CHOSE_POSITION).send();
                  }
                  
               }
               break;
            case TriggerHookList.FightSpellCast.name:
               if(StatsAction.exists(StatisticTypeEnum.STEP1960_USE_SPELL))
               {
                  StatsAction.get(StatisticTypeEnum.STEP1960_USE_SPELL).send();
               }
               break;
            case CustomUiHookList.OpeningContextMenu.name:
               if((!(pArgs[0].makerName == "player")) && (StatsAction.exists(StatisticTypeEnum.STEP2220_CLIC_YAKASI)))
               {
                  StatsAction.get(StatisticTypeEnum.STEP2220_CLIC_YAKASI).send();
                  StatsAction.get(StatisticTypeEnum.STEP2240_TALK_YAKASI).start();
               }
               else if((!(pArgs[0].makerName == "player")) && (StatsAction.exists(StatisticTypeEnum.STEP2620_CLIC_YAKASI)))
               {
                  StatsAction.get(StatisticTypeEnum.STEP2620_CLIC_YAKASI).send();
                  StatsAction.get(StatisticTypeEnum.STEP2640_END_DIALOG).start();
               }
               
               break;
            case RoleplayHookList.NpcDialogCreation.name:
               if(StatsAction.exists(StatisticTypeEnum.STEP2240_TALK_YAKASI))
               {
                  StatsAction.get(StatisticTypeEnum.STEP2240_TALK_YAKASI).send();
                  StatsAction.get(StatisticTypeEnum.STEP2260_ACCEPT_MISSION).start();
               }
               break;
            case BeriliaHookList.MouseClick.name:
               obj = pArgs[0] as ReadOnlyObject;
               if((obj) && (obj.simplyfiedQualifiedClassName == "FrustumShape") && (StatsAction.exists(StatisticTypeEnum.STEP2430_GO_TO_NEXT_MAP)))
               {
                  StatsAction.get(StatisticTypeEnum.STEP2430_GO_TO_NEXT_MAP).send();
                  StatsAction.get(StatisticTypeEnum.STEP2460_CLIC_MONSTER).start();
               }
               else if((obj) && (obj.simplyfiedQualifiedClassName == "AnimatedCharacter") && (!(pArgs[0].id == PlayedCharacterManager.getInstance().id)))
               {
                  if(StatsAction.exists(StatisticTypeEnum.STEP2460_CLIC_MONSTER))
                  {
                     StatsAction.get(StatisticTypeEnum.STEP2460_CLIC_MONSTER).send();
                  }
               }
               
               break;
         }
      }
      
      private function initTutorial() : void {
         if(!this._init)
         {
            this._arrivalAction = StatsAction.get(StatisticTypeEnum.STEP0500_ARRIVES_ON_TUTORIAL);
            this._arrivalAction.start();
            this._arrivalAction.send();
            this._quitAction = StatsAction.get(StatisticTypeEnum.STEP0550_QUITS_TUTORIAL);
            this._quitAction.start();
            this.getStepAction(1059).start();
            this._init = true;
         }
      }
      
      private function getStepAction(pStepId:uint) : StatsAction {
         var action:StatsAction = null;
         switch(pStepId)
         {
            case 1042:
               action = StatsAction.get(StatisticTypeEnum.STEP0600_TUTO1_MOVE_MAP,true);
               break;
            case 1043:
               action = StatsAction.get(StatisticTypeEnum.STEP0700_TUTO2_TALK_TO_YAKASI,true);
               break;
            case 1044:
               action = StatsAction.get(StatisticTypeEnum.STEP0800_TUTO3_EQUIP_RING,true);
               break;
            case 1045:
               action = StatsAction.get(StatisticTypeEnum.STEP0900_TUTO4_CHANGE_MAP,true);
               break;
            case 1046:
               action = StatsAction.get(StatisticTypeEnum.STEP1000_TUTO5_START_FIRST_FIGHT,true);
               break;
            case 1047:
               action = StatsAction.get(StatisticTypeEnum.STEP1100_TUTO6_CHOSE_START_POSITION,true);
               break;
            case 1048:
               action = StatsAction.get(StatisticTypeEnum.STEP1200_TUTO7_MOVE_IN_FIGHT,true);
               break;
            case 1049:
               action = StatsAction.get(StatisticTypeEnum.STEP1900_TUTO8_USE_SPELL,true);
               break;
            case 1050:
               action = StatsAction.get(StatisticTypeEnum.STEP2000_TUTO9_END_TURN,true);
               break;
            case 1051:
               action = StatsAction.get(StatisticTypeEnum.STEP2100_TUTO10_WIN_FIGHT,true);
               break;
            case 1052:
               action = StatsAction.get(StatisticTypeEnum.STEP2200_TUTO11_START_FIRST_QUEST,true);
               break;
            case 1060:
               action = StatsAction.get(StatisticTypeEnum.STEP2300_TUTO12_EQUIP_SET,true);
               break;
            case 1053:
               action = StatsAction.get(StatisticTypeEnum.STEP2400_TUTO13_LETS_KILL_MONSTER,true);
               break;
            case 1061:
               action = StatsAction.get(StatisticTypeEnum.STEP2500_TUTO14_END_SECOND_FIGHT,true);
               break;
            case 1059:
               action = StatsAction.get(StatisticTypeEnum.STEP2600_TUTO15_END_TUTO,true);
               break;
         }
         return action;
      }
      
      private function startSubSteps(pStepId:uint) : void {
         switch(pStepId)
         {
            case 1044:
               StatsAction.get(StatisticTypeEnum.STEP0820_CLIC_BAG).start();
               break;
            case 1047:
               StatsAction.get(StatisticTypeEnum.STEP1130_CHOSE_POSITION).start();
               break;
            case 1049:
               StatsAction.get(StatisticTypeEnum.STEP1930_CHOSE_SPELL).start();
               break;
            case 1052:
               StatsAction.get(StatisticTypeEnum.STEP2220_CLIC_YAKASI).start();
               break;
            case 1053:
               StatsAction.get(StatisticTypeEnum.STEP2430_GO_TO_NEXT_MAP).start();
               break;
            case 1059:
               StatsAction.get(StatisticTypeEnum.STEP2620_CLIC_YAKASI).start();
               break;
         }
      }
      
      public function remove() : void {
      }
   }
}
