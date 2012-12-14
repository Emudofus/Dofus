package com.ankamagames.jerakine.handlers.messages.mouse
{
    import flash.display.*;
    import flash.events.*;

    public class MouseReleaseOutsideMessage extends MouseMessage
    {

        public function MouseReleaseOutsideMessage()
        {
            return;
        }// end function

        public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage = null) : MouseReleaseOutsideMessage
        {
            if (!param3)
            {
                param3 = new MouseReleaseOutsideMessage;
            }
            return MouseMessage.create(param1, param2, param3) as MouseReleaseOutsideMessage;
        }// end function

    }
}
