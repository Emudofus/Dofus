// Action script...

// [Initial MovieClip Action of sprite 20759]
#initclip 24
if (!dofus.datacenter.Conquest)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Conquest = function ()
    {
        super();
        this.clear();
        mx.events.EventDispatcher.initialize(this);
    }).prototype;
    _loc1.clear = function ()
    {
        this._eaPlayers = new ank.utils.ExtendedArray();
        this._eaAttackers = new ank.utils.ExtendedArray();
    };
    _loc1.__get__alignBonus = function ()
    {
        return (this._cbdAlignBonus);
    };
    _loc1.__set__alignBonus = function (cbd)
    {
        this._cbdAlignBonus = cbd;
        this.dispatchEvent({type: "bonusChanged"});
        //return (this.alignBonus());
    };
    _loc1.__get__alignMalus = function ()
    {
        return (this._cbdAlignMalus);
    };
    _loc1.__set__alignMalus = function (cbd)
    {
        this._cbdAlignMalus = cbd;
        this.dispatchEvent({type: "bonusChanged"});
        //return (this.alignMalus());
    };
    _loc1.__get__rankMultiplicator = function ()
    {
        return (this._cbdRankMultiplicator);
    };
    _loc1.__set__rankMultiplicator = function (cbd)
    {
        this._cbdRankMultiplicator = cbd;
        this.dispatchEvent({type: "bonusChanged"});
        //return (this.rankMultiplicator());
    };
    _loc1.__get__players = function ()
    {
        return (this._eaPlayers);
    };
    _loc1.__set__players = function (value)
    {
        this._eaPlayers = value;
        //return (this.players());
    };
    _loc1.__get__attackers = function ()
    {
        return (this._eaAttackers);
    };
    _loc1.__set__attackers = function (value)
    {
        this._eaAttackers = value;
        //return (this.attackers());
    };
    _loc1.__get__worldDatas = function ()
    {
        return (this._cwdDatas);
    };
    _loc1.__set__worldDatas = function (value)
    {
        this._cwdDatas = value;
        this.dispatchEvent({type: "worldDataChanged", value: value});
        //return (this.worldDatas());
    };
    _loc1.addProperty("attackers", _loc1.__get__attackers, _loc1.__set__attackers);
    _loc1.addProperty("alignMalus", _loc1.__get__alignMalus, _loc1.__set__alignMalus);
    _loc1.addProperty("players", _loc1.__get__players, _loc1.__set__players);
    _loc1.addProperty("alignBonus", _loc1.__get__alignBonus, _loc1.__set__alignBonus);
    _loc1.addProperty("worldDatas", _loc1.__get__worldDatas, _loc1.__set__worldDatas);
    _loc1.addProperty("rankMultiplicator", _loc1.__get__rankMultiplicator, _loc1.__set__rankMultiplicator);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
