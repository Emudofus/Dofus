// Action script...

// [Initial MovieClip Action of sprite 20833]
#initclip 98
if (!dofus.graphics.gapi.controls.alignmentviewer.RankViewer)
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
    if (!dofus.graphics.gapi.controls.alignmentviewer)
    {
        _global.dofus.graphics.gapi.controls.alignmentviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.alignmentviewer.RankViewer = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.alignmentviewer.RankViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this._mcPvpActive._visible = false;
        this._mcPvpInactive._visible = false;
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.initTexts = function ()
    {
        this._lblStats.text = this.api.lang.getText("PVP_MODE");
        this._lblInfos.text = this.api.lang.getText("INFORMATIONS");
        this._lblDisgrace.text = this.api.lang.getText("DISGRACE_POINTS");
        this._lblHonour.text = this.api.lang.getText("HONOUR_POINTS");
        this._lblRank.text = this.api.lang.getText("RANK");
        this._txtInfos.text = this.api.lang.getText("RANK_SYSTEM_INFO");
    };
    _loc1.addListeners = function ()
    {
        this.api.datacenter.Player.addEventListener("rankChanged", this);
        this._btnEnabled.addEventListener("click", this);
        this._btnEnabled.addEventListener("over", this);
        this._btnEnabled.addEventListener("out", this);
        this._btnDisgraceSanction.addEventListener("click", this);
        this._btnDisgraceSanction.addEventListener("over", this);
        this._btnDisgraceSanction.addEventListener("out", this);
    };
    _loc1.initData = function ()
    {
        this._pbDisgrace.maximum = this.api.lang.getMaxDisgracePoints();
        this.rankChanged({rank: this.api.datacenter.Player.rank});
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnEnabled":
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
            case "_btnDisgraceSanction":
            {
                this.api.kernel.GameManager.showDisgraceSanction();
                break;
            } 
        } // End of switch
    };
    _loc1.rankChanged = function (oEvent)
    {
        this._oRank = oEvent.rank;
        var _loc3 = this.api.lang.getGradeHonourPointsBounds(this._oRank.value);
        this._pbHonour.maximum = _loc3.max;
        this._pbHonour.minimum = _loc3.min;
        this._pbHonour.value = this._oRank.honour;
        this._mcHonour.onRollOver = function ()
        {
            this._parent.gapi.showTooltip(new ank.utils.ExtendedString(this._parent._oRank.honour).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + new ank.utils.ExtendedString(this._parent._pbHonour.maximum).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3), this, -10);
        };
        this._mcHonour.onRollOut = function ()
        {
            this._parent.gapi.hideTooltip();
        };
        this._pbDisgrace.value = this._oRank.disgrace;
        this._mcDisgrace.onRollOver = function ()
        {
            this._parent.gapi.showTooltip(new ank.utils.ExtendedString(this._parent._oRank.disgrace).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + new ank.utils.ExtendedString(this._parent._pbDisgrace.maximum).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3), this, -10);
        };
        this._mcDisgrace.onRollOut = function ()
        {
            this._parent.gapi.hideTooltip();
        };
        if (this._oRank.enable && this._lblRankDisabled.text != undefined)
        {
            var _loc4 = this.api.datacenter.Player.alignment.index;
            if (_loc4 == 0)
            {
                this._lblRankValue.text = this.api.lang.getRankLongName(0, 0);
            }
            else
            {
                this._lblRankValue.text = oEvent.rank.value + " (" + this.api.lang.getRankLongName(_loc4, this._oRank.value) + ")";
            } // end else if
            this._lblDisgrace._visible = true;
            this._mcDisgrace._visible = true;
            this._pbDisgrace._visible = true;
            this._lblRank.text = this.api.lang.getText("RANK");
            this._lblRankDisabled.text = "";
            this._lblStats.text = this.api.lang.getText("PVP_MODE") + " (" + this.api.lang.getText("ACTIVE") + ")";
            this._mcPvpActive._visible = true;
            this._mcPvpInactive._visible = false;
            this._btnEnabled.label = this.api.lang.getText("DISABLE");
        }
        else if (this._lblRankValue.text != undefined)
        {
            this._lblDisgrace._visible = false;
            this._mcDisgrace._visible = false;
            this._pbDisgrace._visible = false;
            this._lblRankValue.text = "";
            this._lblRank.text = "";
            this._lblRankDisabled.text = this.api.lang.getText("PVP_MODE_DISABLED");
            this._lblStats.text = this.api.lang.getText("PVP_MODE") + " (" + this.api.lang.getText("INACTIVE") + ")";
            this._mcPvpActive._visible = false;
            this._mcPvpInactive._visible = true;
            this._btnEnabled.label = this.api.lang.getText("ENABLE");
        } // end else if
        this._btnDisgraceSanction._visible = this.api.datacenter.Player.rank.disgrace > 0;
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnEnabled":
            {
                this.gapi.showTooltip(this.api.lang.getText(this._oRank.enable ? ("DISABLE_PVP") : ("ENABLE_PVP")), this._btnEnabled, -20);
                break;
            } 
            case "_btnDisgraceSanction":
            {
                this.gapi.showTooltip(this.api.lang.getText("DISGRACE_SANCTION_TOOLTIP"), this._btnDisgraceSanction, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.alignmentviewer.RankViewer = function ()
    {
        super();
    }).CLASS_NAME = "RankViewer";
} // end if
#endinitclip
