package com.ankamagames.jerakine.handlers.messages
{
    import flash.events.Event;
    import flash.display.InteractiveObject;

    public class FocusChangeMessage extends HumanInputMessage 
    {


        public static function create(target:InteractiveObject, instance:FocusChangeMessage=null):FocusChangeMessage
        {
            if (!(instance))
            {
                instance = new (FocusChangeMessage)();
            };
            return ((HumanInputMessage.create(target, new Event("FocusChange"), instance) as FocusChangeMessage));
        }


    }
}//package com.ankamagames.jerakine.handlers.messages

