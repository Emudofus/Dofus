package com.ankamagames.jerakine.handlers.messages.mouse
{
    import com.ankamagames.jerakine.handlers.messages.*;
    import flash.display.*;
    import flash.events.*;

    public class MouseMessage extends HumanInputMessage
    {

        public function MouseMessage(param1:InteractiveObject, param2:MouseEvent)
        {
            super(param1, param2);
            return;
        }// end function

        public function get mouseEvent() : MouseEvent
        {
            return MouseEvent(_nativeEvent);
        }// end function

    }
}
