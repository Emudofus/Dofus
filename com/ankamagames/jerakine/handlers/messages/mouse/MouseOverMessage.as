package com.ankamagames.jerakine.handlers.messages.mouse
{
    import flash.display.*;
    import flash.events.*;

    public class MouseOverMessage extends MouseMessage
    {

        public function MouseOverMessage()
        {
            return;
        }// end function

        public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage = null) : MouseOverMessage
        {
            if (!param3)
            {
                param3 = new MouseOverMessage;
            }
            return MouseMessage.create(param1, param2, param3) as MouseOverMessage;
        }// end function

    }
}
