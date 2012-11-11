package com.ankamagames.jerakine.data
{
    import com.ankamagames.jerakine.utils.errors.*;

    public class XmlConfig extends Object
    {
        private var _constants:Array;
        private static var _self:XmlConfig;

        public function XmlConfig()
        {
            this._constants = new Array();
            if (_self)
            {
                throw new SingletonError();
            }
            return;
        }// end function

        public function init(param1:Array) : void
        {
            this._constants = param1;
            return;
        }// end function

        public function addCategory(param1:Array) : void
        {
            var _loc_2:* = undefined;
            for (_loc_2 in param1)
            {
                
                this._constants[_loc_2] = param1[_loc_2];
            }
            return;
        }// end function

        public function getEntry(param1:String)
        {
            return this._constants[param1];
        }// end function

        public function setEntry(param1:String, param2) : void
        {
            this._constants[param1] = param2;
            return;
        }// end function

        public static function getInstance() : XmlConfig
        {
            if (!_self)
            {
                _self = new XmlConfig;
            }
            return _self;
        }// end function

    }
}
