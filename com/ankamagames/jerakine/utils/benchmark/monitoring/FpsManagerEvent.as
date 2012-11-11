package com.ankamagames.jerakine.utils.benchmark.monitoring
{
    import flash.events.*;

    public class FpsManagerEvent extends Event
    {
        public var data:Object;

        public function FpsManagerEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

    }
}
