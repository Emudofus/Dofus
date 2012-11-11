package com.ankamagames.berilia.components.messages
{
    import flash.display.*;

    public class TextClickMessage extends ComponentMessage
    {
        private var _textEvent:String;

        public function TextClickMessage(param1:InteractiveObject, param2:String)
        {
            this._textEvent = param2;
            super(param1);
            return;
        }// end function

        public function get textEvent() : String
        {
            return this._textEvent;
        }// end function

    }
}
