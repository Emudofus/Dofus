package com.ankamagames.jerakine.handlers.messages.mouse
{
    import flash.display.*;
    import flash.events.*;

    public class MouseRightClickMessage extends MouseMessage
    {

        public function MouseRightClickMessage()
        {
            return;
        }// end function

        public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage = null) : MouseRightClickMessage
        {
            if (!param3)
            {
                param3 = new MouseRightClickMessage;
            }
            return MouseMessage.create(param1, param2, param3) as MouseRightClickMessage;
        }// end function

    }
}
