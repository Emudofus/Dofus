package com.ankamagames.atouin.messages
{

    public class MapLoadingFailedMessage extends MapMessage
    {
        public var errorReason:uint;
        public static const NO_FILE:uint = 0;

        public function MapLoadingFailedMessage()
        {
            return;
        }// end function

    }
}
