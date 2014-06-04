package com.ankamagames.dofus.datacenter.world
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class Waypoint extends Object implements IDataCenter
   {
      
      public function Waypoint() {
         super();
      }
      
      public static const MODULE:String = "Waypoints";
      
      public static function getAllWaypoints() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var mapId:uint;
      
      public var subAreaId:uint;
   }
}
