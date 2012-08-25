// Action script...

// [Initial MovieClip Action of sprite 20963]
#initclip 228
if (!dofus.graphics.gapi.ui.ChooseFeed)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.ChooseFeed = function ()
    {
        super();
    }).prototype;
    _loc1.__set__itemsType = function (aTypes)
    {
        this._aFiltersType = aTypes;
        if (this._eaDataProvider)
        {
            this.updateData();
        } // end if
        //return (this.itemsType());
    };
    _loc1.__set__item = function (oData)
    {
        this._oItem = oData;
        //return (this.item());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.ChooseFeed.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.updateData});
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnValid.addEventListener("click", this);
        this._bgh.addEventListener("click", this);
        this._cgGrid.addEventListener("selectItem", this);
        this._cgGrid.addEventListener("overItem", this);
        this._cgGrid.addEventListener("outItem", this);
        this._cgGrid.addEventListener("dblClickItem", this);
    };
    _loc1.initTexts = function ()
    {
        this._btnValid.label = this.api.lang.getText("VALIDATE");
        this._winBg.title = this.api.lang.getText("FEED_ITEM");
        this._lblNoItem.text = this.api.lang.getText("SELECT_ITEM");
    };
    _loc1.updateData = function ()
    {
        this._eaDataProvider = this.api.datacenter.Player.Inventory;
        this._itvItemViewer._visible = false;
        this._mcItvIconBg._visible = false;
        var _loc2 = new ank.utils.ExtendedArray();
        for (var k in this._eaDataProvider)
        {
            var _loc3 = this._eaDataProvider[k];
            var _loc4 = 0;
            
            while (++_loc4, _loc4 < this._aFiltersType.length)
            {
                if (_loc3.type == this._aFiltersType[_loc4] && (!_loc3.skineable && (_loc3.position == -1 && _loc3.canBeExchange)))
                {
                    _loc2.push(_loc3);
                    break;
                } // end if
            } // end while
        } // end of for...in
        if (_loc2.length)
        {
            this._cgGrid.dataProvider = _loc2;
        }
        else
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("ERROR_NO_FOOD_LIVING_ITEM", [this._oItem.name]), "ERROR_BOX", {name: "noItem", listener: this});
            this.callClose();
        } // end else if
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.validate = function (oItem, noConfirm)
    {
        if (!oItem.ID)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("SELECT_ITEM"), "ERROR_BOX", {name: "noSelection", listener: this});
            return;
        } // end if
        if (!noConfirm)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("CONFIRM_FOOD_LIVING_ITEM"), "CAUTION_YESNO", {name: "Confirm", params: {oItem: oItem}, listener: this});
            return;
        } // end if
        this.api.kernel.SpeakingItemsManager.triggerPrivateEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_FEED);
        this.api.network.Items.feed(this._oItem.ID, this._oItem.position, oItem.ID);
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
                this.validate(this._cgGrid.selectedItem.contentData);
            } 
        } // End of switch
    };
    _loc1.dblClickItem = function (oEvent)
    {
        this.validate(oEvent.target.contentData);
    };
    _loc1.selectItem = function (oEvent)
    {
        this._itvItemViewer.itemData = oEvent.target.contentData;
        this._itvItemViewer._visible = true;
        this._mcItvIconBg._visible = true;
        this._lblNoItem._visible = false;
    };
    _loc1.overItem = function (oEvent)
    {
        this.gapi.showTooltip(oEvent.target.contentData.name, oEvent.target, -20, undefined, oEvent.target.contentData.style + "ToolTip");
    };
    _loc1.outItem = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoConfirm":
            {
                this.validate(oEvent.params.oItem, true);
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("item", function ()
    {
    }, _loc1.__set__item);
    _loc1.addProperty("itemsType", function ()
    {
    }, _loc1.__set__itemsType);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.ChooseFeed = function ()
    {
        super();
    }).CLASS_NAME = "LivingItemsViewer";
} // end if
#endinitclip
