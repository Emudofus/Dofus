package com.ankamagames.tubul.events
{
   import flash.events.Event;
   
   public class AudioBusVolumeEvent extends Event
   {
      
      public function AudioBusVolumeEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const VOLUME_CHANGED:String = "volume_changed";
      
      public var newVolume:Number;
      
      override public function clone() : Event {
         var _loc1_:AudioBusVolumeEvent = new AudioBusVolumeEvent(type,bubbles,cancelable);
         _loc1_.newVolume = this.newVolume;
         return _loc1_;
      }
   }
}
