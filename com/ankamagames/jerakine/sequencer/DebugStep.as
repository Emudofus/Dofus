package com.ankamagames.jerakine.sequencer
{
   public class DebugStep extends AbstractSequencable implements ISequencableListener
   {
      
      public function DebugStep(param1:String, param2:ISequencable=null) {
         super();
         this._message = param1;
         this._subStep = param2;
      }
      
      private var _message:String;
      
      private var _subStep:ISequencable;
      
      override public function start() : void {
         _log.debug(this._message);
         if(this._subStep)
         {
            this._subStep.addListener(this);
            this._subStep.start();
         }
         else
         {
            executeCallbacks();
         }
      }
      
      public function stepFinished(param1:ISequencable, param2:Boolean=false) : void {
         if(this._subStep)
         {
            this._subStep.removeListener(this);
         }
         executeCallbacks();
      }
   }
}
