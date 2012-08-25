// Action script...

// [Initial MovieClip Action of sprite 20880]
#initclip 145
if (!dofus.graphics.gapi.ui.PayZone)
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
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.PayZone = function ()
    {
        super();
    }).prototype;
    _loc1.__set__dialogID = function (nDialogID)
    {
        this._nDialogID = nDialogID;
        //return (this.dialogID());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.PayZone.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        if (this.api.datacenter.Basics.payzone_isFirst)
        {
            this.gapi.loadUIComponent("PayZoneDialog2", "PayZoneDialog2", {name: "El Pemy", gfx: "9059", dialogID: this._nDialogID});
        } // end if
    };
    _loc1.addListeners = function ()
    {
        this._btnInfos.addEventListener("click", this);
    };
    _loc1.click = function (oEvent)
    {
        this.gapi.loadUIComponent("PayZoneDialog2", "PayZoneDialog2", {name: "El Pemy", gfx: "9059", dialogID: this._nDialogID});
    };
    _loc1.addProperty("dialogID", function ()
    {
    }, _loc1.__set__dialogID);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.PayZone = function ()
    {
        super();
    }).CLASS_NAME = "PayZone";
} // end if
#endinitclip
