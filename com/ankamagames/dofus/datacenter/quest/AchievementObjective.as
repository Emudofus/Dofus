package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class AchievementObjective extends Object implements IDataCenter
   {
      
      public function AchievementObjective() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AchievementObjective));
      
      public static const MODULE:String = "AchievementObjectives";
      
      public static function getAchievementObjectiveById(param1:int) : AchievementObjective {
         return GameData.getObject(MODULE,param1) as AchievementObjective;
      }
      
      public static function getAchievementObjectives() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var achievementId:uint;
      
      public var nameId:uint;
      
      public var criterion:String;
      
      private var _name:String;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
