package com.ankamagames.tubul.events
{
   import flash.events.Event;
   
   public class TubulEvent extends Event
   {
      
      public function TubulEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
         super(type,bubbles,cancelable);
      }
      
      public static const ACTIVATION:String = "activation";
      
      public var activated:Boolean;
      
      override public function clone() : Event {
         var e:TubulEvent = new TubulEvent(this.type,this.bubbles,this.cancelable);
         e.activated = this.activated;
         return e;
      }
   }
}
