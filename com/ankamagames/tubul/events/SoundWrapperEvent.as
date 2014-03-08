package com.ankamagames.tubul.events
{
   import flash.events.Event;
   
   public class SoundWrapperEvent extends Event
   {
      
      public function SoundWrapperEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const SOON_END_OF_FILE:String = "soon_end_of_file";
      
      override public function clone() : Event {
         var _loc1_:SoundWrapperEvent = new SoundWrapperEvent(this.type,this.bubbles,this.cancelable);
         return _loc1_;
      }
   }
}
