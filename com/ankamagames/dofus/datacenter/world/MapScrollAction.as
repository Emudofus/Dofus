package com.ankamagames.dofus.datacenter.world
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class MapScrollAction extends Object implements IDataCenter
   {
      
      public function MapScrollAction() {
         super();
      }
      
      public static const MODULE:String = "MapScrollActions";
      
      public static function getMapScrollActionById(id:int) : MapScrollAction {
         return GameData.getObject(MODULE,id) as MapScrollAction;
      }
      
      public static function getMapScrollActions() : Array {
         return GameData.getObjects(MODULE) as Array;
      }
      
      public var id:int;
      
      public var rightExists:Boolean;
      
      public var bottomExists:Boolean;
      
      public var leftExists:Boolean;
      
      public var topExists:Boolean;
      
      public var rightMapId:int;
      
      public var bottomMapId:int;
      
      public var leftMapId:int;
      
      public var topMapId:int;
   }
}
