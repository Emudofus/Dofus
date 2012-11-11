package com.ankamagames.berilia.types.data
{
    import com.ankamagames.berilia.utils.errors.*;

    public class Hook extends Object
    {
        private var _trusted:Boolean;
        private var _name:String;
        private var _nativeHook:Boolean;
        private static var _hookNameList:Array;

        public function Hook(param1:String, param2:Boolean, param3:Boolean = true)
        {
            if (!_hookNameList)
            {
                _hookNameList = new Array();
            }
            _hookNameList[param1] = this;
            this._name = param1;
            this._trusted = param2;
            return;
        }// end function

        public function get trusted() : Boolean
        {
            return this._trusted;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get nativeHook() : Boolean
        {
            return this._nativeHook;
        }// end function

        public static function create(param1:String, param2:Boolean, param3:Boolean = true) : Hook
        {
            var _loc_4:* = _hookNameList[param1];
            if (_hookNameList[param1])
            {
                if (param2)
                {
                    throw new BeriliaError("Hook name (" + param1 + ") aleardy used, please rename it.");
                }
                return _loc_4;
            }
            return new Hook(param1, param2, param3);
        }// end function

        public static function getHookByName(param1:String) : Hook
        {
            return _hookNameList[param1];
        }// end function

    }
}
