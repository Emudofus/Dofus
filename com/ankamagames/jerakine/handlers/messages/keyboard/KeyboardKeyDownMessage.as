package com.ankamagames.jerakine.handlers.messages.keyboard
{
    import flash.display.*;
    import flash.events.*;

    public class KeyboardKeyDownMessage extends KeyboardMessage
    {

        public function KeyboardKeyDownMessage()
        {
            return;
        }// end function

        public static function create(param1:InteractiveObject, param2:KeyboardEvent, param3:KeyboardMessage = null) : KeyboardKeyDownMessage
        {
            if (!param3)
            {
                param3 = new KeyboardKeyDownMessage;
            }
            return KeyboardMessage.create(param1, param2, param3) as KeyboardKeyDownMessage;
        }// end function

    }
}
