package com.ankamagames.jerakine.types.events
{
    import com.ankamagames.jerakine.sequencer.*;
    import flash.events.*;

    public class SequencerEvent extends Event
    {
        private var _sequancer:ISequencer;
        public static const SEQUENCE_END:String = "onSequenceEnd";

        public function SequencerEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:ISequencer = null)
        {
            super(param1, param2, param3);
            this._sequancer = param4;
            return;
        }// end function

        public function get sequencer() : ISequencer
        {
            return this._sequancer;
        }// end function

    }
}
