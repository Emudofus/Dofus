// Action script...

// [Initial MovieClip Action of sprite 20642]
#initclip 163
if (!dofus.graphics.gapi.ui.MountViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.MountViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__mount = function (oMount)
    {
        this._oMount = oMount;
        if (this.initialized)
        {
            this.updateData();
        } // end if
        //return (this.mount());
    };
    _loc1.__get__mount = function ()
    {
        return (this._oMount);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.MountViewer.CLASS_NAME);
    };
    _loc1.destroy = function ()
    {
        this.gapi.hideTooltip();
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.updateData});
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
    };
    _loc1.updateData = function ()
    {
        this._mvMountViewer.mount = this._oMount;
    };
    _loc1.initTexts = function ()
    {
        this._btnClose.label = this.api.lang.getText("CLOSE");
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnClose:
            {
                this.callClose();
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("mount", _loc1.__get__mount, _loc1.__set__mount);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.MountViewer = function ()
    {
        super();
    }).CLASS_NAME = "MountViewer";
} // end if
#endinitclip
