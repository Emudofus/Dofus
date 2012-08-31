// Action script...

// [Initial MovieClip Action of sprite 819]
#initclip 28
class ank.utils.extensions.StringExtensions extends String
{
    var split, length, substr;
    function StringExtensions()
    {
        super();
    } // End of the function
    function replace(pFrom, pTo)
    {
        if (arguments.length == 0)
        {
            return (this);
        } // end if
        if (arguments.length == 1)
        {
            if (pFrom instanceof Array)
            {
                pTo = new Array(pFrom.length);
            }
            else
            {
                return (this.split(pFrom).join(""));
            } // end if
        } // end else if
        if (!(pFrom instanceof Array))
        {
            return (this.split(pFrom).join(pTo));
        } // end if
        var _loc7 = pFrom.length;
        var _loc4 = this;
        if (pTo instanceof Array)
        {
            for (var _loc3 = 0; _loc3 < _loc7; ++_loc3)
            {
                _loc4 = _loc4.split(pFrom[_loc3]).join(pTo[_loc3]);
            } // end of for
        }
        else
        {
            for (var _loc3 = 0; _loc3 < _loc7; ++_loc3)
            {
                _loc4 = _loc4.split(pFrom[_loc3]).join(pTo);
            } // end of for
        } // end else if
        return (_loc4);
    } // End of the function
    function addLeftChar(sChar, nMaxSize)
    {
        var _loc4 = nMaxSize - length;
        var _loc3 = new String();
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            _loc3 = _loc3 + sChar;
        } // end of for
        _loc3 = _loc3 + this;
        return (_loc3);
    } // End of the function
    function addMiddleChar(nChar, nCount)
    {
        if (isNaN(nCount))
        {
            nCount = Number(nCount);
        } // end if
        nCount = Math.abs(nCount);
        var _loc2;
        var _loc4 = new Array();
        for (var _loc2 = length; _loc2 > 0; _loc2 = _loc2 - nCount)
        {
            if (Math.max(0, _loc2 - nCount) == 0)
            {
                _loc4.push(this.substr(0, _loc2));
                continue;
            } // end if
            _loc4.push(this.substr(_loc2 - nCount, nCount));
        } // end of for
        _loc4.reverse();
        return (_loc4.join(nChar));
    } // End of the function
} // End of Class
#endinitclip
