package com.ankamagames.tubul.events
{
    import flash.events.*;

    public class TubulEvent extends Event
    {
        public var activated:Boolean;
        public static const ACTIVATION:String = "activation";

        public function TubulEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new TubulEvent(this.type, this.bubbles, this.cancelable);
            _loc_1.activated = this.activated;
            return _loc_1;
        }// end function

    }
}
