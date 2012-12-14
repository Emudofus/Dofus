package com.ankamagames.berilia.events
{
    import flash.events.*;

    public class LinkInteractionEvent extends Event
    {
        public var text:String;
        public static const ROLL_OVER:String = "RollOverLink";
        public static const ROLL_OUT:String = "RollOutLink";

        public function LinkInteractionEvent(param1:String, param2:String = "")
        {
            this.text = param2;
            super(param1, false, false);
            return;
        }// end function

    }
}
