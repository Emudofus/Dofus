// Action script...

// [Initial MovieClip Action of sprite 594]
#initclip 254
class ank.gapi.controls.ColorPicker extends ank.gapi.core.UIBasicComponent
{
    var __get__sliderOutWidth, __get__sliderInWidth, createEmptyMovieClip, _mcSliderUp, _cSliderUpColor, attachMovie, _mcColorsV, _parent, _mcSlider, _mcColorsH, __width, __height, _nColorsWidth, _nSliderCenterX, drawRoundRect, _mcColorsCross, _mcSliderCross, _nLastGradiantColor, _ymouse, _xmouse, dispatchEvent, __set__sliderInWidth, __set__sliderOutWidth;
    function ColorPicker()
    {
        super();
    } // End of the function
    function set sliderOutWidth(nSliderOutWidth)
    {
        _nSliderOutWidth = Number(nSliderOutWidth);
        //return (this.sliderOutWidth());
        null;
    } // End of the function
    function get sliderOutWidth()
    {
        return (_nSliderOutWidth);
    } // End of the function
    function set sliderInWidth(nSliderInWidth)
    {
        _nSliderInWidth = Number(nSliderInWidth);
        //return (this.sliderInWidth());
        null;
    } // End of the function
    function get sliderInWidth()
    {
        return (_nSliderInWidth);
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.ColorPicker.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.createEmptyMovieClip("_mcColorsV", 10);
        this.createEmptyMovieClip("_mcColorsH", 20);
        this.createEmptyMovieClip("_mcSlider", 30);
        this.createEmptyMovieClip("_mcSliderUp", 40);
        _cSliderUpColor = new Color(_mcSliderUp);
        this.attachMovie("ColorPickerColorsCross", "_mcColorsCross", 50);
        this.attachMovie("ColorPickerSliderCross", "_mcSliderCross", 60);
        _mcColorsV.onPress = function ()
        {
            _parent.onStartColorsCrossMove();
        };
        _mcColorsV.onRelease = _mcColorsV.onReleaseOutside = function ()
        {
            _parent.onStopColorsCrossMove();
        };
        _mcSlider.onPress = function ()
        {
            _parent.onStartSliderCrossMove();
        };
        _mcSlider.onRelease = _mcSlider.onReleaseOutside = function ()
        {
            _parent.onStopSliderCrossMove();
        };
    } // End of the function
    function arrange()
    {
        _mcColorsV._width = _mcColorsH._width = __width - _nSliderOutWidth;
        _mcColorsV._height = _mcColorsH._height = __height;
        _mcSlider._x = _mcSliderUp._x = __width - (_nSliderOutWidth + _nSliderInWidth) / 2;
        _mcSlider._width = _mcSliderUp._width = _nSliderInWidth;
        _mcSlider._height = _mcSliderUp._height = __height;
        _nColorsWidth = __width - 30;
        _nSliderCenterX = __width - _nSliderOutWidth / 2;
        this.placeSliderCross(_nSliderCenterX, __height / 2);
    } // End of the function
    function draw()
    {
        this.drawRoundRect(_mcColorsV, 0, 0, 1, 1, 0, ank.gapi.controls.ColorPicker.COLORS_V, ank.gapi.controls.ColorPicker.ALPHAS_V, ank.gapi.controls.ColorPicker.MATRIX_V, "linear", ank.gapi.controls.ColorPicker.RATIOS_V);
        this.drawRoundRect(_mcColorsH, 0, 0, 1, 1, 0, ank.gapi.controls.ColorPicker.COLORS_H, ank.gapi.controls.ColorPicker.ALPHAS_H, ank.gapi.controls.ColorPicker.MATRIX_H, "linear", ank.gapi.controls.ColorPicker.RATIOS_H);
        this.drawRoundRect(_mcSlider, 0, 0, 1, 5.000000E-001, 0, 16777215);
        this.drawRoundRect(_mcSlider, 0, 5.000000E-001, 1, 5.000000E-001, 0, 0);
        this.drawRoundRect(_mcSliderUp, 0, 0, 1, 1, 0, ank.gapi.controls.ColorPicker.COLORS_SLIDER, ank.gapi.controls.ColorPicker.ALPHAS_SLIDER, ank.gapi.controls.ColorPicker.MATRIX_H, "linear", ank.gapi.controls.ColorPicker.RATIOS_SLIDER);
    } // End of the function
    function getGradientColor()
    {
        var _loc10 = _mcColorsCross._x / Math.floor(_nColorsWidth);
        var _loc3 = Math.floor(_loc10 * (ank.gapi.controls.ColorPicker.RATIOS_V.length - 1));
        _loc10 = _loc10 * 255;
        var _loc2 = 255 * (1 - (ank.gapi.controls.ColorPicker.RATIOS_V[_loc3 + 1] - _loc10) / (ank.gapi.controls.ColorPicker.RATIOS_V[_loc3 + 1] - ank.gapi.controls.ColorPicker.RATIOS_V[_loc3]));
        var _loc8 = ank.gapi.controls.ColorPicker.COLORS_V[_loc3];
        var _loc7 = ank.gapi.controls.ColorPicker.COLORS_V[_loc3 + 1];
        var _loc9 = _loc8 & 16711680;
        var _loc12 = _loc8 & 65280;
        var _loc11 = _loc8 & 255;
        var _loc14 = _loc7 & 16711680;
        var _loc16 = _loc7 & 65280;
        var _loc15 = _loc7 & 255;
        var _loc5;
        if (_loc9 != _loc14)
        {
            _loc5 = Math.round(_loc9 > _loc14 ? (255 - _loc2) : (_loc2));
        }
        else
        {
            _loc5 = _loc9 >> 16;
        } // end else if
        var _loc6;
        if (_loc12 != _loc16)
        {
            _loc6 = Math.round(_loc12 > _loc16 ? (255 - _loc2) : (_loc2));
        }
        else
        {
            _loc6 = _loc12 >> 8;
        } // end else if
        var _loc4;
        if (_loc11 != _loc15)
        {
            _loc4 = Math.round(_loc11 > _loc15 ? (255 - _loc2) : (_loc2));
        }
        else
        {
            _loc4 = _loc11;
        } // end else if
        var _loc13 = _mcColorsCross._y / __height * 255;
        _loc5 = _loc5 + (127 - _loc5) * _loc13 / 255;
        _loc6 = _loc6 + (127 - _loc6) * _loc13 / 255;
        _loc4 = _loc4 + (127 - _loc4) * _loc13 / 255;
        return ((_loc5 << 16) + (_loc6 << 8) + _loc4);
    } // End of the function
    function placeColorsCross(nX, nY)
    {
        _mcColorsCross._x = nX;
        _mcColorsCross._y = nY;
    } // End of the function
    function placeSliderCross(nX, nY)
    {
        _mcSliderCross._x = nX;
        _mcSliderCross._y = nY;
    } // End of the function
    function setColor(nColor)
    {
        var _loc3 = ((nColor & 16711680) >> 16) / 255;
        var _loc4 = ((nColor & 65280) >> 8) / 255;
        var _loc2 = (nColor & 255) / 255;
        var _loc6 = Math.min(Math.min(_loc3, _loc4), _loc2);
        var _loc5 = Math.max(Math.max(_loc3, _loc4), _loc2);
        var _loc10 = _loc5 - _loc6;
        var _loc7 = Math.acos((_loc3 - _loc4 + (_loc3 - _loc2)) / 2 / Math.sqrt(Math.pow(_loc3 - _loc4, 2) + (_loc3 - _loc2) * (_loc4 - _loc2)));
        var _loc11 = (_loc5 + _loc6) / 2;
        var _loc12 = _loc11 < 5.000000E-001 ? (_loc10 / (_loc5 + _loc6)) : (_loc10 / (2 - _loc5 - _loc6));
        if (_loc2 > _loc4)
        {
            _loc7 = 6.283185E+000 - _loc7;
        } // end if
        var _loc8 = Math.floor(_loc7 / 6.283185E+000 * _nColorsWidth);
        var _loc15 = Math.floor((1 - Math.abs(_loc12)) * __height);
        var _loc14 = Math.floor((1 - _loc11) * __height);
        if (isNaN(_loc8))
        {
            _loc8 = 0;
        } // end if
        this.placeColorsCross(_loc8, _loc15);
        this.placeSliderCross(_nSliderCenterX, _loc14);
        var _loc9 = this.getGradientColor();
        _cSliderUpColor.setRGB(_loc9);
        _nLastGradiantColor = _loc9;
    } // End of the function
    function getColor()
    {
        var _loc2 = 255 * (1 - _mcSliderCross._y / Math.floor(__height) * 2);
        var _loc3 = (_nLastGradiantColor & 16711680) >> 16;
        var _loc5 = (_nLastGradiantColor & 65280) >> 8;
        var _loc4 = _nLastGradiantColor & 255;
        var _loc6;
        var _loc8;
        var _loc7;
        if (_loc2 >= 0)
        {
            _loc6 = _loc2 * (255 - _loc3) / 255 + _loc3;
            _loc8 = _loc2 * (255 - _loc5) / 255 + _loc5;
            _loc7 = _loc2 * (255 - _loc4) / 255 + _loc4;
        }
        else
        {
            _loc2 = _loc2 * -1;
            _loc6 = Math.round(_loc3 - _loc3 * _loc2 / 255);
            _loc8 = Math.round(_loc5 - _loc5 * _loc2 / 255);
            _loc7 = Math.round(_loc4 - _loc4 * _loc2 / 255);
        } // end else if
        return (Math.round((_loc6 << 16) + (_loc8 << 8) + _loc7));
    } // End of the function
    function onStartColorsCrossMove()
    {
        _bMoveColorsCross = true;
        this.placeColorsCross(_xmouse, _ymouse);
        _mcColorsCross.startDrag(true, 0, 0, _nColorsWidth - 1, __height);
        _nLastGradiantColor = this.getGradientColor();
        _cSliderUpColor.setRGB(_nLastGradiantColor);
        this.dispatchEvent({type: "change", value: this.getColor()});
    } // End of the function
    function onStopColorsCrossMove()
    {
        _bMoveColorsCross = false;
        _mcColorsCross.stopDrag();
    } // End of the function
    function onStartSliderCrossMove()
    {
        _bMoveSliderCross = true;
        this.placeSliderCross(_nSliderCenterX, _ymouse);
        _mcSliderCross.startDrag(true, _nSliderCenterX, 0, _nSliderCenterX, __height);
        _nLastGradiantColor = this.getGradientColor();
        this.dispatchEvent({type: "change", value: this.getColor()});
    } // End of the function
    function onStopSliderCrossMove()
    {
        _bMoveSliderCross = false;
        _mcSliderCross.stopDrag();
    } // End of the function
    function onMouseMove()
    {
        if (_bMoveColorsCross)
        {
            var _loc2 = this.getGradientColor();
            _cSliderUpColor.setRGB(_loc2);
            _nLastGradiantColor = _loc2;
            this.dispatchEvent({type: "change", value: this.getColor()});
        } // end if
        if (_bMoveSliderCross)
        {
            this.dispatchEvent({type: "change", value: this.getColor()});
        } // end if
    } // End of the function
    static var CLASS_NAME = "ColorPicker";
    static var MATRIX_V = {matrixType: "box", x: 0, y: 0, w: 1, h: 1, r: 0};
    static var MATRIX_H = {matrixType: "box", x: 0, y: 0, w: 1, h: 1, r: 1.570796E+000};
    static var COLORS_V = [16711680, 16776960, 65280, 65535, 255, 16711935, 16711680];
    static var ALPHAS_V = [100, 100, 100, 100, 100, 100, 100];
    static var RATIOS_V = [0, 4.250000E+001, 85, 1.275000E+002, 170, 2.125000E+002, 255];
    static var COLORS_H = [8421504, 8421504];
    static var ALPHAS_H = [0, 100];
    static var RATIOS_H = [0, 255];
    static var COLORS_SLIDER = [16711680, 16711680, 16711680];
    static var ALPHAS_SLIDER = [0, 100, 0];
    static var RATIOS_SLIDER = [0, 1.275000E+002, 255];
    var _nSliderOutWidth = 30;
    var _nSliderInWidth = 10;
    var _bMoveColorsCross = false;
    var _bMoveSliderCross = false;
} // End of Class
#endinitclip
