// Action script...

// [Initial MovieClip Action of sprite 20763]
#initclip 28
if (!ank.utils.Timer)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.Timer = function ()
    {
        super();
    }).prototype;
    (_global.ank.utils.Timer = function ()
    {
        super();
    }).setTimer = function (mRefObject, sLayer, mFuncObject, fFunction, nInterval, aParams, bRepeat)
    {
        ank.utils.Timer.garbageCollector();
        var _loc9 = ank.utils.Timer.getNextTimerIndex();
        var _loc10 = _global.setInterval(ank.utils.Timer.getInstance(), "onTimer", nInterval, _loc9, mRefObject, sLayer, mFuncObject, fFunction, aParams);
        mRefObject.__ANKTIMERID__ = _loc10;
        mRefObject.__ANKTIMERREPEAT__ = bRepeat;
        if (ank.utils.Timer._oIDs[sLayer] == undefined)
        {
            ank.utils.Timer._oIDs[sLayer] = new Object();
        } // end if
        ank.utils.Timer._oIDs[sLayer][_loc9] = new Array(mRefObject, _loc10, sLayer);
    };
    (_global.ank.utils.Timer = function ()
    {
        super();
    }).clear = function (sLayer)
    {
        if (sLayer != undefined)
        {
            var _loc3 = ank.utils.Timer._oIDs[sLayer];
            for (var k in _loc3)
            {
                ank.utils.Timer.removeTimer(_loc3[k][0], sLayer, _loc3[k][1]);
            } // end of for...in
        }
        else
        {
            for (var k in ank.utils.Timer._oIDs)
            {
                var _loc4 = ank.utils.Timer._oIDs[k];
                for (var kk in _loc4)
                {
                    ank.utils.Timer.removeTimer(_loc4[kk][0], _loc4[kk][2], _loc4[kk][1]);
                } // end of for...in
            } // end of for...in
        } // end else if
        ank.utils.Timer.garbageCollector();
    };
    (_global.ank.utils.Timer = function ()
    {
        super();
    }).clean = function ()
    {
        ank.utils.Timer.garbageCollector();
    };
    (_global.ank.utils.Timer = function ()
    {
        super();
    }).removeTimer = function (mRefObject, sLayer, nTimerIndex)
    {
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
            var _loc5 = mRefObject.__ANKTIMERID__;
        }
        else
        {
            _loc5 = ank.utils.Timer._oIDs[sLayer][nTimerIndex][1];
        } // end else if
        _global.clearInterval(_loc5);
        delete mRefObject.__ANKTIMERID__;
        delete ank.utils.Timer._oIDs[sLayer][nTimerIndex];
    };
    (_global.ank.utils.Timer = function ()
    {
        super();
    }).getInstance = function ()
    {
        return (ank.utils.Timer._tTimer);
    };
    (_global.ank.utils.Timer = function ()
    {
        super();
    }).garbageCollector = function ()
    {
        for (var k in ank.utils.Timer._oIDs)
        {
            var _loc2 = ank.utils.Timer._oIDs[k];
            for (var kk in _loc2)
            {
                var _loc3 = _loc2[kk];
                if (_loc3[0] == undefined || (typeof(_loc3[0]) == "movieclip" && _loc3[0]._name == undefined || _loc3[0].__ANKTIMERID__ != _loc3[1]))
                {
                    _global.clearInterval(_loc3[1]);
                    delete _loc2[kk];
                } // end if
            } // end of for...in
        } // end of for...in
    };
    (_global.ank.utils.Timer = function ()
    {
        super();
    }).getTimersCount = function ()
    {
        var _loc2 = 0;
        for (var k in ank.utils.Timer._oIDs)
        {
            var _loc3 = ank.utils.Timer._oIDs[k];
            for (var kk in _loc3)
            {
                ++_loc2;
            } // end of for...in
        } // end of for...in
        return (_loc2);
    };
    (_global.ank.utils.Timer = function ()
    {
        super();
    }).getNextTimerIndex = function ()
    {
        return (ank.utils.Timer._nTimerIndex++);
    };
    _loc1.onTimer = function (nTimerIndex, mRefObject, sLayer, mFuncObject, fFunction, aParams)
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
        if (!mRefObject.__ANKTIMERREPEAT__)
        {
            ank.utils.Timer.removeTimer(mRefObject, sLayer, nTimerIndex);
            delete mRefObject.__ANKTIMERID__;
        } // end if
        fFunction.apply(mFuncObject, aParams);
        ank.utils.Timer.garbageCollector();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.utils.Timer = function ()
    {
        super();
    })._nTimerIndex = 0;
    (_global.ank.utils.Timer = function ()
    {
        super();
    })._oIDs = new Object(, _global.ank.utils.Timer = function ()
    {
        super();
    })._tTimer = new ank.utils.Timer();
} // end if
#endinitclip
