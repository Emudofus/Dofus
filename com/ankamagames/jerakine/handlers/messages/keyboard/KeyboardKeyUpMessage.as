package com.ankamagames.jerakine.handlers.messages.keyboard
{
    import flash.display.*;
    import flash.events.*;

    public class KeyboardKeyUpMessage extends KeyboardMessage
    {

        public function KeyboardKeyUpMessage()
        {
            return;
        }// end function

        public static function create(param1:InteractiveObject, param2:KeyboardEvent, param3:KeyboardMessage = null) : KeyboardKeyUpMessage
        {
            if (!param3)
            {
                param3 = new KeyboardKeyUpMessage;
            }
            return KeyboardMessage.create(param1, param2, param3) as KeyboardKeyUpMessage;
        }// end function

    }
}
