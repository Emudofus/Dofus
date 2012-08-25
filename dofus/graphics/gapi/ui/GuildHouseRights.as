// Action script...

// [Initial MovieClip Action of sprite 20571]
#initclip 92
if (!dofus.graphics.gapi.ui.GuildHouseRights)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.GuildHouseRights = function ()
    {
        super();
    }).prototype;
    _loc1.__set__house = function (hHouse)
    {
        this._hHouse = hHouse;
        //return (this.house());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.GuildHouseRights.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.initTexts = function ()
    {
        this._winBackground.title = this.api.lang.getText("GUILD_HOUSE");
        this._lblAddThisHouseToGuildSystem.text = this.api.lang.getText("GUILD_HOUSE_ENABLE_FOR_THIS_HOUSE");
        this._lblGuildHouseNotice.text = this.api.lang.getText("GUILD_HOUSE_NOTICE");
        this._lblDisplayEmblemTitle.text = this.api.lang.getText("GUILD_HOUSE_DISPLAY_EMBLEM_ON_DOOR_TITLE") + ":";
        this._lblDisplayLabelForOthers.text = this.api.lang.getText("GUILD_HOUSE_DISPLAY_EMBLEM_FOR_OTHERS");
        this._lblDisplayLabelForGuild.text = this.api.lang.getText("GUILD_HOUSE_DISPLAY_EMBLEM_FOR_GUILD");
        this._lblHouseAccessTitle.text = this.api.lang.getText("GUILD_HOUSE_HOUSE_ACCESS_TITLE") + ":";
        this._lblAllowGuildToAccessHouse.text = this.api.lang.getText("GUILD_HOUSE_ACCESS_HOUSE_ALLOW_GUILDMATES");
        this._lblDenyOtherToAccessHouse.text = this.api.lang.getText("GUILD_HOUSE_ACCESS_HOUSE_DENY_OTHERS");
        this._lblSafesAccessTitle.text = this.api.lang.getText("GUILD_HOUSE_SAFES_ACCESS_TITLE") + ":";
        this._lblAllowGuildToAccessSafes.text = this.api.lang.getText("GUILD_HOUSE_ACCESS_SAFES_ALLOW_GUILDMATES");
        this._lblDenyOtherToAccessSafes.text = this.api.lang.getText("GUILD_HOUSE_ACCESS_SAFES_DENY_OTHERS");
        this._lblOtherTitle.text = this.api.lang.getText("GUILD_HOUSE_OTHER_TITLE") + ":";
        this._lblAllowRespawn.text = this.api.lang.getText("GUILD_HOUSE_ALLOW_RESPAWN");
        this._lblAllowTeleport.text = this.api.lang.getText("GUILD_HOUSE_ALLOW_TELEPORT");
        this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
        this._btnValidate.label = this.api.lang.getText("VALIDATE");
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnEnableHouseSharing.addEventListener("click", this);
        this._btnShowEmblemForOthers.addEventListener("click", this);
        this._btnShowEmblemForGuild.addEventListener("click", this);
        this._btnAllowGuildToAccessHouse.addEventListener("click", this);
        this._btnDenyOtherToAccessHouse.addEventListener("click", this);
        this._btnAllowGuildToAccessSafes.addEventListener("click", this);
        this._btnDenyOtherToAccessSafes.addEventListener("click", this);
        this._btnAllowRespawn.addEventListener("click", this);
        this._btnAllowTeleport.addEventListener("click", this);
        this._btnCancel.addEventListener("click", this);
        this._btnValidate.addEventListener("click", this);
        this._hHouse.addEventListener("shared", this);
        this._hHouse.addEventListener("guild", this);
    };
    _loc1.initData = function ()
    {
        this.api.network.Houses.state();
    };
    _loc1.update = function ()
    {
        this._btnEnableHouseSharing.selected = this._hHouse.isShared;
        this._btnShowEmblemForGuild.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_DOORSIGN_GUILD);
        this._btnShowEmblemForOthers.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_DOORSIGN_OTHERS);
        this._btnAllowGuildToAccessHouse.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_ALLOWDOOR_GUILD);
        this._btnDenyOtherToAccessHouse.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_FORBIDDOOR_OTHERS);
        this._btnAllowGuildToAccessSafes.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_ALLOWCHESTS_GUILD);
        this._btnDenyOtherToAccessSafes.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_FORBIDCHESTS_OTHERS);
        this._btnAllowRespawn.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_RESPAWN);
        this._btnAllowTeleport.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_TELEPORT);
        this._mcMask._visible = !this._btnEnableHouseSharing.selected;
        this._eEmblem.data = this.api.datacenter.Player.guildInfos.emblem;
    };
    _loc1.validate = function ()
    {
        var _loc2 = 0;
        if (this._btnShowEmblemForGuild.selected)
        {
            _loc2 = _loc2 + dofus.datacenter.House.GUILDSHARE_DOORSIGN_GUILD;
        } // end if
        if (this._btnShowEmblemForOthers.selected)
        {
            _loc2 = _loc2 + dofus.datacenter.House.GUILDSHARE_DOORSIGN_OTHERS;
        } // end if
        if (this._btnAllowGuildToAccessHouse.selected)
        {
            _loc2 = _loc2 + dofus.datacenter.House.GUILDSHARE_ALLOWDOOR_GUILD;
        } // end if
        if (this._btnDenyOtherToAccessHouse.selected)
        {
            _loc2 = _loc2 + dofus.datacenter.House.GUILDSHARE_FORBIDDOOR_OTHERS;
        } // end if
        if (this._btnAllowGuildToAccessSafes.selected)
        {
            _loc2 = _loc2 + dofus.datacenter.House.GUILDSHARE_ALLOWCHESTS_GUILD;
        } // end if
        if (this._btnDenyOtherToAccessSafes.selected)
        {
            _loc2 = _loc2 + dofus.datacenter.House.GUILDSHARE_FORBIDCHESTS_OTHERS;
        } // end if
        if (this._btnAllowRespawn.selected)
        {
            _loc2 = _loc2 + dofus.datacenter.House.GUILDSHARE_RESPAWN;
        } // end if
        if (this._btnAllowTeleport.selected)
        {
            _loc2 = _loc2 + dofus.datacenter.House.GUILDSHARE_TELEPORT;
        } // end if
        this.api.network.Houses.rights(_loc2);
        this.unloadThis();
    };
    _loc1.guild = function (oEvent)
    {
        this.update();
    };
    _loc1.shared = function (oEvent)
    {
        this.update();
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnEnableHouseSharing:
            {
                if (this._btnEnableHouseSharing.selected)
                {
                    this.api.network.Houses.share();
                }
                else
                {
                    this.api.network.Houses.unshare();
                } // end else if
                break;
            } 
            case this._btnValidate:
            {
                this.validate();
                break;
            } 
            case this._btnClose:
            case this._btnCancel:
            {
                this.unloadThis();
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("house", function ()
    {
    }, _loc1.__set__house);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.GuildHouseRights = function ()
    {
        super();
    }).CLASS_NAME = "GuildHouseRights";
} // end if
#endinitclip
