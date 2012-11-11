package com.ankamagames.jerakine.sequencer
{

    public class StartSequenceStep extends AbstractSequencable
    {
        private var _sequence:ISequencer;

        public function StartSequenceStep(param1:ISequencer)
        {
            this._sequence = param1;
            return;
        }// end function

        override public function start() : void
        {
            if (this._sequence)
            {
                this._sequence.start();
            }
            executeCallbacks();
            return;
        }// end function

    }
}
