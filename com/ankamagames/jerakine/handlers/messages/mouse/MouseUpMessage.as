package com.ankamagames.jerakine.handlers.messages.mouse
{
    import flash.display.*;
    import flash.events.*;

    public class MouseUpMessage extends MouseMessage
    {

        public function MouseUpMessage()
        {
            return;
        }// end function

        public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage = null) : MouseUpMessage
        {
            if (!param3)
            {
                param3 = new MouseUpMessage;
            }
            return MouseMessage.create(param1, param2, param3) as MouseUpMessage;
        }// end function

    }
}
