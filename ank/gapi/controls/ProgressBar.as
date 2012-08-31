// Action script...

// [Initial MovieClip Action of sprite 179]
#initclip 24
class ank.gapi.controls.ProgressBar extends ank.gapi.core.UIBasicComponent
{
    var _bInitialized, __get__renderer, __get__minimum, __get__maximum, addToQueue, __get__value, attachMovie, _mcRenderer, __height, __width, getStyle, setMovieClipColor, _bEnabled, dispatchEvent, __set__maximum, __set__minimum, __set__renderer, __set__value;
    function ProgressBar()
    {
        super();
    } // End of the function
    function set renderer(sRenderer)
    {
        if (_bInitialized)
        {
            return;
        } // end if
        _sRenderer = sRenderer;
        //return (this.renderer());
        null;
    } // End of the function
    function set minimum(nMinimum)
    {
        _nMinimum = Number(nMinimum);
        //return (this.minimum());
        null;
    } // End of the function
    function get minimum()
    {
        return (_nMinimum);
    } // End of the function
    function set maximum(nMaximum)
    {
        _nMaximum = Number(nMaximum);
        //return (this.maximum());
        null;
    } // End of the function
    function get maximum()
    {
        return (_nMaximum);
    } // End of the function
    function set value(nValue)
    {
        if (nValue > _nMaximum)
        {
            nValue = _nMaximum;
        } // end if
        if (nValue < _nMinimum)
        {
            nValue = _nMinimum;
        } // end if
        _nValue = Number(nValue);
        this.addToQueue({object: this, method: applyValue});
        //return (this.value());
        null;
    } // End of the function
    function get value()
    {
        return (_nValue);
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.ProgressBar.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.attachMovie(_sRenderer, "_mcRenderer", 10);
        this.hideUp(true);
    } // End of the function
    function size()
    {
        super.size();
    } // End of the function
    function arrange()
    {
        _mcRenderer._mcBgLeft._height = _mcRenderer._mcBgMiddle._height = _mcRenderer._mcBgRight._height = __height;
        var _loc2 = _mcRenderer._mcBgLeft._yscale;
        _mcRenderer._mcBgLeft._xscale = _mcRenderer._mcUpLeft._xscale = _mcRenderer._mcUpLeft._yscale = _loc2;
        _mcRenderer._mcBgRight._xscale = _mcRenderer._mcUpRight._xscale = _mcRenderer._mcUpRight._yscale = _loc2;
        _mcRenderer._mcUpMiddle._yscale = _loc2;
        var _loc3 = _mcRenderer._mcBgLeft._width;
        var _loc4 = _mcRenderer._mcBgLeft._width;
        _mcRenderer._mcBgLeft._x = _mcRenderer._mcBgLeft._y = _mcRenderer._mcBgMiddle._y = _mcRenderer._mcBgRight._y = 0;
        _mcRenderer._mcUpLeft._x = _mcRenderer._mcUpLeft._y = _mcRenderer._mcUpMiddle._y = _mcRenderer._mcUpRight._y = 0;
        _mcRenderer._mcBgMiddle._x = _mcRenderer._mcUpMiddle._x = _loc3;
        _mcRenderer._mcBgRight._x = __width - _loc4;
        _mcRenderer._mcBgMiddle._width = __width - _loc3 - _loc4;
    } // End of the function
    function draw()
    {
        var _loc2;
        var _loc3 = this.getStyle();
        _loc2 = _mcRenderer._mcBgLeft;
        for (var _loc5 in _loc2)
        {
            var _loc4 = _loc5.split("_")[0];
            this.setMovieClipColor(_loc2[_loc5], _loc3[_loc4 + "color"]);
        } // end of for...in
        _loc2 = _mcRenderer._mcBgMiddle;
        for (var _loc5 in _loc2)
        {
            _loc4 = _loc5.split("_")[0];
            this.setMovieClipColor(_loc2[_loc5], _loc3[_loc4 + "color"]);
        } // end of for...in
        _loc2 = _mcRenderer._mcBgRight;
        for (var _loc5 in _loc2)
        {
            _loc4 = _loc5.split("_")[0];
            this.setMovieClipColor(_loc2[_loc5], _loc3[_loc4 + "color"]);
        } // end of for...in
        _loc2 = _mcRenderer._mcUpLeft;
        for (var _loc5 in _loc2)
        {
            _loc4 = _loc5.split("_")[0];
            this.setMovieClipColor(_loc2[_loc5], _loc3[_loc4 + "color"]);
        } // end of for...in
        _loc2 = _mcRenderer._mcUpMiddle;
        for (var _loc5 in _loc2)
        {
            _loc4 = _loc5.split("_")[0];
            this.setMovieClipColor(_loc2[_loc5], _loc3[_loc4 + "color"]);
        } // end of for...in
        _loc2 = _mcRenderer._mcUpRight;
        for (var _loc5 in _loc2)
        {
            _loc4 = _loc5.split("_")[0];
            this.setMovieClipColor(_loc2[_loc5], _loc3[_loc4 + "color"]);
        } // end of for...in
    } // End of the function
    function hideUp(bHide)
    {
        _mcRenderer._mcUpLeft._visible = !bHide;
        _mcRenderer._mcUpMiddle._visible = !bHide;
        _mcRenderer._mcUpRight._visible = !bHide;
    } // End of the function
    function applyValue()
    {
        var _loc2 = _mcRenderer._mcBgLeft._width;
        var _loc7 = _mcRenderer._mcBgLeft._width;
        var _loc4 = _nValue - _nMinimum;
        if (_loc4 == 0)
        {
            this.hideUp(true);
        }
        else
        {
            this.hideUp(false);
            var _loc5 = _nMaximum - _nMinimum;
            var _loc6 = __width - _loc2 - _loc7;
            var _loc3 = Math.floor(_loc4 / _loc5 * _loc6);
            _mcRenderer._mcUpMiddle._width = _loc3;
            _mcRenderer._mcUpRight._x = _loc3 + _loc2;
        } // end else if
    } // End of the function
    function setEnabled()
    {
        if (_bEnabled)
        {
            function onRollOver()
            {
                this.dispatchEvent({type: "over"});
            } // End of the function
            function onRollOut()
            {
                this.dispatchEvent({type: "out"});
            } // End of the function
        }
        else
        {
            onRollOver = undefined;
            onRollOut = undefined;
        } // end else if
    } // End of the function
    static var CLASS_NAME = "ProgressBar";
    var _sRenderer = "ProgressBarDefaultRenderer";
    var _nValue = 0;
    var _nMinimum = 0;
    var _nMaximum = 100;
} // End of Class
#endinitclip
