package com.ankamagames.tubul.events
{
   import flash.events.Event;
   
   public class SoundSilenceEvent extends Event
   {
      
      public function SoundSilenceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
         super(type,bubbles,cancelable);
      }
      
      public static const START:String = "start";
      
      public static const COMPLETE:String = "complete";
      
      override public function clone() : Event {
         var e:SoundSilenceEvent = new SoundSilenceEvent(this.type,this.bubbles,this.cancelable);
         return e;
      }
   }
}
