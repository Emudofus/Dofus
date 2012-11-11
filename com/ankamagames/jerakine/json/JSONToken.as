package com.ankamagames.jerakine.json
{

    public class JSONToken extends Object
    {
        private var _type:int;
        private var _value:Object;

        public function JSONToken(param1:int = -1, param2:Object = null)
        {
            this._type = param1;
            this._value = param2;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get value() : Object
        {
            return this._value;
        }// end function

        public function set value(param1:Object) : void
        {
            this._value = param1;
            return;
        }// end function

    }
}
