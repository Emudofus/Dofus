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
      
      public static function getSubAreaById(param1:int) : SubArea {
         var _loc2_:SubArea = GameData.getObject(MODULE,param1) as SubArea;
         if(!_loc2_ || !_loc2_.area)
         {
            return null;
         }
         return _loc2_;
      }
      
      public static function getSubAreaByMapId(param1:uint) : SubArea {
         var _loc2_:MapPosition = MapPosition.getMapPositionById(param1);
         if(_loc2_)
         {
            return _loc2_.subArea;
         }
         return null;
      }
      
      public static function getAllSubArea() : Array {
         if(_allSubAreas)
         {
            return _allSubAreas;
         }
         _allSubAreas = GameData.getObjects(MODULE) as Array;
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
      
      public var isConquestVillage:Boolean;
      
      public var basicAccountAllowed:Boolean;
      
      public var displayOnWorldMap:Boolean;
      
      public var monsters:Vector.<uint>;
      
      public var entranceMapIds:Vector.<uint>;
      
      public var exitMapIds:Vector.<uint>;
      
      public var capturable:Boolean;
      
      private var _name:String;
      
      private var _area:Area;
      
      private var _worldMap:WorldMap;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get area() : Area {
         if(!this._area)
         {
            this._area = Area.getAreaById(this.areaId);
         }
         return this._area;
      }
      
      public function get worldmap() : WorldMap {
         if(!this._worldMap)
         {
            if(this.hasCustomWorldMap)
            {
               this._worldMap = WorldMap.getWorldMapById(this.customWorldMap[0]);
            }
            else
            {
               this._worldMap = this.area.superArea.worldmap;
            }
         }
         return this._worldMap;
      }
      
      public function get hasCustomWorldMap() : Boolean {
         return (this.customWorldMap) && this.customWorldMap.length > 0;
      }
   }
}
