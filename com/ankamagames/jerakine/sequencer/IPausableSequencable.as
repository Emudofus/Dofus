package com.ankamagames.jerakine.sequencer
{
    public interface IPausableSequencable extends ISequencable 
    {

        function pause():void;
        function resume():void;

    }
}//package com.ankamagames.jerakine.sequencer

