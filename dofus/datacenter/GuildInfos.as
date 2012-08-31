// Action script...

// [Initial MovieClip Action of sprite 956]
#initclip 168
class dofus.datacenter.GuildInfos extends Object
{
    var api, _eaMembers, _eaTaxCollectors, _sName, _bValid, _nBackEmblemID, _nBackEmblemColor, _nUpEmblemID, _nUpEmblemColor, _grPlayerRights, _nLevel, _nXPMin, _nXPMax, _nXP, _nTaxCount, _nTaxCountMax, _eaTaxSpells, _nTaxLP, _nTaxBonusDamage, _nTaxHireCost, _nTaxPercentRessources, _nTaxPercentKamas, _nTaxProbDrop, _nBoostPoints, _nDefendedTaxCollectorID, __get__defendedTaxCollectorID, dispatchEvent, __get__boostPoints, __set__defendedTaxCollectorID, __get__emblem, __get__isLocalPlayerDefender, __get__isValid, __get__level, __get__members, __get__name, __get__playerRights, __get__taxBonus, __get__taxCollectors, __get__taxCount, __get__taxCountMax, __get__taxLp, __get__taxPercentKamas, __get__taxPercentRes, __get__taxProbObjects, __get__taxSpells, __get__taxcollectorHireCost, __get__xp, __get__xpmax, __get__xpmin;
    function GuildInfos(sName, nBackEmblemID, nBackEmblemColor, nUpEmblemID, nUpEmblemColor, nPlayerRights)
    {
        super();
        api = _global.API;
        mx.events.EventDispatcher.initialize(this);
        this.initialize(sName, nBackEmblemID, nBackEmblemColor, nUpEmblemID, nUpEmblemColor, nPlayerRights);
        _eaMembers = new ank.utils.ExtendedArray();
        _eaTaxCollectors = new ank.utils.ExtendedArray();
    } // End of the function
    function get name()
    {
        return (_sName);
    } // End of the function
    function get isValid()
    {
        return (_bValid);
    } // End of the function
    function get emblem()
    {
        return ({backID: _nBackEmblemID, backColor: _nBackEmblemColor, upID: _nUpEmblemID, upColor: _nUpEmblemColor});
    } // End of the function
    function get playerRights()
    {
        return (_grPlayerRights);
    } // End of the function
    function get level()
    {
        return (_nLevel);
    } // End of the function
    function get xpmin()
    {
        return (_nXPMin);
    } // End of the function
    function get xpmax()
    {
        return (_nXPMax);
    } // End of the function
    function get xp()
    {
        return (_nXP);
    } // End of the function
    function get members()
    {
        return (_eaMembers);
    } // End of the function
    function get taxCount()
    {
        return (_nTaxCount);
    } // End of the function
    function get taxCountMax()
    {
        return (_nTaxCountMax);
    } // End of the function
    function get taxSpells()
    {
        return (_eaTaxSpells);
    } // End of the function
    function get taxLp()
    {
        return (_nTaxLP);
    } // End of the function
    function get taxBonus()
    {
        return (_nTaxBonusDamage);
    } // End of the function
    function get taxcollectorHireCost()
    {
        return (_nTaxHireCost);
    } // End of the function
    function get taxPercentRes()
    {
        return (_nTaxPercentRessources);
    } // End of the function
    function get taxPercentKamas()
    {
        return (_nTaxPercentKamas);
    } // End of the function
    function get taxProbObjects()
    {
        return (_nTaxProbDrop);
    } // End of the function
    function get boostPoints()
    {
        return (_nBoostPoints);
    } // End of the function
    function get taxCollectors()
    {
        return (_eaTaxCollectors);
    } // End of the function
    function set defendedTaxCollectorID(nDefendedTaxCollectorID)
    {
        _nDefendedTaxCollectorID = nDefendedTaxCollectorID;
        //return (this.defendedTaxCollectorID());
        null;
    } // End of the function
    function get defendedTaxCollectorID()
    {
        return (_nDefendedTaxCollectorID);
    } // End of the function
    function get isLocalPlayerDefender()
    {
        return (_nDefendedTaxCollectorID != undefined);
    } // End of the function
    function initialize(sName, nBackEmblemID, nBackEmblemColor, nUpEmblemID, nUpEmblemColor, nPlayerRights)
    {
        _sName = sName;
        _nBackEmblemID = nBackEmblemID;
        _nBackEmblemColor = nBackEmblemColor;
        _nUpEmblemID = nUpEmblemID;
        _nUpEmblemColor = nUpEmblemColor;
        _grPlayerRights = new dofus.datacenter.GuildRights(nPlayerRights);
    } // End of the function
    function setGeneralInfos(bValid, nLevel, nXPMin, nXP, nXPMax)
    {
        _bValid = bValid;
        _nLevel = nLevel;
        _nXPMin = nXPMin;
        _nXP = nXP;
        _nXPMax = nXPMax;
        this.dispatchEvent({type: "modelChanged", eventName: "general"});
    } // End of the function
    function setMembers()
    {
        this.dispatchEvent({type: "modelChanged", eventName: "members"});
    } // End of the function
    function setBoosts(nTaxCount, nTaxCountMax, nLP, nBonusDamage, nPercentRessources, nPercentKamas, nProbDrop, nBoostPoints, nTaxHireCost, eaSpells)
    {
        _nTaxCount = nTaxCount;
        _nTaxCountMax = nTaxCountMax;
        _nTaxLP = nLP;
        _nTaxBonusDamage = nBonusDamage;
        _nTaxPercentRessources = nPercentRessources / 10;
        _nTaxPercentKamas = nPercentKamas / 10;
        _nTaxProbDrop = nProbDrop / 10;
        _nBoostPoints = nBoostPoints;
        _nTaxHireCost = nTaxHireCost;
        _eaTaxSpells = eaSpells;
        this.dispatchEvent({type: "modelChanged", eventName: "boosts"});
    } // End of the function
    function setNoBoosts()
    {
        this.dispatchEvent({type: "modelChanged", eventName: "noboosts"});
    } // End of the function
    function canBoost(sCharac, nParams)
    {
        var _loc2 = this.getBoostCostAndCountForCharacteristic(sCharac, nParams).cost;
        if (_nBoostPoints >= _loc2 && _loc2 != undefined)
        {
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function getBoostCostAndCountForCharacteristic(sCharac, nParams)
    {
        var _loc3 = api.lang.getGuildBoosts(sCharac);
        var _loc7 = 1;
        var _loc6 = 1;
        var _loc5 = 0;
        switch (sCharac)
        {
            case "r":
            {
                _loc5 = _nTaxPercentRessources;
                break;
            } 
            case "k":
            {
                _loc5 = _nTaxPercentKamas;
                break;
            } 
            case "o":
            {
                _loc5 = _nTaxProbDrop;
                break;
            } 
            case "s":
            {
                var _loc8 = _eaTaxSpells.findFirstItem("ID", nParams);
                if (_loc8 != -1)
                {
                    _loc5 = _loc8.item.level;
                } // end if
                break;
            } 
        } // End of switch
        var _loc9 = api.lang.getGuildBoostsMax(sCharac);
        if (_loc5 < _loc9)
        {
            for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
            {
                var _loc4 = _loc3[_loc2][0];
                if (_loc5 >= _loc4)
                {
                    _loc7 = _loc3[_loc2][1];
                    _loc6 = _loc3[_loc2][2] == undefined ? (1) : (_loc3[_loc2][2]);
                    continue;
                } // end if
                break;
            } // end of for
            return ({cost: _loc7, count: _loc6});
        }
        else
        {
            return (null);
        } // end else if
    } // End of the function
    function setTaxCollectors()
    {
        this.dispatchEvent({type: "modelChanged", eventName: "taxcollectors"});
    } // End of the function
    function setNoTaxCollectors()
    {
        this.dispatchEvent({type: "modelChanged", eventName: "notaxcollectors"});
    } // End of the function
} // End of Class
#endinitclip
