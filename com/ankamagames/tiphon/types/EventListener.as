package com.ankamagames.tiphon.types
{
    import com.ankamagames.jerakine.interfaces.*;

    public class EventListener extends Object
    {
        public var listener:IFLAEventHandler;
        public var typesEvents:String;

        public function EventListener(param1:IFLAEventHandler, param2:String)
        {
            this.listener = param1;
            this.typesEvents = param2;
            return;
        }// end function

    }
}
