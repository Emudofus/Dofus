// Action script...

// [Initial MovieClip Action of sprite 20514]
#initclip 35
if (!dofus.datacenter.ConquestZoneData)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.ConquestZoneData = function (id, alignment, fighting, prism, attackable)
    {
        super();
        this._nSubAreaId = id;
        this._nAlignment = alignment;
        this._bFighting = fighting;
        this._nPrismMap = prism;
        this._bAttackable = attackable;
        this.areaName = _global.API.lang.getMapAreaText(Number(_global.API.lang.getMapSubAreaText(this._nSubAreaId).a)).n;
    }).prototype;
    _loc1.__get__id = function ()
    {
        return (this._nSubAreaId);
    };
    _loc1.__get__areaId = function ()
    {
        return (Number(_global.API.lang.getMapSubAreaText(this._nSubAreaId).a));
    };
    _loc1.__get__alignment = function ()
    {
        return (this._nAlignment);
    };
    _loc1.__get__fighting = function ()
    {
        return (this._bFighting);
    };
    _loc1.__get__prism = function ()
    {
        return (this._nPrismMap);
    };
    _loc1.__get__attackable = function ()
    {
        return (this._bAttackable);
    };
    _loc1.isCapturable = function ()
    {
        if (!this._bAttackable)
        {
            return (false);
        } // end if
        if (this.alignment == this.api.datacenter.Player.alignment.index)
        {
            return (false);
        } // end if
        var _loc2 = this.getNearZonesList();
        var _loc3 = this.api.datacenter.Conquest.worldDatas;
        for (var s in _loc2)
        {
            if (_loc3.areas.findFirstItem("id", _loc2[s]).item.alignment == this.api.datacenter.Player.alignment.index)
            {
                return (true);
            } // end if
        } // end of for...in
        return (false);
    };
    _loc1.isVulnerable = function ()
    {
        if (!this._bAttackable)
        {
            return (false);
        } // end if
        if (this.alignment != this.api.datacenter.Player.alignment.index)
        {
            return (false);
        } // end if
        var _loc2 = this.getNearZonesList();
        var _loc3 = this.api.datacenter.Conquest.worldDatas;
        for (var s in _loc2)
        {
            var _loc4 = _loc3.areas.findFirstItem("id", _loc2[s]).item.alignment;
            if (_loc4 != this.api.datacenter.Player.alignment.index && _loc4 > 0)
            {
                return (true);
            } // end if
        } // end of for...in
        return (false);
    };
    _loc1.getNearZonesList = function ()
    {
        return (this.api.lang.getMapSubAreaText(this._nSubAreaId).v);
    };
    _loc1.toString = function ()
    {
        return ("N:" + this.areaName + "/A:" + this.areaId + "/S:" + this.id);
    };
    _loc1.addProperty("fighting", _loc1.__get__fighting, function ()
    {
    });
    _loc1.addProperty("alignment", _loc1.__get__alignment, function ()
    {
    });
    _loc1.addProperty("attackable", _loc1.__get__attackable, function ()
    {
    });
    _loc1.addProperty("prism", _loc1.__get__prism, function ()
    {
    });
    _loc1.addProperty("areaId", _loc1.__get__areaId, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
