// Action script...

// [Initial MovieClip Action of sprite 20533]
#initclip 54
if (!dofus.graphics.gapi.ui.Mount)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Mount = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Mount.CLASS_NAME);
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
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.mountChanged, params: [{mount: this.api.datacenter.Player.mount}]});
    };
    _loc1.addListeners = function ()
    {
        this._btnNameValid.addEventListener("click", this);
        this._btnName.addEventListener("click", this);
        this._btnName.addEventListener("over", this);
        this._btnName.addEventListener("out", this);
        this._btnXP.addEventListener("click", this);
        this._btnXP.addEventListener("over", this);
        this._btnXP.addEventListener("out", this);
        this._btnRide.addEventListener("click", this);
        this._btnRide.addEventListener("over", this);
        this._btnRide.addEventListener("out", this);
        this._btnInventory.addEventListener("click", this);
        this._btnInventory.addEventListener("over", this);
        this._btnInventory.addEventListener("out", this);
        this._btnAction.addEventListener("click", this);
        this._btnAction.addEventListener("over", this);
        this._btnAction.addEventListener("out", this);
        this.api.datacenter.Player.addEventListener("mountXPPercentChanged", this);
        this.api.datacenter.Player.addEventListener("mountChanged", this);
        this._btnClose.addEventListener("click", this);
    };
    _loc1.initData = function ()
    {
        this.mountChanged();
    };
    _loc1.initTexts = function ()
    {
        this._win.title = this.api.lang.getText("MY_MOUNT");
        this._lblName.text = this.api.lang.getText("NAME_BIG");
        this._lblPercentXP.text = this.api.lang.getText("MOUNT_PERCENT_XP");
        this._lblInventory.text = this.api.lang.getText("MOUNT_INVENTORY_2");
    };
    _loc1.editName = function (bEdit)
    {
        this._tiName._visible = bEdit;
        this._btnNameValid._visible = bEdit;
        this._mcTextInputBackground._visible = bEdit;
        this._lblNameValue._visible = !bEdit;
        this._btnName._visible = !bEdit;
    };
    _loc1.mountXPPercentChanged = function (oEvent)
    {
        this._lblPercentXPValue.text = this.api.datacenter.Player.mountXPPercent + "%";
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnNameValid:
            {
                if (this._tiName.text != "")
                {
                    this.api.network.Mount.rename(this._tiName.text);
                } // end if
                break;
            } 
            case this._btnName:
            {
                this.editName(true);
                break;
            } 
            case this._btnXP:
            {
                var _loc3 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: this.api.datacenter.Player.mountXPPercent, max: 90});
                _loc3.addEventListener("validate", this);
                break;
            } 
            case this._btnClose:
            {
                this.callClose();
                break;
            } 
            case this._btnRide:
            {
                this.api.network.Mount.ride();
                break;
            } 
            case this._btnInventory:
            {
                this.api.network.Exchange.request(15);
                break;
            } 
            case this._btnAction:
            {
                var _loc4 = this.api.ui.createPopupMenu();
                var _loc5 = this.api.datacenter.Player.mount;
                _loc4.addStaticItem(_loc5.name);
                _loc4.addItem(this.api.lang.getText("MOUNT_CASTRATE_TOOLTIP"), this, this.castrateMount);
                _loc4.addItem(this.api.lang.getText("MOUNT_KILL_TOOLTIP"), this, this.killMount);
                _loc4.show(_root._xmouse, _root._ymouse);
                break;
            } 
        } // End of switch
    };
    _loc1.castrateMount = function ()
    {
        this.api.kernel.showMessage(undefined, this.api.lang.getText("DO_U_CASTRATE_YOUR_MOUNT"), "CAUTION_YESNO", {name: "CastrateMount", listener: this});
    };
    _loc1.killMount = function ()
    {
        this.api.kernel.showMessage(undefined, this.api.lang.getText("DO_U_KILL_YOUR_MOUNT"), "CAUTION_YESNO", {name: "KillMount", listener: this});
    };
    _loc1.nameChanged = function (oEvent)
    {
        var _loc3 = this.api.datacenter.Player.mount;
        this._lblNameValue.text = _loc3.name;
        this._tiName.text = _loc3.name;
        this.editName(false);
    };
    _loc1.mountChanged = function (oEvent)
    {
        var _loc3 = this.api.datacenter.Player.mount;
        if (_loc3 != undefined)
        {
            _loc3.addEventListener("nameChanged", this);
            this._mvMountViewer.mount = _loc3;
            this.mountXPPercentChanged();
            this.nameChanged();
        }
        else
        {
            this.callClose();
        } // end else if
    };
    _loc1.validate = function (oEvent)
    {
        var _loc3 = oEvent.value;
        if (_global.isNaN(_loc3))
        {
            return;
        } // end if
        if (_loc3 > 90)
        {
            return;
        } // end if
        if (_loc3 < 0)
        {
            return;
        } // end if
        this.api.network.Mount.setXP(_loc3);
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnName:
            {
                this.gapi.showTooltip(this.api.lang.getText("MOUNT_RENAME_TOOLTIP"), oEvent.target, -30, {bXLimit: true, bYLimit: false});
                break;
            } 
            case this._btnInventory:
            {
                this.gapi.showTooltip(this.api.lang.getText("MOUNT_INVENTORY_ACCES"), oEvent.target, -30, {bXLimit: true, bYLimit: false});
                break;
            } 
            case this._btnRide:
            {
                this.gapi.showTooltip(this.api.lang.getText("MOUNT_RIDE_TOOLTIP"), oEvent.target, -30, {bXLimit: true, bYLimit: false});
                break;
            } 
            case this._btnAction:
            {
                this.gapi.showTooltip(this.api.lang.getText("MOUNT_ACTION_TOOLTIP"), oEvent.target, -30, {bXLimit: true, bYLimit: false});
                break;
            } 
            case this._btnXP:
            {
                this.gapi.showTooltip(this.api.lang.getText("MOUNT_XP_PERCENT_TOOLTIP"), oEvent.target, -30, {bXLimit: true, bYLimit: false});
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoKillMount":
            {
                this.api.network.Mount.kill();
                break;
            } 
            case "AskYesNoCastrateMount":
            {
                this.api.network.Mount.castrate();
                break;
            } 
        } // End of switch
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Mount = function ()
    {
        super();
    }).CLASS_NAME = "Mount";
} // end if
#endinitclip
