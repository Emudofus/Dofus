package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.data.UiModule;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementRewardable;
   import com.ankamagames.dofus.datacenter.quest.AchievementObjective;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class QuestApi extends Object implements IApi
   {
      
      public function QuestApi() {
         this._log = Log.getLogger(getQualifiedClassName(QuestApi));
         super();
      }
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      public function set module(param1:UiModule) : void {
         this._module = param1;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function getQuestInformations(param1:int) : Object {
         return this.getQuestFrame().getQuestInformations(param1);
      }
      
      public function getAllQuests() : Vector.<Object> {
         var _loc3_:QuestActiveInformations = null;
         var _loc4_:Vector.<uint> = null;
         var _loc5_:uint = 0;
         var _loc1_:Vector.<Object> = new Vector.<Object>(0,false);
         var _loc2_:Vector.<QuestActiveInformations> = this.getQuestFrame().getActiveQuests();
         for each (_loc3_ in _loc2_)
         {
            _loc1_.push(
               {
                  "id":_loc3_.questId,
                  "status":true
               });
         }
         _loc4_ = this.getQuestFrame().getCompletedQuests();
         for each (_loc5_ in _loc4_)
         {
            _loc1_.push(
               {
                  "id":_loc5_,
                  "status":false
               });
         }
         return _loc1_;
      }
      
      public function getActiveQuests() : Vector.<uint> {
         var _loc3_:QuestActiveInformations = null;
         var _loc1_:Vector.<uint> = new Vector.<uint>();
         var _loc2_:Vector.<QuestActiveInformations> = this.getQuestFrame().getActiveQuests();
         for each (_loc3_ in _loc2_)
         {
            _loc1_.push(_loc3_.questId);
         }
         return _loc1_;
      }
      
      public function getCompletedQuests() : Vector.<uint> {
         return this.getQuestFrame().getCompletedQuests();
      }
      
      public function getAllQuestsOrderByCategory(param1:Boolean=false) : Array {
         var _loc3_:Quest = null;
         var _loc4_:QuestActiveInformations = null;
         var _loc6_:Object = null;
         var _loc9_:uint = 0;
         var _loc10_:Vector.<uint> = null;
         var _loc2_:Array = new Array();
         var _loc5_:* = 0;
         var _loc7_:uint = 0;
         var _loc8_:Vector.<QuestActiveInformations> = this.getQuestFrame().getActiveQuests();
         _loc5_ = _loc5_ + _loc8_.length;
         for each (_loc4_ in _loc8_)
         {
            _loc3_ = Quest.getQuestById(_loc4_.questId);
            _loc7_ = _loc3_.category.order;
            if(_loc7_ > _loc2_.length || !_loc2_[_loc7_])
            {
               _loc6_ = new Object();
               _loc6_.data = new Array();
               _loc6_.id = _loc3_.categoryId;
               _loc2_[_loc7_] = _loc6_;
            }
            _loc2_[_loc7_].data.push(
               {
                  "id":_loc4_.questId,
                  "status":true
               });
         }
         if(param1)
         {
            _loc10_ = this.getQuestFrame().getCompletedQuests();
            _loc5_ = _loc5_ + _loc10_.length;
            for each (_loc9_ in _loc10_)
            {
               _loc3_ = Quest.getQuestById(_loc9_);
               _loc7_ = _loc3_.category.order;
               if(_loc7_ > _loc2_.length || !_loc2_[_loc7_])
               {
                  _loc6_ = new Object();
                  _loc6_.data = new Array();
                  _loc6_.id = _loc3_.categoryId;
                  _loc2_[_loc7_] = _loc6_;
               }
               _loc2_[_loc7_].data.push(
                  {
                     "id":_loc9_,
                     "status":false
                  });
            }
         }
         return _loc2_;
      }
      
      public function getTutorialReward() : Vector.<ItemWrapper> {
         var _loc1_:Vector.<ItemWrapper> = new Vector.<ItemWrapper>();
         _loc1_.push(ItemWrapper.create(0,0,10785,1,null,false));
         _loc1_.push(ItemWrapper.create(0,0,10794,1,null,false));
         _loc1_.push(ItemWrapper.create(0,0,10797,1,null,false));
         _loc1_.push(ItemWrapper.create(0,0,10798,1,null,false));
         _loc1_.push(ItemWrapper.create(0,0,10799,1,null,false));
         _loc1_.push(ItemWrapper.create(0,0,10784,1,null,false));
         _loc1_.push(ItemWrapper.create(0,0,10800,1,null,false));
         _loc1_.push(ItemWrapper.create(0,0,10801,1,null,false));
         _loc1_.push(ItemWrapper.create(0,0,10792,1,null,false));
         _loc1_.push(ItemWrapper.create(0,0,10793,2,null,false));
         _loc1_.push(ItemWrapper.create(0,0,10795,1,null,false));
         _loc1_.push(ItemWrapper.create(0,0,10796,1,null,false));
         return _loc1_;
      }
      
      public function getNotificationList() : Array {
         return QuestFrame.notificationList;
      }
      
      public function getFinishedAchievementsIds() : Vector.<uint> {
         return this.getQuestFrame().finishedAchievementsIds;
      }
      
      public function isAchievementFinished(param1:int) : Boolean {
         return !(this.getQuestFrame().finishedAchievementsIds.indexOf(param1) == -1);
      }
      
      public function getAchievementKamasReward(param1:Achievement, param2:int=0) : Number {
         if(param2 == 0)
         {
            param2 = PlayedCharacterManager.getInstance().infos.level;
         }
         return param1.getKamasReward(param2);
      }
      
      public function getAchievementExperienceReward(param1:Achievement, param2:int=0) : Number {
         if(param2 == 0)
         {
            param2 = PlayedCharacterManager.getInstance().infos.level;
         }
         return param1.getExperienceReward(param2,PlayedCharacterManager.getInstance().experiencePercent);
      }
      
      public function getRewardableAchievements() : Vector.<AchievementRewardable> {
         return this.getQuestFrame().rewardableAchievements;
      }
      
      public function getAchievementObjectivesNames(param1:int) : String {
         var _loc4_:* = 0;
         var _loc5_:AchievementObjective = null;
         var _loc2_:* = "-";
         var _loc3_:Achievement = Achievement.getAchievementById(param1);
         for each (_loc4_ in _loc3_.objectiveIds)
         {
            _loc5_ = AchievementObjective.getAchievementObjectiveById(_loc4_);
            if((_loc5_) && (_loc5_.name))
            {
               _loc2_ = _loc2_ + (" " + StringUtils.noAccent(_loc5_.name).toLowerCase());
            }
         }
         return _loc2_;
      }
      
      private function getQuestFrame() : QuestFrame {
         return Kernel.getWorker().getFrame(QuestFrame) as QuestFrame;
      }
   }
}
