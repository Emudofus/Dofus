// Action script...

// [Initial MovieClip Action of sprite 20821]
#initclip 86
if (!dofus.datacenter.Server)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Server = function (nID, nState, nCompletion, bCanLog)
    {
        this.initialize(nID, nState, nCompletion, bCanLog);
        this._nCharactersCount = 0;
    }).prototype;
    _loc1.__set__id = function (nID)
    {
        this._nID = nID;
        //return (this.id());
    };
    _loc1.__get__id = function ()
    {
        return (this._nID);
    };
    _loc1.__set__charactersCount = function (nCount)
    {
        this._nCharactersCount = nCount;
        //return (this.charactersCount());
    };
    _loc1.__get__charactersCount = function ()
    {
        return (this._nCharactersCount);
    };
    _loc1.__set__state = function (nState)
    {
        this._nState = nState;
        //return (this.state());
    };
    _loc1.__get__state = function ()
    {
        return (this._nState);
    };
    _loc1.__get__stateStr = function ()
    {
        switch (this._nState)
        {
            case dofus.datacenter.Server.SERVER_OFFLINE:
            {
                return (this.api.lang.getText("SERVER_OFFLINE"));
                break;
            } 
            case dofus.datacenter.Server.SERVER_ONLINE:
            {
                return (this.api.lang.getText("SERVER_ONLINE"));
                break;
            } 
            case dofus.datacenter.Server.SERVER_STARTING:
            {
                return (this.api.lang.getText("SERVER_STARTING"));
                break;
            } 
        } // End of switch
        return ("");
    };
    _loc1.__get__stateStrShort = function ()
    {
        switch (this._nState)
        {
            case dofus.datacenter.Server.SERVER_OFFLINE:
            {
                return (this.api.lang.getText("SERVER_OFFLINE_SHORT"));
                break;
            } 
            case dofus.datacenter.Server.SERVER_ONLINE:
            {
                return (this.api.lang.getText("SERVER_ONLINE_SHORT"));
                break;
            } 
            case dofus.datacenter.Server.SERVER_STARTING:
            {
                return (this.api.lang.getText("SERVER_STARTING_SHORT"));
                break;
            } 
        } // End of switch
        return ("");
    };
    _loc1.__set__canLog = function (bCanLog)
    {
        this._bCanLog = bCanLog;
        //return (this.canLog());
    };
    _loc1.__get__canLog = function ()
    {
        return (this._bCanLog);
    };
    _loc1.__get__label = function ()
    {
        return (this.api.lang.getServerInfos(this._nID).n);
    };
    _loc1.__get__description = function ()
    {
        return (this.api.lang.getServerInfos(this._nID).d);
    };
    _loc1.__get__language = function ()
    {
        return (this.api.lang.getServerInfos(this._nID).l);
    };
    _loc1.__get__population = function ()
    {
        return (Number(this.api.lang.getServerInfos(this._nID).p));
    };
    _loc1.__get__populationStr = function ()
    {
        return (this.api.lang.getServerPopulation(this.population));
    };
    _loc1.__get__community = function ()
    {
        return (Number(this.api.lang.getServerInfos(this._nID).c));
    };
    _loc1.__get__communityStr = function ()
    {
        return (this.api.lang.getServerCommunity(this.community));
    };
    _loc1.__get__date = function ()
    {
        var _loc2 = new Date(Number(this.api.lang.getServerInfos(this._nID).date));
        return (_loc2);
    };
    _loc1.__get__dateStr = function ()
    {
        var _loc2 = new Date(Number(this.api.lang.getServerInfos(this._nID).date));
        return (org.utils.SimpleDateFormatter.formatDate(_loc2, this.api.lang.getConfigText("LONG_DATE_FORMAT"), this.api.config.language));
    };
    _loc1.__get__type = function ()
    {
        return (this.api.lang.getText("SERVER_GAME_TYPE_" + this.api.lang.getServerInfos(this._nID).t));
    };
    _loc1.__get__typeNum = function ()
    {
        return (this.api.lang.getServerInfos(this._nID).t);
    };
    _loc1.isHardcore = function ()
    {
        return (this.typeNum == dofus.datacenter.Server.SERVER_HARDCORE);
    };
    _loc1.initialize = function (nID, nState, nCompletion, bCanLog)
    {
        this.api = _global.API;
        this._nID = nID;
        this._nState = nState;
        this._bCanLog = bCanLog;
        this.completion = nCompletion;
        this.populationWeight = Number(this.api.lang.getServerPopulationWeight(this.population));
    };
    _loc1.isAllowed = function ()
    {
        if (this.api.datacenter.Player.isAuthorized)
        {
            return (true);
        } // end if
        var _loc2 = this.api.lang.getServerInfos(this._nID).rlng;
        if (_loc2 == undefined || (_loc2.length == undefined || (_loc2.length == 0 || this.api.config.skipLanguageVerification)))
        {
            return (true);
        } // end if
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < _loc2.length)
        {
            if (_loc2[_loc3].toUpperCase() == this.api.config.language.toUpperCase())
            {
                return (true);
            } // end if
        } // end while
        return (false);
    };
    _loc1.addProperty("state", _loc1.__get__state, _loc1.__set__state);
    _loc1.addProperty("label", _loc1.__get__label, function ()
    {
    });
    _loc1.addProperty("language", _loc1.__get__language, function ()
    {
    });
    _loc1.addProperty("stateStr", _loc1.__get__stateStr, function ()
    {
    });
    _loc1.addProperty("description", _loc1.__get__description, function ()
    {
    });
    _loc1.addProperty("dateStr", _loc1.__get__dateStr, function ()
    {
    });
    _loc1.addProperty("stateStrShort", _loc1.__get__stateStrShort, function ()
    {
    });
    _loc1.addProperty("population", _loc1.__get__population, function ()
    {
    });
    _loc1.addProperty("populationStr", _loc1.__get__populationStr, function ()
    {
    });
    _loc1.addProperty("community", _loc1.__get__community, function ()
    {
    });
    _loc1.addProperty("charactersCount", _loc1.__get__charactersCount, _loc1.__set__charactersCount);
    _loc1.addProperty("type", _loc1.__get__type, function ()
    {
    });
    _loc1.addProperty("typeNum", _loc1.__get__typeNum, function ()
    {
    });
    _loc1.addProperty("communityStr", _loc1.__get__communityStr, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, _loc1.__set__id);
    _loc1.addProperty("canLog", _loc1.__get__canLog, _loc1.__set__canLog);
    _loc1.addProperty("date", _loc1.__get__date, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.datacenter.Server = function (nID, nState, nCompletion, bCanLog)
    {
        this.initialize(nID, nState, nCompletion, bCanLog);
        this._nCharactersCount = 0;
    }).SERVER_OFFLINE = 0;
    (_global.dofus.datacenter.Server = function (nID, nState, nCompletion, bCanLog)
    {
        this.initialize(nID, nState, nCompletion, bCanLog);
        this._nCharactersCount = 0;
    }).SERVER_ONLINE = 1;
    (_global.dofus.datacenter.Server = function (nID, nState, nCompletion, bCanLog)
    {
        this.initialize(nID, nState, nCompletion, bCanLog);
        this._nCharactersCount = 0;
    }).SERVER_STARTING = 2;
    (_global.dofus.datacenter.Server = function (nID, nState, nCompletion, bCanLog)
    {
        this.initialize(nID, nState, nCompletion, bCanLog);
        this._nCharactersCount = 0;
    }).SERVER_CLASSIC = 0;
    (_global.dofus.datacenter.Server = function (nID, nState, nCompletion, bCanLog)
    {
        this.initialize(nID, nState, nCompletion, bCanLog);
        this._nCharactersCount = 0;
    }).SERVER_HARDCORE = 1;
    (_global.dofus.datacenter.Server = function (nID, nState, nCompletion, bCanLog)
    {
        this.initialize(nID, nState, nCompletion, bCanLog);
        this._nCharactersCount = 0;
    }).SERVER_EVENT = 2;
} // end if
#endinitclip
