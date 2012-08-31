// Action script...

// [Initial MovieClip Action of sprite 106]
#initclip 30
class ank.gapi.controls.VerticalChrono extends ank.gapi.core.UIBasicComponent
{
    var _nTimerValue, _nMaxTime, addToQueue, _nIntervalID, _mcRectangle, createEmptyMovieClip, __width, __height, getStyle, drawRoundRect, dispatchEvent;
    function VerticalChrono()
    {
        super();
    } // End of the function
    function startTimer(nDuration, nMaxValue)
    {
        _nTimerValue = Math.ceil(nDuration);
        _nMaxTime = nMaxValue == undefined ? (_nTimerValue) : (nMaxValue);
        this.addToQueue({object: this, method: updateTimer});
        clearInterval(_nIntervalID);
        _nIntervalID = setInterval(this, "updateTimer", 1000);
    } // End of the function
    function stopTimer()
    {
        _mcRectangle._height = 0;
        clearInterval(_nIntervalID);
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.VerticalChrono.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.createEmptyMovieClip("_mcRectangle", 10);
    } // End of the function
    function arrange()
    {
        _mcRectangle._width = __width;
        _mcRectangle._height = 0;
        _mcRectangle._x = 0;
        _mcRectangle._y = __height;
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        var _loc3 = _loc2 != undefined ? (_loc2.bgcolor) : (0);
        var _loc4 = _loc2 != undefined ? (_loc2.bgalpha) : (100);
        _mcRectangle.clear();
        this.drawRoundRect(_mcRectangle, 0, 0, 100, 100, 0, _loc3, _loc4);
    } // End of the function
    function updateTimer()
    {
        var _loc2 = _nTimerValue / _nMaxTime;
        var _loc3 = (_nMaxTime - _nTimerValue) / _nMaxTime * __height;
        var _loc4 = _loc2 * __height;
        _mcRectangle._y = _loc4;
        _mcRectangle._height = _loc3;
        if (_nTimerValue < 0)
        {
            this.stopTimer();
            this.dispatchEvent({type: "endTimer"});
        } // end if
        --_nTimerValue;
    } // End of the function
    static var CLASS_NAME = "VerticalChrono";
} // End of Class
#endinitclip
