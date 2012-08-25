// Action script...

// [Initial MovieClip Action of sprite 20576]
#initclip 97
if (!dofus.graphics.gapi.ui.ChooseItemSkin)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.ChooseItemSkin = function ()
    {
        super();
    }).prototype;
    _loc1.__set__item = function (oItem)
    {
        this._oItem = oItem;
        if (this.initialized)
        {
            this.updateData();
        } // end if
        //return (this.item());
    };
    _loc1.__get__item = function ()
    {
        return (this._oItem);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.ChooseItemSkin.CLASS_NAME);
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
        this._btnValid.addEventListener("click", this);
    };
    _loc1.updateData = function ()
    {
        this._cisItem.item = this._oItem;
    };
    _loc1.initTexts = function ()
    {
        this._btnValid.label = this.api.lang.getText("VALIDATE");
        this._win.title = this.api.lang.getText("CHOOSE_SKIN");
    };
    _loc1.validate = function (oItem)
    {
        if (!oItem)
        {
            return;
        } // end if
        this.api.kernel.SpeakingItemsManager.triggerPrivateEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CHANGE_SKIN);
        this.api.network.Items.setSkin(this._oItem.ID, this._oItem.position, oItem.skin + 1);
        this.callClose();
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._bgh:
            case this._btnClose:
            {
                this.callClose();
                break;
            } 
            case this._btnValid:
            {
                this.validate(this._cisItem.selectedItem);
            } 
        } // End of switch
    };
    _loc1.dblClickItem = function (oEvent)
    {
        this.validate(oEvent.target.contentData);
    };
    _loc1.addProperty("item", _loc1.__get__item, _loc1.__set__item);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.ChooseItemSkin = function ()
    {
        super();
    }).CLASS_NAME = "ChooseItemSkin";
} // end if
#endinitclip
