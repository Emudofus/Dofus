// Action script...

// [Initial MovieClip Action of sprite 20949]
#initclip 214
if (!dofus.datacenter.Game)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Game = function ()
    {
        super();
        this.initialize();
    }).prototype;
    _loc1.__set__playerCount = function (nPlayerCount)
    {
        this._nPlayerCount = Number(nPlayerCount);
        //return (this.playerCount());
    };
    _loc1.__get__playerCount = function ()
    {
        return (this._nPlayerCount);
    };
    _loc1.__set__currentPlayerID = function (sCurrentPlayerID)
    {
        this._sCurrentPlayerID = sCurrentPlayerID;
        //return (this.currentPlayerID());
    };
    _loc1.__get__currentPlayerID = function ()
    {
        return (this._sCurrentPlayerID);
    };
    _loc1.__set__lastPlayerID = function (sLastPlayerID)
    {
        this._sLastPlayerID = sLastPlayerID;
        //return (this.lastPlayerID());
    };
    _loc1.__get__lastPlayerID = function ()
    {
        return (this._sLastPlayerID);
    };
    _loc1.__set__state = function (nState)
    {
        this._nState = Number(nState);
        this.dispatchEvent({type: "stateChanged", value: this._nState});
        //return (this.state());
    };
    _loc1.__get__state = function ()
    {
        return (this._nState);
    };
    _loc1.__set__fightType = function (nFightType)
    {
        this._nFightType = nFightType;
        //return (this.fightType());
    };
    _loc1.__get__fightType = function ()
    {
        return (this._nFightType);
    };
    _loc1.__set__isSpectator = function (bSpectator)
    {
        this._bSpectator = bSpectator;
        //return (this.isSpectator());
    };
    _loc1.__get__isSpectator = function ()
    {
        return (this._bSpectator);
    };
    _loc1.__set__turnSequence = function (aTurnSequence)
    {
        this._aTurnSequence = aTurnSequence;
        //return (this.turnSequence());
    };
    _loc1.__get__turnSequence = function ()
    {
        return (this._aTurnSequence);
    };
    _loc1.__set__results = function (oResults)
    {
        this._oResults = oResults;
        //return (this.results());
    };
    _loc1.__get__results = function ()
    {
        return (this._oResults);
    };
    _loc1.__set__isInCreaturesMode = function (bInCreaturesMode)
    {
        this._bInCreaturesMode = bInCreaturesMode;
        //return (this.isInCreaturesMode());
    };
    _loc1.__get__isInCreaturesMode = function ()
    {
        return (this._bInCreaturesMode);
    };
    _loc1.__set__isRunning = function (bRunning)
    {
        this._bRunning = bRunning;
        //return (this.isRunning());
    };
    _loc1.__get__isRunning = function ()
    {
        return (this._bRunning);
    };
    _loc1.__get__isFight = function ()
    {
        return (this._nState > 1 && this._nState != undefined);
    };
    _loc1.__get__interactionType = function ()
    {
        return (this._nInteractionType);
    };
    _loc1.initialize = function ()
    {
        mx.events.EventDispatcher.initialize(this);
        this._bRunning = false;
        this._nPlayerCount = 0;
        this._sCurrentPlayerID = null;
        this._sLastPlayerID = null;
        this._nState = 0;
        this._aTurnSequence = new Array();
        this._oResults = new Object();
        this._nInteractionType = 0;
        this._bInCreaturesMode = false;
    };
    _loc1.setInteractionType = function (sType)
    {
        switch (sType)
        {
            case "move":
            {
                this._nInteractionType = 1;
                break;
            } 
            case "spell":
            {
                this._nInteractionType = 2;
                break;
            } 
            case "cc":
            {
                this._nInteractionType = 3;
                break;
            } 
            case "place":
            {
                this._nInteractionType = 4;
                break;
            } 
            case "target":
            {
                this._nInteractionType = 5;
                break;
            } 
            case "flag":
            {
                this._nInteractionType = 6;
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("turnSequence", _loc1.__get__turnSequence, _loc1.__set__turnSequence);
    _loc1.addProperty("state", _loc1.__get__state, _loc1.__set__state);
    _loc1.addProperty("lastPlayerID", _loc1.__get__lastPlayerID, _loc1.__set__lastPlayerID);
    _loc1.addProperty("isSpectator", _loc1.__get__isSpectator, _loc1.__set__isSpectator);
    _loc1.addProperty("isRunning", _loc1.__get__isRunning, _loc1.__set__isRunning);
    _loc1.addProperty("results", _loc1.__get__results, _loc1.__set__results);
    _loc1.addProperty("currentPlayerID", _loc1.__get__currentPlayerID, _loc1.__set__currentPlayerID);
    _loc1.addProperty("isInCreaturesMode", _loc1.__get__isInCreaturesMode, _loc1.__set__isInCreaturesMode);
    _loc1.addProperty("playerCount", _loc1.__get__playerCount, _loc1.__set__playerCount);
    _loc1.addProperty("fightType", _loc1.__get__fightType, _loc1.__set__fightType);
    _loc1.addProperty("isFight", _loc1.__get__isFight, function ()
    {
    });
    _loc1.addProperty("interactionType", _loc1.__get__interactionType, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    _loc1._bRunning = false;
} // end if
#endinitclip
