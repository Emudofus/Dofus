package com.ankamagames.dofus.datacenter.world
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import flash.geom.Rectangle;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.ambientSounds.AmbientSound;
   import com.ankamagames.jerakine.data.I18n;


   public class SubArea extends Object implements IDataCenter
   {
         

      public function SubArea() {
         super();
      }

      public static const MODULE:String = "SubAreas";

      private static var _allSubAreas:Array;

      public static function getSubAreaById(id:int) : SubArea {
         var subArea:SubArea = GameData.getObject(MODULE,id) as SubArea;
         if((!subArea)||(!subArea.area))
         {
            return null;
         }
         return subArea;
      }

      public static function getSubAreaByMapId(mapId:uint) : SubArea {
         var mp:MapPosition = MapPosition.getMapPositionById(mapId);
         if(mp)
         {
            return mp.subArea;
         }
         return null;
      }

      public static function getAllSubArea() : Array {
         if(_allSubAreas)
         {
            return _allSubAreas;
         }
         _allSubAreas=GameData.getObjects(MODULE) as Array;
         return _allSubAreas;
      }

      private var _bounds:Rectangle;

      public var id:int;

      public var nameId:uint;

      public var areaId:int;

      public var ambientSounds:Vector.<AmbientSound>;

      public var mapIds:Vector.<uint>;

      public var bounds:Rectangle;

      public var shape:Vector.<int>;

      public var customWorldMap:Vector.<uint>;

      public var packId:int;

      public var level:uint;

      public var displayOnWorldMap:Boolean;

      public var monsters:Vector.<uint>;

      private var _name:String;

      private var _area:Area;

      private var _worldMap:WorldMap;

      public function get name() : String {
         if(!this._name)
         {
            this._name=I18n.getText(this.nameId);
         }
         return this._name;
      }

      public function get area() : Area {
         if(!this._area)
         {
            this._area=Area.getAreaById(this.areaId);
         }
         return this._area;
      }

      public function get worldmap() : WorldMap {
         if(!this._worldMap)
         {
            if((this.customWorldMap)&&(this.customWorldMap.length))
            {
               this._worldMap=WorldMap.getWorldMapById(this.customWorldMap[0]);
            }
         }
         return this._worldMap;
      }
   }

}