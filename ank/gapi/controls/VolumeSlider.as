// Action script...

// [Initial MovieClip Action of sprite 411]
#initclip 225
class ank.gapi.controls.VolumeSlider extends ank.gapi.core.UIBasicComponent
{
    var __get__min, __get__max, _bInitialized, __get__value, __get__markerCount, __get__markerWidthRatio, __get__markerSkin, __height, __width, _mcMarkers, _mcOvers, addToQueue, createEmptyMovieClip, drawRoundRect, getStyle, setMovieClipColor, _parent, __set__value, dispatchEvent, __set__markerCount, __set__markerSkin, __get__markerWidth, __set__markerWidthRatio, __set__max, __set__min;
    function VolumeSlider()
    {
        super();
    } // End of the function
    function set min(nMin)
    {
        _nMin = Number(nMin);
        //return (this.min());
        null;
    } // End of the function
    function get min()
    {
        return (_nMin);
    } // End of the function
    function set max(nMax)
    {
        _nMax = Number(nMax);
        //return (this.max());
        null;
    } // End of the function
    function get max()
    {
        return (_nMax);
    } // End of the function
    function set value(nValue)
    {
        nValue = Number(nValue);
        if (isNaN(nValue))
        {
            return;
        } // end if
        if (nValue > this.__get__max())
        {
            nValue = max;
        } // end if
        if (nValue < this.__get__min())
        {
            nValue = min;
        } // end if
        _nValue = nValue;
        if (_bInitialized)
        {
            var _loc3 = Math.floor((_nMarkerCount - 1) * (nValue - _nMin) / (_nMax - _nMin));
            this.setValueByIndex(_loc3);
        } // end if
        //return (this.value());
        null;
    } // End of the function
    function get value()
    {
        return (_nValue);
    } // End of the function
    function set markerCount(nMarkerCount)
    {
        if (Number(nMarkerCount) > 0)
        {
            _nMarkerCount = Number(nMarkerCount);
        }
        else
        {
            ank.utils.Logger.err("[markerCount] ne peut être < à 0");
        } // end else if
        //return (this.markerCount());
        null;
    } // End of the function
    function get markerWidth()
    {
        return (_nMarkerCount);
    } // End of the function
    function set markerWidthRatio(nMarkerWidthRatio)
    {
        if (Number(nMarkerWidthRatio) >= 0 && Number(nMarkerWidthRatio) <= 1)
        {
            _nMarkerWidthRatio = Number(nMarkerWidthRatio);
        }
        else
        {
            ank.utils.Logger.err("[markerCount] ne peut être < à 0 et > 1");
        } // end else if
        //return (this.markerWidthRatio());
        null;
    } // End of the function
    function get markerWidthRatio()
    {
        return (_nMarkerWidthRatio);
    } // End of the function
    function set markerSkin(sMarkerSkin)
    {
        _sMarkerSkin = sMarkerSkin;
        //return (this.markerSkin());
        null;
    } // End of the function
    function get markerSkin()
    {
        return (_sMarkerSkin);
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.VolumeSlider.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.createMarkers();
    } // End of the function
    function arrange()
    {
        var _loc9 = __height;
        var _loc8 = __height / 2;
        var _loc10 = __width / _nMarkerCount;
        var _loc6 = (__width + _loc10 * (1 - _nMarkerWidthRatio)) / _nMarkerCount;
        for (var _loc4 = 0; _loc4 < _nMarkerCount; ++_loc4)
        {
            var _loc3 = _mcMarkers["mcMarker" + _loc4];
            var _loc2 = _mcOvers["mcOver" + _loc4];
            var _loc5 = _loc2.index;
            var _loc7 = _loc5 / _nMarkerCount;
            _loc3._width = _loc6 * _nMarkerWidthRatio;
            _loc2._width = _loc6;
            _loc3._height = _loc8 + _loc7 * (_loc9 - _loc8);
            _loc2._height = __height;
            _loc3._x = _loc5 * _loc6;
            _loc3._y = __height;
            _loc2._x = _loc5 * _loc6;
            _loc2._y = 0;
        } // end of for
    } // End of the function
    function draw()
    {
        this.addToQueue({object: this, method: function ()
        {
            value = _nValue;
        }});
    } // End of the function
    function createMarkers()
    {
        _mcMarkers.removeMovieClip();
        this.createEmptyMovieClip("_mcOvers", 10);
        this.createEmptyMovieClip("_mcMarkers", 20);
        for (var _loc2 = 0; _loc2 < _nMarkerCount; ++_loc2)
        {
            var _loc4 = _mcMarkers.attachMovie(_sMarkerSkin, "mcMarker" + _loc2, _loc2);
            var _loc3 = _mcOvers.createEmptyMovieClip("mcOver" + _loc2, _loc2);
            this.drawRoundRect(_loc3, 0, 0, 1, 1, 0, 16711935, 0);
            _loc3.index = _loc2;
            this.setMovieClipColor(_loc4, this.getStyle().offcolor);
            _loc3.trackAsMenu = true;
            _loc3.onDragOver = function ()
            {
                _parent._parent.dragOver({target: this});
            };
            _loc3.onPress = function ()
            {
                _parent._parent.press({target: this});
            };
        } // end of for
    } // End of the function
    function setValueByIndex(nIndex)
    {
        if (nIndex > _nMarkerCount - 1)
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
        var _loc6 = this.getStyle().oncolor;
        var _loc5 = this.getStyle().offcolor;
        for (var _loc3 = 0; _loc3 <= nIndex; ++_loc3)
        {
            this.setMovieClipColor(_mcMarkers["mcMarker" + _loc3], _loc6);
        } // end of for
        for (var _loc2 = nIndex + 1; _loc2 < _nMarkerCount; ++_loc2)
        {
            this.setMovieClipColor(_mcMarkers["mcMarker" + _loc2], _loc5);
        } // end of for
    } // End of the function
    function getValueByIndex(nIndex)
    {
        return (nIndex * (_nMax - _nMin) / (_nMarkerCount - 1) + _nMin);
    } // End of the function
    function dragOver(oEvent)
    {
        this.__set__value(this.getValueByIndex(oEvent.target.index));
        this.dispatchEvent({type: "change"});
    } // End of the function
    function press(oEvent)
    {
        this.__set__value(this.getValueByIndex(oEvent.target.index));
        this.dispatchEvent({type: "change"});
    } // End of the function
    static var CLASS_NAME = "VolumeSlider";
    var _nMin = 0;
    var _nMax = 100;
    var _nValue = 0;
    var _nMarkerCount = 5;
    var _nMarkerWidthRatio = 7.000000E-001;
    var _sMarkerSkin = "VolumeSliderMarkerDefault";
} // End of Class
#endinitclip
