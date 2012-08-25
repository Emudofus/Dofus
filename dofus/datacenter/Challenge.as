// Action script...

// [Initial MovieClip Action of sprite 20974]
#initclip 239
if (!dofus.datacenter.Challenge)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Challenge = function (nID, nFightType)
    {
        super();
        this.initialize(nID, nFightType);
    }).prototype;
    _loc1.initialize = function (nID, nFightType)
    {
        this._nID = nID;
        this._nFightType = nFightType;
        this._teams = new Object();
    };
    _loc1.addTeam = function (t)
    {
        this._teams[t.id] = t;
        t.setChallenge(this);
    };
    _loc1.__get__id = function ()
    {
        return (this._nID);
    };
    _loc1.__get__fightType = function ()
    {
        return (this._nFightType);
    };
    _loc1.__get__teams = function ()
    {
        return (this._teams);
    };
    _loc1.__get__count = function ()
    {
        var _loc2 = 0;
        for (var k in this._teams)
        {
            _loc2 = _loc2 + this._teams[k].count;
        } // end of for...in
        return (_loc2);
    };
    _loc1.addProperty("count", _loc1.__get__count, function ()
    {
    });
    _loc1.addProperty("teams", _loc1.__get__teams, function ()
    {
    });
    _loc1.addProperty("fightType", _loc1.__get__fightType, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
