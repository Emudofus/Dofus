package com.ankamagames.jerakine.types.events
{
    import flash.events.*;

    public class LangFileEvent extends Event
    {
        private var _sUrl:String;
        private var _sUrlProvider:String;
        public static var ALL_COMPLETE:String = "LangFileEvent_ALL_COMPLETE";
        public static var COMPLETE:String = "LangFileEvent_COMPLETE";

        public function LangFileEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null, param5:String = null)
        {
            super(param1, param2, param3);
            this._sUrl = param4;
            this._sUrlProvider = param5;
            return;
        }// end function

        override public function clone() : Event
        {
            return new LangFileEvent(type, bubbles, cancelable, this._sUrl, this._sUrlProvider);
        }// end function

        public function get url() : String
        {
            return this._sUrl;
        }// end function

        public function get urlProvider() : String
        {
            return this._sUrlProvider;
        }// end function

    }
}
