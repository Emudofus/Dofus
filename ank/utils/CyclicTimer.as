// Action script...

// [Initial MovieClip Action of sprite 871]
#initclip 83
class ank.utils.CyclicTimer extends Object
{
    static var __get__interval;
    function CyclicTimer()
    {
        super();
    } // End of the function
    static function get interval()
    {
        return (ank.utils.CyclicTimer._nInterval);
    } // End of the function
    static function addFunction(oRef, oObjFn, fFunction, aParams, oObjFnEnd, fFunctionEnd, aParamsEnd)
    {
        var _loc1 = new Object();
        _loc1.objRef = oRef;
        _loc1.objFn = oObjFn;
        _loc1.fn = fFunction;
        _loc1.params = aParams;
        _loc1.objFnEnd = oObjFnEnd;
        _loc1.fnEnd = fFunctionEnd;
        _loc1.paramsEnd = aParamsEnd;
        ank.utils.CyclicTimer._aFunctions.push(_loc1);
        ank.utils.CyclicTimer.play();
    } // End of the function
    static function removeFunction(oRef)
    {
        for (var _loc1 = ank.utils.CyclicTimer._aFunctions.length - 1; _loc1 >= 0; --_loc1)
        {
            var _loc2 = ank.utils.CyclicTimer._aFunctions[_loc1];
            if (oRef == _loc2.objRef)
            {
                ank.utils.CyclicTimer._aFunctions.splice(_loc1, 1);
            } // end if
        } // end of for
    } // End of the function
    static function clear()
    {
        ank.utils.CyclicTimer.stop();
        _aFunctions = new Array();
    } // End of the function
    static function play()
    {
        if (ank.utils.CyclicTimer._bPlaying)
        {
            return;
        } // end if
        _bPlaying = true;
        ank.utils.CyclicTimer.doCycle();
    } // End of the function
    static function stop()
    {
        _bPlaying = false;
    } // End of the function
    static function getInstance()
    {
        return (ank.utils.CyclicTimer._oCyclicTimer);
    } // End of the function
    static function doCycle()
    {
        for (var _loc2 = ank.utils.CyclicTimer._aFunctions.length - 1; _loc2 >= 0; --_loc2)
        {
            var _loc1 = ank.utils.CyclicTimer._aFunctions[_loc2];
            if (!_loc1.fn.apply(_loc1.objFn, _loc1.params))
            {
                ank.utils.CyclicTimer.onFunctionEnd(_loc2, _loc1);
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
    } // End of the function
    static function onFunctionEnd(nIndex, oFunction)
    {
        oFunction.fnEnd.apply(oFunction.objFnEnd, oFunction.paramsEnd);
        ank.utils.CyclicTimer._aFunctions.splice(nIndex, 1);
    } // End of the function
    static var _aFunctions = new Array();
    static var _nInterval = 40;
    static var _bPlaying = false;
    static var _oCyclicTimer = new ank.utils.CyclicTimer();
} // End of Class
#endinitclip
