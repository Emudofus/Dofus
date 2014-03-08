package com.ankamagames.jerakine.sequencer
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.events.SequencerEvent;
   
   public class ParallelStartSequenceStep extends AbstractSequencable implements ISubSequenceSequencable
   {
      
      public function ParallelStartSequenceStep(param1:Array, param2:Boolean=true, param3:Boolean=false) {
         super();
         this._aSequence = param1;
         this._waitAllSequenceEnd = param2;
         this._waitFirstEndSequence = param3;
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(ParallelStartSequenceStep));
      
      private var _aSequence:Array;
      
      private var _waitAllSequenceEnd:Boolean;
      
      private var _waitFirstEndSequence:Boolean;
      
      private var _sequenceEndCount:uint = 0;
      
      override public function start() : void {
         var _loc1_:uint = 0;
         while(_loc1_ < this._aSequence.length)
         {
            ISequencer(this._aSequence[_loc1_]).addEventListener(SequencerEvent.SEQUENCE_END,this.onSequenceEnd);
            ISequencer(this._aSequence[_loc1_]).start();
            _loc1_++;
         }
         if(!this._waitAllSequenceEnd && !this._waitFirstEndSequence)
         {
            _log.debug("first executeCallbacks");
            executeCallbacks();
         }
      }
      
      public function get sequenceEndCount() : uint {
         return this._sequenceEndCount;
      }
      
      private function onSequenceEnd(param1:SequencerEvent) : void {
         param1.sequencer.removeEventListener(SequencerEvent.SEQUENCE_END,this.onSequenceEnd);
         this._sequenceEndCount++;
         _log.debug("onSequenceEnd");
         if(this._sequenceEndCount == this._aSequence.length)
         {
            _log.debug("onSequenceEnd executeCallbacks");
            executeCallbacks();
            dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_END));
         }
         else
         {
            if(!this._waitAllSequenceEnd)
            {
               if(this._sequenceEndCount == 1)
               {
                  executeCallbacks();
               }
            }
         }
      }
   }
}
