package com.ankamagames.dofus.types.events
{
    import flash.events.*;

    public class RpcEvent extends Event
    {
        public static const ERROR:String = "RpcEvent_Error";

        public function RpcEvent()
        {
            super(ERROR);
            return;
        }// end function

    }
}
