package com.ankamagames.dofus.internalDatacenter.conquest
{
    import com.ankamagames.jerakine.interfaces.*;

    public class PrismConquestWrapper extends Object implements IDataCenter
    {
        private var _subId:uint;
        private var _align:uint;
        private var _isEntered:Boolean;
        private var _isInRoom:Boolean;
        private static var _cache:Array = new Array();

        public function PrismConquestWrapper()
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

        public function get isEntered() : Boolean
        {
            return this._isEntered;
        }// end function

        public function get isInRoom() : Boolean
        {
            return this._isInRoom;
        }// end function

        public static function create(param1:uint, param2:uint, param3:Boolean, param4:Boolean, param5:Boolean = false) : PrismConquestWrapper
        {
            var _loc_6:PrismConquestWrapper = null;
            if (!_cache[param1] || !param5)
            {
                _loc_6 = new PrismConquestWrapper;
                _loc_6._subId = param1;
                _loc_6._align = param2;
                _loc_6._isEntered = param3;
                _loc_6._isInRoom = param4;
                if (param5)
                {
                    _cache[param1] = _loc_6;
                }
            }
            else
            {
                _loc_6 = _cache[param1];
            }
            return _loc_6;
        }// end function

    }
}
