package com.ankamagames.jerakine.handlers.messages.mouse
{
    import flash.display.InteractiveObject;
    import flash.events.MouseEvent;

    public class MouseMiddleClickMessage extends MouseMessage 
    {


        public static function create(target:InteractiveObject, mouseEvent:MouseEvent, instance:MouseMessage=null):MouseMiddleClickMessage
        {
            if (!(instance))
            {
                instance = new (MouseMiddleClickMessage)();
            };
            return ((MouseMessage.create(target, mouseEvent, instance) as MouseMiddleClickMessage));
        }


    }
}//package com.ankamagames.jerakine.handlers.messages.mouse

