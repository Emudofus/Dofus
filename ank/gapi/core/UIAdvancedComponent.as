// Action script...

// [Initial MovieClip Action of sprite 20483]
#initclip 4
if (!ank.gapi.core.UIAdvancedComponent)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.gapi)
    {
        _global.ank.gapi = new Object();
    } // end if
    if (!ank.gapi.core)
    {
        _global.ank.gapi.core = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.core.UIAdvancedComponent = function ()
    {
        super();
    }).prototype;
    _loc1.__set__api = function (oAPI)
    {
        this._oAPI = oAPI;
        //return (this.api());
    };
    _loc1.__get__api = function ()
    {
        if (this._oAPI == undefined)
        {
            return (this._parent.api);
        }
        else
        {
            return (this._oAPI);
        } // end else if
    };
    _loc1.__set__instanceName = function (sInstanceName)
    {
        this._sInstanceName = sInstanceName;
        //return (this.instanceName());
    };
    _loc1.__get__instanceName = function ()
    {
        return (this._sInstanceName);
    };
    _loc1.callClose = function ()
    {
        return (false);
    };
    _loc1.unloadThis = function ()
    {
        this.gapi.unloadUIComponent(this._sInstanceName);
    };
    _loc1.addProperty("api", _loc1.__get__api, _loc1.__set__api);
    _loc1.addProperty("instanceName", _loc1.__get__instanceName, _loc1.__set__instanceName);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
