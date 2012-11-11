package com.ankamagames.jerakine.resources.events
{
    import flash.events.*;

    public class ResourceEvent extends Event
    {

        public function ResourceEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            return new ResourceEvent(type, bubbles, cancelable);
        }// end function

    }
}
