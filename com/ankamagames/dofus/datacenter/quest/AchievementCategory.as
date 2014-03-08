package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.I18n;
   
   public class AchievementCategory extends Object implements IDataCenter
   {
      
      public function AchievementCategory() {
         super();
      }
      
      public static const MODULE:String = "AchievementCategories";
      
      public static function getAchievementCategoryById(param1:int) : AchievementCategory {
         return GameData.getObject(MODULE,param1) as AchievementCategory;
      }
      
      public static function getAchievementCategories() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var parentId:uint;
      
      public var icon:String;
      
      public var order:uint;
      
      public var color:String;
      
      public var achievementIds:Vector.<uint>;
      
      private var _name:String;
      
      private var _achievements:Vector.<Achievement>;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get achievements() : Vector.<Achievement> {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         if(!this._achievements)
         {
            _loc2_ = this.achievementIds.length;
            this._achievements = new Vector.<Achievement>(_loc2_,true);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this._achievements[_loc1_] = Achievement.getAchievementById(this.achievementIds[_loc1_]);
               _loc1_++;
            }
         }
         return this._achievements;
      }
   }
}
