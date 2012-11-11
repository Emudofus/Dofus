package com.ankamagames.jerakine.types.events
{
    import com.ankamagames.jerakine.logger.*;
    import flash.events.*;

    public class RegisterClassLogEvent extends LogEvent
    {
        private var _className:String;

        public function RegisterClassLogEvent(param1:String)
        {
            super(null, null, 0);
            this._className = param1;
            return;
        }// end function

        public function get className() : String
        {
            return this._className;
        }// end function

        override public function clone() : Event
        {
            return new RegisterClassLogEvent(this._className);
        }// end function

    }
}
