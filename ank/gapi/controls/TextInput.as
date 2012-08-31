// Action script...

// [Initial MovieClip Action of sprite 273]
#initclip 199
class ank.gapi.controls.TextInput extends ank.gapi.controls.Label
{
    var _tText, __get__restrict, __get__maxChars, __get__tabIndex, __get__password, addToQueue, __get__focused, __set__maxChars, __set__password, __set__restrict, __set__tabIndex;
    function TextInput()
    {
        super();
    } // End of the function
    function set restrict(sRestrict)
    {
        _sRestrict = sRestrict == "none" ? (null) : (sRestrict);
        if (_tText != undefined)
        {
            this.setRestrict();
        } // end if
        //return (this.restrict());
        null;
    } // End of the function
    function get restrict()
    {
        return (_tText.restrict);
    } // End of the function
    function set maxChars(nMaxChars)
    {
        _nMaxChars = nMaxChars == -1 ? (null) : (nMaxChars);
        if (_tText != undefined)
        {
            this.setMaxChars();
        } // end if
        //return (this.maxChars());
        null;
    } // End of the function
    function get maxChars()
    {
        return (_tText.maxChars);
    } // End of the function
    function get focused()
    {
        return (Selection.getFocus() == this._tText);
    } // End of the function
    function set tabIndex(nTabIndex)
    {
        _tText.tabIndex = nTabIndex;
        //return (this.tabIndex());
        null;
    } // End of the function
    function get tabIndex()
    {
        return (_tText.tabIndex);
    } // End of the function
    function set password(bPassword)
    {
        _tText.password = bPassword;
        //return (this.password());
        null;
    } // End of the function
    function get password()
    {
        return (_tText.password);
    } // End of the function
    function setFocus()
    {
        if (_tText == undefined)
        {
            this.addToQueue({object: this, method: function ()
            {
                Selection.setFocus(_tText);
            }});
        }
        else
        {
            Selection.setFocus(_tText);
        } // end else if
    } // End of the function
    function createChildren()
    {
        super.createChildren();
        this.setRestrict();
        this.setMaxChars();
    } // End of the function
    function setRestrict()
    {
        _tText.restrict = _sRestrict;
    } // End of the function
    function setMaxChars()
    {
        _tText.maxChars = _nMaxChars;
    } // End of the function
    static var CLASS_NAME = "TextInput";
    var _sTextfiledType = "input";
    var _sRestrict = "none";
    var _nMaxChars = -1;
} // End of Class
#endinitclip
