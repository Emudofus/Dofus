// Action script...

// [Initial MovieClip Action of sprite 20622]
#initclip 143
if (!ank.utils.CyclicTimer)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    }).prototype;
    (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    }).__get__interval = function ()
    {
        return (ank.utils.CyclicTimer._nInterval);
    };
    (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    }).addFunction = function (oRef, oObjFn, fFunction, aParams, oObjFnEnd, fFunctionEnd, aParamsEnd)
    {
        var _loc9 = new Object();
        _loc9.objRef = oRef;
        _loc9.objFn = oObjFn;
        _loc9.fn = fFunction;
        _loc9.params = aParams;
        _loc9.objFnEnd = oObjFnEnd;
        _loc9.fnEnd = fFunctionEnd;
        _loc9.paramsEnd = aParamsEnd;
        ank.utils.CyclicTimer._aFunctions.push(_loc9);
        ank.utils.CyclicTimer.play();
    };
    (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    }).removeFunction = function (oRef)
    {
        for (var _loc3 = ank.utils.CyclicTimer._aFunctions.length - 1; _loc3 >= 0; --_loc3)
        {
            var _loc4 = ank.utils.CyclicTimer._aFunctions[_loc3];
            if (oRef == _loc4.objRef)
            {
                ank.utils.CyclicTimer._aFunctions.splice(_loc3, 1);
            } // end if
        } // end of for
    };
    (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    }).clear = function ()
    {
        ank.utils.CyclicTimer.stop();
        ank.utils.CyclicTimer._aFunctions = new Array();
    };
    (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    }).play = function ()
    {
        if (ank.utils.CyclicTimer._bPlaying)
        {
            return;
        } // end if
        ank.utils.CyclicTimer._bPlaying = true;
        ank.utils.CyclicTimer.doCycle();
    };
    (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    }).stop = function ()
    {
        ank.utils.CyclicTimer._bPlaying = false;
    };
    (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    }).getInstance = function ()
    {
        return (ank.utils.CyclicTimer._oCyclicTimer);
    };
    (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    }).doCycle = function ()
    {
        for (var _loc2 = ank.utils.CyclicTimer._aFunctions.length - 1; _loc2 >= 0; --_loc2)
        {
            var _loc3 = ank.utils.CyclicTimer._aFunctions[_loc2];
            if (!_loc3.fn.apply(_loc3.objFn, _loc3.params))
            {
                ank.utils.CyclicTimer.onFunctionEnd(_loc2, _loc3);
            } // end if
        } // end of for
        if (ank.utils.CyclicTimer._aFunctions.length != 0)
        {
            ank.utils.Timer.setTimer(ank.utils.CyclicTimer._oCyclicTimer, "cyclicTimer", ank.utils.CyclicTimer, ank.utils.CyclicTimer.doCycle, ank.utils.CyclicTimer._nInterval);
        }
        else
        {
            ank.utils.CyclicTimer.stop();
        } // end else if
    };
    (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    }).onFunctionEnd = function (nIndex, oFunction)
    {
        oFunction.fnEnd.apply(oFunction.objFnEnd, oFunction.paramsEnd);
        ank.utils.CyclicTimer._aFunctions.splice(nIndex, 1);
    };
    (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    }).addProperty("interval", (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    }).__get__interval, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    })._aFunctions = new Array();
    (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    })._nInterval = 40;
    (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    })._bPlaying = false;
    (_global.ank.utils.CyclicTimer = function ()
    {
        super();
    })._oCyclicTimer = new ank.utils.CyclicTimer();
} // end if
#endinitclip
