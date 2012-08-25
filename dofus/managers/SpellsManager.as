// Action script...

// [Initial MovieClip Action of sprite 20540]
#initclip 61
if (!dofus.managers.SpellsManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.SpellsManager = function (d)
    {
        this.initialize(d);
    }).prototype;
    _loc1.initialize = function (d)
    {
        this._localPlayerData = d;
        this.api = d.api;
        this.clear();
        this._oSpellsModificators = new Object();
        mx.events.EventDispatcher.initialize(this);
    };
    _loc1.clear = function ()
    {
        this._aSpellsCountByTurn = new Array();
        this._oSpellsCountByTurn_Counter = new Object();
        this._aSpellsCountByPlayer = new Array();
        this._oSpellsCountByPlayer_Counter = new Object();
        this._aSpellsDelay = new Array();
    };
    _loc1.addLaunchedSpell = function (oLaunchedSpell)
    {
        var _loc3 = oLaunchedSpell.spell;
        var _loc4 = _loc3.launchCountByTurn;
        var _loc5 = _loc3.launchCountByPlayerTurn;
        var _loc6 = _loc3.delayBetweenLaunch;
        if (_loc6 != 0)
        {
            this._aSpellsDelay.push(oLaunchedSpell);
        } // end if
        if (_loc5 != 0)
        {
            if (oLaunchedSpell.spriteOnID != undefined)
            {
                this._aSpellsCountByPlayer.push(oLaunchedSpell);
                if (this._oSpellsCountByPlayer_Counter[oLaunchedSpell.spriteOnID + "|" + _loc3.ID] == undefined)
                {
                    this._oSpellsCountByPlayer_Counter[oLaunchedSpell.spriteOnID + "|" + _loc3.ID] = 1;
                }
                else
                {
                    ++this._oSpellsCountByPlayer_Counter[oLaunchedSpell.spriteOnID + "|" + _loc3.ID];
                } // end if
            } // end if
        } // end else if
        if (_loc4 != 0)
        {
            this._aSpellsCountByTurn.push(oLaunchedSpell);
            if (this._oSpellsCountByTurn_Counter[_loc3.ID] == undefined)
            {
                this._oSpellsCountByTurn_Counter[_loc3.ID] = 1;
            }
            else
            {
                ++this._oSpellsCountByTurn_Counter[_loc3.ID];
            } // end if
        } // end else if
        this.dispatchEvent({type: "spellLaunched", spell: _loc3});
    };
    _loc1.nextTurn = function ()
    {
        this._aSpellsCountByTurn = new Array();
        this._oSpellsCountByTurn_Counter = new Object();
        this._aSpellsCountByPlayer = new Array();
        this._oSpellsCountByPlayer_Counter = new Object();
        var _loc3 = this._aSpellsDelay.length;
        while (--_loc3 >= 0)
        {
            var _loc2 = this._aSpellsDelay[_loc3];
            --_loc2.remainingTurn;
            if (_loc2.remainingTurn <= 0)
            {
                this._aSpellsDelay.splice(_loc3, 1);
            } // end if
        } // end while
        this.dispatchEvent({type: "nextTurn"});
    };
    _loc1.checkCanLaunchSpell = function (spellID, nSpriteOnID)
    {
        var _loc4 = this.checkCanLaunchSpellReturnObject(spellID, nSpriteOnID);
        if (_loc4.can == false)
        {
            this.api.datacenter.Basics.spellManager_errorMsg = this.api.lang.getText(_loc4.type, _loc4.params);
            return (false);
        } // end if
        return (true);
    };
    _loc1.checkCanLaunchSpellReturnObject = function (nSpellID, nSpriteOnID)
    {
        if (!this.api.datacenter.Game.isRunning || this.api.datacenter.Game.isSpectator)
        {
            return ({can: false, type: "NOT_IN_FIGHT"});
        } // end if
        var _loc9 = this.api.datacenter.Player.Spells.findFirstItem("ID", nSpellID).item;
        var _loc10 = new Object();
        if (_loc9.needStates)
        {
            var _loc11 = _loc9.requiredStates;
            var _loc12 = _loc9.forbiddenStates;
            var _loc13 = 0;
            
            while (++_loc13, _loc13 < _loc11.length)
            {
                if (!this.api.datacenter.Player.data.isInState(_loc11[_loc13]))
                {
                    _loc10 = {can: false, type: "NOT_IN_REQUIRED_STATE", params: [this.api.lang.getStateText(_loc11[_loc13])]};
                    break;
                } // end if
            } // end while
            var _loc14 = 0;
            
            while (++_loc14, _loc14 < _loc12.length)
            {
                if (this.api.datacenter.Player.data.isInState(_loc12[_loc14]))
                {
                    _loc10 = {can: false, type: "IN_FORBIDDEN_STATE", params: [this.api.lang.getStateText(_loc12[_loc14])]};
                    break;
                } // end if
            } // end while
        } // end if
        var _loc15 = this._aSpellsDelay.length;
        while (--_loc15 >= 0)
        {
            var _loc5 = this._aSpellsDelay[_loc15];
            var _loc6 = _loc5.spell;
            if (_loc6.ID == nSpellID)
            {
                if (_loc5.remainingTurn >= 63)
                {
                    if (_loc10.type)
                    {
                        _loc10.params[1] = _loc5.remainingTurn;
                        return (_loc10);
                    }
                    else
                    {
                        return ({can: false, type: "CANT_RELAUNCH"});
                    } // end else if
                    continue;
                } // end if
                if (_loc10.type)
                {
                    _loc10.params[1] = _loc5.remainingTurn;
                    return (_loc10);
                    continue;
                } // end if
                return ({can: false, type: "CANT_LAUNCH_BEFORE", params: [_loc5.remainingTurn]});
            } // end if
        } // end while
        if (_loc10.type)
        {
            return (_loc10);
        } // end if
        if (_loc9.summonSpell)
        {
            var _loc16 = this.api.datacenter.Player.data.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.MAX_SUMMONED_CREATURES_BOOST) + this.api.datacenter.Player.MaxSummonedCreatures;
            if (this.api.datacenter.Player.SummonedCreatures >= _loc16)
            {
                return ({can: false, type: "CANT_SUMMON_MORE_CREATURE", params: [_loc16]});
            } // end if
        } // end if
        _loc15 = this._aSpellsCountByPlayer.length;
        while (--_loc15 >= 0)
        {
            _loc5 = this._aSpellsCountByPlayer[_loc15];
            _loc6 = _loc5.spell;
            if (_loc6.ID == nSpellID)
            {
                var _loc8 = _loc6.launchCountByPlayerTurn;
                if (_loc5.spriteOnID == nSpriteOnID && this._oSpellsCountByPlayer_Counter[_loc5.spriteOnID + "|" + nSpellID] >= _loc8)
                {
                    return ({can: false, type: "CANT_ON_THIS_PLAYER"});
                } // end if
            } // end if
        } // end while
        _loc15 = this._aSpellsCountByTurn.length;
        while (--_loc15 >= 0)
        {
            _loc5 = this._aSpellsCountByTurn[_loc15];
            _loc6 = _loc5.spell;
            if (_loc6.ID == nSpellID)
            {
                var _loc7 = _loc6.launchCountByTurn;
                if (this._oSpellsCountByTurn_Counter[nSpellID] >= _loc7)
                {
                    return ({can: false, type: "CANT_LAUNCH_MORE", params: [_loc7]});
                } // end if
            } // end if
        } // end while
        if (!this.api.datacenter.Player.hasEnoughAP(_loc9.apCost))
        {
            return ({can: false, type: "NOT_ENOUGH_AP"});
        } // end if
        return ({can: true});
    };
    _loc1.checkCanLaunchSpellOnCell = function (mapHandler, oSpell, cellToData, rangeModerator)
    {
        var _loc6 = Number(this._localPlayerData.data.cellNum);
        var _loc7 = Number(cellToData.mc.num);
        if (_loc6 == _loc7 && oSpell.rangeMin != 0)
        {
            return (false);
        } // end if
        if (!this.api.datacenter.Game.isFight)
        {
            return (false);
        } // end if
        if (ank.battlefield.utils.Pathfinding.checkRange(mapHandler, _loc6, _loc7, oSpell.lineOnly, oSpell.rangeMin, oSpell.rangeMax, rangeModerator))
        {
            if (oSpell.freeCell)
            {
                if (cellToData.movement > 1 && cellToData.spriteOnID != undefined)
                {
                    return (false);
                } // end if
                if (cellToData.movement <= 1)
                {
                    return (false);
                } // end if
            } // end if
            if (oSpell.lineOfSight)
            {
                if (ank.battlefield.utils.Pathfinding.checkView(mapHandler, _loc6, _loc7))
                {
                    return (this.checkCanLaunchSpell(oSpell.ID, cellToData.spriteOnID));
                }
                else
                {
                    return (false);
                } // end if
            } // end else if
            return (this.checkCanLaunchSpell(oSpell.ID, cellToData.spriteOnID));
        } // end if
        return (false);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
