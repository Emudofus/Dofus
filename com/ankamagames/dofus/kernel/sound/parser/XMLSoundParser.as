package com.ankamagames.dofus.kernel.sound.parser
{
   import com.ankamagames.jerakine.types.SoundEventParamWrapper;
   import __AS3__.vec.*;
   
   public class XMLSoundParser extends Object
   {
      
      public function XMLSoundParser() {
         super();
      }
      
      private static const _IDS_UNLOCALIZED:Array = new Array("20","17","16");
      
      public static function parseXMLSoundFile(pXMLFile:XML, pSkins:Vector.<uint>) : SoundEventParamWrapper {
         var matchingSoundNode:XML = null;
         var sound:XML = null;
         var vectorSEPW:Vector.<SoundEventParamWrapper> = null;
         var Sounds:XMLList = null;
         var aSounds:Vector.<SoundEventParamWrapper> = null;
         var Sound:XML = null;
         var randomIndex:uint = 0;
         var skinsString:String = null;
         var skins:Array = null;
         var skin:String = null;
         var skinGapless:String = null;
         var skinId:uint = 0;
         var sepw:SoundEventParamWrapper = null;
         var sounds:XMLList = pXMLFile.elements();
         var r:RegExp = new RegExp("^\\s*(.*?)\\s*$","g");
         for each (sound in sounds)
         {
            if(matchingSoundNode == null)
            {
               skinsString = sound.@skin;
               skins = skinsString.split(",");
               for each (skin in skins)
               {
                  skinGapless = skin.replace(r,"$1");
                  for each (skinId in pSkins)
                  {
                     if(skinGapless == skinId.toString())
                     {
                        matchingSoundNode = sound;
                     }
                  }
               }
            }
         }
         vectorSEPW = new Vector.<SoundEventParamWrapper>();
         Sounds = matchingSoundNode.elements();
         aSounds = new Vector.<SoundEventParamWrapper>();
         for each (Sound in Sounds)
         {
            sepw = new SoundEventParamWrapper(Sound.Id,Sound.Volume,Sound.RollOff);
            sepw.berceauDuree = Sound.BerceauDuree;
            sepw.berceauVol = Sound.BerceauVol;
            sepw.berceauFadeIn = Sound.BerceauFadeIn;
            sepw.berceauFadeOut = Sound.BerceauFadeOut;
            vectorSEPW.push(sepw);
         }
         randomIndex = Math.random() * Math.floor(vectorSEPW.length - 1);
         return vectorSEPW[randomIndex];
      }
      
      public static function isLocalized(pSoundId:String) : Boolean {
         var patternBegin:String = null;
         for each (patternBegin in _IDS_UNLOCALIZED)
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
