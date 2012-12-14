package com.ankamagames.jerakine.handlers.messages.mouse
{
    import flash.display.*;
    import flash.events.*;

    public class MouseMiddleClickMessage extends MouseMessage
    {

        public function MouseMiddleClickMessage()
        {
            return;
        }// end function

        public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage = null) : MouseMiddleClickMessage
        {
            if (!param3)
            {
                param3 = new MouseMiddleClickMessage;
            }
            return MouseMessage.create(param1, param2, param3) as MouseMiddleClickMessage;
        }// end function

    }
}
