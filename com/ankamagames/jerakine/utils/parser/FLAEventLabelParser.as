package com.ankamagames.jerakine.utils.parser
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.types.*;

    public class FLAEventLabelParser extends Object
    {
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

        public function FLAEventLabelParser()
        {
            return;
        }// end function

        public static function parseSoundLabel(param1:String) : Array
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = 0;
            var _loc_22:* = null;
            var _loc_2:* = new Array();
            var _loc_3:* = param1.split(BALISE_PARAM_DELIMITER);
            var _loc_4:* = _loc_3.length;
            var _loc_5:* = new Vector.<String>;
            var _loc_6:* = new Vector.<uint>;
            var _loc_12:* = false;
            var _loc_13:* = 0;
            while (_loc_13 < _loc_4)
            {
                
                _loc_16 = _loc_3[_loc_13].split(BALISE_PARAM_ASSIGN)[0];
                _loc_17 = /^\s*(.*?)\s*$""^\s*(.*?)\s*$/g;
                _loc_16 = _loc_16.replace(_loc_17, "$1");
                _loc_18 = _loc_3[_loc_13].split(BALISE_PARAM_ASSIGN)[1];
                _loc_19 = _loc_18.split(BALISE_PARAM_NEXT_PARAM);
                switch(_loc_16.toUpperCase())
                {
                    case PARAM_ID.toUpperCase():
                    {
                        for each (_loc_20 in _loc_19)
                        {
                            
                            _loc_20 = _loc_20.replace(_loc_17, "$1");
                            _loc_5.push(_loc_20);
                        }
                        break;
                    }
                    case PARAM_VOLUME.toUpperCase():
                    {
                        for each (_loc_21 in _loc_19)
                        {
                            
                            _loc_6.push(_loc_21);
                        }
                        break;
                    }
                    case PARAM_ROLLOFF.toUpperCase():
                    {
                        _loc_7 = _loc_19[0];
                        break;
                    }
                    case PARAM_BERCEAU_DUREE.toUpperCase():
                    {
                        _loc_8 = _loc_19[0];
                        break;
                    }
                    case PARAM_BERCEAU_VOL.toUpperCase():
                    {
                        _loc_9 = _loc_19[0];
                        break;
                    }
                    case PARAM_BERCEAU_FADE_IN.toUpperCase():
                    {
                        _loc_10 = _loc_19[0];
                        break;
                    }
                    case PARAM_BERCEAU_FADE_OUT.toUpperCase():
                    {
                        _loc_11 = _loc_19[0];
                        break;
                    }
                    case PARAM_NO_CUT_SILENCE.toUpperCase():
                    {
                        if (String(_loc_19[0]).match("false"))
                        {
                            _loc_12 = false;
                        }
                        else
                        {
                            _loc_12 = true;
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_13 = _loc_13 + 1;
            }
            var _loc_14:* = _loc_5.length;
            if (_loc_5.length != _loc_6.length)
            {
                throw new Error("The number of sound id and volume are differents");
            }
            var _loc_15:* = 0;
            while (_loc_15 < _loc_14)
            {
                
                _loc_22 = new SoundEventParamWrapper(_loc_5[_loc_15], _loc_6[_loc_15], _loc_7);
                _loc_22.berceauDuree = _loc_8;
                _loc_22.berceauVol = _loc_9;
                _loc_22.berceauFadeIn = _loc_10;
                _loc_22.berceauFadeOut = _loc_11;
                _loc_22.noCutSilence = _loc_12;
                _loc_2.push(_loc_22);
                _loc_15 = _loc_15 + 1;
            }
            return _loc_2;
        }// end function

        public static function buildSoundLabel(param1:Vector.<SoundEventParamWrapper>) : String
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = new Vector.<String>;
            var _loc_3:* = new Vector.<uint>;
            if (!param1 || param1.length == 0)
            {
                return null;
            }
            for each (_loc_4 in param1)
            {
                
                _loc_2.push(_loc_4.id);
                _loc_3.push(_loc_4.volume);
            }
            _loc_5 = PARAM_ID + "=" + _loc_2.join(",") + "; " + PARAM_VOLUME + "=" + _loc_3.join(",") + "; " + PARAM_ROLLOFF + "=" + param1[0].rollOff + "; " + PARAM_BERCEAU_DUREE + "=" + param1[0].berceauDuree + "; " + PARAM_BERCEAU_VOL + "=" + param1[0].berceauVol + "; " + PARAM_BERCEAU_FADE_IN + "=" + param1[0].berceauFadeIn + "; " + PARAM_BERCEAU_FADE_OUT + "=" + param1[0].berceauFadeOut + "; " + PARAM_NO_CUT_SILENCE + "=" + param1[0].noCutSilence;
            return _loc_5;
        }// end function

    }
}
