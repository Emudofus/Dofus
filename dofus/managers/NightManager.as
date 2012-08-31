// Action script...

// [Initial MovieClip Action of sprite 899]
#initclip 111
class dofus.managers.NightManager
{
    var _aSequence, _aMonths, _nYearOffset, _mcBattlefield, _cdDate, _nIntervalID, __get__time;
    function NightManager()
    {
    } // End of the function
    function get time()
    {
        var _loc2 = this.getCurrentTime();
        return (String(_loc2[0]).addLeftChar("0", 2) + ":" + String(_loc2[1]).addLeftChar("0", 2));
    } // End of the function
    function initialize(tz, aMonths, nYearOffset, b)
    {
        _aSequence = tz;
        _aMonths = aMonths;
        _nYearOffset = nYearOffset;
        _mcBattlefield = b;
    } // End of the function
    function setReferenceTime(nTine)
    {
        _cdDate = new ank.utils.CustomDate(nTine, _aMonths, _nYearOffset);
        this.clear();
        this.setState();
    } // End of the function
    function clear()
    {
        clearInterval(_nIntervalID);
    } // End of the function
    function noEffects()
    {
        this.clear();
        _mcBattlefield.setColor();
    } // End of the function
    function getCurrentTime()
    {
        return (_cdDate.getCurrentTime());
    } // End of the function
    function getCurrentDateString()
    {
        var _loc2 = _cdDate.getCurrentDate();
        return (_loc2[2] + " " + _loc2[1] + " " + _loc2[0]);
    } // End of the function
    function getDiffDate(nTime)
    {
        return (_cdDate.getDiffDate(nTime));
    } // End of the function
    function setState()
    {
        var _loc5 = _cdDate.getCurrentMillisInDay();
        for (var _loc2 = 0; _loc2 < _aSequence.length; ++_loc2)
        {
            var _loc3 = _aSequence[_loc2][1];
            if (_loc5 < _loc3)
            {
                var _loc4 = _aSequence[_loc2][2];
                this.applyState(_loc4, _loc3 - _loc5, _loc3);
                return;
            } // end if
        } // end of for
        ank.utils.Logger.err("[setState] ... heu la date " + _loc5 + " n\'est pas dans la séquence");
    } // End of the function
    function applyState(oStateColor, nDelay, nEndTime)
    {
        _mcBattlefield.setColor(oStateColor);
        this.clear();
        _nIntervalID = setInterval(this, "setState", nDelay, nEndTime);
    } // End of the function
    static var STATE_COLORS = [undefined, dofus.Constants.NIGHT_COLOR];
} // End of Class
#endinitclip
