package com.ankamagames.tubul.events
{
    import flash.events.*;

    public class SoundWrapperEvent extends Event
    {
        public static const SOON_END_OF_FILE:String = "soon_end_of_file";

        public function SoundWrapperEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new SoundWrapperEvent(this.type, this.bubbles, this.cancelable);
            return _loc_1;
        }// end function

    }
}
