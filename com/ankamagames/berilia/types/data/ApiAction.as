package com.ankamagames.berilia.types.data
{
    import com.ankamagames.berilia.utils.errors.*;
    import flash.utils.*;

    public class ApiAction extends Object
    {
        protected var _trusted:Boolean;
        protected var _name:String;
        protected var _actionClass:Class;
        protected var _maxUsePerFrame:uint = 1;
        protected var _needInteraction:Boolean;
        protected var _minimalUseInterval:uint = 0;
        protected var _needConfirmation:Boolean;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        static var _apiActionNameList:Array = new Array();

        public function ApiAction(param1:String, param2:Class, param3:Boolean, param4:Boolean, param5:uint, param6:uint, param7:Boolean)
        {
            if (!_apiActionNameList)
            {
                _apiActionNameList = new Array();
            }
            if (_apiActionNameList[param1])
            {
                throw new BeriliaError("ApiAction name (" + param1 + ") aleardy used, please rename it.");
            }
            _apiActionNameList[param1] = this;
            this._name = param1;
            this._actionClass = param2;
            this._trusted = param3;
            this._needInteraction = param4;
            this._maxUsePerFrame = param5;
            this._minimalUseInterval = param6;
            this._needConfirmation = param7;
            MEMORY_LOG[this] = 1;
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

        public function get needInteraction() : Boolean
        {
            return this._needInteraction;
        }// end function

        public function get maxUsePerFrame() : uint
        {
            return this._maxUsePerFrame;
        }// end function

        public function get minimalUseInterval() : uint
        {
            return this._minimalUseInterval;
        }// end function

        public function get needConfirmation() : Boolean
        {
            return this._needConfirmation;
        }// end function

        public function get actionClass() : Class
        {
            return this._actionClass;
        }// end function

        public static function getApiActionByName(param1:String) : ApiAction
        {
            return _apiActionNameList[param1];
        }// end function

        public static function getApiActionsList() : Array
        {
            return _apiActionNameList;
        }// end function

    }
}
