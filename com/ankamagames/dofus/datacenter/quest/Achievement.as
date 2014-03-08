package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Achievement extends Object implements IDataCenter
   {
      
      public function Achievement() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Achievement));
      
      public static const MODULE:String = "Achievements";
      
      private static const REWARD_SCALE_CAP:Number = 1.5;
      
      private static const REWARD_REDUCED_SCALE:Number = 0.7;
      
      public static function getAchievementById(param1:int) : Achievement {
         return GameData.getObject(MODULE,param1) as Achievement;
      }
      
      public static function getAchievements() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var categoryId:uint;
      
      public var descriptionId:uint;
      
      public var iconId:uint;
      
      public var points:uint;
      
      public var level:uint;
      
      public var order:uint;
      
      public var kamasRatio:Number;
      
      public var experienceRatio:Number;
      
      public var kamasScaleWithPlayerLevel:Boolean;
      
      public var objectiveIds:Vector.<int>;
      
      public var rewardIds:Vector.<int>;
      
      private var _name:String;
      
      private var _desc:String;
      
      private var _category:AchievementCategory;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get description() : String {
         if(!this._desc)
         {
            this._desc = I18n.getText(this.descriptionId);
         }
         return this._desc;
      }
      
      public function get category() : AchievementCategory {
         if(!this._category)
         {
            this._category = AchievementCategory.getAchievementCategoryById(this.categoryId);
         }
         return this._category;
      }
      
      public function getKamasReward(param1:int) : Number {
         var _loc2_:int = this.kamasScaleWithPlayerLevel?param1:this.level;
         return (Math.pow(_loc2_,2) + 20 * _loc2_ - 20) * this.kamasRatio;
      }
      
      public function getExperienceReward(param1:int, param2:int) : Number {
         var _loc4_:* = 0;
         var _loc3_:Number = 1 + param2 / 100;
         if(param1 > this.level)
         {
            _loc4_ = Math.min(param1,this.level * REWARD_SCALE_CAP);
            return ((1 - REWARD_REDUCED_SCALE) * this.getFixeExperienceReward(this.level) + REWARD_REDUCED_SCALE * this.getFixeExperienceReward(_loc4_)) * _loc3_;
         }
         return this.getFixeExperienceReward(param1) * _loc3_;
      }
      
      private function getFixeExperienceReward(param1:int) : int {
         return param1 * Math.pow(100 + 2 * param1,2) / 20 * this.experienceRatio;
      }
   }
}
