package com.ankamagames.jerakine.sequencer
{
   import com.ankamagames.jerakine.types.Callback;
   
   public class CallbackStep extends AbstractSequencable
   {
      
      public function CallbackStep(callback:Callback) {
         super();
         this._callback = callback;
      }
      
      private var _callback:Callback;
      
      override public function start() : void {
         this._callback.exec();
         executeCallbacks();
      }
   }
}
