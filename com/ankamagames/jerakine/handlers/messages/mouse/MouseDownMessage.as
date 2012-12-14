package com.ankamagames.jerakine.handlers.messages.mouse
{
    import flash.display.*;
    import flash.events.*;

    public class MouseDownMessage extends MouseMessage
    {

        public function MouseDownMessage()
        {
            return;
        }// end function

        public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage = null) : MouseDownMessage
        {
            if (!param3)
            {
                param3 = new MouseDownMessage;
            }
            return MouseMessage.create(param1, param2, param3) as MouseDownMessage;
        }// end function

    }
}
