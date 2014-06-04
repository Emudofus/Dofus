package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.roleplay.managers.RoleplayManager;
   
   public class Achievement extends Object implements IDataCenter
   {
      
      public function Achievement() {
         super();
      }
      
      protected static const _log:Logger;
      
      public static const MODULE:String = "Achievements";
      
      public static function getAchievementById(id:int) : Achievement {
         return GameData.getObject(MODULE,id) as Achievement;
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
      
      public function getKamasReward(pPlayerLevel:int) : Number {
         return RoleplayManager.getInstance().getKamasReward(this.kamasScaleWithPlayerLevel,this.level,this.kamasRatio,1,pPlayerLevel);
      }
      
      public function getExperienceReward(pPlayerLevel:int, pXpBonus:int) : Number {
         return RoleplayManager.getInstance().getExperienceReward(pPlayerLevel,pXpBonus,this.level,this.experienceRatio);
      }
   }
}
