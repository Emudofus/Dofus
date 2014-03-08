package com.ankamagames.tubul.events
{
   import flash.events.Event;
   
   public class TubulEvent extends Event
   {
      
      public function TubulEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const ACTIVATION:String = "activation";
      
      public var activated:Boolean;
      
      override public function clone() : Event {
         var _loc1_:TubulEvent = new TubulEvent(this.type,this.bubbles,this.cancelable);
         _loc1_.activated = this.activated;
         return _loc1_;
      }
   }
}
