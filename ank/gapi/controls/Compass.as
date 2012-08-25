// Action script...

// [Initial MovieClip Action of sprite 20925]
#initclip 190
if (!ank.gapi.controls.Compass)
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
    var _loc1 = (_global.ank.gapi.controls.Compass = function ()
    {
        super();
    }).prototype;
    _loc1.__set__updateOnLoad = function (bUpdateOnLoad)
    {
        this._bUpdateOnLoad = bUpdateOnLoad;
        //return (this.updateOnLoad());
    };
    _loc1.__get__updateOnLoad = function ()
    {
        return (this._bUpdateOnLoad);
    };
    _loc1.__set__background = function (sBackground)
    {
        this._sBackground = sBackground;
        //return (this.background());
    };
    _loc1.__get__background = function ()
    {
        return (this._sBackground);
    };
    _loc1.__set__arrow = function (sArrow)
    {
        this._sArrow = sArrow;
        //return (this.arrow());
    };
    _loc1.__get__arrow = function ()
    {
        return (this._sArrow);
    };
    _loc1.__set__noArrow = function (sNoArrow)
    {
        this._sNoArrow = sNoArrow;
        //return (this.noArrow());
    };
    _loc1.__get__noArrow = function ()
    {
        return (this._sNoArrow);
    };
    _loc1.__set__currentCoords = function (aCurrentCoords)
    {
        this._aCurrentCoords = aCurrentCoords;
        if (this.initialized)
        {
            this.layoutContent();
        } // end if
        //return (this.currentCoords());
    };
    _loc1.__set__targetCoords = function (aTargetCoords)
    {
        this._aTargetCoords = aTargetCoords;
        if (this.initialized)
        {
            this.layoutContent();
        } // end if
        //return (this.targetCoords());
    };
    _loc1.__get__targetCoords = function ()
    {
        return (this._aTargetCoords);
    };
    _loc1.__set__allCoords = function (oAllCoords)
    {
        this._aTargetCoords = oAllCoords.targetCoords;
        this._aCurrentCoords = oAllCoords.currentCoords;
        if (this.initialized)
        {
            this.addToQueue({object: this, method: this.layoutContent});
        } // end if
        //return (this.allCoords());
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.Compass.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.attachMovie("Loader", "_ldrBack", 10, {contentPath: this._sBackground, centerContent: false, scaleContent: true});
        this.createEmptyMovieClip("_mcArrow", 20);
        this._mcArrow.attachMovie("Loader", "_ldrArrow", 10, {contentPath: this._sNoArrow, centerContent: false, scaleContent: true});
        if (this._bUpdateOnLoad)
        {
            this.addToQueue({object: this, method: this.layoutContent});
        } // end if
    };
    _loc1.size = function ()
    {
        super.size();
        this.arrange();
    };
    _loc1.arrange = function ()
    {
        this._ldrBack.setSize(this.__width, this.__height);
        this._mcArrow._x = this.__width / 2;
        this._mcArrow._y = this.__height / 2;
        this._mcArrow._ldrArrow.setSize(this.__width, this.__height);
        this._mcArrow._ldrArrow._x = -this.__width / 2;
        this._mcArrow._ldrArrow._y = -this.__height / 2;
    };
    _loc1.layoutContent = function ()
    {
        if (this._aCurrentCoords == undefined)
        {
            return;
        } // end if
        if (this._aCurrentCoords.length == 0)
        {
            return;
        } // end if
        if (this._aTargetCoords == undefined)
        {
            return;
        } // end if
        if (this._aTargetCoords.length == 0)
        {
            return;
        } // end if
        ank.utils.Timer.removeTimer(this, "compass");
        var _loc2 = this._aTargetCoords[0] - this._aCurrentCoords[0];
        var _loc3 = this._aTargetCoords[1] - this._aCurrentCoords[1];
        if (_loc2 == 0 && _loc3 == 0)
        {
            this._mcArrow._ldrArrow.contentPath = this._sNoArrow;
            this._mcArrow._ldrArrow.content._rotation = this._mcArrow._rotation;
            this._mcArrow._rotation = 0;
            this.smoothRotation(0, 1);
        }
        else
        {
            var _loc4 = Math.atan2(_loc3, _loc2) * (180 / Math.PI);
            this._mcArrow._ldrArrow.contentPath = this._sArrow;
            this._mcArrow._ldrArrow.content._rotation = this._mcArrow._rotation - _loc4;
            this._mcArrow._rotation = _loc4;
            this.smoothRotation(_loc4, 1);
        } // end else if
    };
    _loc1.smoothRotation = function (nMaxAngle, nSpeed)
    {
        this._mcArrow._ldrArrow.content._rotation = this._mcArrow._ldrArrow.content._rotation + nSpeed;
        nSpeed = -this._mcArrow._ldrArrow.content._rotation * 2.000000E-001 + nSpeed * 7.000000E-001;
        if (Math.abs(nSpeed) > 1.000000E-002)
        {
            ank.utils.Timer.setTimer(this, "compass", this, this.smoothRotation, 50, [nMaxAngle, nSpeed]);
        }
        else
        {
            this._mcArrow._ldrArrow.content._rotation = 0;
        } // end else if
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
    _loc1.addProperty("noArrow", _loc1.__get__noArrow, _loc1.__set__noArrow);
    _loc1.addProperty("targetCoords", _loc1.__get__targetCoords, _loc1.__set__targetCoords);
    _loc1.addProperty("background", _loc1.__get__background, _loc1.__set__background);
    _loc1.addProperty("arrow", _loc1.__get__arrow, _loc1.__set__arrow);
    _loc1.addProperty("currentCoords", function ()
    {
    }, _loc1.__set__currentCoords);
    _loc1.addProperty("updateOnLoad", _loc1.__get__updateOnLoad, _loc1.__set__updateOnLoad);
    _loc1.addProperty("allCoords", function ()
    {
    }, _loc1.__set__allCoords);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.Compass = function ()
    {
        super();
    }).CLASS_NAME = "Compass";
    _loc1._bUpdateOnLoad = true;
    _loc1._sBackground = "CompassNormalBackground";
    _loc1._sArrow = "CompassNormalArrow";
    _loc1._sNoArrow = "CompassNormalNoArrow";
} // end if
#endinitclip
