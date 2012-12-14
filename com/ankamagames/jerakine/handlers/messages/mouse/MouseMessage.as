package com.ankamagames.jerakine.handlers.messages.mouse
{
    import com.ankamagames.jerakine.handlers.messages.*;
    import flash.display.*;
    import flash.events.*;

    public class MouseMessage extends HumanInputMessage
    {

        public function MouseMessage()
        {
            return;
        }// end function

        public function get mouseEvent() : MouseEvent
        {
            return MouseEvent(_nativeEvent);
        }// end function

        public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage = null) : MouseMessage
        {
            if (!param3)
            {
                param3 = new MouseMessage;
            }
            return HumanInputMessage.create(param1, param2, param3) as MouseMessage;
        }// end function

    }
}
