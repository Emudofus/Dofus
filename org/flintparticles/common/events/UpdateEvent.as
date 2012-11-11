package org.flintparticles.common.events
{
    import flash.events.*;

    public class UpdateEvent extends Event
    {
        public var time:Number;
        public static var UPDATE:String = "update";

        public function UpdateEvent(param1:String, param2:Number = NaN, param3:Boolean = false, param4:Boolean = false)
        {
            super(param1, param3, param4);
            this.time = param2;
            return;
        }// end function

    }
}
