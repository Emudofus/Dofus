package com.ankamagames.atouin.messages
{
    import com.ankamagames.jerakine.messages.*;

    public class AdjacentMapClickMessage extends Object implements Message
    {
        public var adjacentMapId:uint;
        public var cellId:uint;

        public function AdjacentMapClickMessage()
        {
            return;
        }// end function

    }
}
