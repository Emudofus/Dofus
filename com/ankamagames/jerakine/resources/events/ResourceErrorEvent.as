package com.ankamagames.jerakine.resources.events
{
    import com.ankamagames.jerakine.types.*;
    import flash.events.*;

    public class ResourceErrorEvent extends ResourceEvent
    {
        public var uri:Uri;
        public var errorMsg:String;
        public var errorCode:uint;
        public static const ERROR:String = "error";

        public function ResourceErrorEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new ResourceErrorEvent(type, bubbles, cancelable);
            _loc_1.uri = this.uri;
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.errorCode = this.errorCode;
            return _loc_1;
        }// end function

    }
}
