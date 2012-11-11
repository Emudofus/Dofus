package com.ankamagames.dofus.datacenter.world
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class SuperArea extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var worldmapId:uint;
        private var _name:String;
        private var _worldmap:WorldMap;
        private static const MODULE:String = "SuperAreas";
        private static var _allSuperAreas:Array;

        public function SuperArea()
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

        public function get worldmap() : WorldMap
        {
            if (!this._worldmap)
            {
                this._worldmap = WorldMap.getWorldMapById(this.worldmapId);
            }
            return this._worldmap;
        }// end function

        public static function getSuperAreaById(param1:int) : SuperArea
        {
            var _loc_2:* = GameData.getObject(MODULE, param1) as SuperArea;
            if (!_loc_2)
            {
                return null;
            }
            return _loc_2;
        }// end function

        public static function getAllSuperArea() : Array
        {
            if (_allSuperAreas)
            {
                return _allSuperAreas;
            }
            _allSuperAreas = GameData.getObjects(MODULE) as Array;
            return _allSuperAreas;
        }// end function

    }
}
