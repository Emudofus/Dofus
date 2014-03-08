package com.ankamagames.berilia.types.event
{
   import flash.events.Event;
   
   public class BeriliaEvent extends Event
   {
      
      public function BeriliaEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
         super(type,bubbles,cancelable);
      }
      
      public static const REMOVE_COMPONENT:String = "Berilia_remove_component";
   }
}
