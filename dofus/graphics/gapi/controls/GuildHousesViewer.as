// Action script...

// [Initial MovieClip Action of sprite 20549]
#initclip 70
if (!dofus.graphics.gapi.controls.GuildHousesViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.GuildHousesViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__houses = function (eaHouses)
    {
        this.updateData(eaHouses);
        //return (this.houses());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.GuildHousesViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.initTexts = function ()
    {
        this._lblDescription.text = this.api.lang.getText("GUILD_HOUSES_LIST");
        this._lblHouse.text = this.api.lang.getText("HOUSE_WORD");
        this._lblOwner.text = this.api.lang.getText("OWNER_WORD");
        this._lblCoordsTitle.text = this.api.lang.getText("COORDINATES");
        this._lblOwnerTitle.text = this.api.lang.getText("OWNER_WORD");
        this._lblSkillsTitle.text = this.api.lang.getText("SKILLS");
        this._lblRightsTitle.text = this.api.lang.getText("RIGHTS");
        this._lblSelectHouse.text = this.api.lang.getText("SELECT_A_HOUSE");
        this._btnTeleport.label = this.api.lang.getText("JOIN_SMALL");
    };
    _loc1.addListeners = function ()
    {
        this._lstHouses.addEventListener("itemSelected", this);
        this._btnTeleport.addEventListener("click", this);
    };
    _loc1.updateData = function (eaHouses)
    {
        this._lstHouses.dataProvider = eaHouses;
    };
    _loc1.itemSelected = function (oEvent)
    {
        this._hSelectedHouse = (dofus.datacenter.House)(oEvent.row.item);
        this._lblHouseName.text = this._hSelectedHouse.name;
        this._lblHouseCoords.text = this._hSelectedHouse.coords.x + ";" + this._hSelectedHouse.coords.y;
        this._lblHouseOwner.text = this._hSelectedHouse.ownerName;
        var _loc3 = new ank.utils.ExtendedArray();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this._hSelectedHouse.skills.length)
        {
            var _loc5 = new dofus.datacenter.Skill(this._hSelectedHouse.skills[_loc4]);
            if (!_global.isNaN(_loc5.id))
            {
                _loc3.push({id: _loc5.id, label: _loc5.description});
            } // end if
        } // end while
        this._lstSkills.dataProvider = _loc3;
        this._lstRights.dataProvider = this._hSelectedHouse.getHumanReadableRightsList();
        this._btnTeleport._visible = this._hSelectedHouse.hasRight(dofus.datacenter.House.GUILDSHARE_TELEPORT);
        if (!this._btnTeleport._visible)
        {
            if (!this._mcHouseIcon.moved)
            {
                this._mcHouseIcon.moved = true;
                this._mcHouseIcon._y = this._mcHouseIcon._y + this._btnTeleport._height / 2;
            } // end if
        } // end if
        this._mcMask._visible = false;
        this._lblSelectHouse._visible = false;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnTeleport:
            {
                if (this._hSelectedHouse == null)
                {
                    return;
                } // end if
                if (!this._hSelectedHouse.hasRight(dofus.datacenter.House.GUILDSHARE_TELEPORT))
                {
                    return;
                } // end if
                this.api.network.Guild.teleportToGuildHouse(this._hSelectedHouse.id);
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnTeleport:
            {
                this.gapi.showTooltip(this.api.lang.getText("GUILD_HOUSE_TELEPORT_TOOLTIP"), this._btnTeleport, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("houses", function ()
    {
    }, _loc1.__set__houses);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.GuildHousesViewer = function ()
    {
        super();
    }).CLASS_NAME = "GuildHousesViewer";
} // end if
#endinitclip
