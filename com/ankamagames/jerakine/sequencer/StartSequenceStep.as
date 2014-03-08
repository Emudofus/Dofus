package com.ankamagames.jerakine.sequencer
{
   public class StartSequenceStep extends AbstractSequencable
   {
      
      public function StartSequenceStep(param1:ISequencer) {
         super();
         this._sequence = param1;
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
