package com.ankamagames.jerakine.handlers.messages.mouse
{
    import flash.display.*;
    import flash.events.*;

    public class MouseClickMessage extends MouseMessage
    {

        public function MouseClickMessage()
        {
            return;
        }// end function

        public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage = null) : MouseClickMessage
        {
            if (!param3)
            {
                param3 = new MouseClickMessage;
            }
            return MouseMessage.create(param1, param2, param3) as MouseClickMessage;
        }// end function

    }
}
