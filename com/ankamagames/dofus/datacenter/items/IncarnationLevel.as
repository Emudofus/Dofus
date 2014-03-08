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
      
      public static function getIncarnationLevelById(id:uint) : IncarnationLevel {
         return GameData.getObject(MODULE,id) as IncarnationLevel;
      }
      
      public static function getIncarnationLevelByIdAndLevel(incarnationId:int, level:int) : IncarnationLevel {
         var id:int = incarnationId * 100 + level;
         return getIncarnationLevelById(id);
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
