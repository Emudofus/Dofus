// Action script...

// [Initial MovieClip Action of sprite 20480]
#initclip 1
if (!dofus.datacenter.FightInfos)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.FightInfos = function (nID, nDuration)
    {
        super();
        this.initialize(nID, nDuration);
    }).prototype;
    _loc1.__get__id = function ()
    {
        return (this._nID);
    };
    _loc1.__get__durationString = function ()
    {
        return (this.api.kernel.GameManager.getDurationString(this.duration));
    };
    _loc1.__get__hasTeamPlayers = function ()
    {
        return (this._eaTeam1Players != undefined && this._eaTeam2Players != undefined);
    };
    _loc1.__get__team1IconFile = function ()
    {
        return (dofus.Constants.getTeamFileFromType(this._nTeam1Type, this._nTeam1AlignmentIndex));
    };
    _loc1.__get__team1Count = function ()
    {
        return (this._nTeam1Count);
    };
    _loc1.__get__team1Players = function ()
    {
        return (this._eaTeam1Players);
    };
    _loc1.__get__team1Level = function ()
    {
        var _loc2 = 0;
        for (var k in this._eaTeam1Players)
        {
            _loc2 = _loc2 + this._eaTeam1Players[k].level;
        } // end of for...in
        return (_loc2);
    };
    _loc1.__get__team2IconFile = function ()
    {
        return (dofus.Constants.getTeamFileFromType(this._nTeam2Type, this._nTeam2AlignmentIndex));
    };
    _loc1.__get__team2Count = function ()
    {
        return (this._nTeam2Count);
    };
    _loc1.__get__team2Players = function ()
    {
        return (this._eaTeam2Players);
    };
    _loc1.__get__team2Level = function ()
    {
        var _loc2 = 0;
        for (var k in this._eaTeam2Players)
        {
            _loc2 = _loc2 + this._eaTeam2Players[k].level;
        } // end of for...in
        return (_loc2);
    };
    _loc1.initialize = function (nID, nDuration)
    {
        this.api = _global.API;
        this._nID = nID;
        this.duration = nDuration;
    };
    _loc1.addTeam = function (nIndex, nType, nAlignmentIndex, nCount)
    {
        switch (nIndex)
        {
            case 1:
            {
                this._nTeam1Type = nType;
                this._nTeam1AlignmentIndex = nAlignmentIndex;
                this._nTeam1Count = nCount;
                break;
            } 
            case 2:
            {
                this._nTeam2Type = nType;
                this._nTeam2AlignmentIndex = nAlignmentIndex;
                this._nTeam2Count = nCount;
                break;
            } 
        } // End of switch
    };
    _loc1.addPlayers = function (nIndex, eaPlayers)
    {
        switch (nIndex)
        {
            case 1:
            {
                this._eaTeam1Players = eaPlayers;
                break;
            } 
            case 2:
            {
                this._eaTeam2Players = eaPlayers;
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("team2Players", _loc1.__get__team2Players, function ()
    {
    });
    _loc1.addProperty("team1Count", _loc1.__get__team1Count, function ()
    {
    });
    _loc1.addProperty("team1IconFile", _loc1.__get__team1IconFile, function ()
    {
    });
    _loc1.addProperty("team1Level", _loc1.__get__team1Level, function ()
    {
    });
    _loc1.addProperty("team1Players", _loc1.__get__team1Players, function ()
    {
    });
    _loc1.addProperty("team2IconFile", _loc1.__get__team2IconFile, function ()
    {
    });
    _loc1.addProperty("team2Level", _loc1.__get__team2Level, function ()
    {
    });
    _loc1.addProperty("team2Count", _loc1.__get__team2Count, function ()
    {
    });
    _loc1.addProperty("durationString", _loc1.__get__durationString, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    _loc1.addProperty("hasTeamPlayers", _loc1.__get__hasTeamPlayers, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
