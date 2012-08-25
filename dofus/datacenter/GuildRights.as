// Action script...

// [Initial MovieClip Action of sprite 20626]
#initclip 147
if (!dofus.datacenter.GuildRights)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.GuildRights = function (nRights)
    {
        super();
        this._nRights = nRights;
    }).prototype;
    _loc1.__get__value = function ()
    {
        return (this._nRights);
    };
    _loc1.__set__value = function (nValue)
    {
        this._nRights = nValue;
        //return (this.value());
    };
    _loc1.__get__isBoss = function ()
    {
        return ((this._nRights & 1) == 1);
    };
    _loc1.__get__canManageBoost = function ()
    {
        return (this.isBoss || (this._nRights & 2) == 2);
    };
    _loc1.__get__canManageRights = function ()
    {
        return (this.isBoss || (this._nRights & 4) == 4);
    };
    _loc1.__get__canInvite = function ()
    {
        return (this.isBoss || (this._nRights & 8) == 8);
    };
    _loc1.__get__canBann = function ()
    {
        return (this.isBoss || (this._nRights & 16) == 16);
    };
    _loc1.__get__canManageXPContitribution = function ()
    {
        return (this.isBoss || (this._nRights & 32) == 32);
    };
    _loc1.__get__canManageRanks = function ()
    {
        return (this.isBoss || (this._nRights & 64) == 64);
    };
    _loc1.__get__canHireTaxCollector = function ()
    {
        return (this.isBoss || (this._nRights & 128) == 128);
    };
    _loc1.__get__canManageOwnXPContitribution = function ()
    {
        return (this.isBoss || (this._nRights & 256) == 256);
    };
    _loc1.__get__canCollect = function ()
    {
        return (this.isBoss || (this._nRights & 512) == 512);
    };
    _loc1.__get__canUseMountPark = function ()
    {
        return (this.isBoss || (this._nRights & 4096) == 4096);
    };
    _loc1.__get__canArrangeMountPark = function ()
    {
        return (this.isBoss || (this._nRights & 8192) == 8192);
    };
    _loc1.__get__canManageOtherMount = function ()
    {
        return (this.isBoss || (this._nRights & 16384) == 16384);
    };
    _loc1.addProperty("canArrangeMountPark", _loc1.__get__canArrangeMountPark, function ()
    {
    });
    _loc1.addProperty("isBoss", _loc1.__get__isBoss, function ()
    {
    });
    _loc1.addProperty("canManageOtherMount", _loc1.__get__canManageOtherMount, function ()
    {
    });
    _loc1.addProperty("canHireTaxCollector", _loc1.__get__canHireTaxCollector, function ()
    {
    });
    _loc1.addProperty("value", _loc1.__get__value, _loc1.__set__value);
    _loc1.addProperty("canManageXPContitribution", _loc1.__get__canManageXPContitribution, function ()
    {
    });
    _loc1.addProperty("canCollect", _loc1.__get__canCollect, function ()
    {
    });
    _loc1.addProperty("canInvite", _loc1.__get__canInvite, function ()
    {
    });
    _loc1.addProperty("canBann", _loc1.__get__canBann, function ()
    {
    });
    _loc1.addProperty("canManageOwnXPContitribution", _loc1.__get__canManageOwnXPContitribution, function ()
    {
    });
    _loc1.addProperty("canUseMountPark", _loc1.__get__canUseMountPark, function ()
    {
    });
    _loc1.addProperty("canManageBoost", _loc1.__get__canManageBoost, function ()
    {
    });
    _loc1.addProperty("canManageRanks", _loc1.__get__canManageRanks, function ()
    {
    });
    _loc1.addProperty("canManageRights", _loc1.__get__canManageRights, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
