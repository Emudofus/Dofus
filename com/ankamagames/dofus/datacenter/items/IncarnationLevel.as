package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class IncarnationLevel extends Object implements IDataCenter
   {
      
      public function IncarnationLevel() {
         super();
      }
      
      public static const MODULE:String = "IncarnationLevels";
      
      public static function getIncarnationLevelById(param1:uint) : IncarnationLevel {
         return GameData.getObject(MODULE,param1) as IncarnationLevel;
      }
      
      public static function getIncarnationLevelByIdAndLevel(param1:int, param2:int) : IncarnationLevel {
         var _loc3_:int = param1 * 100 + param2;
         return getIncarnationLevelById(_loc3_);
      }
      
      public var id:int;
      
      public var incarnationId:int;
      
      public var level:int;
      
      public var requiredXp:uint;
      
      public function get incarnation() : Incarnation {
         return Incarnation.getIncarnationById(this.id);
      }
   }
}
