package com.ankamagames.jerakine.json
{

    public class JSONParseError extends Error
    {
        private var _location:int;
        private var _text:String;

        public function JSONParseError(param1:String = "", param2:int = 0, param3:String = "")
        {
            super(param1);
            name = "JSONParseError";
            this._location = param2;
            this._text = param3;
            return;
        }// end function

        public function get location() : int
        {
            return this._location;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

    }
}
