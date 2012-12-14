package com.ankamagames.jerakine.handlers.messages.mouse
{
    import com.ankamagames.jerakine.handlers.messages.*;
    import flash.display.*;
    import flash.events.*;

    public class MouseOutMessage extends MouseMessage
    {

        public function MouseOutMessage()
        {
            return;
        }// end function

        public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage = null) : MouseOutMessage
        {
            if (!param3)
            {
                param3 = new MouseOutMessage;
            }
            return HumanInputMessage.create(param1, param2, param3) as MouseOutMessage;
        }// end function

    }
}
