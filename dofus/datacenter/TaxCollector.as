// Action script...

// [Initial MovieClip Action of sprite 20672]
#initclip 193
if (!dofus.datacenter.TaxCollector)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.TaxCollector = function (sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super();
        this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID);
    }).prototype;
    _loc1.__set__name = function (sName)
    {
        this._sName = sName;
        //return (this.name());
    };
    _loc1.__get__name = function ()
    {
        return (this._sName);
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
    _loc1.__set__emblem = function (oEmblem)
    {
        this._oEmblem = oEmblem;
        //return (this.emblem());
    };
    _loc1.__get__emblem = function ()
    {
        return (this._oEmblem);
    };
    _loc1.__set__resistances = function (aResistances)
    {
        this._aResistances = aResistances;
        //return (this.resistances());
    };
    _loc1.__get__resistances = function ()
    {
        return (this._aResistances);
    };
    _loc1.addProperty("emblem", _loc1.__get__emblem, _loc1.__set__emblem);
    _loc1.addProperty("resistances", _loc1.__get__resistances, _loc1.__set__resistances);
    _loc1.addProperty("name", _loc1.__get__name, _loc1.__set__name);
    _loc1.addProperty("guildName", _loc1.__get__guildName, _loc1.__set__guildName);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
