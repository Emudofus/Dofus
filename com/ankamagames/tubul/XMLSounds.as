package com.ankamagames.tubul
{
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.managers.LangManager;
   
   public class XMLSounds extends Object
   {
      
      public function XMLSounds() {
         super();
      }
      
      private static const BREED_BONES_FILENAME:String = "2100000000.xml";
      
      public static const ROLLOFF_FILENAME:String = "presetsRollOff";
      
      public static const BREED_BONES_BARKS:Uri = new Uri(LangManager.getInstance().getEntry("config.audio.barks") + BREED_BONES_FILENAME);
      
      public static const ROLLOFF_PRESET:Uri = new Uri(LangManager.getInstance().getEntry("config.audio.presets") + ROLLOFF_FILENAME + ".xml");
   }
}
