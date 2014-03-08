package com.ankamagames.tubul.events
{
   import flash.events.Event;
   import com.ankamagames.tubul.interfaces.ISound;
   
   public class PlaylistEvent extends Event
   {
      
      public function PlaylistEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const COMPLETE:String = "complete";
      
      public static const NEW_SOUND:String = "new_sound";
      
      public var newSound:ISound;
      
      override public function clone() : Event {
         var _loc1_:PlaylistEvent = new PlaylistEvent(type,bubbles,cancelable);
         _loc1_.newSound = this.newSound;
         return _loc1_;
      }
   }
}
