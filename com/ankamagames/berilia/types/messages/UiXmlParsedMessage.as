package com.ankamagames.berilia.types.messages
{
    import com.ankamagames.jerakine.messages.*;

    public class UiXmlParsedMessage extends Object implements Message
    {
        private var _url:String;

        public function UiXmlParsedMessage(param1:String)
        {
            this._url = param1;
            return;
        }// end function

        public function get url() : String
        {
            return this._url;
        }// end function

    }
}
