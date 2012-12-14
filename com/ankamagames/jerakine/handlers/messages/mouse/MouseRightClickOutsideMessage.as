package com.ankamagames.jerakine.handlers.messages.mouse
{
    import flash.display.*;
    import flash.events.*;

    public class MouseRightClickOutsideMessage extends MouseMessage
    {

        public function MouseRightClickOutsideMessage()
        {
            return;
        }// end function

        public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage = null) : MouseRightClickOutsideMessage
        {
            if (!param3)
            {
                param3 = new MouseRightClickOutsideMessage;
            }
            return MouseMessage.create(param1, param2, param3) as MouseRightClickOutsideMessage;
        }// end function

    }
}
