package com.ankamagames.jerakine.types.events
{
    import flash.events.*;

    public class ErrorReportedEvent extends Event
    {
        private var _error:Error;
        private var _text:String;
        private var _showPopup:Boolean;
        public static const ERROR:String = "ErrorReportedEvent";

        public function ErrorReportedEvent(param1:Error, param2:String, param3:Boolean = true)
        {
            super(ERROR, false, false);
            this._error = param1;
            this._text = param2;
            this._showPopup = param3;
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

        public function get showPopup() : Boolean
        {
            return this._showPopup;
        }// end function

        public function get errorType() : String
        {
            if (this.error == null)
            {
                return "";
            }
            var _loc_1:* = this.error.toString().split(":");
            return _loc_1[0];
        }// end function

    }
}
