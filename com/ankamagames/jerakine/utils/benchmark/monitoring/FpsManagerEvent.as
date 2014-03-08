package com.ankamagames.jerakine.utils.benchmark.monitoring
{
   import flash.events.Event;
   
   public class FpsManagerEvent extends Event
   {
      
      public function FpsManagerEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public var data:Object;
   }
}
