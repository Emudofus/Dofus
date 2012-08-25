// Action script...

// [Initial MovieClip Action of sprite 20578]
#initclip 99
if (!ank.utils.ExtendedString)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.ExtendedString = function (o)
    {
        super();
        this._s = String(o);
    }).prototype;
    _loc1.replace = function (pFrom, pTo)
    {
        if (arguments.length == 0)
        {
            return (this._s);
        } // end if
        if (arguments.length == 1)
        {
            if (pFrom instanceof Array)
            {
                pTo = new Array(pFrom.length);
            }
            else
            {
                return (this._s.split(pFrom).join(""));
            } // end if
        } // end else if
        if (!(pFrom instanceof Array))
        {
            return (this._s.split(pFrom).join(pTo));
        } // end if
        var _loc4 = pFrom.length;
        var _loc5 = this._s;
        if (pTo instanceof Array)
        {
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < _loc4)
            {
                _loc5 = _loc5.split(pFrom[_loc6]).join(pTo[_loc6]);
            } // end while
        }
        else
        {
            var _loc7 = 0;
            
            while (++_loc7, _loc7 < _loc4)
            {
                _loc5 = _loc5.split(pFrom[_loc7]).join(pTo);
            } // end while
        } // end else if
        return (_loc5);
    };
    _loc1.addLeftChar = function (sChar, nMaxSize)
    {
        var _loc4 = nMaxSize - this._s.length;
        var _loc5 = new String();
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc4)
        {
            _loc5 = _loc5 + sChar;
        } // end while
        _loc5 = _loc5 + this._s;
        return (_loc5);
    };
    _loc1.addMiddleChar = function (nChar, nCount)
    {
        if (_global.isNaN(nCount))
        {
            nCount = Number(nCount);
        } // end if
        nCount = Math.abs(nCount);
        var _loc5 = new Array();
        var _loc4 = this._s.length;
        
        while (_loc4 = _loc4 - nCount, _loc4 > 0)
        {
            if (Math.max(0, _loc4 - nCount) == 0)
            {
                _loc5.push(this._s.substr(0, _loc4));
                continue;
            } // end if
            _loc5.push(this._s.substr(_loc4 - nCount, nCount));
        } // end while
        _loc5.reverse();
        return (_loc5.join(nChar));
    };
    _loc1.lTrim = function ($space)
    {
        this._clearOutOfRange();
        this._lTrim(this.spaceStringToObject($space));
        return (this);
    };
    _loc1.rTrim = function ($space)
    {
        this._clearOutOfRange();
        this._rTrim(this.spaceStringToObject($space));
        return (this);
    };
    _loc1.trim = function ($space)
    {
        var _loc3 = this.spaceStringToObject($space);
        this._clearOutOfRange();
        this._rTrim(_loc3);
        this._lTrim(_loc3);
        return (this);
    };
    _loc1.toString = function ()
    {
        return (this._s);
    };
    _loc1.spaceStringToObject = function ($space)
    {
        var _loc3 = new Object();
        if ($space == undefined)
        {
            $space = ank.utils.ExtendedString.DEFAULT_SPACECHARS;
        } // end if
        if (typeof($space) == "string")
        {
            var _loc4 = $space.length;
            while (--_loc4 >= 0)
            {
                _loc3[$space.charAt(_loc4)] = true;
            } // end while
        }
        else
        {
            _loc3 = $space;
        } // end else if
        return (_loc3);
    };
    _loc1._lTrim = function ($space)
    {
        var _loc3 = this._s.length;
        var _loc4 = 0;
        while (_loc3 > 0)
        {
            if (!$space[this._s.charAt(_loc4)])
            {
                break;
            } // end if
            ++_loc4;
            --_loc3;
        } // end while
        this._s = this._s.slice(_loc4);
    };
    _loc1._rTrim = function ($space)
    {
        var _loc3 = this._s.length;
        var _loc4 = _loc3 - 1;
        while (_loc3 > 0)
        {
            if (!$space[this._s.charAt(_loc4)])
            {
                break;
            } // end if
            --_loc4;
            --_loc3;
        } // end while
        this._s = this._s.slice(0, _loc4 + 1);
    };
    _loc1._clearOutOfRange = function ()
    {
        var _loc2 = "";
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._s.length)
        {
            if (this._s.charCodeAt(_loc3) > 32 && this._s.charCodeAt(_loc3) <= 255)
            {
                _loc2 = _loc2 + this._s.charAt(_loc3);
            } // end if
        } // end while
        this._s = _loc2;
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.utils.ExtendedString = function (o)
    {
        super();
        this._s = String(o);
    }).DEFAULT_SPACECHARS = " \n\r\t";
} // end if
#endinitclip
