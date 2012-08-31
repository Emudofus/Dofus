// Action script...

// [Initial MovieClip Action of sprite 816]
#initclip 25
class ank.utils.PatternDecoder
{
    function PatternDecoder()
    {
    } // End of the function
    static function getDescription(sText, aParams)
    {
        ank.utils.Extensions.addExtensions();
        var _loc2 = sText.split("");
        var _loc1 = ank.utils.PatternDecoder.decodeDescription(_loc2, aParams).join("");
        return (_loc1);
    } // End of the function
    static function combine(str, gender, singular)
    {
        ank.utils.Extensions.addExtensions();
        var _loc3 = str.split("");
        var _loc1 = new Object();
        _loc1.m = gender == "m";
        _loc1.f = gender == "f";
        _loc1.n = gender == "n";
        _loc1.p = !singular;
        _loc1.s = singular;
        var _loc2 = ank.utils.PatternDecoder.decodeCombine(_loc3, _loc1).join("");
        return (_loc2);
    } // End of the function
    static function replace(sSrc, sPattern)
    {
        var _loc2 = sSrc.split("##");
        for (var _loc1 = 1; _loc1 < _loc2.length; _loc1 = _loc1 + 2)
        {
            var _loc3 = _loc2[_loc1].split(",");
            _loc2[_loc1] = ank.utils.PatternDecoder.getDescription(sPattern, _loc3);
        } // end of for
        return (_loc2.join(""));
    } // End of the function
    static function decodeDescription(aStr, aParams)
    {
        var _loc1 = 0;
        var _loc7 = new String();
        var _loc8 = aStr.length;
        while (_loc1 < _loc8)
        {
            _loc7 = aStr[_loc1];
            switch (_loc7)
            {
                case "#":
                {
                    var _loc5 = aStr[_loc1 + 1];
                    if (!isNaN(_loc5))
                    {
                        if (aParams[_loc5 - 1] != undefined)
                        {
                            aStr.splice(_loc1, 2, aParams[_loc5 - 1]);
                            --_loc1;
                        }
                        else
                        {
                            aStr.splice(_loc1, 2);
                            _loc1 = _loc1 - 2;
                        } // end if
                    } // end else if
                    break;
                } 
                case "~":
                {
                    _loc5 = aStr[_loc1 + 1];
                    if (!isNaN(_loc5))
                    {
                        if (aParams[_loc5 - 1] != undefined)
                        {
                            aStr.splice(_loc1, 2);
                            _loc1 = _loc1 - 2;
                        }
                        else
                        {
                            return (aStr.slice(0, _loc1));
                        } // end if
                    } // end else if
                    break;
                } 
                case "{":
                {
                    var _loc4 = ank.utils.PatternDecoder.find(aStr.slice(_loc1), "}");
                    var _loc6 = ank.utils.PatternDecoder.decodeDescription(aStr.slice(_loc1 + 1, _loc1 + _loc4), aParams).join("");
                    aStr.splice(_loc1, _loc4 + 1, _loc6);
                    break;
                } 
                case "[":
                {
                    _loc4 = ank.utils.PatternDecoder.find(aStr.slice(_loc1), "]");
                    _loc5 = Number(aStr.slice(_loc1 + 1, _loc1 + _loc4).join(""));
                    if (!isNaN(_loc5))
                    {
                        aStr.splice(_loc1, _loc4 + 1, aParams[_loc5] + " ");
                        _loc1 = _loc1 - _loc4;
                    } // end if
                    break;
                } 
            } // End of switch
            ++_loc1;
        } // end while
        return (aStr);
    } // End of the function
    static function decodeCombine(aStr, oParams)
    {
        var _loc1 = 0;
        var _loc6 = new String();
        var _loc8 = aStr.length;
        while (_loc1 < _loc8)
        {
            _loc6 = aStr[_loc1];
            switch (_loc6)
            {
                case "~":
                {
                    var _loc4 = aStr[_loc1 + 1];
                    if (oParams[_loc4])
                    {
                        aStr.splice(_loc1, 2);
                        _loc1 = _loc1 - 2;
                    }
                    else
                    {
                        return (aStr.slice(0, _loc1));
                    } // end else if
                    break;
                } 
                case "{":
                {
                    var _loc3 = ank.utils.PatternDecoder.find(aStr.slice(_loc1), "}");
                    var _loc5 = ank.utils.PatternDecoder.decodeCombine(aStr.slice(_loc1 + 1, _loc1 + _loc3), oParams).join("");
                    aStr.splice(_loc1, _loc3 + 1, _loc5);
                    break;
                } 
            } // End of switch
            ++_loc1;
        } // end while
        return (aStr);
    } // End of the function
    static function find(a, f)
    {
        var _loc2 = a.length;
        var _loc1;
        for (var _loc1 = 0; _loc1 < _loc2; ++_loc1)
        {
            if (a[_loc1] == f)
            {
                return (_loc1);
            } // end if
        } // end of for
        return (-1);
    } // End of the function
} // End of Class
#endinitclip
