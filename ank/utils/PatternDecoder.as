// Action script...

// [Initial MovieClip Action of sprite 20795]
#initclip 60
if (!ank.utils.PatternDecoder)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.PatternDecoder = function ()
    {
    }).prototype;
    (_global.ank.utils.PatternDecoder = function ()
    {
    }).getDescription = function (sText, aParams)
    {
        ank.utils.Extensions.addExtensions();
        var _loc4 = sText.split("");
        var _loc5 = ank.utils.PatternDecoder.decodeDescription(_loc4, aParams).join("");
        return (_loc5);
    };
    (_global.ank.utils.PatternDecoder = function ()
    {
    }).combine = function (str, gender, singular)
    {
        ank.utils.Extensions.addExtensions();
        var _loc5 = str.split("");
        var _loc6 = new Object();
        _loc6.m = gender == "m";
        _loc6.f = gender == "f";
        _loc6.n = gender == "n";
        _loc6.p = !singular;
        _loc6.s = singular;
        var _loc7 = ank.utils.PatternDecoder.decodeCombine(_loc5, _loc6).join("");
        return (_loc7);
    };
    (_global.ank.utils.PatternDecoder = function ()
    {
    }).replace = function (sSrc, sPattern)
    {
        var _loc4 = sSrc.split("##");
        var _loc5 = 1;
        
        while (_loc5 = _loc5 + 2, _loc5 < _loc4.length)
        {
            var _loc6 = _loc4[_loc5].split(",");
            _loc4[_loc5] = ank.utils.PatternDecoder.getDescription(sPattern, _loc6);
        } // end while
        return (_loc4.join(""));
    };
    (_global.ank.utils.PatternDecoder = function ()
    {
    }).replaceStr = function (sSrc, sSearchPattern, sReplaceStr)
    {
        var _loc5 = sSrc.split(sSearchPattern);
        return (_loc5.join(sReplaceStr));
    };
    (_global.ank.utils.PatternDecoder = function ()
    {
    }).decodeDescription = function (aStr, aParams)
    {
        var _loc4 = 0;
        var _loc5 = new String();
        var _loc6 = aStr.length;
        while (_loc4 < _loc6)
        {
            _loc5 = aStr[_loc4];
            switch (_loc5)
            {
                case "#":
                {
                    var _loc7 = aStr[_loc4 + 1];
                    if (!_global.isNaN(_loc7))
                    {
                        if (aParams[_loc7 - 1] != undefined)
                        {
                            aStr.splice(_loc4, 2, aParams[_loc7 - 1]);
                            --_loc4;
                        }
                        else
                        {
                            aStr.splice(_loc4, 2);
                            _loc4 = _loc4 - 2;
                        } // end if
                    } // end else if
                    break;
                } 
                case "~":
                {
                    var _loc8 = aStr[_loc4 + 1];
                    if (!_global.isNaN(_loc8))
                    {
                        if (aParams[_loc8 - 1] != undefined)
                        {
                            aStr.splice(_loc4, 2);
                            _loc4 = _loc4 - 2;
                        }
                        else
                        {
                            return (aStr.slice(0, _loc4));
                        } // end if
                    } // end else if
                    break;
                } 
                case "{":
                {
                    var _loc9 = ank.utils.PatternDecoder.find(aStr.slice(_loc4), "}");
                    var _loc10 = ank.utils.PatternDecoder.decodeDescription(aStr.slice(_loc4 + 1, _loc4 + _loc9), aParams).join("");
                    aStr.splice(_loc4, _loc9 + 1, _loc10);
                    break;
                } 
                case "[":
                {
                    var _loc11 = ank.utils.PatternDecoder.find(aStr.slice(_loc4), "]");
                    var _loc12 = Number(aStr.slice(_loc4 + 1, _loc4 + _loc11).join(""));
                    if (!_global.isNaN(_loc12))
                    {
                        aStr.splice(_loc4, _loc11 + 1, aParams[_loc12] + " ");
                        _loc4 = _loc4 - _loc11;
                    } // end if
                    break;
                } 
            } // End of switch
            ++_loc4;
        } // end while
        return (aStr);
    };
    (_global.ank.utils.PatternDecoder = function ()
    {
    }).decodeCombine = function (aStr, oParams)
    {
        var _loc4 = 0;
        var _loc5 = new String();
        var _loc6 = aStr.length;
        while (_loc4 < _loc6)
        {
            _loc5 = aStr[_loc4];
            switch (_loc5)
            {
                case "~":
                {
                    var _loc7 = aStr[_loc4 + 1];
                    if (oParams[_loc7])
                    {
                        aStr.splice(_loc4, 2);
                        _loc4 = _loc4 - 2;
                    }
                    else
                    {
                        return (aStr.slice(0, _loc4));
                    } // end else if
                    break;
                } 
                case "{":
                {
                    var _loc8 = ank.utils.PatternDecoder.find(aStr.slice(_loc4), "}");
                    var _loc9 = ank.utils.PatternDecoder.decodeCombine(aStr.slice(_loc4 + 1, _loc4 + _loc8), oParams).join("");
                    aStr.splice(_loc4, _loc8 + 1, _loc9);
                    break;
                } 
            } // End of switch
            ++_loc4;
        } // end while
        return (aStr);
    };
    (_global.ank.utils.PatternDecoder = function ()
    {
    }).find = function (a, f)
    {
        var _loc4 = a.length;
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc4)
        {
            if (a[_loc5] == f)
            {
                return (_loc5);
            } // end if
        } // end while
        return (-1);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
