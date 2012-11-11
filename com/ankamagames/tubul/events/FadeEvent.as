package com.ankamagames.tubul.events
{
    import com.ankamagames.tubul.interfaces.*;
    import flash.events.*;

    public class FadeEvent extends Event
    {
        public var soundSource:ISoundController;
        public static const COMPLETE:String = "complete";

        public function FadeEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new FadeEvent(type, bubbles, cancelable);
            _loc_1.soundSource = this.soundSource;
            return _loc_1;
        }// end function

    }
}
