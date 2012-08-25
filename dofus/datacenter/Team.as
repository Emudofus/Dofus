// Action script...

// [Initial MovieClip Action of sprite 20729]
#initclip 250
if (!dofus.datacenter.Team)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Team = function (sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment)
    {
        super();
        this.initialize(sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment);
    }).prototype;
    _loc1.initialize = function (sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment)
    {
        super.initialize(sID, fClipClass, sGfxFile, nCellNum);
        this.color1 = nColor1;
        this._nType = Number(nType);
        this._oAlignment = new dofus.datacenter.Alignment(Number(nAlignment));
        this._aPlayers = new Object();
        this.options = new Object();
    };
    _loc1.setChallenge = function (oChallenge)
    {
        this._oChallenge = oChallenge;
    };
    _loc1.addPlayer = function (oPlayer)
    {
        this._aPlayers[oPlayer.id] = oPlayer;
    };
    _loc1.removePlayer = function (nID)
    {
        delete this._aPlayers[nID];
    };
    _loc1.__get__type = function ()
    {
        return (this._nType);
    };
    _loc1.__get__alignment = function ()
    {
        return (this._oAlignment);
    };
    _loc1.__get__name = function ()
    {
        var _loc2 = new String();
        for (var k in this._aPlayers)
        {
            _loc2 = _loc2 + ("\n" + this._aPlayers[k].name + "(" + this._aPlayers[k].level + ")");
        } // end of for...in
        return (_loc2.substr(1));
    };
    _loc1.__get__totalLevel = function ()
    {
        var _loc2 = 0;
        for (var k in this._aPlayers)
        {
            _loc2 = _loc2 + Number(this._aPlayers[k].level);
        } // end of for...in
        return (_loc2);
    };
    _loc1.__get__count = function ()
    {
        var _loc2 = 0;
        for (var k in this._aPlayers)
        {
            ++_loc2;
        } // end of for...in
        return (_loc2);
    };
    _loc1.__get__challenge = function ()
    {
        return (this._oChallenge);
    };
    _loc1.__get__enemyTeam = function ()
    {
        var _loc2 = this._oChallenge.teams;
        for (var k in _loc2)
        {
            if (k != this.id)
            {
                var _loc3 = k;
                break;
            } // end if
        } // end of for...in
        return (_loc2[_loc3]);
    };
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("type", _loc1.__get__type, function ()
    {
    });
    _loc1.addProperty("totalLevel", _loc1.__get__totalLevel, function ()
    {
    });
    _loc1.addProperty("enemyTeam", _loc1.__get__enemyTeam, function ()
    {
    });
    _loc1.addProperty("challenge", _loc1.__get__challenge, function ()
    {
    });
    _loc1.addProperty("alignment", _loc1.__get__alignment, function ()
    {
    });
    _loc1.addProperty("count", _loc1.__get__count, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.datacenter.Team = function (sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment)
    {
        super();
        this.initialize(sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment);
    }).OPT_BLOCK_JOINER = "BlockJoiner";
    (_global.dofus.datacenter.Team = function (sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment)
    {
        super();
        this.initialize(sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment);
    }).OPT_BLOCK_SPECTATOR = "BlockSpectator";
    (_global.dofus.datacenter.Team = function (sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment)
    {
        super();
        this.initialize(sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment);
    }).OPT_BLOCK_JOINER_EXCEPT_PARTY_MEMBER = "BlockJoinerExceptPartyMember";
    (_global.dofus.datacenter.Team = function (sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment)
    {
        super();
        this.initialize(sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment);
    }).OPT_NEED_HELP = "NeedHelp";
} // end if
#endinitclip
