package com.ankamagames.jerakine.types.events
{
    import flash.events.*;

    public class ErrorReportedEvent extends Event
    {
        private var _error:Error;
        private var _text:String;
        public static const ERROR:String = "ErrorReportedEvent";

        public function ErrorReportedEvent(param1:Error, param2:String)
        {
            super(ERROR, false, false);
            this._error = param1;
            this._text = param2;
            return;
        }// end function

        public function get error() : Error
        {
            return this._error;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

    }
}
