package com.ankamagames.dofus.internalDatacenter.conquest
{
    import com.ankamagames.jerakine.interfaces.*;

    public class PrismSubAreaWrapper extends Object implements IDataCenter
    {
        private var _subId:uint;
        private var _align:uint;
        private var _mapId:uint;
        private var _worldX:int;
        private var _worldY:int;
        private var _isInFight:Boolean;
        private var _isFightable:Boolean;
        private static var _cache:Array = new Array();

        public function PrismSubAreaWrapper()
        {
            return;
        }// end function

        public function get subAreaId() : uint
        {
            return this._subId;
        }// end function

        public function get alignmentId() : uint
        {
            return this._align;
        }// end function

        public function get mapId() : uint
        {
            return this._mapId;
        }// end function

        public function get worldX() : int
        {
            return this._worldX;
        }// end function

        public function get worldY() : int
        {
            return this._worldY;
        }// end function

        public function get isInFight() : Boolean
        {
            return this._isInFight;
        }// end function

        public function get isFightable() : Boolean
        {
            return this._isFightable;
        }// end function

        public static function create(param1:uint, param2:uint, param3:uint, param4:Boolean, param5:Boolean, param6:Boolean = false, param7:int = 0, param8:int = 0) : PrismSubAreaWrapper
        {
            var _loc_9:* = null;
            if (!_cache[param1] || !param6)
            {
                _loc_9 = new PrismSubAreaWrapper;
                _loc_9._subId = param1;
                _loc_9._align = param2;
                _loc_9._mapId = param3;
                _loc_9._worldX = param7;
                _loc_9._worldY = param8;
                _loc_9._isInFight = param4;
                _loc_9._isFightable = param5;
                if (param6)
                {
                    _cache[param1] = _loc_9;
                }
            }
            else
            {
                _loc_9 = _cache[param1];
            }
            return _loc_9;
        }// end function

    }
}
