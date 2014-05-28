package com.ankamagames.jerakine.utils.parser
{
   import com.ankamagames.jerakine.types.SoundEventParamWrapper;
   
   public class FLAEventLabelParser extends Object
   {
      
      public function FLAEventLabelParser() {
         super();
      }
      
      private static var BALISE_PARAM_DELIMITER:String = ";";
      
      private static var BALISE_PARAM_ASSIGN:String = "=";
      
      private static var BALISE_PARAM_NEXT_PARAM:String = ",";
      
      private static var PARAM_ID:String = "id";
      
      private static var PARAM_VOLUME:String = "vol";
      
      private static var PARAM_ROLLOFF:String = "rollOff";
      
      private static var PARAM_BERCEAU_DUREE:String = "berceauDuree";
      
      private static var PARAM_BERCEAU_VOL:String = "berceauVol";
      
      private static var PARAM_BERCEAU_FADE_IN:String = "berceauFadeIn";
      
      private static var PARAM_BERCEAU_FADE_OUT:String = "berceauFadeOut";
      
      private static var PARAM_NO_CUT_SILENCE:String = "noCutSilence";
      
      public static function parseSoundLabel(pParams:String) : Array {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function buildSoundLabel(soundEvents:Vector.<SoundEventParamWrapper>) : String {
         var soundEvent:SoundEventParamWrapper = null;
         var label:String = null;
         var aIds:Vector.<String> = new Vector.<String>();
         var aVols:Vector.<uint> = new Vector.<uint>();
         if((!soundEvents) || (soundEvents.length == 0))
         {
            return null;
         }
         for each(soundEvent in soundEvents)
         {
            aIds.push(soundEvent.id);
            aVols.push(soundEvent.volume);
         }
         label = PARAM_ID + "=" + aIds.join(",") + "; " + PARAM_VOLUME + "=" + aVols.join(",") + "; " + PARAM_ROLLOFF + "=" + soundEvents[0].rollOff + "; " + PARAM_BERCEAU_DUREE + "=" + soundEvents[0].berceauDuree + "; " + PARAM_BERCEAU_VOL + "=" + soundEvents[0].berceauVol + "; " + PARAM_BERCEAU_FADE_IN + "=" + soundEvents[0].berceauFadeIn + "; " + PARAM_BERCEAU_FADE_OUT + "=" + soundEvents[0].berceauFadeOut + "; " + PARAM_NO_CUT_SILENCE + "=" + soundEvents[0].noCutSilence;
         return label;
      }
   }
}
