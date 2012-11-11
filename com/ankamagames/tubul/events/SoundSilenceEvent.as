package com.ankamagames.tubul.events
{
    import flash.events.*;

    public class SoundSilenceEvent extends Event
    {
        public static const START:String = "start";
        public static const COMPLETE:String = "complete";

        public function SoundSilenceEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new SoundSilenceEvent(this.type, this.bubbles, this.cancelable);
            return _loc_1;
        }// end function

    }
}
