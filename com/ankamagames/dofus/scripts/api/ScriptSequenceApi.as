package com.ankamagames.dofus.scripts.api
{
   import com.ankamagames.jerakine.lua.LuaPackage;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.types.events.SequencerEvent;
   import __AS3__.vec.*;
   
   public class ScriptSequenceApi extends Object implements LuaPackage
   {
      
      public function ScriptSequenceApi() {
         this._sequencers = new Vector.<SerialSequencer>(0);
         this._callbacks = new Vector.<Function>(0);
         super();
      }
      
      private var _sequencers:Vector.<SerialSequencer>;
      
      private var _callbacks:Vector.<Function>;
      
      public function hasSequences() : Boolean {
         return this._sequencers.length > 0;
      }
      
      public function create() : SerialSequencer {
         var _loc1_:SerialSequencer = new SerialSequencer("ScriptSequencer");
         this._sequencers.push(_loc1_);
         _loc1_.addEventListener(SequencerEvent.SEQUENCE_END,this.onSequenceEnd);
         return _loc1_;
      }
      
      public function addCompleteCallback(param1:Function) : void {
         this._callbacks.push(param1);
      }
      
      public function clear() : void {
         var _loc1_:SerialSequencer = null;
         for each (_loc1_ in this._sequencers)
         {
            _loc1_.clear();
         }
         this._sequencers.length = 0;
         this._callbacks.length = 0;
      }
      
      private function onSequenceEnd(param1:SequencerEvent) : void {
         var _loc2_:Function = null;
         param1.currentTarget.removeEventListener(SequencerEvent.SEQUENCE_END,this.onSequenceEnd);
         this._sequencers.splice(this._sequencers.indexOf(param1.currentTarget),1);
         if(this._sequencers.length == 0)
         {
            for each (_loc2_ in this._callbacks)
            {
               _loc2_.apply();
            }
            this._callbacks.length = 0;
         }
      }
   }
}
