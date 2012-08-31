// Action script...

// [Initial MovieClip Action of sprite 452]
#initclip 229
class ank.gapi.controls.CircleChrono extends ank.gapi.core.UIBasicComponent
{
    var __get__background, __get__finalCountDownTrigger, _nMaxTime, _nTimerValue, _nIntervalID, dispatchEvent, addToQueue, attachMovie, _mcLeft, _mcRight, __width, __height, getStyle, setMovieClipColor, __set__background, __set__finalCountDownTrigger;
    function CircleChrono()
    {
        super();
    } // End of the function
    function set background(sBackground)
    {
        _sBackgroundLink = sBackground;
        //return (this.background());
        null;
    } // End of the function
    function set finalCountDownTrigger(nFinalCountDownTrigger)
    {
        nFinalCountDownTrigger = Number(nFinalCountDownTrigger);
        if (isNaN(nFinalCountDownTrigger))
        {
            return;
        } // end if
        if (nFinalCountDownTrigger < 0)
        {
            return;
        } // end if
        _nFinalCountDownTrigger = nFinalCountDownTrigger;
        //return (this.finalCountDownTrigger());
        null;
    } // End of the function
    function startTimer(nDuration)
    {
        nDuration = Number(nDuration);
        if (isNaN(nDuration))
        {
            return;
        } // end if
        if (nDuration < 0)
        {
            return;
        } // end if
        _nMaxTime = nDuration;
        _nTimerValue = nDuration;
        this.updateTimer();
        clearInterval(_nIntervalID);
        _nIntervalID = setInterval(this, "updateTimer", 1000);
    } // End of the function
    function stopTimer()
    {
        clearInterval(_nIntervalID);
        this.dispatchEvent({type: "finish"});
        this.addToQueue({object: this, method: initialize});
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.CircleChrono.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.attachMovie(_sBackgroundLink, "_mcLeft", 10);
        this.attachMovie(_sBackgroundLink, "_mcRight", 20);
    } // End of the function
    function arrange()
    {
        _mcLeft._width = _mcRight._width = __width;
        _mcLeft._height = _mcRight._height = __height;
        _mcLeft._xscale = _mcLeft._xscale * -1;
        _mcLeft._yscale = _mcLeft._yscale * -1;
        _mcLeft._x = _mcRight._x = __width / 2;
        _mcLeft._y = _mcRight._y = __height / 2;
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        if (_loc2.bgcolor != undefined)
        {
            this.setMovieClipColor(_mcLeft.bg_mc, _loc2.bgcolor);
            this.setMovieClipColor(_mcRight.bg_mc, _loc2.bgcolor);
        } // end if
    } // End of the function
    function updateTimer()
    {
        var _loc4 = _nTimerValue / _nMaxTime;
        var _loc2 = 360 * (1 - _nTimerValue / _nMaxTime);
        if (_loc2 < 180)
        {
            this.setRtation(_mcRight, _loc2);
            this.setRtation(_mcLeft, 0);
        }
        else
        {
            this.setRtation(_mcRight, 180);
            this.setRtation(_mcLeft, _loc2 - 180);
        } // end else if
        if (_nTimerValue <= _nFinalCountDownTrigger)
        {
            this.dispatchEvent({type: "finalCountDown", value: Math.ceil(_nTimerValue)});
        } // end if
        --_nTimerValue;
        if (_nTimerValue < 0)
        {
            this.stopTimer();
        } // end if
    } // End of the function
    function initialize()
    {
        this.setRtation(_mcLeft, 0);
        this.setRtation(_mcRight, 0);
    } // End of the function
    function setRtation(mc, nAngle)
    {
        mc._mcMask._rotation = nAngle;
    } // End of the function
    static var CLASS_NAME = "CircleChrono";
    var _sBackgroundLink = "CircleChronoHalfDefault";
    var _nFinalCountDownTrigger = 5;
} // End of Class
#endinitclip
