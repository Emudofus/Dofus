// Action script...

// [Initial MovieClip Action of sprite 20947]
#initclip 212
if (!ank.external.ExternalConnectorListerner)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.external)
    {
        _global.ank.external = new Object();
    } // end if
    var _loc1 = (_global.ank.external.ExternalConnectorListerner = function ()
    {
        mx.events.EventDispatcher.initialize(this);
        ank.external.ExternalConnector.getInstance().addEventListener("onExternalConnectionFaild", this);
    }).prototype;
    _loc1.getParams = function ()
    {
        return (this._oParams);
    };
    _loc1.setParams = function (oParams)
    {
        this._oParams = oParams;
    };
    _loc1.removeListeners = function ()
    {
        ank.external.ExternalConnector.getInstance().removeEventListener("onExternalConnectionFaild", this);
    };
    _loc1.onExternalConnectionFaild = function (oEvent)
    {
        this.dispatchEvent({type: "onExternalError"});
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
