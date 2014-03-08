package com.ankamagames.jerakine.types.events
{
   import com.ankamagames.jerakine.logger.LogEvent;
   import flash.events.Event;
   
   public class RegisterClassLogEvent extends LogEvent
   {
      
      public function RegisterClassLogEvent(param1:String) {
         super(null,null,0);
         this._className = param1;
      }
      
      private var _className:String;
      
      public function get className() : String {
         return this._className;
      }
      
      override public function clone() : Event {
         return new RegisterClassLogEvent(this._className);
      }
   }
}
