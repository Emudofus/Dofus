// Action script...

// [Initial MovieClip Action of sprite 20768]
#initclip 33
if (!dofus.datacenter.House)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.House = function (nID)
    {
        super();
        this.initialize(nID);
    }).prototype;
    _loc1.__get__id = function ()
    {
        return (this._nID);
    };
    _loc1.__get__name = function ()
    {
        return (this.api.lang.fetchString(this._sName));
    };
    _loc1.__get__description = function ()
    {
        return (this.api.lang.fetchString(this._sDescription));
    };
    _loc1.__set__price = function (nPrice)
    {
        this._nPrice = Number(nPrice);
        //return (this.price());
    };
    _loc1.__get__price = function ()
    {
        return (this._nPrice);
    };
    _loc1.__set__localOwner = function (bLocalOwner)
    {
        this._bLocalOwner = bLocalOwner;
        //return (this.localOwner());
    };
    _loc1.__get__localOwner = function ()
    {
        return (this._bLocalOwner);
    };
    _loc1.__set__ownerName = function (sOwnerName)
    {
        this._sOwnerName = sOwnerName;
        //return (this.ownerName());
    };
    _loc1.__get__ownerName = function ()
    {
        if (typeof(this._sOwnerName) == "string")
        {
            if (this._sOwnerName.length > 0)
            {
                return (this._sOwnerName);
            } // end if
        } // end if
        return (null);
    };
    _loc1.__set__guildName = function (sGuildName)
    {
        this._sGuildName = sGuildName;
        this.dispatchEvent({type: "guild", value: this});
        //return (this.guildName());
    };
    _loc1.__get__guildName = function ()
    {
        if (typeof(this._sGuildName) == "string")
        {
            if (this._sGuildName.length > 0)
            {
                return (this._sGuildName);
            } // end if
        } // end if
        return (null);
    };
    _loc1.__set__guildEmblem = function (oGuildEmblem)
    {
        this._oGuildEmblem = oGuildEmblem;
        this.dispatchEvent({type: "guild", value: this});
        //return (this.guildEmblem());
    };
    _loc1.__get__guildEmblem = function ()
    {
        return (this._oGuildEmblem);
    };
    _loc1.__set__guildRights = function (nRights)
    {
        this._nGuildRights = Number(nRights);
        this.dispatchEvent({type: "guild", value: this});
        //return (this.guildRights());
    };
    _loc1.__get__guildRights = function ()
    {
        return (this._nGuildRights);
    };
    _loc1.__set__isForSale = function (bForSale)
    {
        this._bForSale = bForSale;
        this.dispatchEvent({type: "forsale", value: bForSale});
        //return (this.isForSale());
    };
    _loc1.__get__isForSale = function ()
    {
        return (this._bForSale);
    };
    _loc1.__set__isLocked = function (bLocked)
    {
        this._bLocked = bLocked;
        this.dispatchEvent({type: "locked", value: bLocked});
        //return (this.isLocked());
    };
    _loc1.__get__isLocked = function ()
    {
        return (this._bLocked);
    };
    _loc1.__set__isShared = function (bShared)
    {
        this._bShared = bShared;
        this.dispatchEvent({type: "shared", value: bShared});
        //return (this.isShared());
    };
    _loc1.__get__isShared = function ()
    {
        return (this._bShared);
    };
    _loc1.__set__coords = function (pCoords)
    {
        this._pCoords = pCoords;
        //return (this.coords());
    };
    _loc1.__get__coords = function ()
    {
        return (this._pCoords);
    };
    _loc1.__set__skills = function (aSkillsIDs)
    {
        this._aSkills = aSkillsIDs;
        //return (this.skills());
    };
    _loc1.__get__skills = function ()
    {
        return (this._aSkills);
    };
    _loc1.initialize = function (nID)
    {
        this.api = _global.API;
        mx.events.EventDispatcher.initialize(this);
        this._nID = nID;
        var _loc3 = this.api.lang.getHouseText(nID);
        this._sName = _loc3.n;
        this._sDescription = _loc3.d;
    };
    _loc1.hasRight = function (nRight)
    {
        return ((this._nGuildRights & nRight) == nRight);
    };
    _loc1.getHumanReadableRightsList = function ()
    {
        var _loc2 = new ank.utils.ExtendedArray();
        var _loc3 = 1;
        
        while (_loc3 = _loc3 * 2, _loc3 < 8192)
        {
            if (this.hasRight(_loc3))
            {
                _loc2.push({id: _loc3, label: this.api.lang.getText("GUILD_HOUSE_RIGHT_" + _loc3)});
            } // end if
        } // end while
        return (_loc2);
    };
    _loc1.addProperty("guildEmblem", _loc1.__get__guildEmblem, _loc1.__set__guildEmblem);
    _loc1.addProperty("isShared", _loc1.__get__isShared, _loc1.__set__isShared);
    _loc1.addProperty("guildRights", _loc1.__get__guildRights, _loc1.__set__guildRights);
    _loc1.addProperty("description", _loc1.__get__description, function ()
    {
    });
    _loc1.addProperty("localOwner", _loc1.__get__localOwner, _loc1.__set__localOwner);
    _loc1.addProperty("guildName", _loc1.__get__guildName, _loc1.__set__guildName);
    _loc1.addProperty("price", _loc1.__get__price, _loc1.__set__price);
    _loc1.addProperty("ownerName", _loc1.__get__ownerName, _loc1.__set__ownerName);
    _loc1.addProperty("coords", _loc1.__get__coords, _loc1.__set__coords);
    _loc1.addProperty("skills", _loc1.__get__skills, _loc1.__set__skills);
    _loc1.addProperty("isLocked", _loc1.__get__isLocked, _loc1.__set__isLocked);
    _loc1.addProperty("isForSale", _loc1.__get__isForSale, _loc1.__set__isForSale);
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.datacenter.House = function (nID)
    {
        super();
        this.initialize(nID);
    }).GUILDSHARE_VISIBLE_GUILD_BRIEF = 1;
    (_global.dofus.datacenter.House = function (nID)
    {
        super();
        this.initialize(nID);
    }).GUILDSHARE_DOORSIGN_GUILD = 2;
    (_global.dofus.datacenter.House = function (nID)
    {
        super();
        this.initialize(nID);
    }).GUILDSHARE_DOORSIGN_OTHERS = 4;
    (_global.dofus.datacenter.House = function (nID)
    {
        super();
        this.initialize(nID);
    }).GUILDSHARE_ALLOWDOOR_GUILD = 8;
    (_global.dofus.datacenter.House = function (nID)
    {
        super();
        this.initialize(nID);
    }).GUILDSHARE_FORBIDDOOR_OTHERS = 16;
    (_global.dofus.datacenter.House = function (nID)
    {
        super();
        this.initialize(nID);
    }).GUILDSHARE_ALLOWCHESTS_GUILD = 32;
    (_global.dofus.datacenter.House = function (nID)
    {
        super();
        this.initialize(nID);
    }).GUILDSHARE_FORBIDCHESTS_OTHERS = 64;
    (_global.dofus.datacenter.House = function (nID)
    {
        super();
        this.initialize(nID);
    }).GUILDSHARE_TELEPORT = 128;
    (_global.dofus.datacenter.House = function (nID)
    {
        super();
        this.initialize(nID);
    }).GUILDSHARE_RESPAWN = 256;
    _loc1._bLocalOwner = false;
    _loc1._sOwnerName = new String();
    _loc1._sGuildName = new String();
    _loc1._bForSale = false;
    _loc1._bLocked = false;
    _loc1._bShared = false;
} // end if
#endinitclip
