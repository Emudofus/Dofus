package com.ankamagames.jerakine.types.events
{
   import flash.events.Event;
   import com.ankamagames.jerakine.sequencer.ISequencer;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   
   public class SequencerEvent extends Event
   {
      
      public function SequencerEvent(param1:String, param2:ISequencer=null, param3:ISequencable=null) {
         super(param1,false,false);
         this._sequencer = param2;
         this._step = param3;
      }
      
      public static const SEQUENCE_END:String = "onSequenceEnd";
      
      public static const SEQUENCE_STEP_START:String = "SEQUENCE_STEP_START";
      
      public static const SEQUENCE_STEP_FINISH:String = "SEQUENCE_STEP_FINISH";
      
      public static const SEQUENCE_TIMEOUT:String = "onSequenceTimeOut";
      
      private var _sequencer:ISequencer;
      
      private var _step:ISequencable;
      
      public function get sequencer() : ISequencer {
         return this._sequencer;
      }
      
      public function get step() : ISequencable {
         return this._step;
      }
   }
}
