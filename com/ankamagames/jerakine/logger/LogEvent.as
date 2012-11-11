package com.ankamagames.jerakine.logger
{
    import flash.events.*;

    public class LogEvent extends Event
    {
        public var message:String;
        public var level:uint;
        public var category:String;
        public static const LOG_EVENT:String = "logEvent";

        public function LogEvent(param1:String = null, param2:String = null, param3:uint = 0)
        {
            super(LOG_EVENT, false, false);
            this.category = param1;
            this.message = param2;
            this.level = param3;
            return;
        }// end function

        override public function clone() : Event
        {
            return new LogEvent(this.category, this.message, this.level);
        }// end function

    }
}
