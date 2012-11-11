package com.ankamagames.jerakine.sequencer
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.events.*;
    import flash.utils.*;

    public class SerialSequencer extends EventDispatcher implements ISequencer, IEventDispatcher
    {
        private var _aStep:Array;
        private var _currentStep:ISequencable;
        private var _running:Boolean = false;
        private var _type:String;
        private var _activeSubSequenceCount:uint;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(SerialSequencer));
        public static const DEFAULT_SEQUENCER_NAME:String = "SerialSequencerDefault";
        private static var SEQUENCERS:Array = [];

        public function SerialSequencer(param1:String = "SerialSequencerDefault")
        {
            this._aStep = new Array();
            if (!SEQUENCERS[param1])
            {
                SEQUENCERS[param1] = new Dictionary(true);
            }
            SEQUENCERS[param1][this] = true;
            return;
        }// end function

        public function get currentStep() : ISequencable
        {
            return this._currentStep;
        }// end function

        public function get length() : uint
        {
            return this._aStep.length;
        }// end function

        public function get running() : Boolean
        {
            return this._running;
        }// end function

        public function get steps() : Array
        {
            return this._aStep;
        }// end function

        public function addStep(param1:ISequencable) : void
        {
            this._aStep.push(param1);
            return;
        }// end function

        public function start() : void
        {
            if (!this._running)
            {
                this._running = this._aStep.length != 0;
                if (this._running)
                {
                    this.execute();
                }
                else
                {
                    dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_END, false, false, this));
                }
            }
            return;
        }// end function

        public function clear() : void
        {
            var _loc_1:* = null;
            if (this._currentStep)
            {
                this._currentStep.clear();
                this._currentStep = null;
            }
            for each (_loc_1 in this._aStep)
            {
                
                _loc_1.clear();
            }
            this._aStep = new Array();
            return;
        }// end function

        override public function toString() : String
        {
            var _loc_1:* = "";
            var _loc_2:* = 0;
            while (_loc_2 < this._aStep.length)
            {
                
                _loc_1 = _loc_1 + (this._aStep[_loc_2].toString() + "\n");
                _loc_2 = _loc_2 + 1;
            }
            return _loc_1;
        }// end function

        private function execute() : void
        {
            this._currentStep = this._aStep.shift();
            if (!this._currentStep)
            {
                return;
            }
            FightProfiler.getInstance().start();
            this._currentStep.addListener(this);
            try
            {
                if (this._currentStep is ISubSequenceSequencable)
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._activeSubSequenceCount + 1;
                    _loc_2._activeSubSequenceCount = _loc_3;
                    ISubSequenceSequencable(this._currentStep).addEventListener(SequencerEvent.SEQUENCE_END, this.onSubSequenceEnd);
                }
                this._currentStep.start();
            }
            catch (e:Error)
            {
                if (_currentStep is ISubSequenceSequencable)
                {
                    var _loc_4:* = _activeSubSequenceCount - 1;
                    _activeSubSequenceCount = _loc_4;
                    ISubSequenceSequencable(_currentStep).removeEventListener(SequencerEvent.SEQUENCE_END, onSubSequenceEnd);
                }
                _log.error("Exception sur la step " + _currentStep + " : \n" + e.getStackTrace());
                stepFinished();
            }
            return;
        }// end function

        public function stepFinished() : void
        {
            if (this._running)
            {
                this._running = this._aStep.length != 0;
                if (!this._running)
                {
                    if (!this._activeSubSequenceCount)
                    {
                        dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_END, false, false, this));
                    }
                    else
                    {
                        this._running = true;
                    }
                }
                else
                {
                    this.execute();
                }
            }
            return;
        }// end function

        private function onSubSequenceEnd(event:SequencerEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._activeSubSequenceCount - 1;
            _loc_2._activeSubSequenceCount = _loc_3;
            if (!this._activeSubSequenceCount)
            {
                this._running = false;
                dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_END, false, false, this));
            }
            return;
        }// end function

        public static function clearByType(param1:String) : void
        {
            var _loc_2:* = null;
            for (_loc_2 in SEQUENCERS[param1])
            {
                
                SerialSequencer.SerialSequencer(_loc_2).clear();
            }
            delete SEQUENCERS[param1];
            return;
        }// end function

    }
}
