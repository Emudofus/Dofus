// Action script...

// [Initial MovieClip Action of sprite 840]
#initclip 52
class dofus.datacenter.Alignment
{
    var api, _nIndex, __get__index, _nValue, __get__value, __get__frame, __get__iconFile, __set__index, __get__name, __set__value;
    function Alignment(nIndex, nValue)
    {
        api = _global.API;
        this.initialize(nIndex, nValue);
    } // End of the function
    function get index()
    {
        return (_nIndex);
    } // End of the function
    function set index(nIndex)
    {
        _nIndex = isNaN(nIndex) || nIndex == undefined ? (0) : (nIndex);
        //return (this.index());
        null;
    } // End of the function
    function get name()
    {
        if (_nIndex == -1)
        {
            return ("");
        } // end if
        return (api.lang.getAlignment(_nIndex));
    } // End of the function
    function get value()
    {
        return (_nValue);
    } // End of the function
    function set value(nValue)
    {
        _nValue = isNaN(nValue) || nValue == undefined ? (0) : (nValue);
        //return (this.value());
        null;
    } // End of the function
    function get frame()
    {
        if (_nValue <= 20)
        {
            return (1);
        }
        else if (_nValue <= 40)
        {
            return (2);
        }
        else if (_nValue <= 60)
        {
            return (3);
        }
        else if (_nValue <= 80)
        {
            return (4);
        }
        else
        {
            return (5);
        } // end else if
    } // End of the function
    function get iconFile()
    {
        return (dofus.Constants.ALIGNMENTS_PATH + _nIndex + ".swf");
    } // End of the function
    function initialize(nIndex, nValue)
    {
        _nIndex = isNaN(nIndex) || nIndex == undefined ? (0) : (nIndex);
        _nValue = isNaN(nValue) || nValue == undefined ? (0) : (nValue);
    } // End of the function
} // End of Class
#endinitclip
