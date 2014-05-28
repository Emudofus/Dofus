package com.ankamagames.dofus.datacenter.world
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class WorldMap extends Object implements IDataCenter
   {
      
      public function WorldMap() {
         super();
      }
      
      public static const MODULE:String = "WorldMaps";
      
      public static function getWorldMapById(id:int) : WorldMap {
         return GameData.getObject(MODULE,id) as WorldMap;
      }
      
      public static function getAllWorldMaps() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var origineX:int;
      
      public var origineY:int;
      
      public var mapWidth:Number;
      
      public var mapHeight:Number;
      
      public var horizontalChunck:uint;
      
      public var verticalChunck:uint;
      
      public var viewableEverywhere:Boolean;
      
      public var minScale:Number;
      
      public var maxScale:Number;
      
      public var startScale:Number;
      
      public var centerX:int;
      
      public var centerY:int;
      
      public var totalWidth:int;
      
      public var totalHeight:int;
      
      public var zoom:Vector.<String>;
   }
}
