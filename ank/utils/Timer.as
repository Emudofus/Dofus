// Action script...

// [Initial MovieClip Action of sprite 43]
#initclip 36
class ank.utils.Timer extends Object
{
    function Timer()
    {
        super();
    } // End of the function
    static function setTimer(mRefObject, sLayer, mFuncObject, fFunction, nInterval, aParams)
    {
        ank.utils.Timer.garbageCollector();
        var _loc2 = ank.utils.Timer.getNextTimerIndex();
        var _loc3 = setInterval(ank.utils.Timer.getInstance(), "onTimer", nInterval, _loc2, mRefObject, sLayer, mFuncObject, fFunction, aParams);
        mRefObject.__ANKTIMERID__ = _loc3;
        if (ank.utils.Timer._oIDs[sLayer] == undefined)
        {
            ank.utils.Timer._oIDs[sLayer] = new Object();
        } // end if
        ank.utils.Timer._oIDs[sLayer][_loc2] = new Array(mRefObject, _loc3, sLayer);
    } // End of the function
    static function clear(sLayer)
    {
        if (sLayer != undefined)
        {
            var _loc1 = ank.utils.Timer._oIDs[sLayer];
            for (var _loc4 in _loc1)
            {
                ank.utils.Timer.removeTimer(_loc1[_loc4][0], sLayer, _loc1[_loc4][1]);
            } // end of for...in
        }
        else
        {
            for (var _loc4 in ank.utils.Timer._oIDs)
            {
                _loc1 = ank.utils.Timer._oIDs[_loc4];
                for (var _loc2 in _loc1)
                {
                    ank.utils.Timer.removeTimer(_loc1[_loc2][0], _loc1[_loc2][2], _loc1[_loc2][1]);
                } // end of for...in
            } // end of for...in
        } // end else if
        ank.utils.Timer.garbageCollector();
    } // End of the function
    static function clean()
    {
        ank.utils.Timer.garbageCollector();
    } // End of the function
    static function removeTimer(mRefObject, sLayer, nTimerIndex)
    {
        var _loc2;
        if (nTimerIndex == undefined)
        {
            if (mRefObject == undefined)
            {
                return;
            } // end if
            if (mRefObject.__ANKTIMERID__ == undefined)
            {
                return;
            } // end if
            _loc2 = mRefObject.__ANKTIMERID__;
        }
        else
        {
            _loc2 = ank.utils.Timer._oIDs[sLayer][nTimerIndex][1];
        } // end else if
        clearInterval(_loc2);
        delete mRefObject.__ANKTIMERID__;
        delete ank.utils.Timer._oIDs[sLayer][nTimerIndex];
    } // End of the function
    static function getInstance()
    {
        return (ank.utils.Timer._tTimer);
    } // End of the function
    static function garbageCollector()
    {
        for (var _loc4 in ank.utils.Timer._oIDs)
        {
            var _loc2 = ank.utils.Timer._oIDs[_loc4];
            for (var _loc3 in _loc2)
            {
                var _loc1 = _loc2[_loc3];
                if (_loc1[0] == undefined || typeof(_loc1[0]) == "movieclip" && _loc1[0]._name == undefined || _loc1[0].__ANKTIMERID__ != _loc1[1])
                {
                    clearInterval(_loc1[1]);
                    delete _loc2[_loc3];
                } // end if
            } // end of for...in
        } // end of for...in
    } // End of the function
    static function getTimersCount()
    {
        var _loc2 = 0;
        for (var _loc4 in ank.utils.Timer._oIDs)
        {
            var _loc1 = ank.utils.Timer._oIDs[_loc4];
            for (var _loc3 in _loc1)
            {
                ++_loc2;
            } // end of for...in
        } // end of for...in
        return (_loc2);
    } // End of the function
    static function getNextTimerIndex()
    {
        _nTimerIndex = ++ank.utils.Timer._nTimerIndex;
        return (ank.utils.Timer._nTimerIndex);
    } // End of the function
    function onTimer(nTimerIndex, mRefObject, sLayer, mFuncObject, fFunction, aParams)
    {
        if (mRefObject == undefined)
        {
            ank.utils.Timer.removeTimer(undefined, sLayer, nTimerIndex);
            return;
        } // end if
        if (mRefObject.__ANKTIMERID__ == undefined)
        {
            ank.utils.Timer.removeTimer(undefined, sLayer, nTimerIndex);
            return;
        } // end if
        ank.utils.Timer.removeTimer(mRefObject, sLayer, nTimerIndex);
        delete mRefObject.__ANKTIMERID__;
        fFunction.apply(mFuncObject, aParams);
        ank.utils.Timer.garbageCollector();
    } // End of the function
    static var _nTimerIndex = 0;
    static var _oIDs = new Object();
    static var _tTimer = new ank.utils.Timer();
} // End of Class
#endinitclip
