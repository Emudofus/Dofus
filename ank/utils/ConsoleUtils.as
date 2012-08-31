// Action script...

// [Initial MovieClip Action of sprite 905]
#initclip 117
class ank.utils.ConsoleUtils
{
    function ConsoleUtils()
    {
    } // End of the function
    static function autoCompletion(aList, sCmd)
    {
        var _loc6 = ank.utils.ConsoleUtils.removeAndGetLastWord(sCmd);
        var _loc4 = _loc6.lastWord;
        sCmd = _loc6.leftCmd;
        _loc4 = _loc4.toLowerCase();
        var _loc2 = ank.utils.ConsoleUtils.getStringsStartWith(aList, _loc4);
        if (_loc2.length > 1)
        {
            var _loc3 = "";
            for (var _loc1 = 0; _loc1 < _loc2.length; ++_loc1)
            {
                _loc3 = String(_loc2[_loc1]).charAt(_loc4.length);
                if (_loc3 != "")
                {
                    break;
                } // end if
            } // end of for
            if (_loc3 == "")
            {
                return ({result: sCmd + _loc4, full: false});
            }
            else
            {
                return (ank.utils.ConsoleUtils.autoCompletionRecurcive(_loc2, sCmd, _loc4 + _loc3));
            } // end else if
        }
        else if (_loc2.length != 0)
        {
            return ({result: sCmd + _loc2[0], isFull: true});
        }
        else
        {
            return ({result: sCmd + _loc4, list: _loc2, isFull: false});
        } // end else if
    } // End of the function
    static function removeAndGetLastWord(sCmd)
    {
        var _loc1 = sCmd.split(" ");
        if (_loc1.length == 0)
        {
            return ({leftCmd: "", lastWord: ""});
        } // end if
        var _loc2 = String(_loc1.pop());
        return ({leftCmd: _loc1.length == 0 ? ("") : (_loc1.join(" ") + " "), lastWord: _loc2});
    } // End of the function
    static function autoCompletionRecurcive(aList, sLeftCmd, sPattern)
    {
        sPattern = sPattern.toLowerCase();
        var _loc2 = ank.utils.ConsoleUtils.getStringsStartWith(aList, sPattern);
        if (_loc2.length > 1 && _loc2.length == aList.length)
        {
            var _loc3 = "";
            for (var _loc1 = 0; _loc1 < _loc2.length; ++_loc1)
            {
                _loc3 = String(_loc2[_loc1]).charAt(sPattern.length);
                if (_loc3 != "")
                {
                    break;
                } // end if
            } // end of for
            if (_loc3 == "")
            {
                return ({result: sLeftCmd + sPattern, isFull: false});
            }
            else
            {
                return (ank.utils.ConsoleUtils.autoCompletionRecurcive(_loc2, sLeftCmd, sPattern + _loc3));
            } // end else if
        }
        else if (_loc2.length != 0)
        {
            return ({result: sLeftCmd + sPattern.substr(0, sPattern.length - 1), list: aList, isFull: false});
        }
        else
        {
            return ({result: sLeftCmd + sPattern, list: aList, isFull: false});
        } // end else if
    } // End of the function
    static function getStringsStartWith(aList, sPattern)
    {
        var _loc5 = new Array();
        for (var _loc1 = 0; _loc1 < aList.length; ++_loc1)
        {
            var _loc3 = String(aList[_loc1]).toLowerCase().split(sPattern);
            if (_loc3[0] == "" && _loc3.length != 0 && String(aList[_loc1]).length >= sPattern.length)
            {
                _loc5.push(aList[_loc1]);
            } // end if
        } // end of for
        return (_loc5);
    } // End of the function
} // End of Class
#endinitclip
