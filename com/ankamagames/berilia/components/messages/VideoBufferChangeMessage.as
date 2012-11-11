package com.ankamagames.berilia.components.messages
{
    import flash.display.*;

    public class VideoBufferChangeMessage extends ComponentMessage
    {
        private var _state:uint;

        public function VideoBufferChangeMessage(param1:InteractiveObject, param2:uint) : void
        {
            super(param1);
            this._state = param2;
            return;
        }// end function

        public function get state() : uint
        {
            return this._state;
        }// end function

    }
}
