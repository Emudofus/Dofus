// Action script...

// [Initial MovieClip Action of sprite 20528]
#initclip 49
if (!ank.gapi.controls.ColorPicker)
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
    var _loc1 = (_global.ank.gapi.controls.ColorPicker = function ()
    {
        super();
    }).prototype;
    _loc1.__set__sliderOutWidth = function (nSliderOutWidth)
    {
        this._nSliderOutWidth = Number(nSliderOutWidth);
        //return (this.sliderOutWidth());
    };
    _loc1.__get__sliderOutWidth = function ()
    {
        return (this._nSliderOutWidth);
    };
    _loc1.__set__sliderInWidth = function (nSliderInWidth)
    {
        this._nSliderInWidth = Number(nSliderInWidth);
        //return (this.sliderInWidth());
    };
    _loc1.__get__sliderInWidth = function ()
    {
        return (this._nSliderInWidth);
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.ColorPicker.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.createEmptyMovieClip("_mcColorsV", 10);
        this.createEmptyMovieClip("_mcColorsH", 20);
        this.createEmptyMovieClip("_mcSlider", 30);
        this.createEmptyMovieClip("_mcSliderUp", 40);
        this._cSliderUpColor = new Color(this._mcSliderUp);
        this.attachMovie("ColorPickerColorsCross", "_mcColorsCross", 50);
        this.attachMovie("ColorPickerSliderCross", "_mcSliderCross", 60);
        this._mcColorsV.onPress = function ()
        {
            this._parent.onStartColorsCrossMove();
        };
        this._mcColorsV.onRelease = this._mcColorsV.onReleaseOutside = function ()
        {
            this._parent.onStopColorsCrossMove();
        };
        this._mcSlider.onPress = function ()
        {
            this._parent.onStartSliderCrossMove();
        };
        this._mcSlider.onRelease = this._mcSlider.onReleaseOutside = function ()
        {
            this._parent.onStopSliderCrossMove();
        };
    };
    _loc1.arrange = function ()
    {
        this._mcColorsV._width = this._mcColorsH._width = this.__width - this._nSliderOutWidth;
        this._mcColorsV._height = this._mcColorsH._height = this.__height;
        this._mcSlider._x = this._mcSliderUp._x = this.__width - (this._nSliderOutWidth + this._nSliderInWidth) / 2;
        this._mcSlider._width = this._mcSliderUp._width = this._nSliderInWidth;
        this._mcSlider._height = this._mcSliderUp._height = this.__height;
        this._nColorsWidth = this.__width - 30;
        this._nSliderCenterX = this.__width - this._nSliderOutWidth / 2;
        this.placeSliderCross(this._nSliderCenterX, this.__height / 2);
    };
    _loc1.draw = function ()
    {
        this.drawRoundRect(this._mcColorsV, 0, 0, 1, 1, 0, ank.gapi.controls.ColorPicker.COLORS_V, ank.gapi.controls.ColorPicker.ALPHAS_V, ank.gapi.controls.ColorPicker.MATRIX_V, "linear", ank.gapi.controls.ColorPicker.RATIOS_V);
        this.drawRoundRect(this._mcColorsH, 0, 0, 1, 1, 0, ank.gapi.controls.ColorPicker.COLORS_H, ank.gapi.controls.ColorPicker.ALPHAS_H, ank.gapi.controls.ColorPicker.MATRIX_H, "linear", ank.gapi.controls.ColorPicker.RATIOS_H);
        this.drawRoundRect(this._mcSlider, 0, 0, 1, 5.000000E-001, 0, 16777215);
        this.drawRoundRect(this._mcSlider, 0, 5.000000E-001, 1, 5.000000E-001, 0, 0);
        this.drawRoundRect(this._mcSliderUp, 0, 0, 1, 1, 0, ank.gapi.controls.ColorPicker.COLORS_SLIDER, ank.gapi.controls.ColorPicker.ALPHAS_SLIDER, ank.gapi.controls.ColorPicker.MATRIX_H, "linear", ank.gapi.controls.ColorPicker.RATIOS_SLIDER);
    };
    _loc1.getGradientColor = function ()
    {
        var _loc2 = this._mcColorsCross._x / Math.floor(this._nColorsWidth);
        var _loc3 = Math.floor(_loc2 * (ank.gapi.controls.ColorPicker.RATIOS_V.length - 1));
        _loc2 = _loc2 * 255;
        var _loc4 = 255 * (1 - (ank.gapi.controls.ColorPicker.RATIOS_V[_loc3 + 1] - _loc2) / (ank.gapi.controls.ColorPicker.RATIOS_V[_loc3 + 1] - ank.gapi.controls.ColorPicker.RATIOS_V[_loc3]));
        var _loc5 = ank.gapi.controls.ColorPicker.COLORS_V[_loc3];
        var _loc6 = ank.gapi.controls.ColorPicker.COLORS_V[_loc3 + 1];
        var _loc7 = _loc5 & 16711680;
        var _loc8 = _loc5 & 65280;
        var _loc9 = _loc5 & 255;
        var _loc10 = _loc6 & 16711680;
        var _loc11 = _loc6 & 65280;
        var _loc12 = _loc6 & 255;
        if (_loc7 != _loc10)
        {
            var _loc13 = Math.round(_loc7 > _loc10 ? (255 - _loc4) : (_loc4));
        }
        else
        {
            _loc13 = _loc7 >> 16;
        } // end else if
        if (_loc8 != _loc11)
        {
            var _loc14 = Math.round(_loc8 > _loc11 ? (255 - _loc4) : (_loc4));
        }
        else
        {
            _loc14 = _loc8 >> 8;
        } // end else if
        if (_loc9 != _loc12)
        {
            var _loc15 = Math.round(_loc9 > _loc12 ? (255 - _loc4) : (_loc4));
        }
        else
        {
            _loc15 = _loc9;
        } // end else if
        var _loc16 = this._mcColorsCross._y / this.__height * 255;
        _loc13 = _loc13 + (127 - _loc13) * _loc16 / 255;
        _loc14 = _loc14 + (127 - _loc14) * _loc16 / 255;
        _loc15 = _loc15 + (127 - _loc15) * _loc16 / 255;
        return ((_loc13 << 16) + (_loc14 << 8) + _loc15);
    };
    _loc1.placeColorsCross = function (nX, nY)
    {
        this._mcColorsCross._x = nX;
        this._mcColorsCross._y = nY;
    };
    _loc1.placeSliderCross = function (nX, nY)
    {
        this._mcSliderCross._x = nX;
        this._mcSliderCross._y = nY;
    };
    _loc1.setColor = function (nColor)
    {
        var _loc3 = ((nColor & 16711680) >> 16) / 255;
        var _loc4 = ((nColor & 65280) >> 8) / 255;
        var _loc5 = (nColor & 255) / 255;
        var _loc6 = Math.min(Math.min(_loc3, _loc4), _loc5);
        var _loc7 = Math.max(Math.max(_loc3, _loc4), _loc5);
        var _loc8 = _loc7 - _loc6;
        var _loc9 = Math.acos((_loc3 - _loc4 + (_loc3 - _loc5)) / 2 / Math.sqrt(Math.pow(_loc3 - _loc4, 2) + (_loc3 - _loc5) * (_loc4 - _loc5)));
        var _loc10 = (_loc7 + _loc6) / 2;
        var _loc11 = _loc10 < 5.000000E-001 ? (_loc8 / (_loc7 + _loc6)) : (_loc8 / (2 - _loc7 - _loc6));
        if (_loc5 > _loc4)
        {
            _loc9 = 2 * Math.PI - _loc9;
        } // end if
        var _loc12 = Math.floor(_loc9 / (2 * Math.PI) * this._nColorsWidth);
        var _loc13 = Math.floor((1 - Math.abs(_loc11)) * this.__height);
        var _loc14 = Math.floor((1 - _loc10) * this.__height);
        if (_global.isNaN(_loc12))
        {
            _loc12 = 0;
        } // end if
        this.placeColorsCross(_loc12, _loc13);
        this.placeSliderCross(this._nSliderCenterX, _loc14);
        var _loc15 = this.getGradientColor();
        this._cSliderUpColor.setRGB(_loc15);
        this._nLastGradiantColor = _loc15;
    };
    _loc1.getColor = function ()
    {
        var _loc2 = 255 * (1 - this._mcSliderCross._y / Math.floor(this.__height) * 2);
        var _loc3 = (this._nLastGradiantColor & 16711680) >> 16;
        var _loc4 = (this._nLastGradiantColor & 65280) >> 8;
        var _loc5 = this._nLastGradiantColor & 255;
        if (_loc2 >= 0)
        {
            var _loc6 = _loc2 * (255 - _loc3) / 255 + _loc3;
            var _loc7 = _loc2 * (255 - _loc4) / 255 + _loc4;
            var _loc8 = _loc2 * (255 - _loc5) / 255 + _loc5;
        }
        else
        {
            _loc2 = _loc2 * -1;
            _loc6 = Math.round(_loc3 - _loc3 * _loc2 / 255);
            _loc7 = Math.round(_loc4 - _loc4 * _loc2 / 255);
            _loc8 = Math.round(_loc5 - _loc5 * _loc2 / 255);
        } // end else if
        return (Math.round((_loc6 << 16) + (_loc7 << 8) + _loc8));
    };
    _loc1.onStartColorsCrossMove = function ()
    {
        this._bMoveColorsCross = true;
        this.placeColorsCross(this._xmouse, this._ymouse);
        this._mcColorsCross.startDrag(true, 0, 0, this._nColorsWidth - 1, this.__height);
        this._nLastGradiantColor = this.getGradientColor();
        this._cSliderUpColor.setRGB(this._nLastGradiantColor);
        this.dispatchEvent({type: "change", value: this.getColor()});
    };
    _loc1.onStopColorsCrossMove = function ()
    {
        this._bMoveColorsCross = false;
        this._mcColorsCross.stopDrag();
    };
    _loc1.onStartSliderCrossMove = function ()
    {
        this._bMoveSliderCross = true;
        this.placeSliderCross(this._nSliderCenterX, this._ymouse);
        this._mcSliderCross.startDrag(true, this._nSliderCenterX, 0, this._nSliderCenterX, this.__height);
        this._nLastGradiantColor = this.getGradientColor();
        this.dispatchEvent({type: "change", value: this.getColor()});
    };
    _loc1.onStopSliderCrossMove = function ()
    {
        this._bMoveSliderCross = false;
        this._mcSliderCross.stopDrag();
    };
    _loc1.onMouseMove = function ()
    {
        if (this._bMoveColorsCross)
        {
            var _loc2 = this.getGradientColor();
            this._cSliderUpColor.setRGB(_loc2);
            this._nLastGradiantColor = _loc2;
            this.dispatchEvent({type: "change", value: this.getColor()});
        } // end if
        if (this._bMoveSliderCross)
        {
            this.dispatchEvent({type: "change", value: this.getColor()});
        } // end if
    };
    _loc1.addProperty("sliderInWidth", _loc1.__get__sliderInWidth, _loc1.__set__sliderInWidth);
    _loc1.addProperty("sliderOutWidth", _loc1.__get__sliderOutWidth, _loc1.__set__sliderOutWidth);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.ColorPicker = function ()
    {
        super();
    }).CLASS_NAME = "ColorPicker";
    (_global.ank.gapi.controls.ColorPicker = function ()
    {
        super();
    }).MATRIX_V = {matrixType: "box", x: 0, y: 0, w: 1, h: 1, r: 0};
    (_global.ank.gapi.controls.ColorPicker = function ()
    {
        super();
    }).MATRIX_H = {matrixType: "box", x: 0, y: 0, w: 1, h: 1, r: Math.PI / 2};
    (_global.ank.gapi.controls.ColorPicker = function ()
    {
        super();
    }).COLORS_V = [16711680, 16776960, 65280, 65535, 255, 16711935, 16711680];
    (_global.ank.gapi.controls.ColorPicker = function ()
    {
        super();
    }).ALPHAS_V = [100, 100, 100, 100, 100, 100, 100];
    (_global.ank.gapi.controls.ColorPicker = function ()
    {
        super();
    }).RATIOS_V = [0, 4.250000E+001, 85, 1.275000E+002, 170, 2.125000E+002, 255];
    (_global.ank.gapi.controls.ColorPicker = function ()
    {
        super();
    }).COLORS_H = [8421504, 8421504];
    (_global.ank.gapi.controls.ColorPicker = function ()
    {
        super();
    }).ALPHAS_H = [0, 100];
    (_global.ank.gapi.controls.ColorPicker = function ()
    {
        super();
    }).RATIOS_H = [0, 255];
    (_global.ank.gapi.controls.ColorPicker = function ()
    {
        super();
    }).COLORS_SLIDER = [16711680, 16711680, 16711680];
    (_global.ank.gapi.controls.ColorPicker = function ()
    {
        super();
    }).ALPHAS_SLIDER = [0, 100, 0];
    (_global.ank.gapi.controls.ColorPicker = function ()
    {
        super();
    }).RATIOS_SLIDER = [0, 1.275000E+002, 255];
    _loc1._nSliderOutWidth = 30;
    _loc1._nSliderInWidth = 10;
    _loc1._bMoveColorsCross = false;
    _loc1._bMoveSliderCross = false;
} // end if
#endinitclip
