package com.ankamagames.dofus.datacenter.world
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Area extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var superAreaId:int;
        public var containHouses:Boolean;
        public var containPaddocks:Boolean;
        public var bounds:Rectangle;
        private var _name:String;
        private var _superArea:SuperArea;
        private var _hasVisibleSubAreas:Boolean;
        private var _hasVisibleSubAreasInitialized:Boolean;
        private static const MODULE:String = "Areas";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Area));
        private static var _allAreas:Array;

        public function Area()
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

        public function get superArea() : SuperArea
        {
            if (!this._superArea)
            {
                this._superArea = SuperArea.getSuperAreaById(this.superAreaId);
            }
            return this._superArea;
        }// end function

        public function get hasVisibleSubAreas() : Boolean
        {
            if (!this._hasVisibleSubAreasInitialized)
            {
                this._hasVisibleSubAreas = true;
                this._hasVisibleSubAreasInitialized = true;
            }
            return this._hasVisibleSubAreas;
        }// end function

        public static function getAreaById(param1:int) : Area
        {
            var _loc_2:* = GameData.getObject(MODULE, param1) as ;
            if (!_loc_2 || !_loc_2.superArea || !_loc_2.hasVisibleSubAreas)
            {
                return null;
            }
            return _loc_2;
        }// end function

        public static function getAllArea() : Array
        {
            if (_allAreas)
            {
                return _allAreas;
            }
            _allAreas = GameData.getObjects(MODULE) as Array;
            return _allAreas;
        }// end function

    }
}
