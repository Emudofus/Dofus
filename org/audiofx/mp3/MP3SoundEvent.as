package org.audiofx.mp3
{
    import flash.events.*;
    import flash.media.*;

    public class MP3SoundEvent extends Event
    {
        public var sound:Sound;
        public static const COMPLETE:String = "complete";

        public function MP3SoundEvent(param1:String, param2:Sound, param3:Boolean = false, param4:Boolean = false)
        {
            super(param1, param3, param4);
            this.sound = param2;
            return;
        }// end function

    }
}
