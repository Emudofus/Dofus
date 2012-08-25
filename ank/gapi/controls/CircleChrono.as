// Action script...

// [Initial MovieClip Action of sprite 20785]
#initclip 50
if (!ank.gapi.controls.CircleChrono)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.gapi)
    {
        _global.ank.gapi = new Object();
    } // end if
    if (!ank.gapi.controls)
    {
        _global.ank.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.controls.CircleChrono = function ()
    {
        super();
    }).prototype;
    _loc1.__set__background = function (sBackground)
    {
        this._sBackgroundLink = sBackground;
        //return (this.background());
    };
    _loc1.__set__finalCountDownTrigger = function (nFinalCountDownTrigger)
    {
        nFinalCountDownTrigger = Number(nFinalCountDownTrigger);
        if (_global.isNaN(nFinalCountDownTrigger))
        {
            return;
        } // end if
        if (nFinalCountDownTrigger < 0)
        {
            return;
        } // end if
        this._nFinalCountDownTrigger = nFinalCountDownTrigger;
        //return (this.finalCountDownTrigger());
    };
    _loc1.startTimer = function (nDuration)
    {
        _global.clearInterval(this._nIntervalID);
        nDuration = Number(nDuration);
        if (_global.isNaN(nDuration))
        {
            return;
        } // end if
        if (nDuration < 0)
        {
            return;
        } // end if
        this._nMaxTime = nDuration;
        this._nTimerValue = nDuration;
        this.updateTimer();
        this._nIntervalID = _global.setInterval(this, "updateTimer", 1000);
    };
    _loc1.stopTimer = function ()
    {
        _global.clearInterval(this._nIntervalID);
        this.dispatchEvent({type: "finish"});
        this.addToQueue({object: this, method: this.initialize});
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.CircleChrono.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.attachMovie(this._sBackgroundLink, "_mcLeft", 10);
        this.attachMovie(this._sBackgroundLink, "_mcRight", 20);
    };
    _loc1.arrange = function ()
    {
        this._mcLeft._width = this._mcRight._width = this.__width;
        this._mcLeft._height = this._mcRight._height = this.__height;
        this._mcLeft._xscale = this._mcLeft._xscale * -1;
        this._mcLeft._yscale = this._mcLeft._yscale * -1;
        this._mcLeft._x = this._mcRight._x = this.__width / 2;
        this._mcLeft._y = this._mcRight._y = this.__height / 2;
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        if (_loc2.bgcolor != undefined)
        {
            this.setMovieClipColor(this._mcLeft.bg_mc, _loc2.bgcolor);
            this.setMovieClipColor(this._mcRight.bg_mc, _loc2.bgcolor);
        } // end if
    };
    _loc1.updateTimer = function ()
    {
        this.dispatchEvent({type: "tictac"});
        var _loc2 = this._nTimerValue / this._nMaxTime;
        var _loc3 = 360 * (1 - this._nTimerValue / this._nMaxTime);
        if (_loc3 < 180)
        {
            this.setRtation(this._mcRight, _loc3);
            this.setRtation(this._mcLeft, 0);
        }
        else
        {
            this.setRtation(this._mcRight, 180);
            this.setRtation(this._mcLeft, _loc3 - 180);
        } // end else if
        if (this._nTimerValue - 5 <= this._nFinalCountDownTrigger)
        {
            this.dispatchEvent({type: "beforeFinalCountDown", value: Math.ceil(this._nTimerValue)});
        } // end if
        if (this._nTimerValue <= this._nFinalCountDownTrigger)
        {
            this.dispatchEvent({type: "finalCountDown", value: Math.ceil(this._nTimerValue)});
        } // end if
        --this._nTimerValue;
        if (this._nTimerValue < 0)
        {
            this.stopTimer();
        } // end if
    };
    _loc1.initialize = function ()
    {
        this.setRtation(this._mcLeft, 0);
        this.setRtation(this._mcRight, 0);
    };
    _loc1.setRtation = function (mc, nAngle)
    {
        mc._mcMask._rotation = nAngle;
    };
    _loc1.addProperty("finalCountDownTrigger", function ()
    {
    }, _loc1.__set__finalCountDownTrigger);
    _loc1.addProperty("background", function ()
    {
    }, _loc1.__set__background);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.CircleChrono = function ()
    {
        super();
    }).CLASS_NAME = "CircleChrono";
    _loc1._sBackgroundLink = "CircleChronoHalfDefault";
    _loc1._nFinalCountDownTrigger = 5;
} // end if
#endinitclip
