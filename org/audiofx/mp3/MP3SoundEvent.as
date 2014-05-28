package org.audiofx.mp3
{
   import flash.events.Event;
   import flash.media.Sound;
   
   public class MP3SoundEvent extends Event
   {
      
      public function MP3SoundEvent(param1:String, param2:Sound, param3:uint, param4:Boolean=false, param5:Boolean=false) {
         super(param1,param4,param5);
         this.sound = param2;
         this.channels = param3;
      }
      
      public static const COMPLETE:String = "complete";
      
      public var sound:Sound;
      
      public var channels:uint;
   }
}
