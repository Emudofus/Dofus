// Action script...

// [Initial MovieClip Action of sprite 20836]
#initclip 101
if (!dofus.graphics.gapi.Gapi)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.Gapi = function ()
    {
        super();
    }).prototype;
    _loc1.loadUIComponent = function (sLink, sInstanceName, oComponentParams, oUIParams)
    {
        this.api.kernel.TipsManager.onNewInterface(sLink);
        this.api.kernel.StreamingDisplayManager.onNewInterface(sLink);
        var _loc7 = super.loadUIComponent(sLink, sInstanceName, oComponentParams, oUIParams);
        return (_loc7);
    };
    _loc1.unloadUIComponent = function (sInstanceName)
    {
        this.api.kernel.StreamingDisplayManager.onInterfaceClose(sInstanceName);
        return (super.unloadUIComponent(sInstanceName));
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
