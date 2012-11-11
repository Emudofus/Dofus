package com.ankamagames.jerakine.resources.events
{
    import com.ankamagames.jerakine.types.*;
    import flash.events.*;

    public class ResourceProgressEvent extends ResourceEvent
    {
        public var uri:Uri;
        public var bytesLoaded:uint;
        public var bytesTotal:uint;
        public static const PROGRESS:String = "progress";

        public function ResourceProgressEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new ResourceProgressEvent(type, bubbles, cancelable);
            _loc_1.uri = this.uri;
            _loc_1.bytesLoaded = this.bytesLoaded;
            _loc_1.bytesTotal = this.bytesTotal;
            return _loc_1;
        }// end function

    }
}
