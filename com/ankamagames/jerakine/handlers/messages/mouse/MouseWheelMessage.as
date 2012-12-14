package com.ankamagames.jerakine.handlers.messages.mouse
{
    import flash.display.*;
    import flash.events.*;

    public class MouseWheelMessage extends MouseMessage
    {

        public function MouseWheelMessage()
        {
            return;
        }// end function

        public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage = null) : MouseWheelMessage
        {
            if (!param3)
            {
                param3 = new MouseWheelMessage;
            }
            return MouseMessage.create(param1, param2, param3) as MouseWheelMessage;
        }// end function

    }
}
