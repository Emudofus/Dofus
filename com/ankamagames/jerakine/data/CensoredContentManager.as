package com.ankamagames.jerakine.data
{
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class CensoredContentManager extends Object
    {
        private var _data:Dictionary;
        private var _emtptyData:Dictionary;
        private static var _self:CensoredContentManager;

        public function CensoredContentManager()
        {
            this._data = new Dictionary();
            this._emtptyData = new Dictionary();
            if (_self)
            {
                throw new SingletonError();
            }
            return;
        }// end function

        public function init(param1:Array, param2:String) : void
        {
            var _loc_3:ICensoredDataItem = null;
            for each (_loc_3 in param1)
            {
                
                if (_loc_3.lang != param2)
                {
                    continue;
                }
                if (!this._data[_loc_3.type])
                {
                    this._data[_loc_3.type] = new Dictionary();
                }
                this._data[_loc_3.type][_loc_3.oldValue] = _loc_3.newValue;
            }
            return;
        }// end function

        public function getCensoredIndex(param1:int) : Dictionary
        {
            return this._data[param1] ? (this._data[param1]) : (this._emtptyData);
        }// end function

        public static function getInstance() : CensoredContentManager
        {
            if (!_self)
            {
                _self = new CensoredContentManager;
            }
            return _self;
        }// end function

    }
}
