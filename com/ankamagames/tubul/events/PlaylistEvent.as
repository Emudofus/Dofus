package com.ankamagames.tubul.events
{
    import com.ankamagames.tubul.interfaces.*;
    import flash.events.*;

    public class PlaylistEvent extends Event
    {
        public var newSound:ISound;
        public static const COMPLETE:String = "complete";
        public static const NEW_SOUND:String = "new_sound";

        public function PlaylistEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new PlaylistEvent(type, bubbles, cancelable);
            _loc_1.newSound = this.newSound;
            return _loc_1;
        }// end function

    }
}
