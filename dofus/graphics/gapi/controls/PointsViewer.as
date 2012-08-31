// Action script...

// [Initial MovieClip Action of sprite 1011]
#initclip 231
class dofus.graphics.gapi.controls.PointsViewer extends ank.gapi.core.UIBasicComponent
{
    var _sBackgroundLink, __get__background, _nTextColor, __get__textColor, _nValue, useHandCursor, __get__value, _txtValue, attachMovie, dispatchEvent, __set__background, __set__textColor, __set__value;
    function PointsViewer()
    {
        super();
    } // End of the function
    function set background(sBackground)
    {
        _sBackgroundLink = sBackground;
        //return (this.background());
        null;
    } // End of the function
    function set textColor(nTextColor)
    {
        _nTextColor = nTextColor;
        //return (this.textColor());
        null;
    } // End of the function
    function set value(nValue)
    {
        nValue = Number(nValue);
        if (isNaN(nValue))
        {
            return;
        } // end if
        _nValue = nValue;
        this.applyValue();
        useHandCursor = false;
        //return (this.value());
        null;
    } // End of the function
    function get value()
    {
        return (_nValue);
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.PointsViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.attachMovie(_sBackgroundLink, "_mcBg", _txtValue.getDepth() - 1);
        _txtValue.textColor = _nTextColor;
    } // End of the function
    function applyValue()
    {
        _txtValue.text = String(_nValue);
    } // End of the function
    function onRollOver()
    {
        this.dispatchEvent({type: "over"});
    } // End of the function
    function onRollOut()
    {
        this.dispatchEvent({type: "out"});
    } // End of the function
    static var CLASS_NAME = "PointsViewer";
} // End of Class
#endinitclip
