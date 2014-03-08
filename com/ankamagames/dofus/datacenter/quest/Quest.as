package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.GameRolePlayNpcQuestFlag;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class Quest extends Object implements IDataCenter
   {
      
      public function Quest() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Quest));
      
      public static const MODULE:String = "Quests";
      
      public static function getQuestById(param1:int) : Quest {
         return GameData.getObject(MODULE,param1) as Quest;
      }
      
      public static function getQuests() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public static function getFirstValidQuest(param1:GameRolePlayNpcQuestFlag) : Quest {
         var _loc2_:Quest = null;
         var _loc4_:Quest = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc3_:* = 0;
         for each (_loc5_ in param1.questsToValidId)
         {
            _loc4_ = Quest.getQuestById(_loc5_);
            if(_loc4_ != null)
            {
               _loc6_ = _loc4_.getPriorityValue();
               if(_loc3_ < _loc6_ || _loc2_ == null)
               {
                  _loc2_ = _loc4_;
                  _loc3_ = _loc6_;
               }
            }
         }
         for each (_loc5_ in param1.questsToStartId)
         {
            _loc4_ = Quest.getQuestById(_loc5_);
            if(_loc4_ != null)
            {
               _loc7_ = _loc4_.getPriorityValue();
               if(_loc3_ < _loc7_ || _loc2_ == null)
               {
                  _loc2_ = _loc4_;
                  _loc3_ = _loc7_;
               }
            }
         }
         return _loc2_;
      }
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var stepIds:Vector.<uint>;
      
      public var categoryId:uint;
      
      public var isRepeatable:Boolean;
      
      public var repeatType:uint;
      
      public var repeatLimit:uint;
      
      public var isDungeonQuest:Boolean;
      
      public var levelMin:uint;
      
      public var levelMax:uint;
      
      private var _name:String;
      
      private var _steps:Vector.<QuestStep>;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get steps() : Vector.<QuestStep> {
         var _loc1_:uint = 0;
         if(!this._steps)
         {
            this._steps = new Vector.<QuestStep>(this.stepIds.length,true);
            _loc1_ = 0;
            while(_loc1_ < this.steps.length)
            {
               this._steps[_loc1_] = QuestStep.getQuestStepById(this.stepIds[_loc1_]);
               _loc1_++;
            }
         }
         return this._steps;
      }
      
      public function get category() : QuestCategory {
         return QuestCategory.getQuestCategoryById(this.categoryId);
      }
      
      public function getPriorityValue() : int {
         var _loc1_:int = PlayedCharacterManager.getInstance().infos.level;
         var _loc2_:* = 0;
         if(_loc1_ >= this.levelMin && _loc1_ <= this.levelMax)
         {
            _loc2_ = _loc2_ + 10000;
         }
         if(this.repeatType != 0)
         {
            _loc2_ = _loc2_ + 1000;
         }
         return _loc2_;
      }
   }
}
