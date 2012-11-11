package com.ankamagames.jerakine.resources.events
{
    import com.ankamagames.jerakine.types.*;
    import flash.events.*;

    public class ResourceLoadedEvent extends ResourceEvent
    {
        public var resource:Object;
        public var resourceType:uint = 255;
        public var uri:Uri;
        public static const LOADED:String = "loaded";

        public function ResourceLoadedEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new ResourceLoadedEvent(type, bubbles, cancelable);
            _loc_1.resource = this.resource;
            _loc_1.resourceType = this.resourceType;
            _loc_1.uri = this.uri;
            return _loc_1;
        }// end function

    }
}
