// Action script...

// [Initial MovieClip Action of sprite 20770]
#initclip 35
if (!ank.gapi.controls.ProgressBar)
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
    var _loc1 = (_global.ank.gapi.controls.ProgressBar = function ()
    {
        super();
    }).prototype;
    _loc1.__set__renderer = function (sRenderer)
    {
        if (this._bInitialized)
        {
            return;
        } // end if
        this._sRenderer = sRenderer;
        //return (this.renderer());
    };
    _loc1.__set__minimum = function (nMinimum)
    {
        this._nMinimum = Number(nMinimum);
        //return (this.minimum());
    };
    _loc1.__get__minimum = function ()
    {
        return (this._nMinimum);
    };
    _loc1.__set__maximum = function (nMaximum)
    {
        this._nMaximum = Number(nMaximum);
        //return (this.maximum());
    };
    _loc1.__get__maximum = function ()
    {
        return (this._nMaximum);
    };
    _loc1.__set__value = function (nValue)
    {
        if (nValue > this._nMaximum)
        {
            nValue = this._nMaximum;
        } // end if
        if (nValue < this._nMinimum)
        {
            nValue = this._nMinimum;
        } // end if
        this._nValue = Number(nValue);
        this.addToQueue({object: this, method: this.applyValue});
        //return (this.value());
    };
    _loc1.__get__value = function ()
    {
        return (this._nValue);
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.ProgressBar.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.attachMovie(this._sRenderer, "_mcRenderer", 10);
        this.hideUp(true);
    };
    _loc1.size = function ()
    {
        super.size();
    };
    _loc1.arrange = function ()
    {
        this._mcRenderer._mcBgLeft._height = this._mcRenderer._mcBgMiddle._height = this._mcRenderer._mcBgRight._height = this.__height;
        var _loc2 = this._mcRenderer._mcBgLeft._yscale;
        this._mcRenderer._mcBgLeft._xscale = this._mcRenderer._mcUpLeft._xscale = this._mcRenderer._mcUpLeft._yscale = _loc2;
        this._mcRenderer._mcBgRight._xscale = this._mcRenderer._mcUpRight._xscale = this._mcRenderer._mcUpRight._yscale = _loc2;
        this._mcRenderer._mcUpMiddle._yscale = _loc2;
        var _loc3 = this._mcRenderer._mcBgLeft._width;
        var _loc4 = this._mcRenderer._mcBgLeft._width;
        this._mcRenderer._mcBgLeft._x = this._mcRenderer._mcBgLeft._y = this._mcRenderer._mcBgMiddle._y = this._mcRenderer._mcBgRight._y = 0;
        this._mcRenderer._mcUpLeft._x = this._mcRenderer._mcUpLeft._y = this._mcRenderer._mcUpMiddle._y = this._mcRenderer._mcUpRight._y = 0;
        this._mcRenderer._mcBgMiddle._x = this._mcRenderer._mcUpMiddle._x = _loc3;
        this._mcRenderer._mcBgRight._x = this.__width - _loc4;
        this._mcRenderer._mcBgMiddle._width = this.__width - _loc3 - _loc4;
    };
    _loc1.draw = function ()
    {
        var _loc3 = this.getStyle();
        var _loc2 = this._mcRenderer._mcBgLeft;
        for (var k in _loc2)
        {
            var _loc4 = k.split("_")[0];
            this.setMovieClipColor(_loc2[k], _loc3[_loc4 + "color"]);
        } // end of for...in
        _loc2 = this._mcRenderer._mcBgMiddle;
        for (var k in _loc2)
        {
            var _loc5 = k.split("_")[0];
            this.setMovieClipColor(_loc2[k], _loc3[_loc5 + "color"]);
        } // end of for...in
        _loc2 = this._mcRenderer._mcBgRight;
        for (var k in _loc2)
        {
            var _loc6 = k.split("_")[0];
            this.setMovieClipColor(_loc2[k], _loc3[_loc6 + "color"]);
        } // end of for...in
        _loc2 = this._mcRenderer._mcUpLeft;
        for (var k in _loc2)
        {
            var _loc7 = k.split("_")[0];
            this.setMovieClipColor(_loc2[k], _loc3[_loc7 + "color"]);
        } // end of for...in
        _loc2 = this._mcRenderer._mcUpMiddle;
        for (var k in _loc2)
        {
            var _loc8 = k.split("_")[0];
            this.setMovieClipColor(_loc2[k], _loc3[_loc8 + "color"]);
        } // end of for...in
        _loc2 = this._mcRenderer._mcUpRight;
        for (var k in _loc2)
        {
            var _loc9 = k.split("_")[0];
            this.setMovieClipColor(_loc2[k], _loc3[_loc9 + "color"]);
        } // end of for...in
    };
    _loc1.hideUp = function (bHide)
    {
        this._mcRenderer._mcUpLeft._visible = !bHide;
        this._mcRenderer._mcUpMiddle._visible = !bHide;
        this._mcRenderer._mcUpRight._visible = !bHide;
    };
    _loc1.applyValue = function ()
    {
        var _loc2 = this._mcRenderer._mcBgLeft._width;
        var _loc3 = this._mcRenderer._mcBgLeft._width;
        var _loc4 = this._nValue - this._nMinimum;
        if (_loc4 == 0)
        {
            this.hideUp(true);
        }
        else
        {
            this.hideUp(false);
            var _loc5 = this._nMaximum - this._nMinimum;
            var _loc6 = this.__width - _loc2 - _loc3;
            var _loc7 = Math.floor(_loc4 / _loc5 * _loc6);
            this._mcRenderer._mcUpMiddle._width = _loc7;
            this._mcRenderer._mcUpRight._x = _loc7 + _loc2;
        } // end else if
    };
    _loc1.setEnabled = function ()
    {
        if (this._bEnabled)
        {
            this.onRollOver = function ()
            {
                this.dispatchEvent({type: "over"});
            };
            this.onRollOut = function ()
            {
                this.dispatchEvent({type: "out"});
            };
        }
        else
        {
            this.onRollOver = undefined;
            this.onRollOut = undefined;
        } // end else if
    };
    _loc1.addProperty("value", _loc1.__get__value, _loc1.__set__value);
    _loc1.addProperty("minimum", _loc1.__get__minimum, _loc1.__set__minimum);
    _loc1.addProperty("renderer", function ()
    {
    }, _loc1.__set__renderer);
    _loc1.addProperty("maximum", _loc1.__get__maximum, _loc1.__set__maximum);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.ProgressBar = function ()
    {
        super();
    }).CLASS_NAME = "ProgressBar";
    _loc1._sRenderer = "ProgressBarDefaultRenderer";
    _loc1._nValue = 0;
    _loc1._nMinimum = 0;
    _loc1._nMaximum = 100;
} // end if
#endinitclip
