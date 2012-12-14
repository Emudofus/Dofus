package com.ankamagames.tiphon.types.look
{
    import __AS3__.vec.*;

    public class EntityLookParser extends Object
    {
        private static const CURRENT_FORMAT_VERSION:uint = 0;
        private static const DEFAULT_NUMBER_BASE:uint = 10;

        public function EntityLookParser()
        {
            return;
        }// end function

        public static function fromString(param1:String, param2:uint = 0, param3:uint = 10) : TiphonEntityLook
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = null;
            var _loc_18:* = NaN;
            var _loc_19:* = null;
            var _loc_20:* = 0;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = 0;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = 0;
            var _loc_28:* = 0;
            var _loc_4:* = new TiphonEntityLook();
            new TiphonEntityLook().lock();
            var _loc_5:* = CURRENT_FORMAT_VERSION;
            var _loc_6:* = DEFAULT_NUMBER_BASE;
            if (param1.charAt(0) == "[")
            {
                _loc_8 = param1.substring(1, param1.indexOf("]"));
                if (_loc_8.indexOf(",") > 0)
                {
                    _loc_9 = _loc_8.split(",");
                    if (_loc_9.length != 2)
                    {
                        throw new Error("Malformated headers in an Entity Look string.");
                    }
                    _loc_5 = uint(_loc_9[0]);
                    _loc_6 = getNumberBase(_loc_9[1]);
                }
                else
                {
                    _loc_5 = uint(_loc_8);
                }
                param1 = param1.substr((param1.indexOf("]") + 1));
            }
            if (param1.charAt(0) != "{" || param1.charAt((param1.length - 1)) != "}")
            {
                throw new Error("Malformed body in an Entity Look string.");
            }
            param1 = param1.substring(1, (param1.length - 1));
            var _loc_7:* = param1.split("|");
            _loc_4.setBone(parseInt(_loc_7[0], _loc_6));
            if (_loc_7.length > 1 && _loc_7[1].length > 0)
            {
                _loc_10 = _loc_7[1].split(",");
                for each (_loc_11 in _loc_10)
                {
                    
                    _loc_4.addSkin(parseInt(_loc_11, _loc_6));
                }
            }
            if (_loc_7.length > 2 && _loc_7[2].length > 0)
            {
                _loc_12 = _loc_7[2].split(",");
                for each (_loc_13 in _loc_12)
                {
                    
                    _loc_14 = _loc_13.split("=");
                    if (_loc_14.length != 2)
                    {
                        throw new Error("Malformed color in an Entity Look string.");
                    }
                    _loc_15 = parseInt(_loc_14[0], _loc_6);
                    _loc_16 = 0;
                    if (_loc_14[1].charAt(0) == "#")
                    {
                        _loc_16 = parseInt(_loc_14[1].substr(1), 16);
                    }
                    else
                    {
                        _loc_16 = parseInt(_loc_14[1], _loc_6);
                    }
                    _loc_4.setColor(_loc_15, _loc_16);
                }
            }
            if (_loc_7.length > 3 && _loc_7[3].length > 0)
            {
                _loc_17 = _loc_7[3].split(",");
                if (_loc_17.length == 1)
                {
                    _loc_18 = parseInt(_loc_17[0], _loc_6) / 100;
                    _loc_4.setScales(_loc_18, _loc_18);
                }
                else if (_loc_17.length == 2)
                {
                    _loc_4.setScales(parseInt(_loc_17[0], _loc_6) / 100, parseInt(_loc_17[1], _loc_6) / 100);
                }
                else
                {
                    throw new Error("Malformed scale in an Entity Look string.");
                }
            }
            else
            {
                _loc_4.setScales(1, 1);
            }
            if (_loc_7.length > 4 && _loc_7[4].length > 0)
            {
                _loc_19 = "";
                _loc_20 = 4;
                while (_loc_20 < _loc_7.length)
                {
                    
                    _loc_19 = _loc_19 + (_loc_7[_loc_20] + "|");
                    _loc_20 = _loc_20 + 1;
                }
                _loc_19 = _loc_19.substr(0, (_loc_19.length - 1));
                _loc_21 = [];
                while (true)
                {
                    
                    _loc_23 = _loc_19.indexOf("}");
                    if (_loc_23 == -1)
                    {
                        break;
                    }
                    _loc_21.push(_loc_19.substr(0, (_loc_23 + 1)));
                    _loc_19 = _loc_19.substr((_loc_23 + 1));
                }
                for each (_loc_22 in _loc_21)
                {
                    
                    _loc_24 = _loc_22.substring(0, _loc_22.indexOf("="));
                    _loc_25 = _loc_22.substr((_loc_22.indexOf("=") + 1));
                    _loc_26 = _loc_24.split("@");
                    if (_loc_26.length != 2)
                    {
                        throw new Error("Malformed subentity binding in an Entity Look string.");
                    }
                    _loc_27 = parseInt(_loc_26[0], _loc_6);
                    _loc_28 = parseInt(_loc_26[1], _loc_6);
                    _loc_4.addSubEntity(_loc_27, _loc_28, EntityLookParser.fromString(_loc_25, _loc_5, _loc_6));
                }
            }
            _loc_4.unlock(true);
            return _loc_4;
        }// end function

        public static function toString(param1:TiphonEntityLook) : String
        {
            var _loc_8:* = 0;
            var _loc_9:* = false;
            var _loc_10:* = 0;
            var _loc_11:* = false;
            var _loc_12:* = null;
            var _loc_13:* = false;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_2:* = "{";
            _loc_2 = _loc_2 + param1.getBone().toString(DEFAULT_NUMBER_BASE);
            _loc_2 = _loc_2 + "|";
            var _loc_3:* = param1.getSkins(true);
            if (_loc_3 != null)
            {
                _loc_8 = 0;
                _loc_9 = true;
                for each (_loc_10 in _loc_3)
                {
                    
                    if (_loc_8++ == 0 && param1.defaultSkin != -1)
                    {
                        continue;
                    }
                    if (_loc_9)
                    {
                        _loc_9 = false;
                    }
                    else
                    {
                        _loc_2 = _loc_2 + ",";
                    }
                    _loc_2 = _loc_2 + _loc_10.toString(DEFAULT_NUMBER_BASE);
                }
            }
            _loc_2 = _loc_2 + "|";
            var _loc_4:* = param1.getColors(true);
            if (param1.getColors(true) != null)
            {
                _loc_11 = true;
                for (_loc_12 in _loc_4)
                {
                    
                    if (_loc_11)
                    {
                        _loc_11 = false;
                    }
                    else
                    {
                        _loc_2 = _loc_2 + ",";
                    }
                    _loc_2 = _loc_2 + (uint(_loc_12).toString(DEFAULT_NUMBER_BASE) + "=" + uint(_loc_4[_loc_12]).toString(DEFAULT_NUMBER_BASE));
                }
            }
            _loc_2 = _loc_2 + "|";
            var _loc_5:* = param1.getScaleX();
            var _loc_6:* = param1.getScaleY();
            if (_loc_5 != 1 || _loc_6 != 1)
            {
                _loc_2 = _loc_2 + Math.round(_loc_5 * 100).toString(DEFAULT_NUMBER_BASE);
                if (_loc_6 != _loc_5)
                {
                    _loc_2 = _loc_2 + ("," + Math.round(_loc_6 * 100).toString(DEFAULT_NUMBER_BASE));
                }
            }
            _loc_2 = _loc_2 + "|";
            var _loc_7:* = param1.getSubEntities(true);
            if (param1.getSubEntities(true) != null)
            {
                _loc_13 = true;
                for (_loc_14 in _loc_7)
                {
                    
                    for (_loc_15 in _loc_7[_loc_14])
                    {
                        
                        _loc_16 = _loc_7[_loc_14][_loc_15];
                        if (_loc_13)
                        {
                            _loc_13 = false;
                        }
                        else
                        {
                            _loc_2 = _loc_2 + ",";
                        }
                        _loc_2 = _loc_2 + (uint(_loc_14).toString(DEFAULT_NUMBER_BASE) + "@" + uint(_loc_15).toString(DEFAULT_NUMBER_BASE) + "=" + _loc_16.toString());
                    }
                }
            }
            while (_loc_2.charAt((_loc_2.length - 1)) == "|")
            {
                
                _loc_2 = _loc_2.substr(0, (_loc_2.length - 1));
            }
            return _loc_2 + "}";
        }// end function

        private static function getNumberBase(param1:String) : uint
        {
            switch(param1)
            {
                case "A":
                {
                    return 10;
                }
                case "G":
                {
                    return 16;
                }
                case "Z":
                {
                    return 36;
                }
                default:
                {
                    break;
                }
            }
            throw new Error("Unknown number base type \'" + param1 + "\' in an Entity Look string.");
        }// end function

    }
}
