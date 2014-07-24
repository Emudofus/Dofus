package ui
{
   import d2api.ContextMenuApi;
   import d2api.QuestApi;
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.SoundApi;
   import d2api.PlayedCharacterApi;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.Slot;
   import d2components.TextArea;
   import d2components.Texture;
   import d2components.ButtonContainer;
   import d2components.Grid;
   import d2hooks.*;
   import d2actions.*;
   import managers.TutorialStepManager;
   import d2enums.ComponentHookList;
   import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
   
   public class TutorialUi extends Object
   {
      
      public function TutorialUi() {
         super();
      }
      
      public var modCommon:Object;
      
      public var modContextMenu:Object;
      
      public var menuApi:ContextMenuApi;
      
      public var questApi:QuestApi;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var soundApi:SoundApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var ctr_joinTutorial:GraphicContainer;
      
      public var ctr_quest:GraphicContainer;
      
      public var lbl_step:Label;
      
      public var lbl_title:Label;
      
      public var lbl_stepAdvancing:Label;
      
      public var lbl_expRewardValue:Label;
      
      public var lbl_expRewardXp:Label;
      
      public var slot_reward1:Slot;
      
      public var texta_description:TextArea;
      
      public var tx_progressBar:Texture;
      
      public var tx_reward2:Texture;
      
      public var btn_exit:ButtonContainer;
      
      public var btn_joinTutorial:ButtonContainer;
      
      public var ctr_popup:GraphicContainer;
      
      public var lbl_xp:Label;
      
      public var gd_items:Grid;
      
      public var btn_quit:ButtonContainer;
      
      public var btn_continue:ButtonContainer;
      
      public var btn_closePopup:ButtonContainer;
      
      private var _tutorialManager:Object;
      
      private var _questInfo:Object;
      
      private var _quest:Object;
      
      private var _currentStepNumber:uint;
      
      private var _tipsUiClass:Object = null;
      
      public function main(param:Object) : void {
         var xp:* = 0;
         this.sysApi.addHook(QuestStarted,this.onQuestStarted);
         this.sysApi.addHook(QuestStepValidated,this.onQuestStepValidated);
         this.sysApi.addHook(QuestInfosUpdated,this.onQuestInfosUpdated);
         this.sysApi.addHook(GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(GameFightJoin,this.onGameFightJoin);
         this.sysApi.addHook(ExchangeLeave,this.onExchangeLeave);
         this.sysApi.addHook(ExchangeStarted,this.onExchangeStarted);
         this.sysApi.addHook(ExchangeStartOkHumanVendor,this.onExchangeStartOkHumanVendor);
         this.sysApi.addHook(ExchangeShopStockStarted,this.onExchangeShopStockStarted);
         this.sysApi.addHook(ExchangeStartOkNpcTrade,this.onExchangeStartOkNpcTrade);
         this.sysApi.addHook(GameRolePlayPlayerLifeStatus,this.onGameRolePlayPlayerLifeStatus);
         this.sysApi.addHook(TeleportDestinationList,this.onTeleportDestinationList);
         this.sysApi.addHook(ExchangeStartOkCraft,this.onExchangeStartOkCraft);
         this.sysApi.addHook(ExchangeStartOkNpcShop,this.onExchangeStartOkNpcShop);
         this.sysApi.addHook(DocumentReadingBegin,this.onDocumentReadingBegin);
         this.sysApi.addHook(NpcDialogCreation,this.onNpcDialogCreation);
         this.sysApi.addHook(LeaveDialog,this.onLeaveDialog);
         if(this.uiApi.getUi("tips"))
         {
            this._tipsUiClass = this.uiApi.getUi("tips").uiClass;
         }
         else
         {
            this.sysApi.addHook(UiLoaded,this.onUiLoaded);
         }
         this._tutorialManager = TutorialStepManager.getInstance();
         this._tutorialManager.disabled = false;
         if(!this._tutorialManager.preloaded)
         {
            this._tutorialManager.preload();
         }
         this.uiApi.addComponentHook(this.slot_reward1,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.slot_reward1,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.slot_reward1,"onRightClick");
         this.uiApi.addComponentHook(this.slot_reward1,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.gd_items,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_items,ComponentHookList.ON_ITEM_ROLL_OVER);
         this.uiApi.addComponentHook(this.gd_items,ComponentHookList.ON_ITEM_ROLL_OUT);
         if(param[0])
         {
            this.displayTutorial(false);
         }
         else
         {
            this.closeTutorial();
         }
         this.moveDefault();
         if(!this.sysApi.getData("tutoPopupClosed" + this.playerApi.id()))
         {
            this.sysApi.setData("tutoPopupClosed" + this.playerApi.id(),true);
            xp = 60 * this.playerApi.getExperienceBonusPercent() / 100;
            this.lbl_xp.text = this.uiApi.getText("ui.social.xpTaxCollectorGet",xp);
            this.gd_items.dataProvider = this.questApi.getTutorialReward();
            this.ctr_popup.visible = true;
         }
         else
         {
            this.ctr_popup.visible = false;
         }
      }
      
      public function get tutorialDisabled() : Boolean {
         return this._tutorialManager.disabled;
      }
      
      public function get quest() : Object {
         if(!this._quest)
         {
            this._quest = this.dataApi.getQuest(TutorialConstants.QUEST_TUTORIAL_ID);
         }
         return this._quest;
      }
      
      public function unload() : void {
         if((this._tutorialManager) && (!this._tutorialManager.disabled))
         {
            this._tutorialManager.disabled = true;
         }
         var tipsUi:Object = this.getTipsUi();
         if(tipsUi)
         {
            tipsUi.activate();
         }
         if((this.sysApi && this.questApi) && (this.questApi.getRewardableAchievements()) && (this.questApi.getRewardableAchievements().length > 0))
         {
            this.sysApi.dispatchHook(RewardableAchievementsVisible,true);
         }
         if(Api.highlight)
         {
            Api.highlight.stop();
         }
      }
      
      public function onQuestStarted(questId:uint) : void {
         if(questId == TutorialConstants.QUEST_TUTORIAL_ID)
         {
            this.sysApi.sendAction(new QuestInfosRequest(TutorialConstants.QUEST_TUTORIAL_ID));
         }
      }
      
      public function moveLeft() : void {
         this.ctr_quest.x = 5;
         this.ctr_quest.y = 35;
      }
      
      public function moveDefault() : void {
         this.ctr_quest.x = 850;
         this.ctr_quest.y = 35;
      }
      
      private function onQuestInfosUpdated(questId:uint, infosAvailable:Boolean) : void {
         var stepId:uint = 0;
         if((questId == TutorialConstants.QUEST_TUTORIAL_ID) && (infosAvailable) && (this._tutorialManager.disabled == false))
         {
            if((this.questApi.getRewardableAchievements()) && (this.questApi.getRewardableAchievements().length > 0))
            {
               this.sysApi.dispatchHook(RewardableAchievementsVisible,false);
            }
            this._questInfo = this.questApi.getQuestInformations(questId);
            this._quest = this.dataApi.getQuest(this._questInfo.questId);
            this._currentStepNumber = 0;
            for each(stepId in this.quest.stepIds)
            {
               if(stepId == this._questInfo.stepId)
               {
                  break;
               }
               this._currentStepNumber++;
            }
            this._tutorialManager.jumpToStep(this._currentStepNumber);
            this.setStep(this._currentStepNumber);
            this.ctr_quest.visible = this.visible;
         }
      }
      
      private function onQuestStepValidated(questId:uint, stepId:uint) : void {
         if(questId == TutorialConstants.QUEST_TUTORIAL_ID)
         {
            this._currentStepNumber++;
            this.setStep(this._currentStepNumber);
            this._tutorialManager.jumpToStep(this._currentStepNumber);
         }
      }
      
      private function onUiLoaded(name:String) : void {
         var tipsUi:Object = null;
         if((name == "tips") && (!this._tutorialManager.disabled))
         {
            tipsUi = this.getTipsUi();
            if(tipsUi)
            {
               tipsUi.deactivate();
            }
         }
         this.sysApi.dispatchHook(RewardableAchievementsVisible,false);
      }
      
      private function setStep(stepCount:int) : void {
         var iw:Object = null;
         var steps:Object = this.quest.stepIds;
         var stepId:uint = steps[stepCount];
         var step:Object = this.dataApi.getQuestStep(stepId);
         this.lbl_title.text = step.name;
         this.texta_description.text = step.description;
         var maxSteps:int = steps.length;
         this.lbl_step.text = String(stepCount + 1);
         this.lbl_stepAdvancing.text = this.uiApi.getText("ui.grimoire.quest.step") + " " + (stepCount + 1) + "/" + maxSteps;
         this.tx_progressBar.gotoAndStop = stepCount + 2;
         if(step.experienceReward > 0)
         {
            this.tx_reward2.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "tutorial_tx_backgroundExp");
            this.lbl_expRewardValue.text = step.experienceReward;
            this.lbl_expRewardValue.visible = true;
            this.lbl_expRewardXp.visible = true;
         }
         else
         {
            this.tx_reward2.uri = this.uiApi.createUri(this.uiApi.me().getConstant("emptySlot_uri"));
            this.lbl_expRewardValue.visible = false;
            this.lbl_expRewardXp.visible = false;
         }
         if((step.itemsReward) && (step.itemsReward.length > 0))
         {
            iw = this.dataApi.getItemWrapper(step.itemsReward[0][0]);
            this.slot_reward1.data = iw;
         }
         else
         {
            this.slot_reward1.data = null;
         }
      }
      
      public function onRollOver(target:Object) : void {
         switch(target)
         {
            case this.slot_reward1:
               if(target.data)
               {
                  this.uiApi.showTooltip(target.data,target,false,"standard",0,2,3,null,null,
                     {
                        "showEffects":true,
                        "header":true,
                        "averagePrice":false
                     },"ItemInfo" + target.data.objectGID);
               }
               break;
            case this.btn_joinTutorial:
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.tutorial.joinTutorialTooltip")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
               break;
            case this.btn_exit:
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.tutorial.leaveTutorialTooltip")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
               break;
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRightClick(target:Object) : void {
         var data:Object = null;
         var contextMenu:Object = null;
         if(target == this.slot_reward1)
         {
            data = target.data;
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_joinTutorial:
               this.modCommon.openPopup(this.uiApi.getText("ui.tutorial.tutorial"),this.uiApi.getText("ui.tutorial.joinTutorialPopup"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onJoinTutorial,this.nullFunction],this.onJoinTutorial,this.nullFunction);
               break;
            case this.btn_exit:
            case this.btn_quit:
               this.ctr_popup.visible = false;
               this.modCommon.openPopup(this.uiApi.getText("ui.tutorial.tutorial"),this.uiApi.getText("ui.tutorial.closeTutorialPopup"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onCloseTutorial,this.nullFunction],this.onCloseTutorial,this.nullFunction);
               break;
            case this.slot_reward1:
               if(!this.sysApi.getOption("displayTooltips","dofus"))
               {
                  this.sysApi.dispatchHook(ShowObjectLinked,this.slot_reward1.data);
               }
               break;
            case this.btn_continue:
            case this.btn_closePopup:
               this.ctr_popup.visible = false;
               break;
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if(target == this.gd_items)
         {
            if(selectMethod != GridItemSelectMethodEnum.AUTO)
            {
               if(!this.sysApi.getOption("displayTooltips","dofus"))
               {
                  this.sysApi.dispatchHook(ShowObjectLinked,this.gd_items.selectedItem);
               }
            }
         }
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
         if(item.data)
         {
            this.uiApi.showTooltip(item.data,item.container,false,"standard",8,0,0,"itemName",null,
               {
                  "showEffects":true,
                  "header":true
               },"ItemInfo");
         }
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onJoinTutorial() : void {
         this.sysApi.sendAction(new GuidedModeReturnRequest());
         this.sysApi.dispatchHook(RewardableAchievementsVisible,false);
      }
      
      public function onCloseTutorial() : void {
         this.sysApi.sendAction(new GuidedModeQuitRequest());
         if(this.questApi.getRewardableAchievements().length > 0)
         {
            this.sysApi.dispatchHook(RewardableAchievementsVisible,true);
         }
      }
      
      public function displayTutorial(visible:Boolean = true) : void {
         this.sysApi.sendAction(new QuestInfosRequest(TutorialConstants.QUEST_TUTORIAL_ID));
         this.ctr_joinTutorial.visible = false;
         this.ctr_quest.visible = visible;
         this._tutorialManager.disabled = false;
         var tipsUi:Object = this.getTipsUi();
         if(tipsUi)
         {
            tipsUi.deactivate();
         }
      }
      
      public function get visible() : Boolean {
         return !this._tutorialManager.disabled;
      }
      
      public function closeTutorial() : void {
         this.ctr_quest.visible = false;
         this.ctr_joinTutorial.visible = true;
         this._tutorialManager.disabled = true;
         var tipsUi:Object = this.getTipsUi();
         if(tipsUi)
         {
            tipsUi.activate();
         }
         Api.highlight.stop();
      }
      
      private function getTipsUi() : Object {
         var tipsUi:Object = this.uiApi.getUi("tips");
         if(tipsUi)
         {
            this._tipsUiClass = tipsUi.uiClass;
            if(this._tipsUiClass)
            {
               return this._tipsUiClass;
            }
         }
         return null;
      }
      
      public function nullFunction() : void {
      }
      
      public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:int, fightType:int) : void {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.visible = false;
         }
         this.btn_exit.disabled = true;
      }
      
      public function onGameFightEnd(params:Object) : void {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.visible = true;
         }
         this.btn_exit.disabled = false;
      }
      
      public function onNpcDialogCreation(mapId:int, npcId:int, look:Object) : void {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      public function onLeaveDialog() : void {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = false;
         }
      }
      
      private function onExchangeStarted(pSourceName:String, pTargetName:String, pSourceLook:Object, pTargetLook:Object, pSourceCurrentPods:int, pTargetCurrentPods:int, pSourceMaxPods:int, pTargetMaxPods:int, otherId:int) : void {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onExchangeLeave(success:Boolean) : void {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = false;
         }
      }
      
      private function onExchangeStartOkHumanVendor(vendorName:String, shopStock:Object) : void {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onExchangeShopStockStarted(shopStock:Object) : void {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onExchangeStartOkNpcShop(pNCPSellerId:int, pObjects:Object, pLook:Object, tokenId:int) : void {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onExchangeStartOkNpcTrade(pNPCId:uint, pSourceName:String, pTargetName:String, pSourceLook:Object, pTargetLook:Object) : void {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onDocumentReadingBegin(documentId:uint) : void {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onTeleportDestinationList(teleportList:Object, tpType:uint) : void {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onExchangeStartOkCraft(recipes:Object, skillId:uint, nbCase:uint) : void {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onGameRolePlayPlayerLifeStatus(status:uint, hardcore:uint) : void {
         if(hardcore == 0)
         {
            switch(status)
            {
               case 0:
                  if(this._tutorialManager.disabled)
                  {
                     this.ctr_joinTutorial.disabled = false;
                  }
                  break;
               case 1:
                  if(this._tutorialManager.disabled)
                  {
                     this.ctr_joinTutorial.disabled = true;
                  }
                  break;
               case 2:
                  if(this._tutorialManager.disabled)
                  {
                     this.ctr_joinTutorial.disabled = true;
                  }
                  break;
            }
         }
      }
   }
}
