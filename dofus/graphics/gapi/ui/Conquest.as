// Action script...

// [Initial MovieClip Action of sprite 20708]
#initclip 229
if (!dofus.graphics.gapi.ui.Conquest)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Conquest = function ()
    {
        super();
    }).prototype;
    _loc1.__set__currentTab = function (sTab)
    {
        this._sCurrentTab = sTab;
        //return (this.currentTab());
    };
    _loc1.sharePropertiesWithTab = function (properties)
    {
        for (var i in properties)
        {
            this._mcTabViewer[i] = properties[i];
        } // end of for...in
    };
    _loc1.setBalance = function (worldBalance, areaBalance)
    {
        this._nWorldBalance = worldBalance;
        this._nAreaBalance = areaBalance;
        this.addToQueue({object: this, method: this.updateBalance});
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Conquest.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        switch (this._sCurrentTab)
        {
            case "Zones":
            {
                this.api.network.Conquest.worldInfosLeave();
                break;
            } 
            case "Join":
            {
                if (!(dofus.graphics.gapi.controls.ConquestJoinViewer)(this._mcTabViewer).noUnsubscribe)
                {
                    this.api.network.Conquest.prismInfosLeave();
                } // end if
                break;
            } 
        } // End of switch
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this._mcPlacer._visible = false;
        this._mcPvpActive._visible = false;
        this._mcPvpInactive._visible = false;
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.setCurrentTab, params: [this._sCurrentTab]});
    };
    _loc1.addListeners = function ()
    {
        this.api.datacenter.Player.addEventListener("rankChanged", this);
        this.api.datacenter.Player.addEventListener("alignmentChanged", this);
        this._btnClose.addEventListener("click", this);
        this._btnTabJoin.addEventListener("click", this);
        this._btnTabStats.addEventListener("click", this);
        this._btnTabZones.addEventListener("click", this);
        this._ctrAlignment.addEventListener("over", this);
        this._ctrAlignment.addEventListener("out", this);
        var ref = this;
        this._mcBalanceInteractivity.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcBalanceInteractivity.onRollOut = function ()
        {
            ref.out({target: this});
        };
    };
    _loc1.initTexts = function ()
    {
        this._lblTitle.text = this.api.lang.getText("CONQUEST_WORD");
        this._lblGrade.text = this.api.lang.getText("RANK");
        this._lblBalance.text = this.api.lang.getText("BALANCE_WORD");
        this._btnTabStats.label = this.api.lang.getText("STATS");
        this._btnTabZones.label = this.api.lang.getText("ZONES_WORD");
        this._btnTabJoin.label = this.api.lang.getText("DEFEND");
    };
    _loc1.initData = function ()
    {
        this.rankChanged({rank: this.api.datacenter.Player.rank});
        this.alignmentChanged({alignment: this.api.datacenter.Player.alignment});
        this.api.network.Conquest.requestBalance();
    };
    _loc1.setCurrentTab = function (sNewTab)
    {
        this._mcComboBoxPopup.removeMovieClip();
        var _loc3 = this["_btnTab" + this._sCurrentTab];
        var _loc4 = this["_btnTab" + sNewTab];
        _loc3.selected = true;
        _loc3.enabled = true;
        _loc4.selected = false;
        _loc4.enabled = false;
        switch (this._sCurrentTab)
        {
            case "Zones":
            {
                this.api.network.Conquest.worldInfosLeave();
                break;
            } 
            case "Join":
            {
                if (!(dofus.graphics.gapi.controls.ConquestJoinViewer)(this._mcTabViewer).noUnsubscribe)
                {
                    this.api.network.Conquest.prismInfosLeave();
                } // end if
                break;
            } 
        } // End of switch
        this._sCurrentTab = sNewTab;
        this.updateCurrentTabInformations();
    };
    _loc1.updateCurrentTabInformations = function ()
    {
        this._mcTabViewer.removeMovieClip();
        switch (this._sCurrentTab)
        {
            case "Stats":
            {
                this.attachMovie("ConquestStatsViewer", "_mcTabViewer", this.getNextHighestDepth(), {_x: this._mcPlacer._x, _y: this._mcPlacer._y});
                break;
            } 
            case "Zones":
            {
                this.attachMovie("ConquestZonesViewer", "_mcTabViewer", this.getNextHighestDepth(), {_x: this._mcPlacer._x, _y: this._mcPlacer._y});
                this.api.network.Conquest.worldInfosJoin();
                break;
            } 
            case "Join":
            {
                this.attachMovie("ConquestJoinViewer", "_mcTabViewer", this.getNextHighestDepth(), {_x: this._mcPlacer._x, _y: this._mcPlacer._y});
                this.api.network.Conquest.prismInfosJoin();
                break;
            } 
        } // End of switch
    };
    _loc1.updateBalance = function ()
    {
        var _loc2 = this.api.lang.getAlignmentBalance();
        var _loc3 = new String();
        for (var i in _loc2)
        {
            if (this._nWorldBalance >= _loc2[i].s && this._nWorldBalance <= _loc2[i].e)
            {
                _loc3 = String(_loc2[i].n);
                this._sBalanceDescription = String(_loc2[i].d);
            } // end if
        } // end of for...in
        this._lblBalanceValue.text = this._nWorldBalance + "%" + (_loc3.length > 0 ? (" (" + _loc3 + ")") : (""));
    };
    _loc1.destroy = function ()
    {
        switch (this._sCurrentTab)
        {
            case "Zones":
            {
                this.api.network.Conquest.worldInfosLeave();
                break;
            } 
            case "Join":
            {
                this.api.network.Conquest.prismInfosLeave();
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._ctrAlignment:
            {
                this.gapi.showTooltip(this.api.datacenter.Player.alignment.name, oEvent.target, oEvent.target.height + 5);
                break;
            } 
            case this._mcBalanceInteractivity:
            {
                var _loc3 = new String();
                if (this._sBalanceDescription.length > 0)
                {
                    _loc3 = _loc3 + this._sBalanceDescription;
                } // end if
                if (this._nAreaBalance != undefined && (!_global.isNaN(this._nAreaBalance) && this._nAreaBalance > 0))
                {
                    _loc3 = _loc3 + ("\n\n" + this.api.lang.getText("CONQUEST_ZONE_BALANCE") + ": " + this._nAreaBalance + "%");
                } // end if
                this.gapi.showTooltip(_loc3, oEvent.target, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
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
            case this._btnTabJoin:
            case this._btnTabStats:
            case this._btnTabZones:
            {
                this.setCurrentTab(oEvent.target._name.substr(7));
                break;
            } 
        } // End of switch
    };
    _loc1.rankChanged = function (oEvent)
    {
        this._rRank = (dofus.datacenter.Rank)(oEvent.rank);
        if (this._rRank.enable && this._lblStats.text != undefined)
        {
            var _loc3 = this.api.datacenter.Player.alignment.index;
            if (_loc3 == 0)
            {
                this._lblGradeValue.text = this.api.lang.getRankLongName(0, 0);
            }
            else
            {
                this._lblGradeValue.text = oEvent.rank.value + " (" + this.api.lang.getRankLongName(_loc3, this._rRank.value) + ")";
            } // end else if
            this._lblStats.text = this.api.lang.getText("PVP_MODE") + " (" + this.api.lang.getText("ACTIVE") + ")";
            this._mcPvpActive._visible = true;
            this._mcPvpInactive._visible = false;
        }
        else if (this._lblStats.text != undefined)
        {
            this._lblGradeValue.text = "-";
            this._lblStats.text = this.api.lang.getText("PVP_MODE") + " (" + this.api.lang.getText("INACTIVE") + ")";
            this._mcPvpActive._visible = false;
            this._mcPvpInactive._visible = true;
        } // end else if
    };
    _loc1.alignmentChanged = function (oEvent)
    {
        this._ctrAlignment.contentPath = oEvent.alignment.iconFile;
    };
    _loc1.addProperty("currentTab", function ()
    {
    }, _loc1.__set__currentTab);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Conquest = function ()
    {
        super();
    }).CLASS_NAME = "Conquest";
    _loc1._sCurrentTab = "Stats";
} // end if
#endinitclip
