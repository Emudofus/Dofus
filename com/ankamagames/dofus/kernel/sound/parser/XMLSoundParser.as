package com.ankamagames.dofus.kernel.sound.parser
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.types.*;

    public class XMLSoundParser extends Object
    {
        private var _xmlBreed:XML;
        private static const _IDS_UNLOCALIZED:Array = new Array("20", "17", "16");

        public function XMLSoundParser()
        {
            return;
        }// end function

        public static function parseXMLSoundFile(param1:XML, param2:Vector.<uint>) : SoundEventParamWrapper
        {
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = 0;
            var _loc_17:* = null;
            var _loc_3:* = param1.elements();
            var _loc_5:* = /^\s*(.*?)\s*$""^\s*(.*?)\s*$/g;
            for each (_loc_6 in _loc_3)
            {
                
                if (_loc_4 != null)
                {
                    continue;
                }
                _loc_12 = _loc_6.@skin;
                _loc_13 = _loc_12.split(",");
                for each (_loc_14 in _loc_13)
                {
                    
                    _loc_15 = _loc_14.replace(_loc_5, "$1");
                    for each (_loc_16 in param2)
                    {
                        
                        if (_loc_15 == _loc_16.toString())
                        {
                            _loc_4 = _loc_6;
                            continue;
                        }
                    }
                }
            }
            _loc_7 = new Vector.<SoundEventParamWrapper>;
            _loc_8 = _loc_4.elements();
            _loc_9 = new Vector.<SoundEventParamWrapper>;
            for each (_loc_10 in _loc_8)
            {
                
                _loc_17 = new SoundEventParamWrapper(_loc_10.Id, _loc_10.Volume, _loc_10.RollOff);
                _loc_17.berceauDuree = _loc_10.BerceauDuree;
                _loc_17.berceauVol = _loc_10.BerceauVol;
                _loc_17.berceauFadeIn = _loc_10.BerceauFadeIn;
                _loc_17.berceauFadeOut = _loc_10.BerceauFadeOut;
                _loc_7.push(_loc_17);
            }
            _loc_11 = Math.random() * Math.floor((_loc_7.length - 1));
            return _loc_7[_loc_11];
        }// end function

        public static function isLocalized(param1:String) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in _IDS_UNLOCALIZED)
            {
                
                if (param1.split(_loc_2)[0] == "")
                {
                    return false;
                }
            }
            return true;
        }// end function

    }
}
