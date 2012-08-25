// Action script...

// [Initial MovieClip Action of sprite 20846]
#initclip 111
if (!dofus.graphics.gapi.ui.ItemViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.ItemViewer = function ()
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
        super.init(false, dofus.graphics.gapi.ui.ItemViewer.CLASS_NAME);
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
        this._mcTooltip.onRollOver = function ()
        {
            this._parent.onTooltipOver();
        };
        this._mcTooltip.onRollOut = function ()
        {
            this._parent.onTooltipOut();
        };
    };
    _loc1.updateData = function ()
    {
        this._itvItemViewer.itemData = this._oItem;
    };
    _loc1.initTexts = function ()
    {
        this._btnClose.label = this.api.lang.getText("CLOSE");
        this._lblWarning.text = this.api.lang.getText("ITEMS_CHAT_WARNING");
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
    _loc1.onTooltipOut = function ()
    {
        this.gapi.hideTooltip();
    };
    _loc1.onTooltipOver = function ()
    {
        this.gapi.showTooltip(this.api.lang.getText("ITEMS_CHAT_WARNING_ROLLOVER"), this._mcTooltip, 14);
    };
    _loc1.addProperty("item", _loc1.__get__item, _loc1.__set__item);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.ItemViewer = function ()
    {
        super();
    }).CLASS_NAME = "ItemViewer";
} // end if
#endinitclip
