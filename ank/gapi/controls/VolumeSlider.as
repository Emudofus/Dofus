// Action script...

// [Initial MovieClip Action of sprite 20862]
#initclip 127
if (!ank.gapi.controls.VolumeSlider)
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
    var _loc1 = (_global.ank.gapi.controls.VolumeSlider = function ()
    {
        super();
    }).prototype;
    _loc1.__set__min = function (nMin)
    {
        this._nMin = Number(nMin);
        //return (this.min());
    };
    _loc1.__get__min = function ()
    {
        return (this._nMin);
    };
    _loc1.__set__max = function (nMax)
    {
        this._nMax = Number(nMax);
        //return (this.max());
    };
    _loc1.__get__max = function ()
    {
        return (this._nMax);
    };
    _loc1.__set__value = function (nValue)
    {
        nValue = Number(nValue);
        if (_global.isNaN(nValue))
        {
            return;
        } // end if
        if (nValue > this.max)
        {
            nValue = this.max;
        } // end if
        if (nValue < this.min)
        {
            nValue = this.min;
        } // end if
        this._nValue = nValue;
        if (this._bInitialized)
        {
            var _loc3 = Math.floor((this._nMarkerCount - 1) * (nValue - this._nMin) / (this._nMax - this._nMin));
            this.setValueByIndex(_loc3);
        } // end if
        //return (this.value());
    };
    _loc1.__get__value = function ()
    {
        return (this._nValue);
    };
    _loc1.__set__markerCount = function (nMarkerCount)
    {
        if (Number(nMarkerCount) > 0)
        {
            this._nMarkerCount = Number(nMarkerCount);
        }
        else
        {
            ank.utils.Logger.err("[markerCount] ne peut être < à 0");
        } // end else if
        //return (this.markerCount());
    };
    _loc1.__get__markerWidth = function ()
    {
        return (this._nMarkerCount);
    };
    _loc1.__set__markerWidthRatio = function (nMarkerWidthRatio)
    {
        if (Number(nMarkerWidthRatio) >= 0 && Number(nMarkerWidthRatio) <= 1)
        {
            this._nMarkerWidthRatio = Number(nMarkerWidthRatio);
        }
        else
        {
            ank.utils.Logger.err("[markerCount] ne peut être < à 0 et > 1");
        } // end else if
        //return (this.markerWidthRatio());
    };
    _loc1.__get__markerWidthRatio = function ()
    {
        return (this._nMarkerWidthRatio);
    };
    _loc1.__set__markerSkin = function (sMarkerSkin)
    {
        this._sMarkerSkin = sMarkerSkin;
        //return (this.markerSkin());
    };
    _loc1.__get__markerSkin = function ()
    {
        return (this._sMarkerSkin);
    };
    _loc1.redraw = function ()
    {
        this.createMarkers();
        this.arrange();
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.VolumeSlider.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.createMarkers();
    };
    _loc1.arrange = function ()
    {
        var _loc2 = this.__height;
        var _loc3 = this.__height / 2;
        var _loc4 = this.__width / this._nMarkerCount;
        var _loc5 = (this.__width + _loc4 * (1 - this._nMarkerWidthRatio)) / this._nMarkerCount;
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < this._nMarkerCount)
        {
            var _loc7 = this._mcMarkers["mcMarker" + _loc6];
            var _loc8 = this._mcOvers["mcOver" + _loc6];
            var _loc9 = _loc8.index;
            var _loc10 = _loc9 / this._nMarkerCount;
            _loc7._width = _loc5 * this._nMarkerWidthRatio;
            _loc8._width = _loc5;
            _loc7._height = _loc3 + _loc10 * (_loc2 - _loc3);
            _loc8._height = this.__height;
            _loc7._x = _loc9 * _loc5;
            _loc7._y = this.__height;
            _loc8._x = _loc9 * _loc5;
            _loc8._y = 0;
        } // end while
    };
    _loc1.draw = function ()
    {
        this.addToQueue({object: this, method: function ()
        {
            this.value = this._nValue;
        }});
    };
    _loc1.createMarkers = function ()
    {
        this._mcMarkers.removeMovieClip();
        this.createEmptyMovieClip("_mcOvers", 10);
        this.createEmptyMovieClip("_mcMarkers", 20);
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < this._nMarkerCount)
        {
            var _loc3 = this._mcMarkers.attachMovie(this._sMarkerSkin, "mcMarker" + _loc2, _loc2);
            var _loc4 = this._mcOvers.createEmptyMovieClip("mcOver" + _loc2, _loc2);
            this.drawRoundRect(_loc4, 0, 0, 1, 1, 0, 16711935, 0);
            _loc4.index = _loc2;
            this.setMovieClipColor(_loc3, this.getStyle().offcolor);
            _loc4.trackAsMenu = true;
            _loc4.onDragOver = function ()
            {
                this._parent._parent.dragOver({target: this});
            };
            _loc4.onPress = function ()
            {
                this._parent._parent.press({target: this});
            };
        } // end while
    };
    _loc1.setValueByIndex = function (nIndex)
    {
        if (nIndex > this._nMarkerCount - 1)
        {
            return;
        } // end if
        if (nIndex < 0)
        {
            return;
        } // end if
        if (nIndex == undefined)
        {
            return;
        } // end if
        var _loc3 = this.getStyle().oncolor;
        var _loc4 = this.getStyle().offcolor;
        var _loc5 = 0;
        
        while (++_loc5, _loc5 <= nIndex)
        {
            this.setMovieClipColor(this._mcMarkers["mcMarker" + _loc5], _loc3);
        } // end while
        var _loc6 = nIndex + 1;
        
        while (++_loc6, _loc6 < this._nMarkerCount)
        {
            this.setMovieClipColor(this._mcMarkers["mcMarker" + _loc6], _loc4);
        } // end while
    };
    _loc1.getValueByIndex = function (nIndex)
    {
        return (nIndex * (this._nMax - this._nMin) / (this._nMarkerCount - 1) + this._nMin);
    };
    _loc1.dragOver = function (oEvent)
    {
        this.value = this.getValueByIndex(oEvent.target.index);
        this.dispatchEvent({type: "change"});
    };
    _loc1.press = function (oEvent)
    {
        this.value = this.getValueByIndex(oEvent.target.index);
        this.dispatchEvent({type: "change"});
    };
    _loc1.addProperty("markerSkin", _loc1.__get__markerSkin, _loc1.__set__markerSkin);
    _loc1.addProperty("markerWidthRatio", _loc1.__get__markerWidthRatio, _loc1.__set__markerWidthRatio);
    _loc1.addProperty("value", _loc1.__get__value, _loc1.__set__value);
    _loc1.addProperty("markerWidth", _loc1.__get__markerWidth, function ()
    {
    });
    _loc1.addProperty("max", _loc1.__get__max, _loc1.__set__max);
    _loc1.addProperty("min", _loc1.__get__min, _loc1.__set__min);
    _loc1.addProperty("markerCount", function ()
    {
    }, _loc1.__set__markerCount);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.VolumeSlider = function ()
    {
        super();
    }).CLASS_NAME = "VolumeSlider";
    _loc1._nMin = 0;
    _loc1._nMax = 100;
    _loc1._nValue = 0;
    _loc1._nMarkerCount = 5;
    _loc1._nMarkerWidthRatio = 7.000000E-001;
    _loc1._sMarkerSkin = "VolumeSliderMarkerDefault";
} // end if
#endinitclip
