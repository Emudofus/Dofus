package com.ankamagames.tubul.events
{
    import flash.events.*;

    public class LoopEvent extends Event
    {
        public var sound:Object;
        public var loop:uint;
        public static const SOUND_LOOP:String = "sound_loop";
        public static const SOUND_LOOP_ALL_COMPLETE:String = "sound_loop_all_complete";

        public function LoopEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new LoopEvent(type, bubbles, cancelable);
            _loc_1.sound = this.sound;
            _loc_1.loop = this.loop;
            return _loc_1;
        }// end function

    }
}
