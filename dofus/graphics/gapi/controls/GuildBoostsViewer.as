// Action script...

// [Initial MovieClip Action of sprite 20902]
#initclip 167
if (!dofus.graphics.gapi.controls.GuildBoostsViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.GuildBoostsViewer = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.GuildBoostsViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this._btnBoostWisdom._visible = false;
        this._btnBoostPod._visible = false;
        this._btnBoostPop._visible = false;
        this._btnBoostPP._visible = false;
        this._btnHireTaxCollector._visible = false;
    };
    _loc1.addListeners = function ()
    {
        this._lstSpells.addEventListener("itemSelected", this);
        this._btnBoostPP.addEventListener("click", this);
        this._btnBoostWisdom.addEventListener("click", this);
        this._btnBoostPod.addEventListener("click", this);
        this._btnBoostPop.addEventListener("click", this);
        this._btnHireTaxCollector.addEventListener("click", this);
        this._btnBoostPP.addEventListener("over", this);
        this._btnBoostWisdom.addEventListener("over", this);
        this._btnBoostPod.addEventListener("over", this);
        this._btnBoostPop.addEventListener("over", this);
        this._btnHireTaxCollector.addEventListener("over", this);
        this._btnBoostPP.addEventListener("out", this);
        this._btnBoostWisdom.addEventListener("out", this);
        this._btnBoostPod.addEventListener("out", this);
        this._btnBoostPop.addEventListener("out", this);
        this._btnHireTaxCollector.addEventListener("out", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblLP.text = this.api.lang.getText("LIFEPOINTS");
        this._lblBonus.text = this.api.lang.getText("DAMAGES_BONUS");
        this._lblBoostPP.text = this.api.lang.getText("DISCERNMENT");
        this._lblBoostWisdom.text = this.api.lang.getText("WISDOM");
        this._lblBoostPod.text = this.api.lang.getText("WEIGHT");
        this._lblBoostPop.text = this.api.lang.getText("TAX_COLLECTOR_COUNT");
        this._lblBoostPoints.text = this.api.lang.getText("GUILD_BONUSPOINTS");
        this._lblLevel.text = this.api.lang.getText("LEVEL_SMALL");
        this._lblTaxSpells.text = this.api.lang.getText("GUILD_TAXSPELLS");
        this._lblTaxCharacteristics.text = this.api.lang.getText("GUILD_TAXCHARACTERISTICS");
        this._btnHireTaxCollector.label = this.api.lang.getText("HIRE_TAXCOLLECTOR");
    };
    _loc1.updateData = function ()
    {
        this.gapi.hideTooltip();
        var _loc2 = this.api.datacenter.Player.guildInfos;
        this._lblLPValue.text = _loc2.taxLp + "";
        this._lblBonusValue.text = _loc2.taxBonus + "";
        this._lblBoostPodValue.text = _loc2.taxPod + "";
        this._lblBoostPPValue.text = _loc2.taxPP + "";
        this._lblBoostWisdomValue.text = _loc2.taxWisdom + "";
        this._lblBoostPopValue.text = _loc2.taxPopulation + "";
        this._lblTaxCount.text = this.api.lang.getText("GUILD_TAX_COUNT", [_loc2.taxCount, _loc2.taxCountMax]);
        this._lblBoostPointsValue.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("POINTS", [_loc2.boostPoints]), "m", _loc2.boostPoints < 2);
        this._lstSpells.dataProvider = _loc2.taxSpells;
        var _loc3 = _loc2.playerRights.canManageBoost && _loc2.boostPoints > 0;
        this._btnBoostPod._visible = _loc3 && _loc2.canBoost("w");
        this._btnBoostPP._visible = _loc3 && _loc2.canBoost("p");
        this._btnBoostWisdom._visible = _loc3 && _loc2.canBoost("x");
        this._btnBoostPop._visible = _loc3 && _loc2.canBoost("c");
        this._btnHireTaxCollector.enabled = _loc2.playerRights.canHireTaxCollector && (_loc2.taxCount < _loc2.taxCountMax && !this.api.datacenter.Player.cantInteractWithTaxCollector);
        this._btnHireTaxCollector._visible = true;
    };
    _loc1.itemSelected = function (oEvent)
    {
        this.gapi.loadUIComponent("SpellInfos", "SpellInfos", {spell: oEvent.row.item});
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnBoostPod":
            {
                this.api.sounds.events.onGuildButtonClick();
                this.api.network.Guild.boostCharacteristic("w");
                break;
            } 
            case "_btnBoostPP":
            {
                this.api.sounds.events.onGuildButtonClick();
                this.api.network.Guild.boostCharacteristic("p");
                break;
            } 
            case "_btnBoostWisdom":
            {
                this.api.sounds.events.onGuildButtonClick();
                this.api.network.Guild.boostCharacteristic("x");
                break;
            } 
            case "_btnBoostPop":
            {
                this.api.sounds.events.onGuildButtonClick();
                this.api.network.Guild.boostCharacteristic("c");
                break;
            } 
            case "_btnHireTaxCollector":
            {
                var _loc3 = this.api.datacenter.Player;
                if (_loc3.guildInfos.taxcollectorHireCost < _loc3.Kama)
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("DO_YOU_HIRE_TAXCOLLECTOR", [_loc3.guildInfos.taxcollectorHireCost]), "CAUTION_YESNO", {name: "GuildTaxCollector", listener: this});
                }
                else
                {
                    this.api.kernel.showMessage("undefined", this.api.lang.getText("NOT_ENOUGTH_RICH_TO_HIRE_TAX"), "ERROR_BOX");
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnBoostPod":
            {
                var _loc3 = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("w");
                var _loc4 = this.api.lang.getGuildBoostsMax("w");
                this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + _loc3.cost + " " + this.api.lang.getText("POUR") + " " + _loc3.count + " (max : " + _loc4 + ")", oEvent.target, -20);
                break;
            } 
            case "_btnBoostPP":
            {
                var _loc5 = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("p");
                var _loc6 = this.api.lang.getGuildBoostsMax("p");
                this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + _loc5.cost + " " + this.api.lang.getText("POUR") + " " + _loc5.count + " (max : " + _loc6 + ")", oEvent.target, -20);
                break;
            } 
            case "_btnBoostWisdom":
            {
                var _loc7 = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("x");
                var _loc8 = this.api.lang.getGuildBoostsMax("x");
                this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + _loc7.cost + " " + this.api.lang.getText("POUR") + " " + _loc7.count + " (max : " + _loc8 + ")", oEvent.target, -20);
                break;
            } 
            case "_btnBoostPop":
            {
                var _loc9 = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("c");
                var _loc10 = this.api.lang.getGuildBoostsMax("c");
                this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + _loc9.cost + " " + this.api.lang.getText("POUR") + " " + _loc9.count + " (max : " + _loc10 + ")", oEvent.target, -20);
                break;
            } 
            case "_btnHireTaxCollector":
            {
                this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + this.api.datacenter.Player.guildInfos.taxcollectorHireCost + " " + this.api.lang.getText("KAMAS"), oEvent.target, -20);
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
        this.api.network.Guild.hireTaxCollector();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.GuildBoostsViewer = function ()
    {
        super();
    }).CLASS_NAME = "GuildBoostsViewer";
} // end if
#endinitclip
