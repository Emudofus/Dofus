package com.ankamagames.atouin.messages
{
    import com.ankamagames.jerakine.messages.*;

    public class MapLoadedMessage extends MapMessage implements ILogableMessage
    {
        public var globalRenderingTime:uint;
        public var dataLoadingTime:uint;
        public var gfxLoadingTime:uint;
        public var renderingTime:uint;

        public function MapLoadedMessage()
        {
            return;
        }// end function

    }
}
