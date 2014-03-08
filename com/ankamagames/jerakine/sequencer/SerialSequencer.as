package com.ankamagames.jerakine.sequencer
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.events.SequencerEvent;
   import com.ankamagames.jerakine.utils.misc.FightProfiler;
   import flash.utils.Dictionary;
   
   public class SerialSequencer extends EventDispatcher implements ISequencer, IEventDispatcher
   {
      
      public function SerialSequencer(param1:String="SerialSequencerDefault") {
         this._aStep = new Array();
         super();
         if(!SEQUENCERS[param1])
         {
            SEQUENCERS[param1] = new Dictionary(true);
         }
         SEQUENCERS[param1][this] = true;
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(SerialSequencer));
      
      public static const DEFAULT_SEQUENCER_NAME:String = "SerialSequencerDefault";
      
      private static var SEQUENCERS:Array = [];
      
      public static function clearByType(param1:String) : void {
         var _loc2_:Object = null;
         for (_loc2_ in SEQUENCERS[param1])
         {
            SerialSequencer(_loc2_).clear();
         }
         delete SEQUENCERS[[param1]];
      }
      
      private var _aStep:Array;
      
      private var _currentStep:ISequencable;
      
      private var _lastStep:ISequencable;
      
      private var _running:Boolean = false;
      
      private var _type:String;
      
      private var _activeSubSequenceCount:uint;
      
      private var _paused:Boolean;
      
      private var _defaultStepTimeout:int = -2147483648;
      
      public function get currentStep() : ISequencable {
         return this._currentStep;
      }
      
      public function get lastStep() : ISequencable {
         return this._lastStep;
      }
      
      public function get length() : uint {
         return this._aStep.length;
      }
      
      public function get running() : Boolean {
         return this._running;
      }
      
      public function get steps() : Array {
         return this._aStep;
      }
      
      public function set defaultStepTimeout(param1:int) : void {
         this._defaultStepTimeout = param1;
      }
      
      public function get defaultStepTimeout() : int {
         return this._defaultStepTimeout;
      }
      
      public function pause() : void {
         this._paused = true;
         if(this._currentStep is IPausableSequencable)
         {
            (this._currentStep as IPausableSequencable).pause();
         }
      }
      
      public function resume() : void {
         this._paused = false;
         if(this._currentStep is IPausableSequencable)
         {
            (this._currentStep as IPausableSequencable).resume();
            this._currentStep.start();
         }
      }
      
      public function add(param1:ISequencable) : void {
         if(param1)
         {
            this.addStep(param1);
         }
         else
         {
            _log.error("Tried to add a null step to the LUA script sequence, this step will be ignored");
         }
      }
      
      public function addStep(param1:ISequencable) : void {
         this._aStep.push(param1);
      }
      
      public function start() : void {
         if(!this._running)
         {
            this._running = !(this._aStep.length == 0);
            if(this._running)
            {
               this.execute();
            }
            else
            {
               dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_END,this));
            }
         }
      }
      
      public function clear() : void {
         var _loc1_:ISequencable = null;
         this._lastStep = null;
         if(this._currentStep)
         {
            this._currentStep.clear();
            this._currentStep = null;
         }
         for each (_loc1_ in this._aStep)
         {
            if(_loc1_)
            {
               _loc1_.clear();
            }
         }
         this._aStep = new Array();
      }
      
      override public function toString() : String {
         var _loc1_:* = "";
         var _loc2_:uint = 0;
         while(_loc2_ < this._aStep.length)
         {
            _loc1_ = _loc1_ + (this._aStep[_loc2_].toString() + "\n");
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function execute() : void {
         this._lastStep = this._currentStep;
         this._currentStep = this._aStep.shift();
         if(!this._currentStep)
         {
            return;
         }
         FightProfiler.getInstance().start();
         this._currentStep.addListener(this);
         try
         {
            if(this._currentStep is ISubSequenceSequencable)
            {
               this._activeSubSequenceCount++;
               ISubSequenceSequencable(this._currentStep).addEventListener(SequencerEvent.SEQUENCE_END,this.onSubSequenceEnd);
            }
            if(!(this._defaultStepTimeout == int.MIN_VALUE) && (this._currentStep.hasDefaultTimeout))
            {
               this._currentStep.timeout = this._defaultStepTimeout;
            }
            if(hasEventListener(SequencerEvent.SEQUENCE_STEP_START))
            {
               dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_STEP_START,this,this._currentStep));
            }
            this._currentStep.start();
         }
         catch(e:Error)
         {
            if(_currentStep is ISubSequenceSequencable)
            {
               _activeSubSequenceCount--;
               ISubSequenceSequencable(_currentStep).removeEventListener(SequencerEvent.SEQUENCE_END,onSubSequenceEnd);
            }
            _log.error("Exception sur la step " + _currentStep + " : \n" + e.getStackTrace());
            stepFinished(_currentStep);
         }
      }
      
      public function stepFinished(param1:ISequencable, param2:Boolean=false) : void {
         param1.removeListener(this);
         if(this._running)
         {
            if(param2)
            {
               dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_TIMEOUT,this));
            }
            if(hasEventListener(SequencerEvent.SEQUENCE_STEP_FINISH))
            {
               dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_STEP_FINISH,this,this._currentStep));
            }
            this._running = !(this._aStep.length == 0);
            if(!this._running)
            {
               if(!this._activeSubSequenceCount)
               {
                  dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_END,this));
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
         else
         {
            if(hasEventListener(SequencerEvent.SEQUENCE_STEP_FINISH))
            {
               dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_STEP_FINISH,this,this._currentStep));
            }
         }
      }
      
      private function onSubSequenceEnd(param1:SequencerEvent) : void {
         this._activeSubSequenceCount--;
         if(!this._activeSubSequenceCount)
         {
            this._running = false;
            dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_END,this));
         }
      }
   }
}
