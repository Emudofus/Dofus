// Action script...

// [Initial MovieClip Action of sprite 20825]
#initclip 90
if (!ank.utils.CustomDate)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.CustomDate = function (nRefTime, aMonths, nYearOffset)
    {
        this._nRefTime = nRefTime;
        this._aMonths = aMonths;
        this._nYearOffset = nYearOffset;
        this._aMonths.sortOn("0", Array.NUMERIC | Array.DESCENDING);
        this._nSaveTime = getTimer();
    }).prototype;
    _loc1.getCurrentTime = function ()
    {
        var _loc2 = this.getCurrentRealDate();
        var _loc3 = _loc2.getUTCHours();
        var _loc4 = _loc2.getUTCMinutes();
        return ([_loc3, _loc4]);
    };
    _loc1.getCurrentDate = function ()
    {
        var _loc2 = this.getCurrentRealDate();
        var _loc3 = this.getYearDayNumber();
        var _loc4 = 1;
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < this._aMonths.length)
        {
            if (this._aMonths[_loc5][0] < _loc3)
            {
                _loc4 = _loc5;
                break;
            } // end if
        } // end while
        return ([_loc2.getUTCFullYear(), this._aMonths[_loc4][1], _loc3 - this._aMonths[_loc4][0]]);
    };
    _loc1.getCurrentMillisInDay = function ()
    {
        var _loc2 = new Date();
        _loc2.setTime(this._nRefTime);
        var _loc3 = new Date(Date.UTC(1970, 0, 1, _loc2.getUTCHours(), _loc2.getUTCMinutes(), _loc2.getUTCSeconds(), _loc2.getUTCMilliseconds()));
        return (_loc3.getTime());
    };
    _loc1.getDiffDate = function (nTime)
    {
        var _loc3 = this.getCurrentRealDate();
        var _loc4 = new Date();
        _loc4.setTime(nTime);
        _loc4 = new Date(Date.UTC(_loc4.getUTCFullYear() - this._nYearOffset, _loc4.getUTCMonth(), _loc4.getUTCDate(), _loc4.getUTCHours(), _loc4.getUTCMinutes(), _loc4.getUTCSeconds(), _loc4.getUTCMilliseconds()));
        return (_loc3 - _loc4);
    };
    _loc1.getCurrentRealDate = function ()
    {
        var _loc2 = getTimer() - this._nSaveTime;
        var _loc3 = new Date();
        _loc3.setTime(this._nRefTime + _loc2);
        _loc3 = new Date(Date.UTC(_loc3.getUTCFullYear() - this._nYearOffset, _loc3.getUTCMonth(), _loc3.getUTCDate(), _loc3.getUTCHours(), _loc3.getUTCMinutes(), _loc3.getUTCSeconds(), _loc3.getUTCMilliseconds()));
        return (_loc3);
    };
    _loc1.getYearDayNumber = function ()
    {
        var _loc2 = this.getCurrentRealDate();
        var _loc3 = new Date(Date.UTC(_loc2.getUTCFullYear(), 0, 1));
        return (Math.floor((_loc2 - _loc3) / ank.utils.CustomDate.MS_PER_DAY) + 1);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.utils.CustomDate = function (nRefTime, aMonths, nYearOffset)
    {
        this._nRefTime = nRefTime;
        this._aMonths = aMonths;
        this._nYearOffset = nYearOffset;
        this._aMonths.sortOn("0", Array.NUMERIC | Array.DESCENDING);
        this._nSaveTime = getTimer();
    }).MS_PER_DAY = 86400000;
} // end if
#endinitclip
