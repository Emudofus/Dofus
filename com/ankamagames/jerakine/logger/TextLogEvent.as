package com.ankamagames.jerakine.logger
{
   import flash.events.Event;
   
   public class TextLogEvent extends LogEvent
   {
      
      public function TextLogEvent(category:String=null, message:String=null, logLevel:uint=0) {
         super(category,message,logLevel);
      }
      
      override public function clone() : Event {
         return new TextLogEvent(category,message,level);
      }
   }
}
