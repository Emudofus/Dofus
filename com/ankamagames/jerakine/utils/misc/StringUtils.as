package com.ankamagames.jerakine.utils.misc
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class StringUtils extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(StringUtils));
        private static var pattern:Vector.<RegExp>;
        private static var patternReplace:Vector.<String>;

        public function StringUtils()
        {
            return;
        }// end function

        public static function cleanString(param1:String) : String
        {
            param1 = param1.split("&").join("&amp;");
            param1 = param1.split("<").join("&lt;");
            param1 = param1.split(">").join("&gt;");
            return param1;
        }// end function

        public static function fill(param1:String, param2:uint, param3:String, param4:Boolean = true) : String
        {
            if (!param3 || !param3.length)
            {
                return param1;
            }
            while (param1.length != param2)
            {
                
                if (param4)
                {
                    param1 = param3 + param1;
                    continue;
                }
                param1 = param1 + param3;
            }
            return param1;
        }// end function

        public static function replace(param1:String, param2 = null, param3 = null) : String
        {
            var _loc_6:* = 0;
            if (!param2)
            {
                return param1;
            }
            if (!param3)
            {
                if (param2 is Array)
                {
                    param3 = new Array(param2.length);
                }
                else
                {
                    return param1.split(param2).join("");
                }
            }
            if (!(param2 is Array))
            {
                return param1.split(param2).join(param3);
            }
            var _loc_4:* = param2.length;
            var _loc_5:* = param1;
            if (param3 is Array)
            {
                _loc_6 = 0;
                while (_loc_6 < _loc_4)
                {
                    
                    _loc_5 = _loc_5.split(param2[_loc_6]).join(param3[_loc_6]);
                    _loc_6 = _loc_6 + 1;
                }
            }
            else
            {
                _loc_6 = 0;
                while (_loc_6 < _loc_4)
                {
                    
                    _loc_5 = _loc_5.split(param2[_loc_6]).join(param3);
                    _loc_6 = _loc_6 + 1;
                }
            }
            return _loc_5;
        }// end function

        public static function concatSameString(param1:String, param2:String) : String
        {
            var _loc_3:* = param1.indexOf(param2);
            var _loc_4:* = 0;
            var _loc_5:* = _loc_3;
            while (_loc_5 != -1)
            {
                
                _loc_4 = _loc_5;
                _loc_5 = param1.indexOf(param2, (_loc_4 + 1));
                if (_loc_5 == _loc_3)
                {
                    break;
                }
                if (_loc_5 == _loc_4 + param2.length)
                {
                    param1 = param1.substring(0, _loc_5) + param1.substring(_loc_5 + param2.length);
                    _loc_5 = _loc_5 - param2.length;
                }
            }
            return param1;
        }// end function

        public static function getDelimitedText(param1:String, param2:String, param3:String, param4:Boolean = false) : Vector.<String>
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_5:* = new Vector.<String>;
            var _loc_6:* = false;
            var _loc_7:* = param1;
            while (!_loc_6)
            {
                
                _loc_8 = getSingleDelimitedText(_loc_7, param2, param3, param4);
                if (_loc_8 == "")
                {
                    _loc_6 = true;
                    continue;
                }
                _loc_5.push(_loc_8);
                if (!param4)
                {
                    _loc_8 = param2 + _loc_8 + param3;
                }
                _loc_9 = _loc_7.slice(0, _loc_7.indexOf(_loc_8));
                _loc_10 = _loc_7.slice(_loc_7.indexOf(_loc_8) + _loc_8.length);
                _loc_7 = _loc_9 + _loc_10;
            }
            return _loc_5;
        }// end function

        public static function getAllIndexOf(param1:String, param2:String) : Array
        {
            var _loc_7:* = 0;
            var _loc_3:* = new Array();
            var _loc_4:* = 0;
            var _loc_5:* = false;
            var _loc_6:* = 0;
            while (!_loc_5)
            {
                
                _loc_7 = param2.indexOf(param1, _loc_6);
                if (_loc_7 < _loc_6)
                {
                    _loc_5 = true;
                    continue;
                }
                _loc_3.push(_loc_7);
                _loc_6 = _loc_7 + param1.length;
            }
            return _loc_3;
        }// end function

        public static function noAccent(param1:String) : String
        {
            if (pattern == null || patternReplace == null)
            {
                initPattern();
            }
            return decomposeUnicode(param1);
        }// end function

        private static function initPattern() : void
        {
            pattern = new Vector.<RegExp>(29);
            pattern[0] = new RegExp("Š", "g");
            pattern[1] = new RegExp("Œ", "g");
            pattern[2] = new RegExp("Ž", "g");
            pattern[3] = new RegExp("š", "g");
            pattern[4] = new RegExp("œ", "g");
            pattern[5] = new RegExp("ž", "g");
            pattern[6] = new RegExp("[ÀÁÂÃÄÅ]", "g");
            pattern[7] = new RegExp("Æ", "g");
            pattern[8] = new RegExp("Ç", "g");
            pattern[9] = new RegExp("[ÈÉÊË]", "g");
            pattern[10] = new RegExp("[ÌÍÎÏ]", "g");
            pattern[11] = new RegExp("Ð", "g");
            pattern[12] = new RegExp("Ñ", "g");
            pattern[13] = new RegExp("[ÒÓÔÕÖØ]", "g");
            pattern[14] = new RegExp("[ÙÚÛÜ]", "g");
            pattern[15] = new RegExp("[ŸÝ]", "g");
            pattern[16] = new RegExp("Þ", "g");
            pattern[17] = new RegExp("ß", "g");
            pattern[18] = new RegExp("[àáâãäå]", "g");
            pattern[19] = new RegExp("æ", "g");
            pattern[20] = new RegExp("ç", "g");
            pattern[21] = new RegExp("[èéêë]", "g");
            pattern[22] = new RegExp("[ìíîï]", "g");
            pattern[23] = new RegExp("ð", "g");
            pattern[24] = new RegExp("ñ", "g");
            pattern[25] = new RegExp("[òóôõöø]", "g");
            pattern[26] = new RegExp("[ùúûü]", "g");
            pattern[27] = new RegExp("[ýÿ]", "g");
            pattern[28] = new RegExp("þ", "g");
            patternReplace = new Vector.<String>(29);
            patternReplace[0] = "S";
            patternReplace[1] = "Oe";
            patternReplace[2] = "Z";
            patternReplace[3] = "s";
            patternReplace[4] = "oe";
            patternReplace[5] = "z";
            patternReplace[6] = "A";
            patternReplace[7] = "Ae";
            patternReplace[8] = "C";
            patternReplace[9] = "E";
            patternReplace[10] = "I";
            patternReplace[11] = "D";
            patternReplace[12] = "N";
            patternReplace[13] = "O";
            patternReplace[14] = "U";
            patternReplace[15] = "Y";
            patternReplace[16] = "Th";
            patternReplace[17] = "ss";
            patternReplace[18] = "a";
            patternReplace[19] = "ae";
            patternReplace[20] = "c";
            patternReplace[21] = "e";
            patternReplace[22] = "i";
            patternReplace[23] = "d";
            patternReplace[24] = "n";
            patternReplace[25] = "o";
            patternReplace[26] = "u";
            patternReplace[27] = "y";
            patternReplace[28] = "th";
            return;
        }// end function

        private static function decomposeUnicode(param1:String) : String
        {
            var _loc_2:* = 0;
            var _loc_3:* = pattern.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                param1 = param1.replace(pattern[_loc_2], patternReplace[_loc_2]);
                _loc_2++;
            }
            return param1;
        }// end function

        private static function getSingleDelimitedText(param1:String, param2:String, param3:String, param4:Boolean = false) : String
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_5:* = "";
            var _loc_6:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = false;
            _loc_7 = param1.indexOf(param2, _loc_6);
            if (_loc_7 == -1)
            {
                return "";
            }
            _loc_6 = _loc_7 + param2.length;
            while (!_loc_11)
            {
                
                _loc_8 = param1.indexOf(param2, _loc_6);
                _loc_9 = param1.indexOf(param3, _loc_6);
                if (_loc_9 == -1)
                {
                    trace("Erreur ! On n\'a pas trouvé d\'occurence du second délimiteur.");
                    _loc_11 = true;
                }
                if (_loc_8 < _loc_9 && _loc_8 != -1)
                {
                    _loc_10 = _loc_10 + getAllIndexOf(param2, param1.slice(_loc_8 + param2.length, _loc_9)).length;
                    _loc_6 = _loc_9 + param2.length;
                    continue;
                }
                if (_loc_10 > 1)
                {
                    _loc_6 = _loc_9 + param3.length;
                    _loc_10 = _loc_10 - 1;
                    continue;
                }
                _loc_5 = param1.slice(_loc_7, _loc_9 + param3.length);
                _loc_11 = true;
            }
            if (!param4 && _loc_5 != "")
            {
                _loc_5 = _loc_5.slice(param2.length);
                _loc_5 = _loc_5.slice(0, _loc_5.length - param3.length);
            }
            return _loc_5;
        }// end function

        public static function kamasToString(param1:Number, param2:String = "-") : String
        {
            if (param2 == "-")
            {
                param2 = I18n.getUiText("ui.common.short.kama", []);
            }
            var _loc_3:* = formateIntToString(param1);
            if (param2 == "")
            {
                return _loc_3;
            }
            return _loc_3 + " " + param2;
        }// end function

        public static function stringToKamas(param1:String, param2:String = "-") : int
        {
            var _loc_3:* = null;
            var _loc_4:* = param1;
            do
            {
                
                _loc_3 = _loc_4;
                _loc_4 = _loc_3.replace(" ", "");
            }while (_loc_3 != _loc_4)
            do
            {
                
                _loc_3 = _loc_4;
                _loc_4 = _loc_3.replace(" ", "");
            }while (_loc_3 != _loc_4)
            if (param2 == "-")
            {
                param2 = I18n.getUiText("ui.common.short.kama", []);
            }
            if (_loc_3.substr(_loc_3.length - param2.length) == param2)
            {
                _loc_3 = _loc_3.substr(0, _loc_3.length - param2.length);
            }
            return int(_loc_3);
        }// end function

        public static function formateIntToString(param1:Number) : String
        {
            var _loc_5:* = 0;
            var _loc_2:* = "";
            var _loc_3:* = 1000;
            while (true)
            {
                
                if (param1 / _loc_3 < 1)
                {
                    _loc_2 = int(param1 % _loc_3 / (_loc_3 / 1000)) + " " + _loc_2;
                    break;
                    continue;
                }
                _loc_5 = int(param1 % _loc_3 / (_loc_3 / 1000));
                if (_loc_5 < 10)
                {
                    _loc_2 = "00" + _loc_5 + " " + _loc_2;
                }
                else if (_loc_5 < 100)
                {
                    _loc_2 = "0" + _loc_5 + " " + _loc_2;
                }
                else
                {
                    _loc_2 = _loc_5 + " " + _loc_2;
                }
                _loc_3 = _loc_3 * 1000;
            }
            var _loc_4:* = _loc_2.charAt((_loc_2.length - 1));
            if (_loc_2.charAt((_loc_2.length - 1)) == " ")
            {
                return _loc_2.substr(0, (_loc_2.length - 1));
            }
            return _loc_2;
        }// end function

    }
}
