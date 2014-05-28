package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.datacenter.npcs.NpcMessage;
   
   public class QuestStep extends Object implements IDataCenter
   {
      
      public function QuestStep() {
         super();
      }
      
      protected static const _log:Logger;
      
      public static const MODULE:String = "QuestSteps";
      
      private static const REWARD_SCALE_CAP:Number = 1.5;
      
      private static const REWARD_REDUCED_SCALE:Number = 0.7;
      
      public static function getQuestStepById(id:int) : QuestStep {
         return GameData.getObject(MODULE,id) as QuestStep;
      }
      
      public static function getQuestSteps() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var questId:uint;
      
      public var nameId:uint;
      
      public var descriptionId:uint;
      
      public var dialogId:int;
      
      public var optimalLevel:uint;
      
      public var duration:Number;
      
      public var kamasScaleWithPlayerLevel:Boolean;
      
      public var kamasRatio:Number;
      
      public var xpRatio:Number;
      
      public function get experienceReward() : uint {
         return this.getExperienceReward(PlayedCharacterManager.getInstance().infos.level,PlayedCharacterManager.getInstance().experiencePercent);
      }
      
      public function get kamasReward() : uint {
         return this.getKamasReward(PlayedCharacterManager.getInstance().infos.level);
      }
      
      public function get itemsReward() : Vector.<Vector.<uint>> {
         this.initCurrentLevelRewards();
         return this._currentLevelRewards == null?null:this._currentLevelRewards.itemsReward;
      }
      
      public function get emotesReward() : Vector.<uint> {
         this.initCurrentLevelRewards();
         return this._currentLevelRewards == null?null:this._currentLevelRewards.emotesReward;
      }
      
      public function get jobsReward() : Vector.<uint> {
         this.initCurrentLevelRewards();
         return this._currentLevelRewards == null?null:this._currentLevelRewards.jobsReward;
      }
      
      public function get spellsReward() : Vector.<uint> {
         this.initCurrentLevelRewards();
         return this._currentLevelRewards == null?null:this._currentLevelRewards.spellsReward;
      }
      
      private var _currentLevelRewards:QuestStepRewards;
      
      public var objectiveIds:Vector.<uint>;
      
      public var rewardsIds:Vector.<uint>;
      
      private var _name:String;
      
      private var _description:String;
      
      private var _dialog:String;
      
      private var _objectives:Vector.<QuestObjective>;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get description() : String {
         if(!this._description)
         {
            this._description = I18n.getText(this.descriptionId);
         }
         return this._description;
      }
      
      public function get dialog() : String {
         if(this.dialogId < 1)
         {
            return "";
         }
         if(!this._dialog)
         {
            this._dialog = NpcMessage.getNpcMessageById(this.dialogId).message;
         }
         return this._dialog;
      }
      
      public function get objectives() : Vector.<QuestObjective> {
         var i:uint = 0;
         if(!this._objectives)
         {
            this._objectives = new Vector.<QuestObjective>(this.objectiveIds.length,true);
            i = 0;
            while(i < this.objectiveIds.length)
            {
               this._objectives[i] = QuestObjective.getQuestObjectiveById(this.objectiveIds[i]);
               i++;
            }
         }
         return this._objectives;
      }
      
      private function initCurrentLevelRewards() : void {
         var rewardsId:uint = 0;
         var rewards:QuestStepRewards = null;
         var playerLvl:uint = PlayedCharacterManager.getInstance().infos.level;
         if((this._currentLevelRewards == null) || (playerLvl < this._currentLevelRewards.levelMin) && (!(this._currentLevelRewards.levelMin == -1)) || (playerLvl > this._currentLevelRewards.levelMax) && (!(this._currentLevelRewards.levelMax == -1)))
         {
            this._currentLevelRewards = null;
            for each(rewardsId in this.rewardsIds)
            {
               rewards = QuestStepRewards.getQuestStepRewardsById(rewardsId);
               if(((playerLvl >= rewards.levelMin) || (rewards.levelMin == -1)) && ((playerLvl <= rewards.levelMax) || (rewards.levelMax == -1)))
               {
                  this._currentLevelRewards = rewards;
                  break;
               }
            }
         }
      }
      
      public function getKamasReward(pPlayerLevel:int) : int {
         var lvl:int = this.kamasScaleWithPlayerLevel?pPlayerLevel:this.optimalLevel;
         return (Math.pow(lvl,2) + 20 * lvl - 20) * this.kamasRatio * this.duration;
      }
      
      public function getExperienceReward(pPlayerLevel:int, pXpBonus:int) : int {
         var rewLevel:* = 0;
         var xpBonus:Number = 1 + pXpBonus / 100;
         if(pPlayerLevel > this.optimalLevel)
         {
            rewLevel = Math.min(pPlayerLevel,this.optimalLevel * REWARD_SCALE_CAP);
            return ((1 - REWARD_REDUCED_SCALE) * this.getFixeExperienceReward(this.optimalLevel) + REWARD_REDUCED_SCALE * this.getFixeExperienceReward(rewLevel)) * xpBonus;
         }
         return this.getFixeExperienceReward(pPlayerLevel) * xpBonus;
      }
      
      private function getFixeExperienceReward(level:int) : int {
         return level * Math.pow(100 + 2 * level,2) / 20 * this.duration * this.xpRatio;
      }
   }
}
