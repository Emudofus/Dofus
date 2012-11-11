package com.ankamagames.jerakine.handlers.messages.keyboard
{
    import com.ankamagames.jerakine.handlers.messages.*;
    import flash.display.*;
    import flash.events.*;

    public class KeyboardMessage extends HumanInputMessage
    {

        public function KeyboardMessage(param1:InteractiveObject, param2:KeyboardEvent)
        {
            super(param1, param2);
            return;
        }// end function

        public function get keyboardEvent() : KeyboardEvent
        {
            return KeyboardEvent(_nativeEvent);
        }// end function

    }
}
