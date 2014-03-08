package com.ankamagames.tubul.events
{
   import flash.events.Event;
   
   public class SoundWrapperEvent extends Event
   {
      
      public function SoundWrapperEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
         super(type,bubbles,cancelable);
      }
      
      public static const SOON_END_OF_FILE:String = "soon_end_of_file";
      
      override public function clone() : Event {
         var e:SoundWrapperEvent = new SoundWrapperEvent(this.type,this.bubbles,this.cancelable);
         return e;
      }
   }
}
