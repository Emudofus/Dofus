package com.ankamagames.jerakine.types
{
    import com.ankamagames.jerakine.utils.errors.*;

    public class DataStoreType extends Object
    {
        private var _sCategory:String;
        private var _bPersistant:Boolean;
        private var _nLocation:uint;
        private var _nBind:uint;
        private var _id:String;
        private var _idInitId:String;
        private static var _lastIdInitId:int;
        public static var _ACCOUNT_ID:String;
        private static var _CHARACTER_ID:String;

        public function DataStoreType(param1:String, param2:Boolean, param3:Number = NaN, param4:Number = NaN)
        {
            this._sCategory = param1;
            this._bPersistant = param2;
            if (param2)
            {
                if (!isNaN(param3))
                {
                    this._nLocation = param3;
                }
                else
                {
                    throw new JerakineError("When DataStoreType is a persistant data, arg \'nLocation\' must be defined.");
                }
                if (!isNaN(param4))
                {
                    this._nBind = param4;
                }
                else
                {
                    throw new JerakineError("When DataStoreType is a persistant data, arg \'nBind\' must be defined.");
                }
            }
            return;
        }// end function

        public function get id() : String
        {
            return this._id;
        }// end function

        public function get category() : String
        {
            return this._sCategory;
        }// end function

        public function get persistant() : Boolean
        {
            return this._bPersistant;
        }// end function

        public function get location() : uint
        {
            return this._nLocation;
        }// end function

        public function get bind() : uint
        {
            return this._nBind;
        }// end function

        public static function get CHARACTER_ID() : String
        {
            return _CHARACTER_ID;
        }// end function

        public static function set CHARACTER_ID(param1:String) : void
        {
            _CHARACTER_ID = param1;
            var _loc_3:* = _lastIdInitId + 1;
            _lastIdInitId = _loc_3;
            return;
        }// end function

        public static function get ACCOUNT_ID() : String
        {
            return _ACCOUNT_ID;
        }// end function

        public static function set ACCOUNT_ID(param1:String) : void
        {
            _ACCOUNT_ID = param1;
            var _loc_3:* = _lastIdInitId + 1;
            _lastIdInitId = _loc_3;
            return;
        }// end function

    }
}
