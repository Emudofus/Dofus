// Action script...

// [Initial MovieClip Action of sprite 900]
#initclip 112
class ank.utils.CustomDate
{
    var _nRefTime, _aMonths, _nYearOffset, _nSaveTime;
    function CustomDate(nRefTime, aMonths, nYearOffset)
    {
        _nRefTime = nRefTime;
        _aMonths = aMonths;
        _nYearOffset = nYearOffset;
        _aMonths.sortOn("0", Array.NUMERIC | Array.DESCENDING);
        _nSaveTime = getTimer();
    } // End of the function
    function getCurrentTime()
    {
        var _loc2 = this.getCurrentRealDate();
        var _loc4 = _loc2.getUTCHours();
        var _loc3 = _loc2.getUTCMinutes();
        return ([_loc4, _loc3]);
    } // End of the function
    function getCurrentDate()
    {
        var _loc5 = this.getCurrentRealDate();
        var _loc4 = this.getYearDayNumber();
        var _loc3 = 1;
        for (var _loc2 = 0; _loc2 < _aMonths.length; ++_loc2)
        {
            if (_aMonths[_loc2][0] < _loc4)
            {
                _loc3 = _loc2;
                break;
            } // end if
        } // end of for
        return ([_loc5.getUTCFullYear(), _aMonths[_loc3][1], _loc4 - _aMonths[_loc3][0] + 1]);
    } // End of the function
    function getCurrentMillisInDay()
    {
        var _loc2 = new Date();
        _loc2.setTime(_nRefTime);
        var _loc3 = new Date(Date.UTC(1970, 0, 1, _loc2.getUTCHours(), _loc2.getUTCMinutes(), _loc2.getUTCSeconds(), _loc2.getUTCMilliseconds()));
        return (_loc3.getTime());
    } // End of the function
    function getDiffDate(nTime)
    {
        var _loc3 = this.getCurrentRealDate();
        var _loc2 = new Date();
        _loc2.setTime(nTime);
        _loc2 = new Date(Date.UTC(_loc2.getUTCFullYear() - _nYearOffset, _loc2.getUTCMonth(), _loc2.getUTCDate(), _loc2.getUTCHours(), _loc2.getUTCMinutes(), _loc2.getUTCSeconds(), _loc2.getUTCMilliseconds()));
        return (_loc3 - _loc2);
    } // End of the function
    function getCurrentRealDate()
    {
        var _loc3 = getTimer() - _nSaveTime;
        var _loc2 = new Date();
        _loc2.setTime(_nRefTime + _loc3);
        _loc2 = new Date(Date.UTC(_loc2.getUTCFullYear() - _nYearOffset, _loc2.getUTCMonth(), _loc2.getUTCDate(), _loc2.getUTCHours(), _loc2.getUTCMinutes(), _loc2.getUTCSeconds(), _loc2.getUTCMilliseconds()));
        return (_loc2);
    } // End of the function
    function getYearDayNumber()
    {
        var _loc2 = this.getCurrentRealDate();
        var _loc3 = new Date(Date.UTC(_loc2.getUTCFullYear(), 0, 1));
        return (Math.floor((_loc2 - _loc3) / ank.utils.CustomDate.MS_PER_DAY) + 1);
    } // End of the function
    static var MS_PER_DAY = 86400000;
} // End of Class
#endinitclip
