package com.ankamagames.tubul.events
{
   import flash.events.Event;
   import com.ankamagames.tubul.interfaces.ISoundController;
   
   public class FadeEvent extends Event
   {
      
      public function FadeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
         super(type,bubbles,cancelable);
      }
      
      public static const COMPLETE:String = "complete";
      
      public var soundSource:ISoundController;
      
      override public function clone() : Event {
         var fe:FadeEvent = new FadeEvent(type,bubbles,cancelable);
         fe.soundSource = this.soundSource;
         return fe;
      }
   }
}
