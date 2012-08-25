// Action script...

// [Initial MovieClip Action of sprite 20498]
#initclip 19
if (!dofus.graphics.gapi.ui.PayZoneDialog2)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.PayZoneDialog2 = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.PayZoneDialog2.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.addListeners = function ()
    {
        this._btnMoreInfo.onRelease = this.linkTo(this.api);
    };
    _loc1.linkTo = function (api)
    {
        return (function ()
        {
            getURL(api.lang.getConfigText("MEMBERS_LINK"), "_blank");
        });
    };
    _loc1.initTexts = function ()
    {
        this._lblTitle.text = this.api.lang.getText("PAY_ZONE_TITLE");
        this._taContent.text = this.api.lang.getText("PAY_ZONE_DESC");
        this._btnMoreInfo._label.text = this.api.lang.getText("PAY_ZONE_BTN");
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.PayZoneDialog2 = function ()
    {
        super();
    }).CLASS_NAME = "PayZoneDialog2";
} // end if
#endinitclip
