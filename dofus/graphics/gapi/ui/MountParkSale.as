// Action script...

// [Initial MovieClip Action of sprite 20929]
#initclip 194
if (!dofus.graphics.gapi.ui.MountParkSale)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.MountParkSale = function ()
    {
        super();
    }).prototype;
    _loc1.__get__isMine = function ()
    {
        return (this._oMountPark.isMine(this.api));
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.MountParkSale.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.api.network.Mount.leave();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this._oMountPark = this.api.datacenter.Map.mountPark;
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
        this._btnCancel._visible = false;
        this._txtPrice.tabIndex = 0;
        this._txtPrice.restrict = "0-9";
        this._txtPrice.onSetFocus = function ()
        {
            this._parent.onSetFocus();
        };
        this._txtPrice.onKillFocus = function ()
        {
            this._parent.onKillFocus();
        };
    };
    _loc1.addListeners = function ()
    {
        this._btnCancel.addEventListener("click", this);
        this._btnValidate.addEventListener("click", this);
        this._btnClose.addEventListener("click", this);
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
    };
    _loc1.initData = function ()
    {
        this._txtDescription.text = this.api.lang.getText("MOUNTPARK_DESCRIPTION", [this._oMountPark.size, this._oMountPark.items]);
        if (this.isMine)
        {
            this._txtPrice.text = String(this._oMountPark.price != 0 ? (this._oMountPark.price) : (this.defaultPrice));
            this._btnCancel._visible = this._oMountPark.price != 0;
            this._mcPrice._visible = true;
            Selection.setFocus(this._txtPrice);
        }
        else
        {
            this._txtPrice.text = String(this._oMountPark.price);
            this._txtPrice.editable = false;
            this._txtPrice.selectable = false;
            this._mcPrice._visible = false;
        } // end else if
    };
    _loc1.initTexts = function ()
    {
        this._lblPrice.text = this.api.lang.getText("PRICE") + " :";
        if (this.isMine)
        {
            this._winBackground.title = this.api.lang.getText("MOUNTPARK_SALE");
            this._btnCancel.label = this.api.lang.getText("CANCEL_THE_SALE");
            this._btnValidate.label = this.api.lang.getText("VALIDATE");
        }
        else
        {
            this._winBackground.title = this.api.lang.getText("MOUNTPARK_PURCHASE");
            this._btnValidate.label = this.api.lang.getText("BUY");
        } // end else if
    };
    _loc1.onShortcut = function (sShortcut)
    {
        if (sShortcut == "ACCEPT_CURRENT_DIALOG" && Selection.getFocus()._name == "_txtPrice")
        {
            this.click({target: this._btnValidate});
            return (false);
        } // end if
        return (true);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnCancel":
            {
                if (this.isMine)
                {
                    this.api.network.Mount.mountParkSell(0);
                } // end if
                break;
            } 
            case "_btnValidate":
            {
                if (this.isMine)
                {
                    this.api.network.Mount.mountParkSell(Number(this._txtPrice.text));
                }
                else
                {
                    if (this._oMountPark.price <= 0)
                    {
                        return;
                    } // end if
                    if (this._oMountPark.price > this.api.datacenter.Player.Kama)
                    {
                        this.gapi.loadUIComponent("AskOk", "AskOkNotRich", {title: this.api.lang.getText("ERROR_WORD"), text: this.api.lang.getText("NOT_ENOUGH_RICH")});
                    }
                    else
                    {
                        var _loc3 = this.gapi.loadUIComponent("AskYesNo", "AskYesNoBuy", {title: this.api.lang.getText("MOUNTPARK_PURCHASE"), text: this.api.lang.getText("DO_U_BUY_MOUNTPARK", [this._oMountPark.price])});
                        _loc3.addEventListener("yes", this);
                    } // end else if
                } // end else if
                break;
            } 
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
        } // End of switch
    };
    _loc1.yes = function ()
    {
        this.api.network.Mount.mountParkBuy(this._oMountPark.price);
    };
    _loc1.onSetFocus = function ()
    {
        getURL("FSCommand:" add "trapallkeys", "false");
    };
    _loc1.onKillFocus = function ()
    {
        getURL("FSCommand:" add "trapallkeys", "true");
    };
    _loc1.addProperty("isMine", _loc1.__get__isMine, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.MountParkSale = function ()
    {
        super();
    }).CLASS_NAME = "MountParkSale";
} // end if
#endinitclip
