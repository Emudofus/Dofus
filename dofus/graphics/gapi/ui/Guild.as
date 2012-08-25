// Action script...

// [Initial MovieClip Action of sprite 20619]
#initclip 140
if (!dofus.graphics.gapi.ui.Guild)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Guild = function ()
    {
        super();
    }).prototype;
    _loc1.__set__currentTab = function (sTab)
    {
        this._sCurrentTab = sTab;
        //return (this.currentTab());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Guild.CLASS_NAME);
    };
    _loc1.destroy = function ()
    {
        this.gapi.unloadUIComponent("GuildMemberInfos");
        this.gapi.hideTooltip();
        this.api.datacenter.Player.guildInfos.removeEventListener("modelChanged", this);
        this.checkIfLocalPlayerIsDefender();
        if (this._sCurrentTab == "TaxCollectors")
        {
            this.api.network.Guild.leaveTaxInterface();
        } // end if
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.setCurrentTab, params: [this._sCurrentTab]});
        this._mcPlacer._visible = false;
        this._mcCaution._visible = this._lblValid._visible = false;
    };
    _loc1.initTexts = function ()
    {
        this._btnTabMembers.label = this.api.lang.getText("GUILD_MEMBERS");
        this._btnTabBoosts.label = this.api.lang.getText("GUILD_BOOSTS");
        this._btnTabTaxCollectors.label = this.api.lang.getText("GUILD_TAXCOLLECTORS");
        this._btnTabMountParks.label = this.api.lang.getText("MOUNT_PARK");
        this._btnTabGuildHouses.label = this.api.lang.getText("HOUSES_WORD");
        this._lblXP.text = this.api.lang.getText("EXPERIMENT");
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnTabMembers.addEventListener("click", this);
        this._btnTabBoosts.addEventListener("click", this);
        this._btnTabTaxCollectors.addEventListener("click", this);
        this._btnTabMountParks.addEventListener("click", this);
        this._btnTabGuildHouses.addEventListener("click", this);
        this.api.datacenter.Player.guildInfos.addEventListener("modelChanged", this);
        this._pbXP.addEventListener("over", this);
        this._pbXP.addEventListener("out", this);
    };
    _loc1.initData = function ()
    {
        var _loc2 = this.api.datacenter.Player.guildInfos;
        var _loc3 = _loc2.emblem;
        this._eEmblem.backID = _loc3.backID;
        this._eEmblem.backColor = _loc3.backColor;
        this._eEmblem.upID = _loc3.upID;
        this._eEmblem.upColor = _loc3.upColor;
        this._winBg.title = this.api.lang.getText("GUILD") + " \'" + _loc2.name + "\'";
        this.api.network.Guild.getInfosGeneral();
    };
    _loc1.updateCurrentTabInformations = function ()
    {
        this._mcTabViewer.removeMovieClip();
        switch (this._sCurrentTab)
        {
            case "Members":
            {
                this.attachMovie("GuildMembersViewer", "_mcTabViewer", this.getNextHighestDepth(), {_x: this._mcPlacer._x, _y: this._mcPlacer._y});
                this.api.datacenter.Player.guildInfos.members.removeAll();
                this.api.network.Guild.getInfosMembers();
                break;
            } 
            case "Boosts":
            {
                this.attachMovie("GuildBoostsViewer", "_mcTabViewer", this.getNextHighestDepth(), {_x: this._mcPlacer._x, _y: this._mcPlacer._y});
                this.api.network.Guild.getInfosBoosts();
                break;
            } 
            case "TaxCollectors":
            {
                this.attachMovie("TaxCollectorsViewer", "_mcTabViewer", this.getNextHighestDepth(), {_x: this._mcPlacer._x, _y: this._mcPlacer._y});
                this.api.datacenter.Player.guildInfos.taxCollectors.removeAll();
                this.api.network.Guild.getInfosTaxCollector();
                break;
            } 
            case "MountParks":
            {
                this.attachMovie("GuildMountParkViewer", "_mcTabViewer", this.getNextHighestDepth(), {_x: this._mcPlacer._x, _y: this._mcPlacer._y});
                this.api.network.Guild.getInfosMountPark();
                break;
            } 
            case "GuildHouses":
            {
                this.attachMovie("GuildHousesViewer", "_mcTabViewer", this.getNextHighestDepth(), {_x: this._mcPlacer._x, _y: this._mcPlacer._y});
                this.api.network.Guild.getInfosGuildHouses();
                break;
            } 
        } // End of switch
    };
    _loc1.setCurrentTab = function (sNewTab)
    {
        if (this._sCurrentTab == "TaxCollectors")
        {
            this.api.network.Guild.leaveTaxInterface();
        } // end if
        var _loc3 = this["_btnTab" + this._sCurrentTab];
        var _loc4 = this["_btnTab" + sNewTab];
        _loc3.selected = true;
        _loc3.enabled = true;
        _loc4.selected = false;
        _loc4.enabled = false;
        this._sCurrentTab = sNewTab;
        this.updateCurrentTabInformations();
    };
    _loc1.checkIfLocalPlayerIsDefender = function ()
    {
        var _loc2 = this.api.datacenter.Player.guildInfos;
        if (_loc2.isLocalPlayerDefender)
        {
            this.api.network.Guild.leaveTaxCollector(_loc2.defendedTaxCollectorID);
            this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"), this.api.lang.getText("AUTO_DISJOIN_TAX"), "ERROR_BOX");
        } // end if
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
            case "_btnTabMembers":
            {
                this.setCurrentTab("Members");
                break;
            } 
            case "_btnTabBoosts":
            {
                if (this.api.datacenter.Player.guildInfos.isValid)
                {
                    this.setCurrentTab("Boosts");
                }
                else
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"), "ERROR_BOX");
                    oEvent.target.selected = true;
                } // end else if
                break;
            } 
            case "_btnTabTaxCollectors":
            {
                if (this.api.datacenter.Player.guildInfos.isValid)
                {
                    this.setCurrentTab("TaxCollectors");
                }
                else
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"), "ERROR_BOX");
                    oEvent.target.selected = true;
                } // end else if
                break;
            } 
            case "_btnTabMountParks":
            {
                if (this.api.datacenter.Player.guildInfos.isValid)
                {
                    this.setCurrentTab("MountParks");
                }
                else
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"), "ERROR_BOX");
                    oEvent.target.selected = true;
                } // end else if
                break;
            } 
            case "_btnTabGuildHouses":
            {
                if (this.api.datacenter.Player.guildInfos.isValid)
                {
                    this.setCurrentTab("GuildHouses");
                }
                else
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"), "ERROR_BOX");
                    oEvent.target.selected = true;
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_pbXP":
            {
                this.gapi.showTooltip(new ank.utils.ExtendedString(this._pbXP.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + new ank.utils.ExtendedString(this._pbXP.maximum).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3), this._pbXP, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.modelChanged = function (oEvent)
    {
        switch (oEvent.eventName)
        {
            case "general":
            {
                var _loc3 = this.api.datacenter.Player.guildInfos;
                this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + _loc3.level;
                this._pbXP.minimum = _loc3.xpmin;
                this._pbXP.maximum = _loc3.xpmax;
                this._pbXP.value = _loc3.xp;
                this._pbXP.onRollOver = function ()
                {
                    this._parent.gapi.showTooltip(this.value + " / " + this.maximum, this, -20);
                };
                this._pbXP.onRollOut = function ()
                {
                    this._parent.gapi.hideTooltip();
                };
                if (_loc3.isValid)
                {
                    this._y = 0;
                    this._mcCaution._visible = this._lblValid._visible = false;
                }
                else
                {
                    this._y = -20;
                    this._mcCaution._visible = this._lblValid._visible = true;
                    this._lblValid.text = this.api.lang.getText("GUILD_INVALID_INFOS");
                } // end else if
                break;
            } 
            case "members":
            {
                if (this._sCurrentTab == "Members")
                {
                    this._mcTabViewer.members = this.api.datacenter.Player.guildInfos.members;
                } // end if
                break;
            } 
            case "boosts":
            {
                if (this._sCurrentTab == "Boosts")
                {
                    this._mcTabViewer.updateData();
                } // end if
                break;
            } 
            case "taxcollectors":
            {
                if (this._sCurrentTab == "TaxCollectors")
                {
                    this._mcTabViewer.taxCollectors = this.api.datacenter.Player.guildInfos.taxCollectors;
                } // end if
                break;
            } 
            case "noboosts":
            case "notaxcollectors":
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"), "ERROR_BOX");
                this.setCurrentTab("Members");
                break;
            } 
            case "mountParks":
            {
                if (this._sCurrentTab == "MountParks")
                {
                    this._mcTabViewer.mountParks = this.api.datacenter.Player.guildInfos.mountParks;
                } // end if
                break;
            } 
            case "houses":
            {
                if (this._sCurrentTab == "GuildHouses")
                {
                    this._mcTabViewer.houses = this.api.datacenter.Player.guildInfos.houses;
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("currentTab", function ()
    {
    }, _loc1.__set__currentTab);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Guild = function ()
    {
        super();
    }).CLASS_NAME = "Guild";
    _loc1._sCurrentTab = "Members";
} // end if
#endinitclip
