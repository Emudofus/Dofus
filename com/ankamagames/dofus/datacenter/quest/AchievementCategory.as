package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import __AS3__.vec.*;
   
   public class AchievementCategory extends Object implements IDataCenter
   {
      
      public function AchievementCategory() {
         super();
      }
      
      public static const MODULE:String = "AchievementCategories";
      
      public static function getAchievementCategoryById(id:int) : AchievementCategory {
         return GameData.getObject(MODULE,id) as AchievementCategory;
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
         var i:* = 0;
         var len:* = 0;
         if(!this._achievements)
         {
            len = this.achievementIds.length;
            this._achievements = new Vector.<Achievement>(len,true);
            i = 0;
            while(i < len)
            {
               this._achievements[i] = Achievement.getAchievementById(this.achievementIds[i]);
               i++;
            }
         }
         return this._achievements;
      }
   }
}
