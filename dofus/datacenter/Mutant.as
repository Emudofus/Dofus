// Action script...

// [Initial MovieClip Action of sprite 20857]
#initclip 122
if (!dofus.datacenter.Mutant)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Mutant = function (sID, clipClass, sGfxFile, cellNum, dir, gfxID, bShowIsPlayer)
    {
        super();
        this._bShowIsPlayer = bShowIsPlayer != undefined ? (bShowIsPlayer) : (false);
        this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID);
    }).prototype;
    _loc1.__get__name = function ()
    {
        if (!this._bShowIsPlayer)
        {
            return (this.monsterName);
        }
        else
        {
            return (this._sPlayerName);
        } // end else if
    };
    _loc1.__set__monsterID = function (n)
    {
        this._nMonsterID = n;
        //return (this.monsterID());
    };
    _loc1.__get__monsterID = function ()
    {
        return (this._nMonsterID);
    };
    _loc1.__set__playerName = function (n)
    {
        this._sPlayerName = n;
        //return (this.playerName());
    };
    _loc1.__get__playerName = function ()
    {
        return (this._sPlayerName);
    };
    _loc1.__get__monsterName = function ()
    {
        return (this.api.lang.getMonstersText(this._nMonsterID).n);
    };
    _loc1.__get__alignment = function ()
    {
        return (new dofus.datacenter.Alignment());
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
        return (this.api.lang.getMonstersText(this._nMonsterID)["g" + this._nPowerLevel].l);
    };
    _loc1.__get__resistances = function ()
    {
        return (this.api.lang.getMonstersText(this._nMonsterID)["g" + this._nPowerLevel].r);
    };
    _loc1.__set__showIsPlayer = function (b)
    {
        this._bShowIsPlayer = b;
        //return (this.showIsPlayer());
    };
    _loc1.__get__showIsPlayer = function ()
    {
        return (this._bShowIsPlayer);
    };
    _loc1.addProperty("showIsPlayer", _loc1.__get__showIsPlayer, _loc1.__set__showIsPlayer);
    _loc1.addProperty("monsterID", _loc1.__get__monsterID, _loc1.__set__monsterID);
    _loc1.addProperty("powerLevel", _loc1.__get__powerLevel, _loc1.__set__powerLevel);
    _loc1.addProperty("playerName", _loc1.__get__playerName, _loc1.__set__playerName);
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("resistances", _loc1.__get__resistances, function ()
    {
    });
    _loc1.addProperty("Level", _loc1.__get__Level, function ()
    {
    });
    _loc1.addProperty("alignment", _loc1.__get__alignment, function ()
    {
    });
    _loc1.addProperty("monsterName", _loc1.__get__monsterName, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
