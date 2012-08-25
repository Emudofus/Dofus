// Action script...

// [Initial MovieClip Action of sprite 20868]
#initclip 133
if (!dofus.datacenter.Creature)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Creature = function (sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super();
        this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID);
    }).prototype;
    _loc1.__set__name = function (nNameID)
    {
        this._nNameID = Number(nNameID);
        //return (this.name());
    };
    _loc1.__get__name = function ()
    {
        return (this.api.lang.getMonstersText(this._nNameID).n);
    };
    _loc1.__set__powerLevel = function (nPowerLevel)
    {
        this._nPowerLevel = Number(nPowerLevel);
        //return (this.powerLevel());
    };
    _loc1.__get__powerLevel = function ()
    {
        return (this._nPowerLevel);
    };
    _loc1.__get__Level = function ()
    {
        return (this.api.lang.getMonstersText(this._nNameID)["g" + this._nPowerLevel].l);
    };
    _loc1.__set__resistances = function (a)
    {
        this._resistances = a;
        //return (this.resistances());
    };
    _loc1.__get__resistances = function ()
    {
        if (this._resistances)
        {
            return (this._resistances);
        } // end if
        var _loc2 = this.api.lang.getMonstersText(this._nNameID)["g" + this._nPowerLevel].r;
        _loc2[5] = _loc2[5] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PA_LOST_PROBABILITY);
        _loc2[6] = _loc2[6] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PM_LOST_PROBABILITY);
        return (_loc2);
    };
    _loc1.__get__alignment = function ()
    {
        return (new dofus.datacenter.Alignment(this.api.lang.getMonstersText(this._nNameID).a, 0));
    };
    _loc1.addProperty("powerLevel", _loc1.__get__powerLevel, _loc1.__set__powerLevel);
    _loc1.addProperty("resistances", _loc1.__get__resistances, _loc1.__set__resistances);
    _loc1.addProperty("name", _loc1.__get__name, _loc1.__set__name);
    _loc1.addProperty("alignment", _loc1.__get__alignment, function ()
    {
    });
    _loc1.addProperty("Level", _loc1.__get__Level, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    _loc1._sStartAnimation = "appear";
} // end if
#endinitclip
