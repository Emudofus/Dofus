package com.ankamagames.tubul.events
{
    import com.ankamagames.tubul.interfaces.*;
    import flash.events.*;

    public class AudioBusEvent extends Event
    {
        public var sound:ISound;
        public static const ADD_SOUND_IN_BUS:String = "add_sound_in_bus";
        public static const REMOVE_SOUND_IN_BUS:String = "remove_sound_in_bus";

        public function AudioBusEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new AudioBusEvent(type, bubbles, cancelable);
            _loc_1.sound = this.sound;
            return _loc_1;
        }// end function

    }
}
