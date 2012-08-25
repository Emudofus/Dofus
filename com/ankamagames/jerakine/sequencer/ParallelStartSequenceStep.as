package com.ankamagames.jerakine.sequencer
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.events.*;
    import flash.utils.*;

    public class ParallelStartSequenceStep extends AbstractSequencable implements ISubSequenceSequencable
    {
        private var _aSequence:Array;
        private var _waitAllSequenceEnd:Boolean;
        private var _waitFirstEndSequence:Boolean;
        private var _sequenceEndCount:uint = 0;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(ParallelStartSequenceStep));

        public function ParallelStartSequenceStep(param1:Array, param2:Boolean = true, param3:Boolean = false)
        {
            this._aSequence = param1;
            this._waitAllSequenceEnd = param2;
            this._waitFirstEndSequence = param3;
            return;
        }// end function

        override public function start() : void
        {
            var _loc_1:uint = 0;
            while (_loc_1 < this._aSequence.length)
            {
                
                ISequencer(this._aSequence[_loc_1]).addEventListener(SequencerEvent.SEQUENCE_END, this.onSequenceEnd);
                ISequencer(this._aSequence[_loc_1]).start();
                _loc_1 = _loc_1 + 1;
            }
            if (!this._waitAllSequenceEnd && !this._waitFirstEndSequence)
            {
                _log.debug("first executeCallbacks");
                executeCallbacks();
            }
            return;
        }// end function

        public function get sequenceEndCount() : uint
        {
            return this._sequenceEndCount;
        }// end function

        private function onSequenceEnd(event:SequencerEvent) : void
        {
            event.sequencer.removeEventListener(SequencerEvent.SEQUENCE_END, this.onSequenceEnd);
            var _loc_2:String = this;
            var _loc_3:* = this._sequenceEndCount + 1;
            _loc_2._sequenceEndCount = _loc_3;
            _log.debug("onSequenceEnd");
            if (this._sequenceEndCount == this._aSequence.length)
            {
                _log.debug("onSequenceEnd executeCallbacks");
                executeCallbacks();
                dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_END));
            }
            else if (!this._waitAllSequenceEnd)
            {
                if (this._sequenceEndCount == 1)
                {
                    executeCallbacks();
                }
            }
            return;
        }// end function

    }
}
