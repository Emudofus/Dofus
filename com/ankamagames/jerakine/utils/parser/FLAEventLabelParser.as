package com.ankamagames.jerakine.utils.parser
{
   import com.ankamagames.jerakine.types.SoundEventParamWrapper;
   import __AS3__.vec.Vector;
   
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
      
      public static function parseSoundLabel(param1:String) : Array {
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc16_:String = null;
         var _loc17_:RegExp = null;
         var _loc18_:String = null;
         var _loc19_:Array = null;
         var _loc20_:String = null;
         var _loc21_:uint = 0;
         var _loc22_:SoundEventParamWrapper = null;
         var _loc2_:Array = new Array();
         var _loc3_:Array = param1.split(BALISE_PARAM_DELIMITER);
         var _loc4_:uint = _loc3_.length;
         var _loc5_:Vector.<String> = new Vector.<String>();
         var _loc6_:Vector.<uint> = new Vector.<uint>();
         var _loc12_:* = false;
         var _loc13_:uint = 0;
         while(_loc13_ < _loc4_)
         {
            _loc16_ = _loc3_[_loc13_].split(BALISE_PARAM_ASSIGN)[0];
            _loc17_ = new RegExp("^\\s*(.*?)\\s*$","g");
            _loc16_ = _loc16_.replace(_loc17_,"$1");
            _loc18_ = _loc3_[_loc13_].split(BALISE_PARAM_ASSIGN)[1];
            _loc19_ = _loc18_.split(BALISE_PARAM_NEXT_PARAM);
            switch(_loc16_.toUpperCase())
            {
               case PARAM_ID.toUpperCase():
                  for each (_loc20_ in _loc19_)
                  {
                     _loc20_ = _loc20_.replace(_loc17_,"$1");
                     _loc5_.push(_loc20_);
                  }
                  break;
               case PARAM_VOLUME.toUpperCase():
                  for each (_loc21_ in _loc19_)
                  {
                     _loc6_.push(_loc21_);
                  }
                  break;
               case PARAM_ROLLOFF.toUpperCase():
                  _loc7_ = _loc19_[0];
                  break;
               case PARAM_BERCEAU_DUREE.toUpperCase():
                  _loc8_ = _loc19_[0];
                  break;
               case PARAM_BERCEAU_VOL.toUpperCase():
                  _loc9_ = _loc19_[0];
                  break;
               case PARAM_BERCEAU_FADE_IN.toUpperCase():
                  _loc10_ = _loc19_[0];
                  break;
               case PARAM_BERCEAU_FADE_OUT.toUpperCase():
                  _loc11_ = _loc19_[0];
                  break;
               case PARAM_NO_CUT_SILENCE.toUpperCase():
                  if(String(_loc19_[0]).match("false"))
                  {
                     _loc12_ = false;
                  }
                  else
                  {
                     _loc12_ = true;
                  }
                  break;
            }
            _loc13_++;
         }
         var _loc14_:uint = _loc5_.length;
         if(_loc5_.length != _loc6_.length)
         {
            throw new Error("The number of sound id and volume are differents");
         }
         else
         {
            _loc15_ = 0;
            while(_loc15_ < _loc14_)
            {
               _loc22_ = new SoundEventParamWrapper(_loc5_[_loc15_],_loc6_[_loc15_],_loc7_);
               _loc22_.berceauDuree = _loc8_;
               _loc22_.berceauVol = _loc9_;
               _loc22_.berceauFadeIn = _loc10_;
               _loc22_.berceauFadeOut = _loc11_;
               _loc22_.noCutSilence = _loc12_;
               _loc2_.push(_loc22_);
               _loc15_++;
            }
            return _loc2_;
         }
      }
      
      public static function buildSoundLabel(param1:Vector.<SoundEventParamWrapper>) : String {
         var _loc4_:SoundEventParamWrapper = null;
         var _loc5_:String = null;
         var _loc2_:Vector.<String> = new Vector.<String>();
         var _loc3_:Vector.<uint> = new Vector.<uint>();
         if(!param1 || param1.length == 0)
         {
            return null;
         }
         for each (_loc4_ in param1)
         {
            _loc2_.push(_loc4_.id);
            _loc3_.push(_loc4_.volume);
         }
         _loc5_ = PARAM_ID + "=" + _loc2_.join(",") + "; " + PARAM_VOLUME + "=" + _loc3_.join(",") + "; " + PARAM_ROLLOFF + "=" + param1[0].rollOff + "; " + PARAM_BERCEAU_DUREE + "=" + param1[0].berceauDuree + "; " + PARAM_BERCEAU_VOL + "=" + param1[0].berceauVol + "; " + PARAM_BERCEAU_FADE_IN + "=" + param1[0].berceauFadeIn + "; " + PARAM_BERCEAU_FADE_OUT + "=" + param1[0].berceauFadeOut + "; " + PARAM_NO_CUT_SILENCE + "=" + param1[0].noCutSilence;
         return _loc5_;
      }
   }
}
