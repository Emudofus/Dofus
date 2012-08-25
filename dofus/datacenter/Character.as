// Action script...

// [Initial MovieClip Action of sprite 20807]
#initclip 72
if (!dofus.datacenter.Character)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Character = function (sID, clipClass, sGfxFile, cellNum, dir, gfxID, title)
    {
        super();
        this._title = title;
        this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID);
    }).prototype;
    _loc1.__get__speedModerator = function ()
    {
        return (this.isSlow ? (5.000000E-001) : (this._nSpeedModerator));
    };
    _loc1.__get__Guild = function ()
    {
        return (this._nGuild);
    };
    _loc1.__set__Guild = function (value)
    {
        this._nGuild = Number(value);
        //return (this.Guild());
    };
    _loc1.__get__Sex = function ()
    {
        return (this._nSex);
    };
    _loc1.__set__Sex = function (value)
    {
        this._nSex = Number(value);
        //return (this.Sex());
    };
    _loc1.__get__Aura = function ()
    {
        return (this._nAura);
    };
    _loc1.__set__Aura = function (value)
    {
        this._nAura = Number(value);
        //return (this.Aura());
    };
    _loc1.__get__alignment = function ()
    {
        return (this._oAlignment);
    };
    _loc1.__set__alignment = function (value)
    {
        this._oAlignment = value;
        //return (this.alignment());
    };
    _loc1.__get__Merchant = function ()
    {
        return (this._bMerchant);
    };
    _loc1.__set__Merchant = function (value)
    {
        this._bMerchant = value;
        //return (this.Merchant());
    };
    _loc1.__get__serverID = function ()
    {
        return (this._nServerID);
    };
    _loc1.__set__serverID = function (value)
    {
        this._nServerID = value;
        //return (this.serverID());
    };
    _loc1.__get__Died = function ()
    {
        return (this._bDied);
    };
    _loc1.__set__Died = function (value)
    {
        this._bDied = value;
        //return (this.Died());
    };
    _loc1.__get__rank = function ()
    {
        return (this._oRank);
    };
    _loc1.__set__rank = function (value)
    {
        this._oRank = value;
        //return (this.rank());
    };
    _loc1.__get__multiCraftSkillsID = function ()
    {
        return (this._aMultiCraftSkillsID);
    };
    _loc1.__set__multiCraftSkillsID = function (value)
    {
        this._aMultiCraftSkillsID = value;
        //return (this.multiCraftSkillsID());
    };
    _loc1.__set__guildName = function (sGuildName)
    {
        this._sGuildName = sGuildName;
        //return (this.guildName());
    };
    _loc1.__get__guildName = function ()
    {
        return (this._sGuildName);
    };
    _loc1.__get__title = function ()
    {
        return (this._title);
    };
    _loc1.__set__emblem = function (oEmblem)
    {
        this._oEmblem = oEmblem;
        //return (this.emblem());
    };
    _loc1.__get__emblem = function ()
    {
        return (this._oEmblem);
    };
    _loc1.__set__restrictions = function (nRestrictions)
    {
        this._nRestrictions = Number(nRestrictions);
        //return (this.restrictions());
    };
    _loc1.__get__canBeAssault = function ()
    {
        return ((this._nRestrictions & 1) != 1);
    };
    _loc1.__get__canBeChallenge = function ()
    {
        return ((this._nRestrictions & 2) != 2);
    };
    _loc1.__get__canExchange = function ()
    {
        return ((this._nRestrictions & 4) != 4);
    };
    _loc1.__get__canBeAttack = function ()
    {
        return ((this._nRestrictions & 8) != 8);
    };
    _loc1.__get__forceWalk = function ()
    {
        return ((this._nRestrictions & 16) == 16);
    };
    _loc1.__get__isSlow = function ()
    {
        return ((this._nRestrictions & 32) == 32);
    };
    _loc1.__get__canSwitchInCreaturesMode = function ()
    {
        return ((this._nRestrictions & 64) != 64);
    };
    _loc1.__get__isTomb = function ()
    {
        return ((this._nRestrictions & 128) == 128);
    };
    _loc1.__set__resistances = function (aResistances)
    {
        this._aResistances = aResistances;
        //return (this.resistances());
    };
    _loc1.__get__resistances = function ()
    {
        var _loc2 = new Array();
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._aResistances.length)
        {
            _loc2[_loc3] = this._aResistances[_loc3];
        } // end while
        _loc2[5] = _loc2[5] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PA_LOST_PROBABILITY);
        _loc2[6] = _loc2[6] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PM_LOST_PROBABILITY);
        return (_loc2);
    };
    _loc1.addProperty("alignment", _loc1.__get__alignment, _loc1.__set__alignment);
    _loc1.addProperty("Aura", _loc1.__get__Aura, _loc1.__set__Aura);
    _loc1.addProperty("isTomb", _loc1.__get__isTomb, function ()
    {
    });
    _loc1.addProperty("emblem", _loc1.__get__emblem, _loc1.__set__emblem);
    _loc1.addProperty("resistances", _loc1.__get__resistances, _loc1.__set__resistances);
    _loc1.addProperty("canBeChallenge", _loc1.__get__canBeChallenge, function ()
    {
    });
    _loc1.addProperty("Died", _loc1.__get__Died, _loc1.__set__Died);
    _loc1.addProperty("canBeAttack", _loc1.__get__canBeAttack, function ()
    {
    });
    _loc1.addProperty("title", _loc1.__get__title, function ()
    {
    });
    _loc1.addProperty("serverID", _loc1.__get__serverID, _loc1.__set__serverID);
    _loc1.addProperty("guildName", _loc1.__get__guildName, _loc1.__set__guildName);
    _loc1.addProperty("canExchange", _loc1.__get__canExchange, function ()
    {
    });
    _loc1.addProperty("canBeAssault", _loc1.__get__canBeAssault, function ()
    {
    });
    _loc1.addProperty("forceWalk", _loc1.__get__forceWalk, function ()
    {
    });
    _loc1.addProperty("Sex", _loc1.__get__Sex, _loc1.__set__Sex);
    _loc1.addProperty("Guild", _loc1.__get__Guild, _loc1.__set__Guild);
    _loc1.addProperty("multiCraftSkillsID", _loc1.__get__multiCraftSkillsID, _loc1.__set__multiCraftSkillsID);
    _loc1.addProperty("Merchant", _loc1.__get__Merchant, _loc1.__set__Merchant);
    _loc1.addProperty("rank", _loc1.__get__rank, _loc1.__set__rank);
    _loc1.addProperty("speedModerator", _loc1.__get__speedModerator, function ()
    {
    });
    _loc1.addProperty("canSwitchInCreaturesMode", _loc1.__get__canSwitchInCreaturesMode, function ()
    {
    });
    _loc1.addProperty("restrictions", function ()
    {
    }, _loc1.__set__restrictions);
    _loc1.addProperty("isSlow", _loc1.__get__isSlow, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    _loc1.xtraClipTopAnimations = {staticF: true};
} // end if
#endinitclip
