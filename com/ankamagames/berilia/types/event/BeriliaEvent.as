package com.ankamagames.berilia.types.event
{
    import flash.events.*;

    public class BeriliaEvent extends Event
    {
        public static const REMOVE_COMPONENT:String = "Berilia_remove_component";

        public function BeriliaEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

    }
}
