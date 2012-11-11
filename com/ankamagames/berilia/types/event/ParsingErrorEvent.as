package com.ankamagames.berilia.types.event
{
    import flash.events.*;

    public class ParsingErrorEvent extends Event
    {
        private var _url:String;
        private var _msg:String;
        public static const ERROR:String = "ParsingErrorEvent_Error";

        public function ParsingErrorEvent(param1:String, param2:String)
        {
            super(ERROR);
            this._url = param1;
            this._msg = param2;
            return;
        }// end function

        public function get url() : String
        {
            return this._url;
        }// end function

        public function get msg() : String
        {
            return this._msg;
        }// end function

    }
}
