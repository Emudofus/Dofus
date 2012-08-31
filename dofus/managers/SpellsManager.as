// Action script...

// [Initial MovieClip Action of sprite 914]
#initclip 126
class dofus.managers.SpellsManager
{
    var _localPlayerData, api, _aSpellsCountByTurn, _oSpellsCountByTurn_Counter, _aSpellsCountByPlayer, _oSpellsCountByPlayer_Counter, _aSpellsDelay, dispatchEvent;
    function SpellsManager(d)
    {
        this.initialize(d);
    } // End of the function
    function initialize(d)
    {
        _localPlayerData = d;
        api = d.api;
        this.clear();
        mx.events.EventDispatcher.initialize(this);
    } // End of the function
    function clear()
    {
        _aSpellsCountByTurn = new Array();
        _oSpellsCountByTurn_Counter = new Object();
        _aSpellsCountByPlayer = new Array();
        _oSpellsCountByPlayer_Counter = new Object();
        _aSpellsDelay = new Array();
    } // End of the function
    function addLaunchedSpell(oLaunchedSpell)
    {
        var _loc2 = oLaunchedSpell.spell;
        var _loc5 = _loc2.launchCountByTurn;
        var _loc6 = _loc2.launchCountByPlayerTurn;
        var _loc4 = _loc2.delayBetweenLaunch;
        if (_loc4 != 0)
        {
            _aSpellsDelay.push(oLaunchedSpell);
        } // end if
        if (_loc6 != 0)
        {
            if (oLaunchedSpell.spriteOnID != undefined)
            {
                _aSpellsCountByPlayer.push(oLaunchedSpell);
                if (_oSpellsCountByPlayer_Counter[_loc2.ID] == undefined)
                {
                    _oSpellsCountByPlayer_Counter[_loc2.ID] = 1;
                }
                else
                {
                    ++_oSpellsCountByPlayer_Counter[_loc2.ID];
                } // end if
            } // end if
        } // end else if
        if (_loc5 != 0)
        {
            _aSpellsCountByTurn.push(oLaunchedSpell);
            if (_oSpellsCountByTurn_Counter[_loc2.ID] == undefined)
            {
                _oSpellsCountByTurn_Counter[_loc2.ID] = 1;
            }
            else
            {
                ++_oSpellsCountByTurn_Counter[_loc2.ID];
            } // end if
        } // end else if
        this.dispatchEvent({type: "spellLaunched", spell: _loc2});
    } // End of the function
    function nextTurn()
    {
        var _loc3;
        _aSpellsCountByTurn = new Array();
        _oSpellsCountByTurn_Counter = new Object();
        _aSpellsCountByPlayer = new Array();
        _oSpellsCountByPlayer_Counter = new Object();
        var _loc2 = _aSpellsDelay.length;
        while (--_loc2 >= 0)
        {
            _loc3 = _aSpellsDelay[_loc2];
            --_loc3.remainingTurn;
            if (_loc3.remainingTurn <= 0)
            {
                _aSpellsDelay.splice(_loc2, 1);
            } // end if
        } // end while
        this.dispatchEvent({type: "nextTurn"});
    } // End of the function
    function checkCanLaunchSpell(spellID, nSpriteOnID)
    {
        var _loc2 = this.checkCanLaunchSpellReturnObject(spellID, nSpriteOnID);
        if (_loc2.can == false)
        {
            api.datacenter.Basics.spellManager_errorMsg = api.lang.getText(_loc2.type, _loc2.params);
            return (false);
        } // end if
        return (true);
    } // End of the function
    function checkCanLaunchSpellReturnObject(nSpellID, nSpriteOnID)
    {
        var _loc14;
        var _loc2;
        var _loc3;
        var _loc6;
        var _loc7;
        var _loc4;
        if (!api.datacenter.Game.isRunning || api.datacenter.Game.isSpectator)
        {
            return ({can: false, type: "NOT_IN_FIGHT"});
        } // end if
        var _loc11 = api.datacenter.Player.Spells.findFirstItem("ID", nSpellID).item;
        _loc4 = _aSpellsDelay.length;
        while (--_loc4 >= 0)
        {
            _loc2 = _aSpellsDelay[_loc4];
            _loc3 = _loc2.spell;
            if (_loc3.ID == nSpellID)
            {
                if (_loc2.remainingTurn >= 63)
                {
                    return ({can: false, type: "CANT_RELAUNCH"});
                    continue;
                } // end if
                return ({can: false, type: "CANT_LAUNCH_BEFORE", params: [_loc2.remainingTurn]});
            } // end if
        } // end while
        if (_loc11.summonSpell)
        {
            var _loc10 = api.datacenter.Player.data.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.MAX_SUMMONED_CREATURES_BOOST) + api.datacenter.Player.MaxSummonedCreatures;
            if (api.datacenter.Player.SummonedCreatures >= _loc10)
            {
                return ({can: false, type: "CANT_SUMMON_MORE_CREATURE", params: [_loc10]});
            } // end if
        } // end if
        _loc4 = _aSpellsCountByPlayer.length;
        while (--_loc4 >= 0)
        {
            _loc2 = _aSpellsCountByPlayer[_loc4];
            _loc3 = _loc2.spell;
            if (_loc3.ID == nSpellID)
            {
                _loc7 = _loc3.launchCountByPlayerTurn;
                if (_loc2.spriteOnID == nSpriteOnID && _oSpellsCountByPlayer_Counter[nSpellID] >= _loc7)
                {
                    return ({can: false, type: "CANT_ON_THIS_PLAYER"});
                } // end if
            } // end if
        } // end while
        _loc4 = _aSpellsCountByTurn.length;
        while (--_loc4 >= 0)
        {
            _loc2 = _aSpellsCountByTurn[_loc4];
            _loc3 = _loc2.spell;
            if (_loc3.ID == nSpellID)
            {
                _loc6 = _loc3.launchCountByTurn;
                if (_oSpellsCountByTurn_Counter[nSpellID] >= _loc6)
                {
                    return ({can: false, type: "CANT_LAUNCH_MORE", params: [_loc6]});
                } // end if
            } // end if
        } // end while
        if (!api.datacenter.Player.hasEnoughAP(_loc11.apCost))
        {
            return ({can: false, type: "NOT_ENOUGH_AP"});
        } // end if
        return ({can: true});
    } // End of the function
    function checkCanLaunchSpellOnCell(mapHandler, oSpell, cellToData, rangeModerator)
    {
        var _loc4 = Number(_localPlayerData.data.cellNum);
        var _loc5 = Number(cellToData.mc.num);
        if (_loc4 == _loc5 && oSpell.rangeMin != 0)
        {
            return (false);
        } // end if
        if (!api.datacenter.Game.isFight)
        {
            return (false);
        } // end if
        if (ank.battlefield.utils.Pathfinding.checkRange(mapHandler, _loc4, _loc5, oSpell.lineOnly, oSpell.rangeMin, oSpell.rangeMax, rangeModerator))
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
                if (ank.battlefield.utils.Pathfinding.checkView(mapHandler, _loc4, _loc5))
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
    } // End of the function
} // End of Class
#endinitclip
