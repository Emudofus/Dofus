package com.ankamagames.jerakine.utils.pattern
{

    public class PatternDecoder extends Object
    {

        public function PatternDecoder()
        {
            return;
        }// end function

        public static function getDescription(param1:String, param2:Array) : String
        {
            var _loc_3:* = param1.split("");
            var _loc_4:* = decodeDescription(_loc_3, param2).join("");
            return decodeDescription(_loc_3, param2).join("");
        }// end function

        public static function combine(param1:String, param2:String, param3:Boolean) : String
        {
            if (!param1)
            {
                return "";
            }
            var _loc_4:* = param1.split("");
            var _loc_5:* = new Object();
            new Object().m = param2 == "m";
            _loc_5.f = param2 == "f";
            _loc_5.n = param2 == "n";
            _loc_5.p = !param3;
            _loc_5.s = param3;
            var _loc_6:* = decodeCombine(_loc_4, _loc_5).join("");
            return decodeCombine(_loc_4, _loc_5).join("");
        }// end function

        public static function decode(param1:String, param2:Array) : String
        {
            if (!param1)
            {
                return "";
            }
            return decodeCombine(param1.split(""), param2).join("");
        }// end function

        public static function replace(param1:String, param2:String) : String
        {
            var _loc_5:* = null;
            var _loc_3:* = param1.split("##");
            var _loc_4:* = 1;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = _loc_3[_loc_4].split(",");
                _loc_3[_loc_4] = getDescription(param2, _loc_5);
                _loc_4 = _loc_4 + 2;
            }
            return _loc_3.join("");
        }// end function

        public static function replaceStr(param1:String, param2:String, param3:String) : String
        {
            var _loc_4:* = param1.split(param2);
            return param1.split(param2).join(param3);
        }// end function

        private static function findOptionnalDices(param1:Array, param2:Array) : Array
        {
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_3:* = param1.length;
            var _loc_4:* = "";
            var _loc_5:* = new Array();
            var _loc_6:* = new Array();
            var _loc_7:* = param1;
            var _loc_8:* = find(param1, "{");
            var _loc_9:* = find(param1, "}");
            if (_loc_8 >= 0 && _loc_9 > _loc_8)
            {
                _loc_10 = 0;
                while (param1[_loc_8 - (_loc_10 + 1)] == " ")
                {
                    
                    _loc_10 = _loc_10 + 1;
                }
                _loc_11 = 0;
                while (param1[_loc_9 + (_loc_11 + 1)] == " ")
                {
                    
                    _loc_11 = _loc_11 + 1;
                }
                _loc_5 = param1.splice(0, _loc_8 - (2 + _loc_10));
                _loc_6 = param1.splice(_loc_9 - _loc_8 + 5 + _loc_11 + _loc_10, param1.length - (_loc_9 - _loc_8));
                if (param1[0] == "#" && param1[param1.length - 2] == "#")
                {
                    if (param2[1] == null && param2[2] == null && param2[3] == null)
                    {
                        _loc_5.push(param2[0]);
                    }
                    else if (param2[0] == 0 && param2[1] == 0)
                    {
                        _loc_5.push(param2[2]);
                    }
                    else if (!param2[2])
                    {
                        param1.splice(param1.indexOf("#"), 2, param2[0]);
                        param1.splice(param1.indexOf("{"), 1);
                        param1.splice(param1.indexOf("~"), 4);
                        param1.splice(param1.indexOf("#"), 2, param2[1]);
                        param1.splice(param1.indexOf("}"), 1);
                        _loc_5 = _loc_5.concat(param1);
                    }
                    else
                    {
                        param1.splice(param1.indexOf("#"), 2, param2[0] + param2[2]);
                        param1.splice(param1.indexOf("{"), 1);
                        param1.splice(param1.indexOf("~"), 4);
                        param1.splice(param1.indexOf("#"), 2, param2[0] * param2[1] + param2[2]);
                        param1.splice(param1.indexOf("}"), 1);
                        _loc_5 = _loc_5.concat(param1);
                    }
                    _loc_7 = _loc_5.concat(_loc_6);
                }
            }
            return _loc_7;
        }// end function

        private static function decodeDescription(param1:Array, param2:Array) : Array
        {
            var _loc_3:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = null;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            _loc_3 = 0;
            var _loc_4:* = new String();
            var _loc_5:* = param1.length;
            param1 = findOptionnalDices(param1, param2);
            while (_loc_3 < _loc_5)
            {
                
                _loc_4 = param1[_loc_3];
                switch(_loc_4)
                {
                    case "#":
                    {
                        _loc_6 = param1[(_loc_3 + 1)];
                        if (!isNaN(_loc_6))
                        {
                            if (param2[(_loc_6 - 1)] != undefined)
                            {
                                param1.splice(_loc_3, 2, param2[(_loc_6 - 1)]);
                                _loc_3 = _loc_3 - 1;
                            }
                            else
                            {
                                param1.splice(_loc_3, 2);
                                _loc_3 = _loc_3 - 2;
                            }
                        }
                        break;
                    }
                    case "~":
                    {
                        _loc_7 = param1[(_loc_3 + 1)];
                        if (!isNaN(_loc_7))
                        {
                            if (param2[(_loc_7 - 1)] != null)
                            {
                                param1.splice(_loc_3, 2);
                                _loc_3 = _loc_3 - 2;
                            }
                            else
                            {
                                return param1.slice(0, _loc_3);
                            }
                        }
                        break;
                    }
                    case "{":
                    {
                        _loc_8 = find(param1.slice(_loc_3), "}");
                        _loc_9 = decodeDescription(param1.slice((_loc_3 + 1), _loc_3 + _loc_8), param2).join("");
                        param1.splice(_loc_3, (_loc_8 + 1), _loc_9);
                        break;
                    }
                    case "[":
                    {
                        _loc_10 = find(param1.slice(_loc_3), "]");
                        _loc_11 = Number(param1.slice((_loc_3 + 1), _loc_3 + _loc_10).join(""));
                        if (!isNaN(_loc_11))
                        {
                            param1.splice(_loc_3, (_loc_10 + 1), param2[_loc_11] + " ");
                            _loc_3 = _loc_3 - _loc_10;
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            return param1;
        }// end function

        private static function decodeCombine(param1:Array, param2:Object) : Array
        {
            var _loc_3:* = NaN;
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            var _loc_8:* = null;
            _loc_3 = 0;
            var _loc_4:* = new String();
            var _loc_5:* = param1.length;
            while (_loc_3 < _loc_5)
            {
                
                _loc_4 = param1[_loc_3];
                switch(_loc_4)
                {
                    case "~":
                    {
                        _loc_6 = param1[(_loc_3 + 1)];
                        if (param2[_loc_6])
                        {
                            param1.splice(_loc_3, 2);
                            _loc_3 = _loc_3 - 2;
                        }
                        else
                        {
                            return param1.slice(0, _loc_3);
                        }
                        break;
                    }
                    case "{":
                    {
                        _loc_7 = find(param1.slice(_loc_3), "}");
                        _loc_8 = decodeCombine(param1.slice((_loc_3 + 1), _loc_3 + _loc_7), param2).join("");
                        param1.splice(_loc_3, (_loc_7 + 1), _loc_8);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            return param1;
        }// end function

        private static function find(param1:Array, param2:Object) : Number
        {
            var _loc_4:* = NaN;
            var _loc_3:* = param1.length;
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (param1[_loc_4] == param2)
                {
                    return _loc_4;
                }
                _loc_4 = _loc_4 + 1;
            }
            return -1;
        }// end function

    }
}
