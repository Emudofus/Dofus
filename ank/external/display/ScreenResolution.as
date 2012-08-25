// Action script...

// [Initial MovieClip Action of sprite 20948]
#initclip 213
if (!ank.external.display.ScreenResolution)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.external)
    {
        _global.ank.external = new Object();
    } // end if
    if (!ank.external.display)
    {
        _global.ank.external.display = new Object();
    } // end if
    var _loc1 = (_global.ank.external.display.ScreenResolution = function ()
    {
        super();
        ank.external.ExternalConnector.getInstance().addEventListener("onScreenResolutionError", this);
        ank.external.ExternalConnector.getInstance().addEventListener("onScreenResolutionSuccess", this);
    }).prototype;
    _loc1.removeListeners = function ()
    {
        super.removeListeners();
        ank.external.ExternalConnector.getInstance().removeEventListener("onScreenResolutionError", this);
        ank.external.ExternalConnector.getInstance().removeEventListener("onScreenResolutionSuccess", this);
    };
    _loc1.enable = function (nWidth, nHeight, nBitDepth)
    {
        ank.external.ExternalConnector.getInstance().pushCall("ScreenResolutionEnable", nWidth, nHeight, nBitDepth);
    };
    _loc1.disable = function ()
    {
        ank.external.ExternalConnector.getInstance().pushCall("ScreenResolutionDisable");
    };
    _loc1.onScreenResolutionError = function (oEvent)
    {
        this.dispatchEvent({type: "onScreenResolutionError"});
    };
    _loc1.onScreenResolutionSuccess = function (oEvent)
    {
        this.dispatchEvent({type: "onScreenResolutionSuccess"});
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
