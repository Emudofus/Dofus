package com.ankamagames.jerakine.resources.events
{
    import com.ankamagames.jerakine.types.*;
    import flash.events.*;

    public class ResourceLoaderProgressEvent extends ResourceEvent
    {
        public var uri:Uri;
        public var filesLoaded:uint;
        public var filesTotal:uint;
        public static const LOADER_PROGRESS:String = "loaderProgress";
        public static const LOADER_COMPLETE:String = "loaderComplete";

        public function ResourceLoaderProgressEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new ResourceLoaderProgressEvent(type, bubbles, cancelable);
            _loc_1.uri = this.uri;
            _loc_1.filesLoaded = this.filesLoaded;
            _loc_1.filesTotal = this.filesTotal;
            return _loc_1;
        }// end function

    }
}
