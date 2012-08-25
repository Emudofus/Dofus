// Action script...

// [Initial MovieClip Action of sprite 20789]
#initclip 54
if (!dofus.datacenter.GuildInfos)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.GuildInfos = function (sName, nBackEmblemID, nBackEmblemColor, nUpEmblemID, nUpEmblemColor, nPlayerRights)
    {
        super();
        this.api = _global.API;
        mx.events.EventDispatcher.initialize(this);
        this.initialize(sName, nBackEmblemID, nBackEmblemColor, nUpEmblemID, nUpEmblemColor, nPlayerRights);
        this._eaMembers = new ank.utils.ExtendedArray();
        this._eaTaxCollectors = new ank.utils.ExtendedArray();
        this._eaMountParks = new ank.utils.ExtendedArray();
    }).prototype;
    _loc1.__get__name = function ()
    {
        return (this._sName);
    };
    _loc1.__get__isValid = function ()
    {
        return (this._bValid);
    };
    _loc1.__get__emblem = function ()
    {
        return ({backID: this._nBackEmblemID, backColor: this._nBackEmblemColor, upID: this._nUpEmblemID, upColor: this._nUpEmblemColor});
    };
    _loc1.__get__playerRights = function ()
    {
        return (this._grPlayerRights);
    };
    _loc1.__get__level = function ()
    {
        return (this._nLevel);
    };
    _loc1.__get__xpmin = function ()
    {
        return (this._nXPMin);
    };
    _loc1.__get__xpmax = function ()
    {
        return (this._nXPMax);
    };
    _loc1.__get__xp = function ()
    {
        return (this._nXP);
    };
    _loc1.__get__members = function ()
    {
        return (this._eaMembers);
    };
    _loc1.__get__taxCount = function ()
    {
        return (this._nTaxCount);
    };
    _loc1.__get__taxCountMax = function ()
    {
        return (this._nTaxCountMax);
    };
    _loc1.__get__taxSpells = function ()
    {
        return (this._eaTaxSpells);
    };
    _loc1.__get__taxLp = function ()
    {
        return (this._nTaxLP);
    };
    _loc1.__get__taxBonus = function ()
    {
        return (this._nTaxBonusDamage);
    };
    _loc1.__get__taxcollectorHireCost = function ()
    {
        return (this._nTaxHireCost);
    };
    _loc1.__get__taxPod = function ()
    {
        return (this._nTaxPods);
    };
    _loc1.__get__taxPP = function ()
    {
        return (this._nTaxPP);
    };
    _loc1.__get__taxWisdom = function ()
    {
        return (this._nTaxSagesse);
    };
    _loc1.__get__taxPopulation = function ()
    {
        return (this._nTaxPercepteur);
    };
    _loc1.__get__boostPoints = function ()
    {
        return (this._nBoostPoints);
    };
    _loc1.__get__taxCollectors = function ()
    {
        return (this._eaTaxCollectors);
    };
    _loc1.__get__mountParks = function ()
    {
        return (this._eaMountParks);
    };
    _loc1.__get__maxMountParks = function ()
    {
        return (this._nMaxMountParks);
    };
    _loc1.__get__houses = function ()
    {
        return (this._eaHouses);
    };
    _loc1.__set__defendedTaxCollectorID = function (nDefendedTaxCollectorID)
    {
        this._nDefendedTaxCollectorID = nDefendedTaxCollectorID;
        //return (this.defendedTaxCollectorID());
    };
    _loc1.__get__defendedTaxCollectorID = function ()
    {
        return (this._nDefendedTaxCollectorID);
    };
    _loc1.__get__isLocalPlayerDefender = function ()
    {
        return (this._nDefendedTaxCollectorID != undefined);
    };
    _loc1.initialize = function (sName, nBackEmblemID, nBackEmblemColor, nUpEmblemID, nUpEmblemColor, nPlayerRights)
    {
        this._sName = sName;
        this._nBackEmblemID = nBackEmblemID;
        this._nBackEmblemColor = nBackEmblemColor;
        this._nUpEmblemID = nUpEmblemID;
        this._nUpEmblemColor = nUpEmblemColor;
        this._grPlayerRights = new dofus.datacenter.GuildRights(nPlayerRights);
    };
    _loc1.setGeneralInfos = function (bValid, nLevel, nXPMin, nXP, nXPMax)
    {
        this._bValid = bValid;
        this._nLevel = nLevel;
        this._nXPMin = nXPMin;
        this._nXP = nXP;
        this._nXPMax = nXPMax;
        this.dispatchEvent({type: "modelChanged", eventName: "general"});
    };
    _loc1.setMembers = function ()
    {
        this.dispatchEvent({type: "modelChanged", eventName: "members"});
    };
    _loc1.setMountParks = function (nMaxMountParks, eaMountParks)
    {
        this._nMaxMountParks = nMaxMountParks;
        this._eaMountParks = eaMountParks;
        this.dispatchEvent({type: "modelChanged", eventName: "mountParks"});
    };
    _loc1.setBoosts = function (nTaxCount, nTaxCountMax, nLP, nBonusDamage, nPods, nPP, nSagesse, nPercepteur, nBoostPoints, nTaxHireCost, eaSpells)
    {
        this._nTaxCount = nTaxCount;
        this._nTaxCountMax = nTaxCountMax;
        this._nTaxLP = nLP;
        this._nTaxBonusDamage = nBonusDamage;
        this._nTaxPods = nPods;
        this._nTaxPP = nPP;
        this._nTaxSagesse = nSagesse;
        this._nTaxPercepteur = nPercepteur;
        this._nBoostPoints = nBoostPoints;
        this._nTaxHireCost = nTaxHireCost;
        this._eaTaxSpells = eaSpells;
        this.dispatchEvent({type: "modelChanged", eventName: "boosts"});
    };
    _loc1.setNoBoosts = function ()
    {
        this.dispatchEvent({type: "modelChanged", eventName: "noboosts"});
    };
    _loc1.canBoost = function (sCharac, nParams)
    {
        var _loc4 = this.getBoostCostAndCountForCharacteristic(sCharac, nParams).cost;
        if (this._nBoostPoints >= _loc4 && _loc4 != undefined)
        {
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    };
    _loc1.getBoostCostAndCountForCharacteristic = function (sCharac, nParams)
    {
        var _loc4 = this.api.lang.getGuildBoosts(sCharac);
        var _loc5 = 1;
        var _loc6 = 1;
        var _loc7 = 0;
        switch (sCharac)
        {
            case "w":
            {
                _loc7 = this._nTaxPods;
                break;
            } 
            case "p":
            {
                _loc7 = this._nTaxPP;
                break;
            } 
            case "c":
            {
                _loc7 = this._nTaxPercepteur;
                break;
            } 
            case "x":
            {
                _loc7 = this._nTaxSagesse;
                break;
            } 
            case "s":
            {
                var _loc8 = this._eaTaxSpells.findFirstItem("ID", nParams);
                if (_loc8 != -1)
                {
                    _loc7 = _loc8.item.level;
                } // end if
                break;
            } 
        } // End of switch
        var _loc9 = this.api.lang.getGuildBoostsMax(sCharac);
        if (_loc7 < _loc9)
        {
            var _loc10 = 0;
            
            while (++_loc10, _loc10 < _loc4.length)
            {
                var _loc11 = _loc4[_loc10][0];
                if (_loc7 >= _loc11)
                {
                    _loc5 = _loc4[_loc10][1];
                    _loc6 = _loc4[_loc10][2] == undefined ? (1) : (_loc4[_loc10][2]);
                    continue;
                } // end if
                break;
            } // end while
            return ({cost: _loc5, count: _loc6});
        }
        else
        {
            return (null);
        } // end else if
    };
    _loc1.setTaxCollectors = function ()
    {
        this.dispatchEvent({type: "modelChanged", eventName: "taxcollectors"});
    };
    _loc1.setNoTaxCollectors = function ()
    {
        this.dispatchEvent({type: "modelChanged", eventName: "notaxcollectors"});
    };
    _loc1.setHouses = function (eaHouses)
    {
        this._eaHouses = eaHouses;
        this.dispatchEvent({type: "modelChanged", eventName: "houses"});
    };
    _loc1.setNoHouses = function ()
    {
        this._eaHouses = new ank.utils.ExtendedArray();
        this.dispatchEvent({type: "modelChanged", eventName: "nohouses"});
    };
    _loc1.addProperty("defendedTaxCollectorID", _loc1.__get__defendedTaxCollectorID, _loc1.__set__defendedTaxCollectorID);
    _loc1.addProperty("taxWisdom", _loc1.__get__taxWisdom, function ()
    {
    });
    _loc1.addProperty("taxPod", _loc1.__get__taxPod, function ()
    {
    });
    _loc1.addProperty("isValid", _loc1.__get__isValid, function ()
    {
    });
    _loc1.addProperty("isLocalPlayerDefender", _loc1.__get__isLocalPlayerDefender, function ()
    {
    });
    _loc1.addProperty("taxCollectors", _loc1.__get__taxCollectors, function ()
    {
    });
    _loc1.addProperty("playerRights", _loc1.__get__playerRights, function ()
    {
    });
    _loc1.addProperty("boostPoints", _loc1.__get__boostPoints, function ()
    {
    });
    _loc1.addProperty("taxcollectorHireCost", _loc1.__get__taxcollectorHireCost, function ()
    {
    });
    _loc1.addProperty("xpmax", _loc1.__get__xpmax, function ()
    {
    });
    _loc1.addProperty("maxMountParks", _loc1.__get__maxMountParks, function ()
    {
    });
    _loc1.addProperty("members", _loc1.__get__members, function ()
    {
    });
    _loc1.addProperty("level", _loc1.__get__level, function ()
    {
    });
    _loc1.addProperty("taxCount", _loc1.__get__taxCount, function ()
    {
    });
    _loc1.addProperty("taxPopulation", _loc1.__get__taxPopulation, function ()
    {
    });
    _loc1.addProperty("taxPP", _loc1.__get__taxPP, function ()
    {
    });
    _loc1.addProperty("xp", _loc1.__get__xp, function ()
    {
    });
    _loc1.addProperty("taxCountMax", _loc1.__get__taxCountMax, function ()
    {
    });
    _loc1.addProperty("taxLp", _loc1.__get__taxLp, function ()
    {
    });
    _loc1.addProperty("houses", _loc1.__get__houses, function ()
    {
    });
    _loc1.addProperty("mountParks", _loc1.__get__mountParks, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("xpmin", _loc1.__get__xpmin, function ()
    {
    });
    _loc1.addProperty("taxBonus", _loc1.__get__taxBonus, function ()
    {
    });
    _loc1.addProperty("taxSpells", _loc1.__get__taxSpells, function ()
    {
    });
    _loc1.addProperty("emblem", _loc1.__get__emblem, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
