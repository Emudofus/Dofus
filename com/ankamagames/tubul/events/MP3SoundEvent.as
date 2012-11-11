package com.ankamagames.tubul.events
{
    import com.ankamagames.tubul.interfaces.*;
    import flash.events.*;

    public class MP3SoundEvent extends Event
    {
        public var sound:ISound;
        public static const SOON_END_OF_FILE:String = "SOON_END_OF_FILE";

        public function MP3SoundEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new MP3SoundEvent(type, bubbles, cancelable);
            _loc_1.sound = this.sound;
            return _loc_1;
        }// end function

    }
}
