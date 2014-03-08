package com.ankamagames.tubul.events
{
   import flash.events.Event;
   
   public class SoundSilenceEvent extends Event
   {
      
      public function SoundSilenceEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const START:String = "start";
      
      public static const COMPLETE:String = "complete";
      
      override public function clone() : Event {
         var _loc1_:SoundSilenceEvent = new SoundSilenceEvent(this.type,this.bubbles,this.cancelable);
         return _loc1_;
      }
   }
}
