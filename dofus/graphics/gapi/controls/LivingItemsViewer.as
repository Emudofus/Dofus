// Action script...

// [Initial MovieClip Action of sprite 20898]
#initclip 163
if (!dofus.graphics.gapi.controls.LivingItemsViewer)
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
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.LivingItemsViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__itemData = function (o)
    {
        this._oItemData = o;
        this.updateData();
        //return (this.itemData());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.LivingItemsViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.updateData});
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._pbXP.addEventListener("over", this);
        this._pbXP.addEventListener("out", this);
        this._btnFeed.addEventListener("click", this);
        this._btnDissociate.addEventListener("click", this);
        this._btnSkin.addEventListener("click", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblStateTitle.text = this.api.lang.getText("STATE");
        this._lblState.text = this.api.lang.getText(this._oItemData.mood == 1 ? ("SATISFIED_WORD") : (this._oItemData.mood == 0 ? ("LEAN") : ("FAT")));
        this._lblLevelTitle.text = this.api.lang.getText("LEVEL");
        this._lblLevel.text = String(this._oItemData.maxSkin);
        this._lblXplTitle.text = this.api.lang.getText("EXPERIMENT");
        this._btnDissociate.label = this.api.lang.getText("DISSOCIATE");
        this._btnFeed.label = this.api.lang.getText("FEED_WORD");
        this._btnSkin.label = this.api.lang.getText("CHOOSE_SKIN");
        var _loc2 = this._oItemData.effects;
        for (var i in _loc2)
        {
            if (_loc2[i].type == 808)
            {
                this._lblEatDate.text = _loc2[i].description;
                break;
            } // end if
        } // end of for...in
    };
    _loc1.updateData = function ()
    {
        this._ctrItem.contentPath = this._oItemData.gfx;
        this._ctrItem.contentData = this._oItemData;
        this._pbXP.minimum = this._oItemData.currentLivingLevelXpMin;
        this._pbXP.maximum = this._oItemData.currentLivingLevelXpMax;
        this._pbXP.value = this._oItemData.currentLivingXp;
        this._btnDissociate.enabled = this._oItemData.isAssociate;
        this._btnFeed.enabled = this._oItemData.isAssociate;
        this.initTexts();
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnSkin:
            {
                this.api.ui.loadUIComponent("ChooseItemSkin", "ChooseItemSkin", {item: this._oItemData});
                break;
            } 
            case this._btnFeed:
            {
                this.api.ui.loadUIComponent("ChooseFeed", "ChooseFeed", {itemsType: [this._oItemData.type], item: this._oItemData});
                break;
            } 
            case this._btnDissociate:
            {
                this.api.kernel.SpeakingItemsManager.triggerPrivateEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_DISSOCIATE);
                this.api.network.Items.dissociate(this._oItemData.ID, this._oItemData.position);
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        this.gapi.showTooltip(new ank.utils.ExtendedString(this._pbXP.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + new ank.utils.ExtendedString(this._pbXP.maximum).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3), this._pbXP, -20);
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("itemData", function ()
    {
    }, _loc1.__set__itemData);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.LivingItemsViewer = function ()
    {
        super();
    }).CLASS_NAME = "LivingItemsViewer";
} // end if
#endinitclip
