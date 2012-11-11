package com.ankamagames.dofus.internalDatacenter.communication
{
    import com.ankamagames.jerakine.interfaces.*;

    public class ChatBubble extends Object implements IDataCenter
    {
        private var _text:String;

        public function ChatBubble(param1:String)
        {
            this._text = param1;
            return;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

    }
}
