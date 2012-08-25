// Action script...

// [Initial MovieClip Action of sprite 20521]
#initclip 42
if (!ank.gapi.controls.Clock)
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
    var _loc1 = (_global.ank.gapi.controls.Clock = function ()
    {
        super();
    }).prototype;
    _loc1.__set__background = function (sBackground)
    {
        this._sBackground = sBackground;
        //return (this.background());
    };
    _loc1.__get__background = function ()
    {
        return (this._sBackground);
    };
    _loc1.__set__arrowHours = function (sArrowHours)
    {
        this._sArrowHours = sArrowHours;
        //return (this.arrowHours());
    };
    _loc1.__get__arrowHours = function ()
    {
        return (this._sArrowHours);
    };
    _loc1.__set__arrowMinutes = function (sArrowMinutes)
    {
        this._sArrowMinutes = sArrowMinutes;
        //return (this.arrowMinutes());
    };
    _loc1.__get__arrowMinutes = function ()
    {
        return (this._sArrowMinutes);
    };
    _loc1.__set__hours = function (nHours)
    {
        this._nHours = nHours % 12;
        if (this.initialized)
        {
            this.layoutContent();
        } // end if
        //return (this.hours());
    };
    _loc1.__get__hours = function ()
    {
        return (this._nHours);
    };
    _loc1.__set__minutes = function (nMinutes)
    {
        this._nMinutes = nMinutes % 59;
        if (this.initialized)
        {
            this.layoutContent();
        } // end if
        //return (this.minutes());
    };
    _loc1.__get__minutes = function ()
    {
        return (this._nMinutes);
    };
    _loc1.__set__updateFunction = function (oUpdateFunction)
    {
        this._oUpdateFunction = oUpdateFunction;
        //return (this.updateFunction());
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.Clock.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.attachMovie("Loader", "_ldrBack", 10, {contentPath: this._sBackground, centerContent: false, scaleContent: true});
        this.attachMovie("Loader", "_ldrArrowHours", 20, {contentPath: this._sArrowHours, centerContent: false, scaleContent: true});
        this.attachMovie("Loader", "_ldrArrowMinutes", 30, {contentPath: this._sArrowMinutes, centerContent: false, scaleContent: true});
        this._ldrArrowHours._visible = false;
        this._ldrArrowMinutes._visible = false;
        this.addToQueue({object: this, method: this.layoutContent});
    };
    _loc1.size = function ()
    {
        super.size();
        this.arrange();
    };
    _loc1.arrange = function ()
    {
        this._ldrBack.setSize(this.__width, this.__height);
        this._ldrArrowHours.setSize(this.__width, this.__height);
        this._ldrArrowMinutes.setSize(this.__width, this.__height);
    };
    _loc1.layoutContent = function ()
    {
        if (this._oUpdateFunction != undefined)
        {
            var _loc2 = this._oUpdateFunction.method.apply(this._oUpdateFunction.object);
            ank.utils.Timer.setTimer(this, "clock", this, this.layoutContent, 30000);
            this._nHours = _loc2[0];
            this._nMinutes = _loc2[1];
        } // end if
        var _loc3 = 30 * this._nHours + 6 * this._nMinutes / 12 - 90;
        var _loc4 = 6 * this._nMinutes - 90;
        this._ldrArrowHours.content._rotation = _loc3;
        this._ldrArrowMinutes.content._rotation = _loc4;
        this._ldrArrowHours._visible = true;
        this._ldrArrowMinutes._visible = true;
    };
    _loc1.onRelease = function ()
    {
        this.dispatchEvent({type: "click"});
    };
    _loc1.onReleaseOutside = function ()
    {
        this.onRollOut();
    };
    _loc1.onRollOver = function ()
    {
        this.dispatchEvent({type: "over"});
    };
    _loc1.onRollOut = function ()
    {
        this.dispatchEvent({type: "out"});
    };
    _loc1.addProperty("hours", _loc1.__get__hours, _loc1.__set__hours);
    _loc1.addProperty("minutes", _loc1.__get__minutes, _loc1.__set__minutes);
    _loc1.addProperty("background", _loc1.__get__background, _loc1.__set__background);
    _loc1.addProperty("arrowHours", _loc1.__get__arrowHours, _loc1.__set__arrowHours);
    _loc1.addProperty("arrowMinutes", _loc1.__get__arrowMinutes, _loc1.__set__arrowMinutes);
    _loc1.addProperty("updateFunction", function ()
    {
    }, _loc1.__set__updateFunction);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.Clock = function ()
    {
        super();
    }).CLASS_NAME = "Clock";
    _loc1._bHoursLoaded = false;
    _loc1._bMinutesLoaded = false;
} // end if
#endinitclip
