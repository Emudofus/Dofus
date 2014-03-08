package com.ankamagames.tubul.events.LoadingSound
{
   import flash.events.Event;
   
   public class LoadingSoundEvent extends Event
   {
      
      public function LoadingSoundEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const LOADED:String = "loaded";
      
      public static const LOADING_FAILED:String = "loading_failed";
      
      public static const ON_PROGRESS:String = "on_progress";
      
      public var data;
      
      override public function clone() : Event {
         var _loc1_:LoadingSoundEvent = new LoadingSoundEvent(type,bubbles,cancelable);
         _loc1_.data = this.data;
         return _loc1_;
      }
   }
}
