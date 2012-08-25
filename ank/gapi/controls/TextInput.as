// Action script...

// [Initial MovieClip Action of sprite 20678]
#initclip 199
if (!ank.gapi.controls.TextInput)
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
    var _loc1 = (_global.ank.gapi.controls.TextInput = function ()
    {
        super();
    }).prototype;
    _loc1.__set__restrict = function (sRestrict)
    {
        this._sRestrict = sRestrict == "none" ? (null) : (sRestrict);
        if (this._tText != undefined)
        {
            this.setRestrict();
        } // end if
        //return (this.restrict());
    };
    _loc1.__get__restrict = function ()
    {
        return (this._tText.restrict);
    };
    _loc1.__set__maxChars = function (nMaxChars)
    {
        this._nMaxChars = nMaxChars == -1 ? (null) : (nMaxChars);
        if (this._tText != undefined)
        {
            this.setMaxChars();
        } // end if
        //return (this.maxChars());
    };
    _loc1.__get__maxChars = function ()
    {
        return (this._tText.maxChars);
    };
    _loc1.__get__focused = function ()
    {
        return (Selection.getFocus() == this._tText);
    };
    _loc1.__set__tabIndex = function (nTabIndex)
    {
        this._tText.tabIndex = nTabIndex;
        //return (this.tabIndex());
    };
    _loc1.__get__tabIndex = function ()
    {
        return (this._tText.tabIndex);
    };
    _loc1.__set__tabEnabled = function (bEnabled)
    {
        this._tText.tabEnabled = bEnabled;
        //return (this.tabEnabled());
    };
    _loc1.__get__tabEnabled = function ()
    {
        return (this._tText.tabEnabled);
    };
    _loc1.__set__password = function (bPassword)
    {
        this._tText.password = bPassword;
        //return (this.password());
    };
    _loc1.__get__password = function ()
    {
        return (this._tText.password);
    };
    _loc1.setFocus = function ()
    {
        if (this._tText == undefined)
        {
            this.addToQueue({object: this, method: function ()
            {
                Selection.setFocus(this._tText);
            }});
        }
        else
        {
            Selection.setFocus(this._tText);
        } // end else if
    };
    _loc1.createChildren = function ()
    {
        super.createChildren();
        this.setRestrict();
        this.setMaxChars();
    };
    _loc1.setEnabled = function ()
    {
        if (this._bEnabled)
        {
            this._tText.type = "input";
        }
        else
        {
            this._tText.type = "dynamic";
        } // end else if
    };
    _loc1.setRestrict = function ()
    {
        this._tText.restrict = this._sRestrict;
    };
    _loc1.setMaxChars = function ()
    {
        this._tText.maxChars = this._nMaxChars;
    };
    _loc1.addProperty("tabIndex", _loc1.__get__tabIndex, _loc1.__set__tabIndex);
    _loc1.addProperty("tabEnabled", _loc1.__get__tabEnabled, _loc1.__set__tabEnabled);
    _loc1.addProperty("maxChars", _loc1.__get__maxChars, _loc1.__set__maxChars);
    _loc1.addProperty("restrict", _loc1.__get__restrict, _loc1.__set__restrict);
    _loc1.addProperty("password", _loc1.__get__password, _loc1.__set__password);
    _loc1.addProperty("focused", _loc1.__get__focused, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.TextInput = function ()
    {
        super();
    }).CLASS_NAME = "TextInput";
    _loc1._sTextfiledType = "input";
    _loc1._sRestrict = "none";
    _loc1._nMaxChars = -1;
} // end if
#endinitclip
