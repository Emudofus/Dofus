// Action script...

// [Initial MovieClip Action of sprite 36]
#initclip 27
class ank.gapi.controls.Fps extends ank.gapi.core.UIBasicComponent
{
    var __get__averageOffset, getNextHighestDepth, createEmptyMovieClip, _mcBack, drawRoundRect, attachMovie, __width, __height, _lblText, getStyle, setMovieClipColor, _nSaveTime, __set__averageOffset;
    function Fps()
    {
        super();
    } // End of the function
    function set averageOffset(nAverageOffset)
    {
        _nAverageOffset = nAverageOffset;
        //return (this.averageOffset());
        null;
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.Fps.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.createEmptyMovieClip("_mcBack", this.getNextHighestDepth());
        this.drawRoundRect(_mcBack, 0, 0, 1, 1, 0, 0);
        this.attachMovie("Label", "_lblText", this.getNextHighestDepth(), {text: "--"});
    } // End of the function
    function size()
    {
        super.size();
        this.arrange();
    } // End of the function
    function arrange()
    {
        _mcBack._width = __width;
        _mcBack._height = __height;
        _lblText.setSize(__width, __height);
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        this.setMovieClipColor(_mcBack, _loc2.backcolor);
        _mcBack._alpha = _loc2.backalpha;
        _lblText.__set__styleName(_loc2.labelstyle);
    } // End of the function
    function pushValue(nValue)
    {
        _aValues.push(nValue);
        if (_aValues.length > _nAverageOffset)
        {
            _aValues.shift();
        } // end if
    } // End of the function
    function getAverage()
    {
        var _loc2 = 0;
        for (var _loc3 in _aValues)
        {
            _loc2 = _loc2 + Number(_aValues[_loc3]);
        } // end of for...in
        return (Math.round(_loc2 / _aValues.length));
    } // End of the function
    function onEnterFrame()
    {
        var _loc2 = getTimer();
        var _loc3 = _loc2 - _nSaveTime;
        this.pushValue(1 / (_loc3 / 1000));
        _lblText.__set__text(String(this.getAverage()));
        _nSaveTime = _loc2;
    } // End of the function
    static var CLASS_NAME = "Fps";
    var _nAverageOffset = 10;
    var _aValues = new Array();
} // End of Class
#endinitclip
