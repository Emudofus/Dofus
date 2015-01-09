package com.ankamagames.jerakine.sequencer
{
    public class StartSequenceStep extends AbstractSequencable 
    {

        private var _sequence:ISequencer;

        public function StartSequenceStep(sequence:ISequencer)
        {
            this._sequence = sequence;
        }

        override public function start():void
        {
            if (this._sequence)
            {
                this._sequence.start();
            };
            executeCallbacks();
        }


    }
}//package com.ankamagames.jerakine.sequencer

