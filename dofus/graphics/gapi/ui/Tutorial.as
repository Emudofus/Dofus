// Action script...

// [Initial MovieClip Action of sprite 20673]
#initclip 194
if (!dofus.graphics.gapi.ui.Tutorial)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Tutorial = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Tutorial.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._btnCancel.addEventListener("click", this);
        this._btnCancel.addEventListener("over", this);
        this._btnCancel.addEventListener("out", this);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnCancel":
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("LEAVE_TUTORIAL"), "CAUTION_YESNO", {name: "Tutorial", listener: this});
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        this.gapi.showTooltip(this.api.lang.getText("CANCEL_TUTORIAL"), oEvent.target, -20);
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.yes = function (oEvent)
    {
        this.api.kernel.TutorialManager.cancel();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Tutorial = function ()
    {
        super();
    }).CLASS_NAME = "Tutorial";
} // end if
#endinitclip
