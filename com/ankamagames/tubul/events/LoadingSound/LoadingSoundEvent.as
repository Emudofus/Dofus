package com.ankamagames.tubul.events.LoadingSound
{
    import flash.events.*;

    public class LoadingSoundEvent extends Event
    {
        public var data:Object;
        public static const LOADED:String = "loaded";
        public static const LOADING_FAILED:String = "loading_failed";
        public static const ON_PROGRESS:String = "on_progress";

        public function LoadingSoundEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new LoadingSoundEvent(type, bubbles, cancelable);
            _loc_1.data = this.data;
            return _loc_1;
        }// end function

    }
}
