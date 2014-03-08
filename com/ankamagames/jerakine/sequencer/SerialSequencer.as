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
      
      public function SerialSequencer(type:String="SerialSequencerDefault") {
         this._aStep = new Array();
         super();
         if(!SEQUENCERS[type])
         {
            SEQUENCERS[type] = new Dictionary(true);
         }
         SEQUENCERS[type][this] = true;
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(SerialSequencer));
      
      public static const DEFAULT_SEQUENCER_NAME:String = "SerialSequencerDefault";
      
      private static var SEQUENCERS:Array = [];
      
      public static function clearByType(type:String) : void {
         var seq:Object = null;
         for (seq in SEQUENCERS[type])
         {
            SerialSequencer(seq).clear();
         }
         delete SEQUENCERS[[type]];
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
      
      public function set defaultStepTimeout(v:int) : void {
         this._defaultStepTimeout = v;
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
      
      public function add(item:ISequencable) : void {
         if(item)
         {
            this.addStep(item);
         }
         else
         {
            _log.error("Tried to add a null step to the LUA script sequence, this step will be ignored");
         }
      }
      
      public function addStep(item:ISequencable) : void {
         this._aStep.push(item);
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
         var step:ISequencable = null;
         this._lastStep = null;
         if(this._currentStep)
         {
            this._currentStep.clear();
            this._currentStep = null;
         }
         for each (step in this._aStep)
         {
            if(step)
            {
               step.clear();
            }
         }
         this._aStep = new Array();
      }
      
      override public function toString() : String {
         var str:String = "";
         var i:uint = 0;
         while(i < this._aStep.length)
         {
            str = str + (this._aStep[i].toString() + "\n");
            i++;
         }
         return str;
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
            if((!(this._defaultStepTimeout == int.MIN_VALUE)) && (this._currentStep.hasDefaultTimeout))
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
      
      public function stepFinished(step:ISequencable, withTimout:Boolean=false) : void {
         step.removeListener(this);
         if(this._running)
         {
            if(withTimout)
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
      
      private function onSubSequenceEnd(e:SequencerEvent) : void {
         this._activeSubSequenceCount--;
         if(!this._activeSubSequenceCount)
         {
            this._running = false;
            dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_END,this));
         }
      }
   }
}
