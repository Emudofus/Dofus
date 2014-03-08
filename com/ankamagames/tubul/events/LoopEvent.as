package com.ankamagames.tubul.events
{
   import flash.events.Event;
   
   public class LoopEvent extends Event
   {
      
      public function LoopEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const SOUND_LOOP:String = "sound_loop";
      
      public static const SOUND_LOOP_ALL_COMPLETE:String = "sound_loop_all_complete";
      
      public var sound;
      
      public var loop:uint;
      
      override public function clone() : Event {
         var _loc1_:LoopEvent = new LoopEvent(type,bubbles,cancelable);
         _loc1_.sound = this.sound;
         _loc1_.loop = this.loop;
         return _loc1_;
      }
   }
}
