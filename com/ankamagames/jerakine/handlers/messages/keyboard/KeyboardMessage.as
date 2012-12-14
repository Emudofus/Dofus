package com.ankamagames.jerakine.handlers.messages.keyboard
{
    import com.ankamagames.jerakine.handlers.messages.*;
    import flash.display.*;
    import flash.events.*;

    public class KeyboardMessage extends HumanInputMessage
    {

        public function KeyboardMessage()
        {
            return;
        }// end function

        public function get keyboardEvent() : KeyboardEvent
        {
            return KeyboardEvent(_nativeEvent);
        }// end function

        public static function create(param1:InteractiveObject, param2:KeyboardEvent, param3:KeyboardMessage = null) : KeyboardMessage
        {
            if (!param3)
            {
                param3 = new KeyboardMessage;
            }
            return HumanInputMessage.create(param1, param2, param3) as KeyboardMessage;
        }// end function

    }
}
