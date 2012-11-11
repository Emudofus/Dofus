package com.ankamagames.jerakine.logger
{
    import flash.events.*;

    public class TextLogEvent extends LogEvent
    {

        public function TextLogEvent(param1:String = null, param2:String = null, param3:uint = 0)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            return new TextLogEvent(category, message, level);
        }// end function

    }
}
