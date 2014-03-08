package com.ankamagames.berilia.types.event
{
   import com.ankamagames.jerakine.logger.LogEvent;
   import flash.utils.Dictionary;
   import flash.events.Event;
   
   public class HookLogEvent extends LogEvent
   {
      
      public function HookLogEvent(param1:String, param2:Array) {
         super(null,null,0);
         this._hookName = param1;
         this._params = param2;
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
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
