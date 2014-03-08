package com.ankamagames.tubul.events
{
   import flash.events.Event;
   import com.ankamagames.tubul.interfaces.ISoundController;
   
   public class FadeEvent extends Event
   {
      
      public function FadeEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const COMPLETE:String = "complete";
      
      public var soundSource:ISoundController;
      
      override public function clone() : Event {
         var _loc1_:FadeEvent = new FadeEvent(type,bubbles,cancelable);
         _loc1_.soundSource = this.soundSource;
         return _loc1_;
      }
   }
}
