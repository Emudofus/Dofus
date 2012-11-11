package com.ankamagames.berilia.types.messages
{
    import com.ankamagames.jerakine.messages.*;

    public class UiXmlParsedErrorMessage extends Object implements Message
    {
        private var _url:String;
        private var _msg:String;

        public function UiXmlParsedErrorMessage(param1:String, param2:String)
        {
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
