package com.ankamagames.tubul.events
{
    import flash.events.*;

    public class AudioBusVolumeEvent extends Event
    {
        public var newVolume:Number;
        public static const VOLUME_CHANGED:String = "volume_changed";

        public function AudioBusVolumeEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new AudioBusVolumeEvent(type, bubbles, cancelable);
            _loc_1.newVolume = this.newVolume;
            return _loc_1;
        }// end function

    }
}
