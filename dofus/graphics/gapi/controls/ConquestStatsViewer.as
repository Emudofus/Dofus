// Action script...

// [Initial MovieClip Action of sprite 20907]
#initclip 172
if (!dofus.graphics.gapi.controls.ConquestStatsViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.ConquestStatsViewer = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.ConquestStatsViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.addListeners = function ()
    {
        this._btnTogglePvP.addEventListener("click", this);
        this._btnTogglePvP.addEventListener("over", this);
        this._btnTogglePvP.addEventListener("out", this);
        this._btnDisgraceSanction.addEventListener("click", this);
        this._btnDisgraceSanction.addEventListener("over", this);
        this._btnDisgraceSanction.addEventListener("out", this);
        this.api.datacenter.Player.addEventListener("rankChanged", this);
        this.api.datacenter.Conquest.addEventListener("bonusChanged", this);
        var ref = this;
        this._mcBonusInteractivity.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcBonusInteractivity.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcMalusInteractivity.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcMalusInteractivity.onRollOut = function ()
        {
            ref.out({target: this});
        };
    };
    _loc1.initTexts = function ()
    {
        this._lblHonour.text = this.api.lang.getText("HONOUR_POINTS");
        this._lblDishonour.text = this.api.lang.getText("DISGRACE_POINTS");
        this._lblBonus.text = this.api.lang.getText("ALIGNED_AREA_MODIFICATORS");
        this._lblType.text = this.api.lang.getText("TYPE");
        this._lblBonusTitle.text = this.api.lang.getText("BONUS");
        this._lblMalusTitle.text = this.api.lang.getText("MALUS");
        this._lblInfos.text = this.api.lang.getText("INFORMATIONS");
        this._txtInfos.text = this.api.lang.getText("RANK_SYSTEM_INFO");
    };
    _loc1.initData = function ()
    {
        this.api.network.Conquest.getAlignedBonus();
        this.rankChanged({rank: this.api.datacenter.Player.rank});
    };
    _loc1.updateBonus = function ()
    {
        var _loc2 = new ank.utils.ExtendedArray();
        var _loc3 = this.api.datacenter.Conquest.alignBonus;
        var _loc4 = this.api.datacenter.Conquest.rankMultiplicator;
        var _loc5 = this.api.datacenter.Conquest.alignMalus;
        _loc2.push({type: this.api.lang.getText("EXPERIMENT"), bonus: _loc4.drop == 0 ? ("0%") : ("+" + _loc3.xp * _loc4.xp + "% (" + _loc3.xp + "% x" + _loc4.xp + ")"), malus: _loc5.xp + "%"});
        _loc2.push({type: this.api.lang.getText("COLLECT"), bonus: _loc4.drop == 0 ? ("0%") : ("+" + _loc3.recolte * _loc4.recolte + "% (" + _loc3.recolte + "% x" + _loc4.recolte + ")"), malus: _loc5.recolte + "%"});
        _loc2.push({type: this.api.lang.getText("LOOT"), bonus: _loc4.drop == 0 ? ("0%") : ("+" + _loc3.drop * _loc4.drop + "% (" + _loc3.drop + "% x" + _loc4.drop + ")"), malus: _loc5.drop + "%"});
        this._lstBonuses.dataProvider = _loc2;
    };
    _loc1.bonusChanged = function (oEvent)
    {
        this.updateBonus();
    };
    _loc1.rankChanged = function (oEvent)
    {
        this._oRank = oEvent.rank;
        var _loc3 = this.api.lang.getGradeHonourPointsBounds(this._oRank.value);
        this._pbHonour.maximum = _global.isNaN(_loc3.max) ? (0) : (_loc3.max);
        this._pbHonour.minimum = _global.isNaN(_loc3.min) ? (0) : (_loc3.min);
        this._pbHonour.value = _global.isNaN(this._oRank.honour) ? (0) : (this._oRank.honour);
        this._mcHonour.onRollOver = function ()
        {
            this._parent.gapi.showTooltip(new ank.utils.ExtendedString(this._parent._oRank.honour).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + new ank.utils.ExtendedString(this._parent._pbHonour.maximum).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3), this, -10);
        };
        this._mcHonour.onRollOut = function ()
        {
            this._parent.gapi.hideTooltip();
        };
        this._pbDishonour.value = this._oRank.disgrace;
        this._pbDishonour.maximum = this.api.lang.getMaxDisgracePoints();
        this._mcDishonour.onRollOver = function ()
        {
            this._parent.gapi.showTooltip(new ank.utils.ExtendedString(this._parent._oRank.disgrace).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + new ank.utils.ExtendedString(this._parent._pbDishonour.maximum).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3), this, -10);
        };
        this._mcDishonour.onRollOut = function ()
        {
            this._parent.gapi.hideTooltip();
        };
        if (this._oRank.enable && this._lblInfos.text != undefined)
        {
            var _loc4 = this.api.datacenter.Player.alignment.index;
            this._btnTogglePvP.label = this.api.lang.getText("DISABLE_PVP_SHORT");
        }
        else if (this._lblInfos.text != undefined)
        {
            this._btnTogglePvP.label = this.api.lang.getText("ENABLE_PVP_SHORT");
        } // end else if
        this._btnDisgraceSanction._visible = this.api.datacenter.Player.rank.disgrace > 0;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnDisgraceSanction:
            {
                this.api.kernel.GameManager.showDisgraceSanction();
                break;
            } 
            case this._btnTogglePvP:
            {
                if (this.api.datacenter.Player.rank.enable)
                {
                    this.api.network.Game.askDisablePVPMode();
                }
                else
                {
                    this.api.network.Game.onPVP("", true);
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnTogglePvP:
            {
                this.gapi.showTooltip(this.api.lang.getText(this._oRank.enable ? ("DISABLE_PVP") : ("ENABLE_PVP")), this._btnTogglePvP, -20);
                break;
            } 
            case this._btnDisgraceSanction:
            {
                this.gapi.showTooltip(this.api.lang.getText("DISGRACE_SANCTION_TOOLTIP"), this._btnDisgraceSanction, -20);
                break;
            } 
            case this._mcBonusInteractivity:
            {
                this.gapi.showTooltip(this.api.lang.getText("CONQUEST_STATS_BONUS"), this._mcBonusInteractivity, -70);
                break;
            } 
            case this._mcMalusInteractivity:
            {
                this.gapi.showTooltip(this.api.lang.getText("CONQUEST_STATS_MALUS"), this._mcMalusInteractivity, -40);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.ConquestStatsViewer = function ()
    {
        super();
    }).CLASS_NAME = "ConquestStatsViewer";
} // end if
#endinitclip
