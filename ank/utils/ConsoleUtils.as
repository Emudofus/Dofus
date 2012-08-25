// Action script...

// [Initial MovieClip Action of sprite 20735]
#initclip 256
if (!ank.utils.ConsoleUtils)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.ConsoleUtils = function ()
    {
    }).prototype;
    (_global.ank.utils.ConsoleUtils = function ()
    {
    }).autoCompletion = function (aList, sCmd)
    {
        var _loc4 = ank.utils.ConsoleUtils.removeAndGetLastWord(sCmd);
        var _loc5 = _loc4.lastWord;
        sCmd = _loc4.leftCmd;
        _loc5 = _loc5.toLowerCase();
        var _loc6 = ank.utils.ConsoleUtils.getStringsStartWith(aList, _loc5);
        if (_loc6.length > 1)
        {
            var _loc7 = "";
            var _loc8 = 0;
            
            while (++_loc8, _loc8 < _loc6.length)
            {
                _loc7 = String(_loc6[_loc8]).charAt(_loc5.length);
                if (_loc7 != "")
                {
                    break;
                } // end if
            } // end while
            if (_loc7 == "")
            {
                return ({result: sCmd + _loc5, full: false});
            }
            else
            {
                return (ank.utils.ConsoleUtils.autoCompletionRecurcive(_loc6, sCmd, _loc5 + _loc7));
            } // end else if
        }
        else if (_loc6.length != 0)
        {
            return ({result: sCmd + _loc6[0], isFull: true});
        }
        else
        {
            return ({result: sCmd + _loc5, list: _loc6, isFull: false});
        } // end else if
    };
    (_global.ank.utils.ConsoleUtils = function ()
    {
    }).removeAndGetLastWord = function (sCmd)
    {
        var _loc3 = sCmd.split(" ");
        if (_loc3.length == 0)
        {
            return ({leftCmd: "", lastWord: ""});
        } // end if
        var _loc4 = String(_loc3.pop());
        return ({leftCmd: _loc3.length == 0 ? ("") : (_loc3.join(" ") + " "), lastWord: _loc4});
    };
    (_global.ank.utils.ConsoleUtils = function ()
    {
    }).autoCompletionRecurcive = function (aList, sLeftCmd, sPattern)
    {
        sPattern = sPattern.toLowerCase();
        var _loc5 = ank.utils.ConsoleUtils.getStringsStartWith(aList, sPattern);
        if (_loc5.length > 1 && _loc5.length == aList.length)
        {
            var _loc6 = "";
            var _loc7 = 0;
            
            while (++_loc7, _loc7 < _loc5.length)
            {
                _loc6 = String(_loc5[_loc7]).charAt(sPattern.length);
                if (_loc6 != "")
                {
                    break;
                } // end if
            } // end while
            if (_loc6 == "")
            {
                return ({result: sLeftCmd + sPattern, isFull: false});
            }
            else
            {
                return (ank.utils.ConsoleUtils.autoCompletionRecurcive(_loc5, sLeftCmd, sPattern + _loc6));
            } // end else if
        }
        else if (_loc5.length != 0)
        {
            return ({result: sLeftCmd + sPattern.substr(0, sPattern.length - 1), list: aList, isFull: false});
        }
        else
        {
            return ({result: sLeftCmd + sPattern, list: aList, isFull: false});
        } // end else if
    };
    (_global.ank.utils.ConsoleUtils = function ()
    {
    }).getStringsStartWith = function (aList, sPattern)
    {
        var _loc4 = new Array();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < aList.length)
        {
            var _loc6 = String(aList[_loc5]).toLowerCase().split(sPattern);
            if (_loc6[0] == "" && (_loc6.length != 0 && String(aList[_loc5]).length >= sPattern.length))
            {
                _loc4.push(aList[_loc5]);
            } // end if
        } // end while
        return (_loc4);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
