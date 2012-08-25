// Action script...

// [Initial MovieClip Action of sprite 20798]
#initclip 63
if (!ank.gapi.controls.VerticalChrono)
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
    var _loc1 = (_global.ank.gapi.controls.VerticalChrono = function ()
    {
        super();
    }).prototype;
    _loc1.startTimer = function (nDuration, nMaxValue)
    {
        this._nTimerValue = Math.ceil(nDuration);
        this._nMaxTime = nMaxValue == undefined ? (this._nTimerValue) : (nMaxValue);
        this.addToQueue({object: this, method: this.updateTimer});
        _global.clearInterval(this._nIntervalID);
        this._nIntervalID = _global.setInterval(this, "updateTimer", 1000);
    };
    _loc1.stopTimer = function ()
    {
        _global.clearInterval(this._nIntervalID);
        this._mcRectangle._height = 0;
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.VerticalChrono.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.createEmptyMovieClip("_mcRectangle", 10);
    };
    _loc1.arrange = function ()
    {
        this._mcRectangle._width = this.__width;
        this._mcRectangle._height = 0;
        this._mcRectangle._x = 0;
        this._mcRectangle._y = this.__height;
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        var _loc3 = _loc2 != undefined ? (_loc2.bgcolor) : (0);
        var _loc4 = _loc2 != undefined ? (_loc2.bgalpha) : (100);
        this._mcRectangle.clear();
        this.drawRoundRect(this._mcRectangle, 0, 0, 100, 100, 0, _loc3, _loc4);
    };
    _loc1.updateTimer = function ()
    {
        var _loc2 = this._nTimerValue / this._nMaxTime;
        var _loc3 = (this._nMaxTime - this._nTimerValue) / this._nMaxTime * this.__height;
        var _loc4 = _loc2 * this.__height;
        this._mcRectangle._y = _loc4;
        this._mcRectangle._height = _loc3;
        if (this._nTimerValue < 0)
        {
            this.stopTimer();
            this.dispatchEvent({type: "endTimer"});
        } // end if
        --this._nTimerValue;
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.VerticalChrono = function ()
    {
        super();
    }).CLASS_NAME = "VerticalChrono";
} // end if
#endinitclip
