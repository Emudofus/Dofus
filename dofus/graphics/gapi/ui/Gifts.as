// Action script...

// [Initial MovieClip Action of sprite 20851]
#initclip 116
if (!dofus.graphics.gapi.ui.Gifts)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Gifts = function ()
    {
        super();
    }).prototype;
    _loc1.__set__gift = function (oGift)
    {
        this._oGift = oGift;
        //return (this.gift());
    };
    _loc1.__set__spriteList = function (aSpriteList)
    {
        this._aSpriteList = aSpriteList;
        //return (this.spriteList());
    };
    _loc1.checkNextGift = function ()
    {
        if (this.api.datacenter.Basics.aks_gifts_stack.length != 0)
        {
            var _loc2 = this.api.datacenter.Basics.aks_gifts_stack.shift();
            this.gapi.loadUIComponent("Gifts", "Gifts", {gift: _loc2, spriteList: this._aSpriteList}, {bForceLoad: true});
        }
        else
        {
            this.gapi.getUIComponent("ChooseCharacter")._visible = true;
            this.gapi.getUIComponent("CreateCharacter")._visible = true;
            this.unloadThis();
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Gifts.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.gapi.getUIComponent("ChooseCharacter")._visible = true;
        this.gapi.getUIComponent("CreateCharacter")._visible = true;
        this.unloadThis();
    };
    _loc1.createChildren = function ()
    {
        this._visible = false;
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.addListeners = function ()
    {
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < 5)
        {
            var _loc3 = this["_ccs" + _loc2];
            _loc3.params = {index: _loc2};
            _loc3.addEventListener("select", this);
        } // end while
        this._cgGifts.addEventListener("selectItem", this);
        this._btnClose.addEventListener("click", this);
        this._btnSelect.addEventListener("click", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblTitle.text = this.api.lang.getText("GIFTS_TITLE");
        this._lblGift.text = this.api.lang.getText("THE_GIFT");
        this._lblItems.text = this.api.lang.getText("GIFT_CONTENT");
        this._lblSelectCharacter.text = this.api.lang.getText("GIFT_SELECT_CHARACTER");
        this._btnClose.label = this.api.lang.getText("CLOSE");
        this._btnSelect.label = this.api.lang.getText("SELECT");
    };
    _loc1.initData = function ()
    {
        switch (this._oGift.type)
        {
            case 1:
            {
                this._visible = true;
                this._cgGifts.dataProvider = this._oGift.items;
                this._cgGifts.selectedIndex = 0;
                this._itvItemViewer.itemData = this._oGift.items[0];
                this._ldrGfx.contentPath = this._oGift.gfxUrl;
                this._lblTitleGift.text = this._oGift.title;
                this._txtDescription.text = this._oGift.desc;
                var _loc2 = 0;
                
                while (++_loc2, _loc2 < 5)
                {
                    var _loc3 = this["_ccs" + _loc2];
                    _loc3.data = this._aSpriteList[_loc2];
                    _loc3.enabled = this._aSpriteList[_loc2] != undefined;
                } // end while
                break;
            } 
            default:
            {
                this.checkNextGift();
            } 
        } // End of switch
    };
    _loc1.select = function (oEvent)
    {
        var _loc3 = oEvent.target.params.index;
        this["_ccs" + this._nSelectedIndex].selected = false;
        if (this._nSelectedIndex == _loc3)
        {
            delete this._nSelectedIndex;
        }
        else
        {
            this._nSelectedIndex = _loc3;
        } // end else if
        if (getTimer() - this._nSaveLastClick < ank.gapi.Gapi.DBLCLICK_DELAY)
        {
            this._nSelectedIndex = _loc3;
            this.click({target: this._btnSelect});
            return;
        } // end if
        this._nSaveLastClick = getTimer();
    };
    _loc1.selectItem = function (oEvent)
    {
        this._itvItemViewer.itemData = oEvent.target.contentData;
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
            case this._btnSelect:
            {
                if (!_global.isNaN(this._nSelectedIndex))
                {
                    var _loc3 = (dofus.datacenter.Item)(this._oGift.items[0]);
                    this.api.kernel.showMessage(this.api.lang.getText("THE_GIFT"), this.api.lang.getText("GIFT_ATTRIBUTION_CONFIRMATION", [_loc3.name, this["_ccs" + this._nSelectedIndex].data.name]), "CAUTION_YESNO", {name: "GiftAttribution", listener: this, params: {giftId: this._oGift.id, charId: this["_ccs" + this._nSelectedIndex].data.id}});
                }
                else
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("SELECT_CHARACTER"), "ERROR_BOX", {name: "NoSelect"});
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoGiftAttribution":
            {
                this.api.network.Account.attributeGiftToCharacter(oEvent.params.giftId, oEvent.params.charId);
                this.api.ui.loadUIComponent("WaitingMessage", "WaitingMessage", {text: this.api.lang.getText("WAITING_MSG_RECORDING")}, {bAlwaysOnTop: true, bForceLoad: true});
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("spriteList", function ()
    {
    }, _loc1.__set__spriteList);
    _loc1.addProperty("gift", function ()
    {
    }, _loc1.__set__gift);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Gifts = function ()
    {
        super();
    }).CLASS_NAME = "Gifts";
} // end if
#endinitclip
