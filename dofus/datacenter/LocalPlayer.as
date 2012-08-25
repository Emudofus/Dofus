// Action script...

// [Initial MovieClip Action of sprite 20956]
#initclip 221
if (!dofus.datacenter.LocalPlayer)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.LocalPlayer = function (oAPI)
    {
        super();
        this.initialize(oAPI);
    }).prototype;
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI);
        mx.events.EventDispatcher.initialize(this);
        this.clean();
        mx.events.EventDispatcher.initialize(this);
    };
    _loc1.clean = function ()
    {
        this.SpellsManager = new dofus.managers.SpellsManager(this);
        this.InteractionsManager = new dofus.managers.InteractionsManager(this, this.api);
        this.Inventory = new ank.utils.ExtendedArray();
        this.ItemSets = new ank.utils.ExtendedObject();
        this.Jobs = new ank.utils.ExtendedArray();
        this.Spells = new ank.utils.ExtendedArray();
        this.Emotes = new ank.utils.ExtendedObject();
        this.clearSummon();
        this._bCraftPublicMode = false;
        this._bInParty = false;
    };
    _loc1.clearSummon = function ()
    {
        this._nSummonedCreatures = 0;
        this._nMaxSummonedCreatures = 1;
        this.summonedCreaturesID = new Object();
    };
    _loc1.__get__clip = function ()
    {
        return (this.api.datacenter.Sprites.getItemAt(this._sID).mc);
    };
    _loc1.__get__data = function ()
    {
        return (this.api.datacenter.Sprites.getItemAt(this._sID));
    };
    _loc1.__get__isCurrentPlayer = function ()
    {
        return (this.api.datacenter.Game.currentPlayerID == this._sID);
    };
    _loc1.__set__ID = function (value)
    {
        this._sID = value;
        //return (this.ID());
    };
    _loc1.__get__ID = function ()
    {
        return (this._sID);
    };
    _loc1.__set__Name = function (value)
    {
        this._sName = String(value);
        //return (this.Name());
    };
    _loc1.__get__Name = function ()
    {
        return (this._sName);
    };
    _loc1.__set__Guild = function (value)
    {
        this._nGuild = Number(value);
        //return (this.Guild());
    };
    _loc1.__get__Guild = function ()
    {
        return (this._nGuild);
    };
    _loc1.__set__Level = function (value)
    {
        this._nLevel = Number(value);
        this.dispatchEvent({type: "levelChanged", value: value});
        //return (this.Level());
    };
    _loc1.__get__Level = function ()
    {
        return (this._nLevel);
    };
    _loc1.__set__Sex = function (value)
    {
        this._nSex = Number(value);
        //return (this.Sex());
    };
    _loc1.__get__Sex = function ()
    {
        return (this._nSex);
    };
    _loc1.__set__color1 = function (value)
    {
        this._nColor1 = Number(value);
        //return (this.color1());
    };
    _loc1.__get__color1 = function ()
    {
        return (this._nColor1);
    };
    _loc1.__set__color2 = function (value)
    {
        this._nColor2 = Number(value);
        //return (this.color2());
    };
    _loc1.__get__color2 = function ()
    {
        return (this._nColor2);
    };
    _loc1.__set__color3 = function (value)
    {
        this._nColor3 = Number(value);
        //return (this.color3());
    };
    _loc1.__get__color3 = function ()
    {
        return (this._nColor3);
    };
    _loc1.__set__LP = function (value)
    {
        this._nLP = Number(value) > 0 ? (Number(value)) : (0);
        this.dispatchEvent({type: "lpChanged", value: value});
        //return (this.LP());
    };
    _loc1.__get__LP = function ()
    {
        return (this._nLP);
    };
    _loc1.__set__LPmax = function (value)
    {
        this._nLPMax = Number(value);
        this.dispatchEvent({type: "lpmaxChanged", value: value});
        //return (this.LPmax());
    };
    _loc1.__get__LPmax = function ()
    {
        return (this._nLPMax);
    };
    _loc1.__set__AP = function (value)
    {
        this._nAP = Number(value);
        this.data.AP = Number(value);
        this.dispatchEvent({type: "apChanged", value: value});
        //return (this.AP());
    };
    _loc1.__get__AP = function ()
    {
        return (this._nAP);
    };
    _loc1.__set__MP = function (value)
    {
        this._nMP = Number(value);
        this.data.MP = Number(value);
        this.dispatchEvent({type: "mpChanged", value: value});
        //return (this.MP());
    };
    _loc1.__get__MP = function ()
    {
        return (this._nMP);
    };
    _loc1.__set__Kama = function (value)
    {
        this._nKama = Number(value);
        this.dispatchEvent({type: "kamaChanged", value: value});
        //return (this.Kama());
    };
    _loc1.__get__Kama = function ()
    {
        return (this._nKama);
    };
    _loc1.__set__XPlow = function (value)
    {
        this._nXPLow = Number(value);
        //return (this.XPlow());
    };
    _loc1.__get__XPlow = function ()
    {
        return (this._nXPLow);
    };
    _loc1.__set__XP = function (value)
    {
        this._nXP = Number(value);
        this.dispatchEvent({type: "xpChanged", value: value});
        //return (this.XP());
    };
    _loc1.__get__XP = function ()
    {
        return (this._nXP);
    };
    _loc1.__set__XPhigh = function (value)
    {
        this._nXPHigh = Number(value);
        //return (this.XPhigh());
    };
    _loc1.__get__XPhigh = function ()
    {
        return (this._nXPHigh);
    };
    _loc1.__set__Initiative = function (value)
    {
        this._nInitiative = Number(value);
        this.dispatchEvent({type: "initiativeChanged", value: value});
        //return (this.Initiative());
    };
    _loc1.__get__Initiative = function ()
    {
        return (this._nInitiative);
    };
    _loc1.__set__Discernment = function (value)
    {
        this._nDiscernment = Number(value);
        this.dispatchEvent({type: "discernmentChanged", value: value});
        //return (this.Discernment());
    };
    _loc1.__get__Discernment = function ()
    {
        return (this._nDiscernment);
    };
    _loc1.__set__Force = function (value)
    {
        this._nForce = Number(value);
        this.dispatchEvent({type: "forceChanged", value: value});
        //return (this.Force());
    };
    _loc1.__get__Force = function ()
    {
        return (this._nForce);
    };
    _loc1.__set__ForceXtra = function (value)
    {
        this._nForceXtra = Number(value);
        this.dispatchEvent({type: "forceXtraChanged", value: value});
        //return (this.ForceXtra());
    };
    _loc1.__get__ForceXtra = function ()
    {
        return (this._nForceXtra);
    };
    _loc1.__set__Vitality = function (value)
    {
        this._nVitality = Number(value);
        this.dispatchEvent({type: "vitalityChanged", value: value});
        //return (this.Vitality());
    };
    _loc1.__get__Vitality = function ()
    {
        return (this._nVitality);
    };
    _loc1.__set__VitalityXtra = function (value)
    {
        this._nVitalityXtra = Number(value);
        this.dispatchEvent({type: "vitalityXtraChanged", value: value});
        //return (this.VitalityXtra());
    };
    _loc1.__get__VitalityXtra = function ()
    {
        return (this._nVitalityXtra);
    };
    _loc1.__set__Wisdom = function (value)
    {
        this._nWisdom = Number(value);
        this.dispatchEvent({type: "wisdomChanged", value: value});
        //return (this.Wisdom());
    };
    _loc1.__get__Wisdom = function ()
    {
        return (this._nWisdom);
    };
    _loc1.__set__WisdomXtra = function (value)
    {
        this._nWisdomXtra = Number(value);
        this.dispatchEvent({type: "wisdomXtraChanged", value: value});
        //return (this.WisdomXtra());
    };
    _loc1.__get__WisdomXtra = function ()
    {
        return (this._nWisdomXtra);
    };
    _loc1.__set__Chance = function (value)
    {
        this._nChance = Number(value);
        this.dispatchEvent({type: "chanceChanged", value: value});
        //return (this.Chance());
    };
    _loc1.__get__Chance = function ()
    {
        return (this._nChance);
    };
    _loc1.__set__ChanceXtra = function (value)
    {
        this._nChanceXtra = Number(value);
        this.dispatchEvent({type: "chanceXtraChanged", value: value});
        //return (this.ChanceXtra());
    };
    _loc1.__get__ChanceXtra = function ()
    {
        return (this._nChanceXtra);
    };
    _loc1.__set__Agility = function (value)
    {
        this._agility = Number(value);
        this.dispatchEvent({type: "agilityChanged", value: value});
        //return (this.Agility());
    };
    _loc1.__get__Agility = function ()
    {
        return (this._agility);
    };
    _loc1.__set__AgilityXtra = function (value)
    {
        this._nAgilityXtra = Number(value);
        this.dispatchEvent({type: "agilityXtraChanged", value: value});
        //return (this.AgilityXtra());
    };
    _loc1.__get__AgilityXtra = function ()
    {
        return (this._nAgilityXtra);
    };
    _loc1.__set__AgilityTotal = function (value)
    {
        this._nAgilityTotal = Number(value);
        this.dispatchEvent({type: "agilityTotalChanged", value: value});
        //return (this.AgilityTotal());
    };
    _loc1.__get__AgilityTotal = function ()
    {
        return (this._nAgilityTotal);
    };
    _loc1.__set__Intelligence = function (value)
    {
        this._intelligence = Number(value);
        this.dispatchEvent({type: "intelligenceChanged", value: value});
        //return (this.Intelligence());
    };
    _loc1.__get__Intelligence = function ()
    {
        return (this._intelligence);
    };
    _loc1.__set__IntelligenceXtra = function (value)
    {
        this._nIntelligenceXtra = Number(value);
        this.dispatchEvent({type: "intelligenceXtraChanged", value: value});
        //return (this.IntelligenceXtra());
    };
    _loc1.__get__IntelligenceXtra = function ()
    {
        return (this._nIntelligenceXtra);
    };
    _loc1.__set__BonusPoints = function (value)
    {
        this._nBonusPoints = Number(value);
        this.dispatchEvent({type: "bonusPointsChanged", value: value});
        //return (this.BonusPoints());
    };
    _loc1.__get__BonusPoints = function ()
    {
        return (this._nBonusPoints);
    };
    _loc1.__set__BonusPointsSpell = function (value)
    {
        this._nBonusPointsSpell = Number(value);
        this.dispatchEvent({type: "bonusSpellsChanged", value: value});
        //return (this.BonusPointsSpell());
    };
    _loc1.__get__BonusPointsSpell = function ()
    {
        return (this._nBonusPointsSpell);
    };
    _loc1.__set__RangeModerator = function (value)
    {
        this._nRangeModerator = Number(value);
        //return (this.RangeModerator());
    };
    _loc1.__get__RangeModerator = function ()
    {
        return (this._nRangeModerator);
    };
    _loc1.__set__Energy = function (value)
    {
        this._nEnergy = Number(value);
        this.dispatchEvent({type: "energyChanged", value: value});
        //return (this.Energy());
    };
    _loc1.__get__Energy = function ()
    {
        return (this._nEnergy);
    };
    _loc1.__set__EnergyMax = function (value)
    {
        this._nEnergyMax = Number(value);
        this.dispatchEvent({type: "energyMaxChanged", value: value});
        //return (this.EnergyMax());
    };
    _loc1.__get__EnergyMax = function ()
    {
        return (this._nEnergyMax);
    };
    _loc1.__set__SummonedCreatures = function (value)
    {
        this._nSummonedCreatures = Number(value);
        //return (this.SummonedCreatures());
    };
    _loc1.__get__SummonedCreatures = function ()
    {
        return (this._nSummonedCreatures);
    };
    _loc1.__set__MaxSummonedCreatures = function (value)
    {
        this._nMaxSummonedCreatures = Number(value);
        //return (this.MaxSummonedCreatures());
    };
    _loc1.__get__MaxSummonedCreatures = function ()
    {
        return (this._nMaxSummonedCreatures);
    };
    _loc1.__set__CriticalHitBonus = function (value)
    {
        this._nCriticalHitBonus = Number(value);
        //return (this.CriticalHitBonus());
    };
    _loc1.__get__CriticalHitBonus = function ()
    {
        return (this._nCriticalHitBonus);
    };
    _loc1.__get__weaponItem = function ()
    {
        return (this._oWeaponItem);
    };
    _loc1.__set__FullStats = function (value)
    {
        this._aFullStats = value;
        this.dispatchEvent({type: "fullStatsChanged", value: value});
        //return (this.FullStats());
    };
    _loc1.__get__FullStats = function ()
    {
        return (this._aFullStats);
    };
    _loc1.__set__currentJobID = function (value)
    {
        if (value == undefined)
        {
            delete this._nCurrentJobID;
        }
        else
        {
            this._nCurrentJobID = Number(value);
        } // end else if
        //return (this.currentJobID());
    };
    _loc1.__get__currentJobID = function ()
    {
        return (this._nCurrentJobID);
    };
    _loc1.__get__currentJob = function ()
    {
        var _loc2 = this.Jobs.findFirstItem("id", this._nCurrentJobID);
        return (_loc2.item);
    };
    _loc1.__set__currentWeight = function (value)
    {
        this._nCurrentWeight = value;
        this.dispatchEvent({type: "currentWeightChanged", value: value});
        //return (this.currentWeight());
    };
    _loc1.__get__currentWeight = function ()
    {
        return (this._nCurrentWeight);
    };
    _loc1.__set__maxWeight = function (value)
    {
        this._nMaxWeight = value;
        this.dispatchEvent({type: "maxWeightChanged", value: value});
        //return (this.maxWeight());
    };
    _loc1.__get__maxWeight = function ()
    {
        return (this._nMaxWeight);
    };
    _loc1.__get__isMutant = function ()
    {
        return (this.data instanceof dofus.datacenter.Mutant);
    };
    _loc1.__set__restrictions = function (value)
    {
        this._nRestrictions = value;
        //return (this.restrictions());
    };
    _loc1.__get__restrictions = function ()
    {
        return (this._nRestrictions);
    };
    _loc1.__set__specialization = function (value)
    {
        this._oSpecialization = value;
        this.dispatchEvent({type: "specializationChanged", value: value});
        //return (this.specialization());
    };
    _loc1.__get__specialization = function ()
    {
        return (this._oSpecialization);
    };
    _loc1.__set__alignment = function (value)
    {
        this._oAlignment = value;
        this.dispatchEvent({type: "alignmentChanged", alignment: value});
        //return (this.alignment());
    };
    _loc1.__get__alignment = function ()
    {
        return (this._oAlignment);
    };
    _loc1.__set__fakeAlignment = function (value)
    {
        this._oFakeAlignment = value;
        //return (this.fakeAlignment());
    };
    _loc1.__get__fakeAlignment = function ()
    {
        return (this._oFakeAlignment);
    };
    _loc1.__set__rank = function (value)
    {
        this._oRank = value;
        this.dispatchEvent({type: "rankChanged", rank: value});
        //return (this.rank());
    };
    _loc1.__get__rank = function ()
    {
        return (this._oRank);
    };
    _loc1.__set__mount = function (value)
    {
        this._oMount = value;
        this.dispatchEvent({type: "mountChanged", mount: value});
        //return (this.mount());
    };
    _loc1.__get__mount = function ()
    {
        return (this._oMount);
    };
    _loc1.__get__isRiding = function ()
    {
        return (this._bIsRiding);
    };
    _loc1.__set__isRiding = function (value)
    {
        this._bIsRiding = value;
        //return (this.isRiding());
    };
    _loc1.__set__mountXPPercent = function (value)
    {
        this._nMountXPPercent = value;
        this.dispatchEvent({type: "mountXPPercentChanged", value: value});
        //return (this.mountXPPercent());
    };
    _loc1.__get__mountXPPercent = function ()
    {
        return (this._nMountXPPercent);
    };
    _loc1.__set__craftPublicMode = function (value)
    {
        this._bCraftPublicMode = value;
        this.dispatchEvent({type: "craftPublicModeChanged", value: value});
        //return (this.craftPublicMode());
    };
    _loc1.__get__craftPublicMode = function ()
    {
        return (this._bCraftPublicMode);
    };
    _loc1.__set__inParty = function (value)
    {
        this._bInParty = value;
        this.dispatchEvent({type: "inPartyChanged", inParty: value});
        //return (this.inParty());
    };
    _loc1.__get__inParty = function ()
    {
        return (this._bInParty);
    };
    _loc1.__get__canAssault = function ()
    {
        return ((this._nRestrictions & 1) != 1);
    };
    _loc1.__get__canChallenge = function ()
    {
        return ((this._nRestrictions & 2) != 2);
    };
    _loc1.__get__canExchange = function ()
    {
        return ((this._nRestrictions & 4) != 4);
    };
    _loc1.__get__canAttack = function ()
    {
        return ((this._nRestrictions & 8) == 8);
    };
    _loc1.__get__canChatToAll = function ()
    {
        return ((this._nRestrictions & 16) != 16);
    };
    _loc1.__get__canBeMerchant = function ()
    {
        return ((this._nRestrictions & 32) != 32);
    };
    _loc1.__get__canUseObject = function ()
    {
        return ((this._nRestrictions & 64) != 64);
    };
    _loc1.__get__cantInteractWithTaxCollector = function ()
    {
        return ((this._nRestrictions & 128) == 128);
    };
    _loc1.__get__canUseInteractiveObjects = function ()
    {
        return ((this._nRestrictions & 256) != 256);
    };
    _loc1.__get__cantSpeakNPC = function ()
    {
        return ((this._nRestrictions & 512) == 512);
    };
    _loc1.__get__canAttackDungeonMonstersWhenMutant = function ()
    {
        return ((this._nRestrictions & 4096) == 4096);
    };
    _loc1.__get__canMoveInAllDirections = function ()
    {
        return ((this._nRestrictions & 8192) == 8192);
    };
    _loc1.__get__canAttackMonstersAnywhereWhenMutant = function ()
    {
        return ((this._nRestrictions & 16384) == 16384);
    };
    _loc1.__get__cantInteractWithPrism = function ()
    {
        return ((this._nRestrictions & 32768) == 32768);
    };
    _loc1.reset = function ()
    {
        this.currentUseObject = null;
    };
    _loc1.updateLP = function (dLP)
    {
        dLP = Number(dLP);
        if (this.LP + dLP > this.LPmax)
        {
            dLP = this.LPmax - this.LP;
        } // end if
        this.LP = this.LP + dLP;
    };
    _loc1.hasEnoughAP = function (wantedAP)
    {
        return (this.data.AP >= wantedAP);
    };
    _loc1.addItem = function (oItem)
    {
        if (oItem.position == 1)
        {
            this.setWeaponItem(oItem);
        } // end if
        this.Inventory.push(oItem);
    };
    _loc1.updateItem = function (oNewItem)
    {
        var _loc3 = this.Inventory.findFirstItem("ID", oNewItem.ID);
        if (_loc3.item.ID == oNewItem.ID && _loc3.item.maxSkin != oNewItem.maxSkin)
        {
            if (!_loc3.item.isLeavingItem && oNewItem.isLeavingItem)
            {
                this.api.kernel.SpeakingItemsManager.triggerPrivateEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_ASSOCIATE);
            } // end if
            if (_loc3.item.isLeavingItem && oNewItem.isLeavingItem)
            {
                this.api.kernel.SpeakingItemsManager.triggerPrivateEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_LEVEL_UP);
            } // end if
        } // end if
        this.Inventory.updateItem(_loc3.index, oNewItem);
    };
    _loc1.updateItemQuantity = function (nItemNum, nQuantity)
    {
        var _loc4 = this.Inventory.findFirstItem("ID", nItemNum);
        var _loc5 = _loc4.item;
        _loc5.Quantity = nQuantity;
        this.Inventory.updateItem(_loc4.index, _loc5);
    };
    _loc1.updateItemPosition = function (nItemNum, nPosition)
    {
        var _loc4 = this.Inventory.findFirstItem("ID", nItemNum);
        var _loc5 = _loc4.item;
        if (_loc5.position == 1)
        {
            this.setWeaponItem();
        }
        else if (nPosition == 1)
        {
            this.setWeaponItem(_loc5);
        } // end else if
        _loc5.position = nPosition;
        this.Inventory.updateItem(_loc4.index, _loc5);
    };
    _loc1.dropItem = function (nItemNum)
    {
        var _loc3 = this.Inventory.findFirstItem("ID", nItemNum);
        if (_loc3.item.position == 1)
        {
            this.setWeaponItem();
        } // end if
        this.Inventory.removeItems(_loc3.index, 1);
    };
    _loc1.updateSpell = function (oSpell)
    {
        var _loc3 = this.Spells.findFirstItem("ID", oSpell.ID);
        if (_loc3.index != -1)
        {
            oSpell.position = _loc3.item.position;
            this.Spells.updateItem(_loc3.index, oSpell);
        }
        else
        {
            this.Spells.push(oSpell);
        } // end else if
    };
    _loc1.updateSpellPosition = function (oSpell)
    {
        var _loc3 = this.Spells.findFirstItem("position", oSpell.position);
        var _loc4 = this.Spells.findFirstItem("ID", oSpell.ID);
        if (_loc3.index != -1)
        {
            _loc3.item.position = undefined;
            this.Spells.updateItem(_loc3.index, oSpell);
        } // end if
        if (_loc4.index != -1)
        {
            this.Spells.updateItem(_loc3.index, oSpell);
        }
        else
        {
            this.Spells.push(oSpell);
        } // end else if
    };
    _loc1.removeSpell = function (nID)
    {
        var _loc3 = this.Spells.findFirstItem("ID", nID);
        if (_loc3.index != -1)
        {
            this.Spells.removeItems(_loc3.index, 1);
        } // end if
    };
    _loc1.canBoost = function (nCharacID)
    {
        if (this.api.datacenter.Game.isRunning)
        {
            return (false);
        } // end if
        var _loc3 = this.getBoostCostAndCountForCharacteristic(nCharacID).cost;
        if (this._nBonusPoints >= _loc3)
        {
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    };
    _loc1.getBoostCostAndCountForCharacteristic = function (nCharacID)
    {
        var _loc3 = this.api.lang.getClassText(this._nGuild)["b" + nCharacID];
        var _loc4 = 1;
        var _loc5 = 1;
        var _loc6 = 0;
        switch (nCharacID)
        {
            case 10:
            {
                _loc6 = this._nForce;
                break;
            } 
            case 11:
            {
                _loc6 = this._nVitality;
                break;
            } 
            case 12:
            {
                _loc6 = this._nWisdom;
                break;
            } 
            case 13:
            {
                _loc6 = this._nChance;
                break;
            } 
            case 14:
            {
                _loc6 = this._agility;
                break;
            } 
            case 15:
            {
                _loc6 = this._intelligence;
                break;
            } 
        } // End of switch
        var _loc7 = 0;
        
        while (++_loc7, _loc7 < _loc3.length)
        {
            var _loc8 = _loc3[_loc7][0];
            if (_loc6 >= _loc8)
            {
                _loc4 = _loc3[_loc7][1];
                _loc5 = _loc3[_loc7][2] == undefined ? (1) : (_loc3[_loc7][2]);
                continue;
            } // end if
            break;
        } // end while
        return ({cost: _loc4, count: _loc5});
    };
    _loc1.isAtHome = function (nMapID)
    {
        var _loc3 = Number(this.api.lang.getHousesMapText(nMapID));
        if (_loc3 != undefined)
        {
            return (this.api.datacenter.Houses.getItemAt(_loc3).localOwner);
        }
        else
        {
            return (false);
        } // end else if
    };
    _loc1.clearEmotes = function ()
    {
        this.Emotes = new ank.utils.ExtendedObject();
    };
    _loc1.addEmote = function (nEmoteID)
    {
        this.Emotes.addItemAt(nEmoteID, true);
    };
    _loc1.hasEmote = function (nEmoteID)
    {
        return (this.Emotes.getItemAt(nEmoteID) == true);
    };
    _loc1.updateCloseCombat = function ()
    {
        this.Spells[0] = new dofus.datacenter.CloseCombat(this._oWeaponItem, this._nGuild);
    };
    _loc1.setWeaponItem = function (oItem)
    {
        this._oWeaponItem = oItem;
        this.updateCloseCombat();
    };
    _loc1.addProperty("canBeMerchant", _loc1.__get__canBeMerchant, function ()
    {
    });
    _loc1.addProperty("currentJobID", _loc1.__get__currentJobID, _loc1.__set__currentJobID);
    _loc1.addProperty("EnergyMax", _loc1.__get__EnergyMax, _loc1.__set__EnergyMax);
    _loc1.addProperty("Force", _loc1.__get__Force, _loc1.__set__Force);
    _loc1.addProperty("mountXPPercent", _loc1.__get__mountXPPercent, _loc1.__set__mountXPPercent);
    _loc1.addProperty("VitalityXtra", _loc1.__get__VitalityXtra, _loc1.__set__VitalityXtra);
    _loc1.addProperty("restrictions", _loc1.__get__restrictions, _loc1.__set__restrictions);
    _loc1.addProperty("XPlow", _loc1.__get__XPlow, _loc1.__set__XPlow);
    _loc1.addProperty("currentWeight", _loc1.__get__currentWeight, _loc1.__set__currentWeight);
    _loc1.addProperty("weaponItem", _loc1.__get__weaponItem, function ()
    {
    });
    _loc1.addProperty("cantInteractWithPrism", _loc1.__get__cantInteractWithPrism, function ()
    {
    });
    _loc1.addProperty("Wisdom", _loc1.__get__Wisdom, _loc1.__set__Wisdom);
    _loc1.addProperty("Vitality", _loc1.__get__Vitality, _loc1.__set__Vitality);
    _loc1.addProperty("XPhigh", _loc1.__get__XPhigh, _loc1.__set__XPhigh);
    _loc1.addProperty("inParty", _loc1.__get__inParty, _loc1.__set__inParty);
    _loc1.addProperty("Agility", _loc1.__get__Agility, _loc1.__set__Agility);
    _loc1.addProperty("MaxSummonedCreatures", _loc1.__get__MaxSummonedCreatures, _loc1.__set__MaxSummonedCreatures);
    _loc1.addProperty("alignment", _loc1.__get__alignment, _loc1.__set__alignment);
    _loc1.addProperty("Chance", _loc1.__get__Chance, _loc1.__set__Chance);
    _loc1.addProperty("isCurrentPlayer", _loc1.__get__isCurrentPlayer, function ()
    {
    });
    _loc1.addProperty("canChallenge", _loc1.__get__canChallenge, function ()
    {
    });
    _loc1.addProperty("specialization", _loc1.__get__specialization, _loc1.__set__specialization);
    _loc1.addProperty("MP", _loc1.__get__MP, _loc1.__set__MP);
    _loc1.addProperty("canExchange", _loc1.__get__canExchange, function ()
    {
    });
    _loc1.addProperty("craftPublicMode", _loc1.__get__craftPublicMode, _loc1.__set__craftPublicMode);
    _loc1.addProperty("RangeModerator", _loc1.__get__RangeModerator, _loc1.__set__RangeModerator);
    _loc1.addProperty("BonusPointsSpell", _loc1.__get__BonusPointsSpell, _loc1.__set__BonusPointsSpell);
    _loc1.addProperty("BonusPoints", _loc1.__get__BonusPoints, _loc1.__set__BonusPoints);
    _loc1.addProperty("data", _loc1.__get__data, function ()
    {
    });
    _loc1.addProperty("canAttackMonstersAnywhereWhenMutant", _loc1.__get__canAttackMonstersAnywhereWhenMutant, function ()
    {
    });
    _loc1.addProperty("canAttack", _loc1.__get__canAttack, function ()
    {
    });
    _loc1.addProperty("fakeAlignment", _loc1.__get__fakeAlignment, _loc1.__set__fakeAlignment);
    _loc1.addProperty("XP", _loc1.__get__XP, _loc1.__set__XP);
    _loc1.addProperty("Kama", _loc1.__get__Kama, _loc1.__set__Kama);
    _loc1.addProperty("Level", _loc1.__get__Level, _loc1.__set__Level);
    _loc1.addProperty("SummonedCreatures", _loc1.__get__SummonedCreatures, _loc1.__set__SummonedCreatures);
    _loc1.addProperty("clip", _loc1.__get__clip, function ()
    {
    });
    _loc1.addProperty("maxWeight", _loc1.__get__maxWeight, _loc1.__set__maxWeight);
    _loc1.addProperty("AP", _loc1.__get__AP, _loc1.__set__AP);
    _loc1.addProperty("LPmax", _loc1.__get__LPmax, _loc1.__set__LPmax);
    _loc1.addProperty("rank", _loc1.__get__rank, _loc1.__set__rank);
    _loc1.addProperty("canUseObject", _loc1.__get__canUseObject, function ()
    {
    });
    _loc1.addProperty("color1", _loc1.__get__color1, _loc1.__set__color1);
    _loc1.addProperty("color2", _loc1.__get__color2, _loc1.__set__color2);
    _loc1.addProperty("isRiding", _loc1.__get__isRiding, _loc1.__set__isRiding);
    _loc1.addProperty("Discernment", _loc1.__get__Discernment, _loc1.__set__Discernment);
    _loc1.addProperty("color3", _loc1.__get__color3, _loc1.__set__color3);
    _loc1.addProperty("mount", _loc1.__get__mount, _loc1.__set__mount);
    _loc1.addProperty("Intelligence", _loc1.__get__Intelligence, _loc1.__set__Intelligence);
    _loc1.addProperty("isMutant", _loc1.__get__isMutant, function ()
    {
    });
    _loc1.addProperty("AgilityXtra", _loc1.__get__AgilityXtra, _loc1.__set__AgilityXtra);
    _loc1.addProperty("ID", _loc1.__get__ID, _loc1.__set__ID);
    _loc1.addProperty("IntelligenceXtra", _loc1.__get__IntelligenceXtra, _loc1.__set__IntelligenceXtra);
    _loc1.addProperty("Name", _loc1.__get__Name, _loc1.__set__Name);
    _loc1.addProperty("AgilityTotal", _loc1.__get__AgilityTotal, _loc1.__set__AgilityTotal);
    _loc1.addProperty("canAssault", _loc1.__get__canAssault, function ()
    {
    });
    _loc1.addProperty("canAttackDungeonMonstersWhenMutant", _loc1.__get__canAttackDungeonMonstersWhenMutant, function ()
    {
    });
    _loc1.addProperty("LP", _loc1.__get__LP, _loc1.__set__LP);
    _loc1.addProperty("cantSpeakNPC", _loc1.__get__cantSpeakNPC, function ()
    {
    });
    _loc1.addProperty("Sex", _loc1.__get__Sex, _loc1.__set__Sex);
    _loc1.addProperty("canMoveInAllDirections", _loc1.__get__canMoveInAllDirections, function ()
    {
    });
    _loc1.addProperty("ChanceXtra", _loc1.__get__ChanceXtra, _loc1.__set__ChanceXtra);
    _loc1.addProperty("currentJob", _loc1.__get__currentJob, function ()
    {
    });
    _loc1.addProperty("FullStats", _loc1.__get__FullStats, _loc1.__set__FullStats);
    _loc1.addProperty("Guild", _loc1.__get__Guild, _loc1.__set__Guild);
    _loc1.addProperty("cantInteractWithTaxCollector", _loc1.__get__cantInteractWithTaxCollector, function ()
    {
    });
    _loc1.addProperty("ForceXtra", _loc1.__get__ForceXtra, _loc1.__set__ForceXtra);
    _loc1.addProperty("canChatToAll", _loc1.__get__canChatToAll, function ()
    {
    });
    _loc1.addProperty("Initiative", _loc1.__get__Initiative, _loc1.__set__Initiative);
    _loc1.addProperty("WisdomXtra", _loc1.__get__WisdomXtra, _loc1.__set__WisdomXtra);
    _loc1.addProperty("canUseInteractiveObjects", _loc1.__get__canUseInteractiveObjects, function ()
    {
    });
    _loc1.addProperty("CriticalHitBonus", _loc1.__get__CriticalHitBonus, _loc1.__set__CriticalHitBonus);
    _loc1.addProperty("Energy", _loc1.__get__Energy, _loc1.__set__Energy);
    ASSetPropFlags(_loc1, null, 1);
    _loc1.isAuthorized = false;
    _loc1.haveFakeAlignment = false;
    _loc1._nSummonedCreatures = 0;
    _loc1._bIsRiding = false;
} // end if
#endinitclip
