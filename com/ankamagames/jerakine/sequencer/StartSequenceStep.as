package com.ankamagames.jerakine.sequencer
{
   public class StartSequenceStep extends AbstractSequencable
   {
      
      public function StartSequenceStep(sequence:ISequencer) {
         super();
         this._sequence = sequence;
      }
      
      private var _sequence:ISequencer;
      
      override public function start() : void {
         if(this._sequence)
         {
            this._sequence.start();
         }
         executeCallbacks();
      }
   }
}
