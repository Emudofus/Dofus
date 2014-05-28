package com.ankamagames.berilia.types.event
{
   import com.ankamagames.jerakine.logger.LogEvent;
   import flash.utils.Dictionary;
   import flash.events.Event;
   
   public class HookLogEvent extends LogEvent
   {
      
      public function HookLogEvent(hookName:String, params:Array) {
         super(null,null,0);
         this._hookName = hookName;
         this._params = params;
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary;
      
      private var _hookName:String;
      
      private var _params:Array;
      
      public function get name() : String {
         return this._hookName;
      }
      
      public function get params() : Array {
         return this._params;
      }
      
      override public function clone() : Event {
         return new HookLogEvent(this._hookName,this._params);
      }
   }
}
