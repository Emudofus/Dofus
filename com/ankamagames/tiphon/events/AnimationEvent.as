package com.ankamagames.tiphon.events
{
   import flash.events.Event;
   
   public class AnimationEvent extends Event
   {
      
      public function AnimationEvent(param1:String, param2:String, param3:Boolean=false, param4:Boolean=false) {
         super(param1,param3,param4);
         this._id = param2;
      }
      
      public static const EVENT:String = "animationEventEvent";
      
      public static const ANIM:String = "animationAnimEvent";
      
      private var _id:String;
      
      public function get id() : String {
         return this._id;
      }
      
      override public function clone() : Event {
         return new AnimationEvent(type,this.id,bubbles,cancelable);
      }
   }
}
