// Action script...

// [Initial MovieClip Action of sprite 20887]
#initclip 152
if (!dofus.graphics.gapi.ui.spells.SpellsItem)
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
    if (!dofus.graphics.gapi.ui.spells)
    {
        _global.dofus.graphics.gapi.ui.spells = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.spells.SpellsItem = function ()
    {
        super();
    }).prototype;
    _loc1.__set__list = function (mcList)
    {
        this._mcList = mcList;
        //return (this.list());
    };
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._oItem = oItem;
            oItem.sortName = oItem.name;
            oItem.sortLevel = oItem.level;
            var _loc5 = this._mcList._parent._parent.api;
            this._lblName.text = oItem.name;
            this._lblLevel.text = _loc5.lang.getText("LEVEL") + " " + oItem.level;
            this._lblRange.text = (oItem.rangeMin != 0 ? (oItem.rangeMin + "-") : ("")) + oItem.rangeMax + " " + _loc5.lang.getText("RANGE");
            this._lblAP.text = oItem.apCost + " " + _loc5.lang.getText("AP");
            this._ldrIcon.contentPath = oItem.iconFile;
            var _loc6 = this._mcList._parent._parent.canBoost(oItem) && _loc5.datacenter.Basics.canUseSeeAllSpell;
            var _loc7 = this._mcList._parent._parent.getCostForBoost(oItem);
            this._btnBoost.enabled = true;
            this._btnBoost._visible = _loc6;
            this._lblBoost.text = _loc7 != -1 && _loc5.datacenter.Basics.canUseSeeAllSpell ? (_loc5.lang.getText("POINT_NEED_TO_BOOST_SPELL", [_loc7])) : ("");
            if (_loc5.datacenter.Player.Level < oItem._minPlayerLevel)
            {
                var _loc8 = 50;
                this._lblName._alpha = _loc8;
                this._ldrIcon._alpha = _loc8;
                this._lblAP._alpha = _loc8;
                this._lblRange._alpha = _loc8;
                this._lblLevel._visible = false;
                this._lblBoost._visible = false;
                this._btnBoost._visible = false;
            }
            else
            {
                this._lblName._alpha = 100;
                this._ldrIcon._alpha = 100;
                this._lblAP._alpha = 100;
                this._lblRange._alpha = 100;
                this._lblLevel._alpha = 100;
                this._lblLevel._visible = true;
                this._lblBoost._visible = true;
            } // end else if
        }
        else if (this._lblName.text != undefined)
        {
            this._lblName.text = "";
            this._lblLevel.text = "";
            this._lblBoost.text = "";
            this._lblRange.text = "";
            this._lblAP.text = "";
            this._ldrIcon.contentPath = "";
            this._btnBoost._visible = false;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._btnBoost._visible = false;
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._btnBoost.addEventListener("click", this);
        this._btnBoost.addEventListener("over", this);
        this._btnBoost.addEventListener("out", this);
    };
    _loc1.click = function (oEvent)
    {
        var _loc3 = this._mcList._parent._parent.api;
        switch (oEvent.target)
        {
            case this._btnBoost:
            {
                if (!_loc3.datacenter.Player.isAuthorized)
                {
                    _loc3.kernel.showMessage(_loc3.lang.getText("UPGRADE_SPELL"), _loc3.lang.getText("UPGRADE_SPELL_WARNING", [this._mcList._parent._parent.getCostForBoost(this._oItem), this._oItem.name, String(this._oItem.level + 1)]), "CAUTION_YESNO", {name: "UpgradeSpellWarning", listener: this});
                }
                else
                {
                    this.yes();
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.yes = function (oEvent)
    {
        if (this._mcList._parent._parent.boostSpell(this._oItem))
        {
            this._btnBoost.enabled = false;
            if (this._lblBoost.text != undefined)
            {
                this._lblBoost.text = "";
            } // end if
        } // end if
    };
    _loc1.over = function (oEvent)
    {
        var _loc3 = this._mcList._parent._parent.api;
        switch (oEvent.target)
        {
            case this._btnBoost:
            {
                _loc3.ui.showTooltip(_loc3.lang.getText("CLICK_HERE_FOR_SPELL_BOOST", [this._mcList._parent._parent.getCostForBoost(this._oItem), this._oItem.name, String(this._oItem.level + 1)]), oEvent.target, -30, {bXLimit: true, bYLimit: false});
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        var _loc3 = this._mcList._parent._parent.api;
        switch (oEvent.target)
        {
            case this._btnBoost:
            {
                _loc3.ui.hideTooltip();
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
