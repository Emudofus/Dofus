package com.ankamagames.dofus.datacenter.world
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import flash.geom.*;

    public class SubArea extends Object implements IDataCenter
    {
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
        private var _name:String;
        private var _area:Area;
        private var _worldMap:WorldMap;
        private static const MODULE:String = "SubAreas";
        private static var _allSubAreas:Array;

        public function SubArea()
        {
            return;
        }// end function

        public function get name() : String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            }
            return this._name;
        }// end function

        public function get area() : Area
        {
            if (!this._area)
            {
                this._area = Area.getAreaById(this.areaId);
            }
            return this._area;
        }// end function

        public function get worldmap() : WorldMap
        {
            if (!this._worldMap)
            {
                if (this.customWorldMap && this.customWorldMap.length)
                {
                    this._worldMap = WorldMap.getWorldMapById(this.customWorldMap[0]);
                }
            }
            return this._worldMap;
        }// end function

        public static function getSubAreaById(param1:int) : SubArea
        {
            var _loc_2:* = GameData.getObject(MODULE, param1) as SubArea;
            if (!_loc_2 || !_loc_2.area)
            {
                return null;
            }
            return _loc_2;
        }// end function

        public static function getSubAreaByMapId(param1:uint) : SubArea
        {
            var _loc_2:* = MapPosition.getMapPositionById(param1);
            if (_loc_2)
            {
                return _loc_2.subArea;
            }
            return null;
        }// end function

        public static function getAllSubArea() : Array
        {
            if (_allSubAreas)
            {
                return _allSubAreas;
            }
            _allSubAreas = GameData.getObjects(MODULE) as Array;
            return _allSubAreas;
        }// end function

    }
}
