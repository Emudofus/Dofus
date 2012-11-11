package com.ankamagames.jerakine.types.enums
{
    import com.ankamagames.jerakine.entities.messages.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.events.*;

    public class InteractionsEnum extends Object
    {
        public static const CLICK:uint = 1 << 0;
        public static const OVER:uint = 1 << 1;
        public static const OUT:uint = 1 << 2;

        public function InteractionsEnum()
        {
            return;
        }// end function

        public static function getEvents(param1:uint) : Array
        {
            switch(param1)
            {
                case CLICK:
                {
                    return [MouseEvent.CLICK];
                }
                case OVER:
                {
                    return [MouseEvent.MOUSE_OVER];
                }
                case OUT:
                {
                    return [MouseEvent.MOUSE_OUT, Event.REMOVED_FROM_STAGE];
                }
                default:
                {
                    break;
                }
            }
            throw new JerakineError("Unknown interaction type " + param1 + ".");
        }// end function

        public static function getMessage(param1:String) : Class
        {
            switch(param1)
            {
                case MouseEvent.CLICK:
                {
                    return EntityClickMessage;
                }
                case MouseEvent.MOUSE_OVER:
                {
                    return EntityMouseOverMessage;
                }
                case Event.REMOVED_FROM_STAGE:
                case MouseEvent.MOUSE_OUT:
                {
                    return EntityMouseOutMessage;
                }
                default:
                {
                    break;
                }
            }
            throw new JerakineError("Unknown event type for an interaction \'" + param1 + "\'.");
        }// end function

    }
}
