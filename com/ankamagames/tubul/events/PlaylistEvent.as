package com.ankamagames.tubul.events
{
   import flash.events.Event;
   import com.ankamagames.tubul.interfaces.ISound;
   
   public class PlaylistEvent extends Event
   {
      
      public function PlaylistEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
         super(type,bubbles,cancelable);
      }
      
      public static const COMPLETE:String = "complete";
      
      public static const NEW_SOUND:String = "new_sound";
      
      public var newSound:ISound;
      
      override public function clone() : Event {
         var pe:PlaylistEvent = new PlaylistEvent(type,bubbles,cancelable);
         pe.newSound = this.newSound;
         return pe;
      }
   }
}
