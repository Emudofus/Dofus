// Action script...

// [Initial MovieClip Action of sprite 1010]
#initclip 230
class dofus.graphics.gapi.controls.Heart extends ank.gapi.core.UIBasicComponent
{
    var _nValue, _nMax, __get__value, __get__max, _mcRectangle, _nMaxHeight, _txtValue, __set__max, __set__value;
    function Heart()
    {
        super();
    } // End of the function
    function set value(nValue)
    {
        nValue = Number(nValue);
        if (isNaN(nValue))
        {
            return;
        } // end if
        _nValue = nValue;
        if (_nMax != undefined)
        {
            this.applyValue();
        } // end if
        //return (this.value());
        null;
    } // End of the function
    function get value()
    {
        return (_nValue);
    } // End of the function
    function set max(nMax)
    {
        nMax = Number(nMax);
        if (isNaN(nMax))
        {
            return;
        } // end if
        _nMax = nMax;
        if (_nValue != undefined)
        {
            this.applyValue();
        } // end if
        //return (this.max());
        null;
    } // End of the function
    function get max()
    {
        return (_nMax);
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.Heart.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        _nMaxHeight = _mcRectangle._height;
    } // End of the function
    function applyValue()
    {
        _txtValue.text = String(_nValue);
        _mcRectangle._height = _nValue / _nMax * _nMaxHeight;
    } // End of the function
    static var CLASS_NAME = "Heart";
} // End of Class
#endinitclip
