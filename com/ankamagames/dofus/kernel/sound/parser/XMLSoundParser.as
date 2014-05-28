package com.ankamagames.dofus.kernel.sound.parser
{
   import com.ankamagames.jerakine.types.SoundEventParamWrapper;
   
   public class XMLSoundParser extends Object
   {
      
      public function XMLSoundParser() {
         super();
      }
      
      private static const _IDS_UNLOCALIZED:Array;
      
      public static function parseXMLSoundFile(pXMLFile:XML, pSkins:Vector.<uint>) : SoundEventParamWrapper {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function isLocalized(pSoundId:String) : Boolean {
         var patternBegin:String = null;
         for each(patternBegin in _IDS_UNLOCALIZED)
         {
            if(pSoundId.split(patternBegin)[0] == "")
            {
               return false;
            }
         }
         return true;
      }
      
      private var _xmlBreed:XML;
   }
}
