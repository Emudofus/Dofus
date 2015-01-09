package com.ankamagames.berilia.types.messages
{
    import com.ankamagames.jerakine.messages.Message;

    public class UiXmlParsedMessage implements Message 
    {

        private var _url:String;

        public function UiXmlParsedMessage(url:String)
        {
            this._url = url;
        }

        public function get url():String
        {
            return (this._url);
        }


    }
}//package com.ankamagames.berilia.types.messages

