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
         this._aStep=new Array();
         super();
         if(!SEQUENCERS[type])
         {
            SEQUENCERS[type]=new Dictionary(true);
         }
         SEQUENCERS[type][this]=true;
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

      private var _running:Boolean = false;

      private var _type:String;

      private var _activeSubSequenceCount:uint;

      public function get currentStep() : ISequencable {
         return this._currentStep;
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

      public function addStep(item:ISequencable) : void {
         this._aStep.push(item);
      }

      public function start() : void {
         if(!this._running)
         {
            this._running=!(this._aStep.length==0);
            if(this._running)
            {
               this.execute();
            }
            else
            {
               dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_END,false,false,this));
            }
         }
      }

      public function clear() : void {
         var step:ISequencable = null;
         if(this._currentStep)
         {
            this._currentStep.clear();
            this._currentStep=null;
         }
         for each (step in this._aStep)
         {
            step.clear();
         }
         this._aStep=new Array();
      }

      override public function toString() : String {
         var str:String = "";
         var i:uint = 0;
         while(i<this._aStep.length)
         {
            str=str+(this._aStep[i].toString()+"\n");
            i++;
         }
         return str;
      }

      private function execute() : void {
         this._currentStep=this._aStep.shift();
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
            this._currentStep.start();
         }
         catch(e:Error)
         {
            if(_currentStep is ISubSequenceSequencable)
            {
               _activeSubSequenceCount--;
               ISubSequenceSequencable(_currentStep).removeEventListener(SequencerEvent.SEQUENCE_END,onSubSequenceEnd);
            }
            _log.error("Exception sur la step "+_currentStep+" : \n"+e.getStackTrace());
            stepFinished();
         }
      }

      public function stepFinished() : void {
         if(this._running)
         {
            this._running=!(this._aStep.length==0);
            if(!this._running)
            {
               if(!this._activeSubSequenceCount)
               {
                  dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_END,false,false,this));
               }
               else
               {
                  this._running=true;
               }
            }
            else
            {
               this.execute();
            }
         }
      }

      private function onSubSequenceEnd(e:SequencerEvent) : void {
         this._activeSubSequenceCount--;
         if(!this._activeSubSequenceCount)
         {
            this._running=false;
            dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_END,false,false,this));
         }
      }
   }

}