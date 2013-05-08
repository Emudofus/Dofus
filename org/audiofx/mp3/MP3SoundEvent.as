package org.audiofx.mp3
{
   import flash.events.Event;
   import flash.media.Sound;


   public class MP3SoundEvent extends Event
   {
         

      public function MP3SoundEvent(type:String, sound:Sound, bubbles:Boolean=false, cancelable:Boolean=false) {
         super(type,bubbles,cancelable);
         this.sound=sound;
      }

      public static const COMPLETE:String = "complete";

      public var sound:Sound;
   }

}