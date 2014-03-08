package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.datacenter.npcs.NpcMessage;
   
   public class QuestStep extends Object implements IDataCenter
   {
      
      public function QuestStep() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(QuestStep));
      
      public static const MODULE:String = "QuestSteps";
      
      private static const REWARD_SCALE_CAP:Number = 1.5;
      
      private static const REWARD_REDUCED_SCALE:Number = 0.7;
      
      public static function getQuestStepById(param1:int) : QuestStep {
         return GameData.getObject(MODULE,param1) as QuestStep;
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
         var _loc1_:uint = 0;
         if(!this._objectives)
         {
            this._objectives = new Vector.<QuestObjective>(this.objectiveIds.length,true);
            _loc1_ = 0;
            while(_loc1_ < this.objectiveIds.length)
            {
               this._objectives[_loc1_] = QuestObjective.getQuestObjectiveById(this.objectiveIds[_loc1_]);
               _loc1_++;
            }
         }
         return this._objectives;
      }
      
      private function initCurrentLevelRewards() : void {
         var _loc2_:uint = 0;
         var _loc3_:QuestStepRewards = null;
         var _loc1_:uint = PlayedCharacterManager.getInstance().infos.level;
         if(this._currentLevelRewards == null || _loc1_ < this._currentLevelRewards.levelMin && !(this._currentLevelRewards.levelMin == -1) || _loc1_ > this._currentLevelRewards.levelMax && !(this._currentLevelRewards.levelMax == -1))
         {
            this._currentLevelRewards = null;
            for each (_loc2_ in this.rewardsIds)
            {
               _loc3_ = QuestStepRewards.getQuestStepRewardsById(_loc2_);
               if((_loc1_ >= _loc3_.levelMin || _loc3_.levelMin == -1) && (_loc1_ <= _loc3_.levelMax || _loc3_.levelMax == -1))
               {
                  this._currentLevelRewards = _loc3_;
                  break;
               }
            }
         }
      }
      
      public function getKamasReward(param1:int) : int {
         var _loc2_:int = this.kamasScaleWithPlayerLevel?param1:this.optimalLevel;
         return (Math.pow(_loc2_,2) + 20 * _loc2_ - 20) * this.kamasRatio * this.duration;
      }
      
      public function getExperienceReward(param1:int, param2:int) : int {
         var _loc4_:* = 0;
         var _loc3_:Number = 1 + param2 / 100;
         if(param1 > this.optimalLevel)
         {
            _loc4_ = Math.min(param1,this.optimalLevel * REWARD_SCALE_CAP);
            return ((1 - REWARD_REDUCED_SCALE) * this.getFixeExperienceReward(this.optimalLevel) + REWARD_REDUCED_SCALE * this.getFixeExperienceReward(_loc4_)) * _loc3_;
         }
         return this.getFixeExperienceReward(param1) * _loc3_;
      }
      
      private function getFixeExperienceReward(param1:int) : int {
         return param1 * Math.pow(100 + 2 * param1,2) / 20 * this.duration * this.xpRatio;
      }
   }
}
