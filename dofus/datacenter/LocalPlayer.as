// Action script...

// [Initial MovieClip Action of sprite 909]
#initclip 121
class dofus.datacenter.LocalPlayer extends dofus.utils.ApiElement
{
    var SpellsManager, __get__api, InteractionsManager, Inventory, ItemSets, Jobs, Spells, Emotes, _nMaxSummonedCreatures, summonedCreaturesID, _sID, api, __get__ID, _sName, __get__Name, _nGuild, __get__Guild, _nLevel, dispatchEvent, __get__Level, _nSex, __get__Sex, _nColor1, __get__color1, _nColor2, __get__color2, _nColor3, __get__color3, _nLP, __get__LP, _nLPMax, __get__LPmax, _nAP, __get__AP, _nMP, __get__MP, _nKama, __get__Kama, _nXPLow, __get__XPlow, _nXP, __get__XP, _nXPHigh, __get__XPhigh, _nInitiative, __get__Initiative, _nDiscernment, __get__Discernment, _nForce, __get__Force, _nForceXtra, __get__ForceXtra, _nVitality, __get__Vitality, _nVitalityXtra, __get__VitalityXtra, _nWisdom, __get__Wisdom, _nWisdomXtra, __get__WisdomXtra, _nChance, __get__Chance, _nChanceXtra, __get__ChanceXtra, _agility, __get__Agility, _nAgilityXtra, __get__AgilityXtra, _intelligence, __get__Intelligence, _nIntelligenceXtra, __get__IntelligenceXtra, _nBonusPoints, __get__BonusPoints, _nBonusPointsSpell, __get__BonusPointsSpell, _nRangeModerator, __get__RangeModerator, _nEnergy, __get__Energy, _nEnergyMax, __get__EnergyMax, __get__SummonedCreatures, __get__MaxSummonedCreatures, _nCurrentJobID, __get__currentJobID, _nCurrentWeight, __get__currentWeight, _nMaxWeight, __get__maxWeight, __get__data, _nRestrictions, __get__restrictions, _oSpecialization, __get__specialization, _oAlignment, __get__alignment, currentUseObject, _oWeaponItem, __set__AP, __set__Agility, __set__AgilityXtra, __set__BonusPoints, __set__BonusPointsSpell, __set__Chance, __set__ChanceXtra, __set__Discernment, __set__Energy, __set__EnergyMax, __set__Force, __set__ForceXtra, __set__Guild, __set__ID, __set__Initiative, __set__Intelligence, __set__IntelligenceXtra, __set__Kama, __set__LP, __set__LPmax, __set__Level, __set__MP, __set__MaxSummonedCreatures, __set__Name, __set__RangeModerator, __set__Sex, __set__SummonedCreatures, __set__Vitality, __set__VitalityXtra, __set__Wisdom, __set__WisdomXtra, __set__XP, __set__XPhigh, __set__XPlow, __set__alignment, __get__canAssault, __get__canAttack, __get__canBeMerchant, __get__canChallenge, __get__canChatToAll, __get__canExchange, __get__canUseInteractiveObjects, __get__canUseObject, __get__cantInteractWithTaxCollector, __get__cantSpeakNPC, __get__clip, __set__color1, __set__color2, __set__color3, __get__currentJob, __set__currentJobID, __set__currentWeight, __get__isCurrentPlayer, __get__isMutant, __set__maxWeight, __set__restrictions, __set__specialization;
    function LocalPlayer(oAPI)
    {
        super();
        this.initialize(oAPI);
    } // End of the function
    function initialize(oAPI)
    {
        super.initialize(oAPI);
        mx.events.EventDispatcher.initialize(this);
        this.clean();
        mx.events.EventDispatcher.initialize(this);
    } // End of the function
    function clean()
    {
        SpellsManager = new dofus.managers.SpellsManager(this);
        InteractionsManager = new dofus.managers.InteractionsManager(this, this.__get__api());
        Inventory = new ank.utils.ExtendedArray();
        ItemSets = new ank.utils.ExtendedObject();
        Jobs = new ank.utils.ExtendedArray();
        Spells = new ank.utils.ExtendedArray();
        Emotes = new ank.utils.ExtendedObject();
        this.clearSummon();
    } // End of the function
    function clearSummon()
    {
        _nSummonedCreatures = 0;
        _nMaxSummonedCreatures = 1;
        summonedCreaturesID = new Object();
    } // End of the function
    function get clip()
    {
        return (api.datacenter.Sprites.getItemAt(_sID).mc);
    } // End of the function
    function get data()
    {
        return (api.datacenter.Sprites.getItemAt(_sID));
    } // End of the function
    function get isCurrentPlayer()
    {
        return (api.datacenter.Game.currentPlayerID == _sID);
    } // End of the function
    function set ID(value)
    {
        _sID = value;
        //return (this.ID());
        null;
    } // End of the function
    function get ID()
    {
        return (_sID);
    } // End of the function
    function set Name(value)
    {
        _sName = String(value);
        //return (this.Name());
        null;
    } // End of the function
    function get Name()
    {
        return (_sName);
    } // End of the function
    function set Guild(value)
    {
        _nGuild = Number(value);
        //return (this.Guild());
        null;
    } // End of the function
    function get Guild()
    {
        return (_nGuild);
    } // End of the function
    function set Level(value)
    {
        _nLevel = Number(value);
        this.dispatchEvent({type: "levelChanged", value: value});
        //return (this.Level());
        null;
    } // End of the function
    function get Level()
    {
        return (_nLevel);
    } // End of the function
    function set Sex(value)
    {
        _nSex = Number(value);
        //return (this.Sex());
        null;
    } // End of the function
    function get Sex()
    {
        return (_nSex);
    } // End of the function
    function set color1(value)
    {
        _nColor1 = Number(value);
        //return (this.color1());
        null;
    } // End of the function
    function get color1()
    {
        return (_nColor1);
    } // End of the function
    function set color2(value)
    {
        _nColor2 = Number(value);
        //return (this.color2());
        null;
    } // End of the function
    function get color2()
    {
        return (_nColor2);
    } // End of the function
    function set color3(value)
    {
        _nColor3 = Number(value);
        //return (this.color3());
        null;
    } // End of the function
    function get color3()
    {
        return (_nColor3);
    } // End of the function
    function set LP(value)
    {
        _nLP = Number(value) > 0 ? (Number(value)) : (0);
        this.dispatchEvent({type: "lpChanged", value: value});
        //return (this.LP());
        null;
    } // End of the function
    function get LP()
    {
        return (_nLP);
    } // End of the function
    function set LPmax(value)
    {
        _nLPMax = Number(value);
        this.dispatchEvent({type: "lpmaxChanged", value: value});
        //return (this.LPmax());
        null;
    } // End of the function
    function get LPmax()
    {
        return (_nLPMax);
    } // End of the function
    function set AP(value)
    {
        _nAP = Number(value);
        this.dispatchEvent({type: "apChanged", value: value});
        //return (this.AP());
        null;
    } // End of the function
    function get AP()
    {
        return (_nAP);
    } // End of the function
    function set MP(value)
    {
        _nMP = Number(value);
        this.dispatchEvent({type: "mpChanged", value: value});
        //return (this.MP());
        null;
    } // End of the function
    function get MP()
    {
        return (_nMP);
    } // End of the function
    function set Kama(value)
    {
        _nKama = Number(value);
        this.dispatchEvent({type: "kamaChanged", value: value});
        //return (this.Kama());
        null;
    } // End of the function
    function get Kama()
    {
        return (_nKama);
    } // End of the function
    function set XPlow(value)
    {
        _nXPLow = Number(value);
        //return (this.XPlow());
        null;
    } // End of the function
    function get XPlow()
    {
        return (_nXPLow);
    } // End of the function
    function set XP(value)
    {
        _nXP = Number(value);
        this.dispatchEvent({type: "xpChanged", value: value});
        //return (this.XP());
        null;
    } // End of the function
    function get XP()
    {
        return (_nXP);
    } // End of the function
    function set XPhigh(value)
    {
        _nXPHigh = Number(value);
        //return (this.XPhigh());
        null;
    } // End of the function
    function get XPhigh()
    {
        return (_nXPHigh);
    } // End of the function
    function set Initiative(value)
    {
        _nInitiative = Number(value);
        this.dispatchEvent({type: "initiativeChanged", value: value});
        //return (this.Initiative());
        null;
    } // End of the function
    function get Initiative()
    {
        return (_nInitiative);
    } // End of the function
    function set Discernment(value)
    {
        _nDiscernment = Number(value);
        this.dispatchEvent({type: "discernmentChanged", value: value});
        //return (this.Discernment());
        null;
    } // End of the function
    function get Discernment()
    {
        return (_nDiscernment);
    } // End of the function
    function set Force(value)
    {
        _nForce = Number(value);
        this.dispatchEvent({type: "forceChanged", value: value});
        //return (this.Force());
        null;
    } // End of the function
    function get Force()
    {
        return (_nForce);
    } // End of the function
    function set ForceXtra(value)
    {
        _nForceXtra = Number(value);
        this.dispatchEvent({type: "forceXtraChanged", value: value});
        //return (this.ForceXtra());
        null;
    } // End of the function
    function get ForceXtra()
    {
        return (_nForceXtra);
    } // End of the function
    function set Vitality(value)
    {
        _nVitality = Number(value);
        this.dispatchEvent({type: "vitalityChanged", value: value});
        //return (this.Vitality());
        null;
    } // End of the function
    function get Vitality()
    {
        return (_nVitality);
    } // End of the function
    function set VitalityXtra(value)
    {
        _nVitalityXtra = Number(value);
        this.dispatchEvent({type: "vitalityXtraChanged", value: value});
        //return (this.VitalityXtra());
        null;
    } // End of the function
    function get VitalityXtra()
    {
        return (_nVitalityXtra);
    } // End of the function
    function set Wisdom(value)
    {
        _nWisdom = Number(value);
        this.dispatchEvent({type: "wisdomChanged", value: value});
        //return (this.Wisdom());
        null;
    } // End of the function
    function get Wisdom()
    {
        return (_nWisdom);
    } // End of the function
    function set WisdomXtra(value)
    {
        _nWisdomXtra = Number(value);
        this.dispatchEvent({type: "wisdomXtraChanged", value: value});
        //return (this.WisdomXtra());
        null;
    } // End of the function
    function get WisdomXtra()
    {
        return (_nWisdomXtra);
    } // End of the function
    function set Chance(value)
    {
        _nChance = Number(value);
        this.dispatchEvent({type: "chanceChanged", value: value});
        //return (this.Chance());
        null;
    } // End of the function
    function get Chance()
    {
        return (_nChance);
    } // End of the function
    function set ChanceXtra(value)
    {
        _nChanceXtra = Number(value);
        this.dispatchEvent({type: "chanceXtraChanged", value: value});
        //return (this.ChanceXtra());
        null;
    } // End of the function
    function get ChanceXtra()
    {
        return (_nChanceXtra);
    } // End of the function
    function set Agility(value)
    {
        _agility = Number(value);
        this.dispatchEvent({type: "agilityChanged", value: value});
        //return (this.Agility());
        null;
    } // End of the function
    function get Agility()
    {
        return (_agility);
    } // End of the function
    function set AgilityXtra(value)
    {
        _nAgilityXtra = Number(value);
        this.dispatchEvent({type: "agilityXtraChanged", value: value});
        //return (this.AgilityXtra());
        null;
    } // End of the function
    function get AgilityXtra()
    {
        return (_nAgilityXtra);
    } // End of the function
    function set Intelligence(value)
    {
        _intelligence = Number(value);
        this.dispatchEvent({type: "intelligenceChanged", value: value});
        //return (this.Intelligence());
        null;
    } // End of the function
    function get Intelligence()
    {
        return (_intelligence);
    } // End of the function
    function set IntelligenceXtra(value)
    {
        _nIntelligenceXtra = Number(value);
        this.dispatchEvent({type: "intelligenceXtraChanged", value: value});
        //return (this.IntelligenceXtra());
        null;
    } // End of the function
    function get IntelligenceXtra()
    {
        return (_nIntelligenceXtra);
    } // End of the function
    function set BonusPoints(value)
    {
        _nBonusPoints = Number(value);
        this.dispatchEvent({type: "bonusPointsChanged", value: value});
        //return (this.BonusPoints());
        null;
    } // End of the function
    function get BonusPoints()
    {
        return (_nBonusPoints);
    } // End of the function
    function set BonusPointsSpell(value)
    {
        _nBonusPointsSpell = Number(value);
        this.dispatchEvent({type: "bonusSpellsChanged", value: value});
        //return (this.BonusPointsSpell());
        null;
    } // End of the function
    function get BonusPointsSpell()
    {
        return (_nBonusPointsSpell);
    } // End of the function
    function set RangeModerator(value)
    {
        _nRangeModerator = Number(value);
        //return (this.RangeModerator());
        null;
    } // End of the function
    function get RangeModerator()
    {
        return (_nRangeModerator);
    } // End of the function
    function set Energy(value)
    {
        _nEnergy = Number(value);
        this.dispatchEvent({type: "energyChanged", value: value});
        //return (this.Energy());
        null;
    } // End of the function
    function get Energy()
    {
        return (_nEnergy);
    } // End of the function
    function set EnergyMax(value)
    {
        _nEnergyMax = Number(value);
        this.dispatchEvent({type: "energyMaxChanged", value: value});
        //return (this.EnergyMax());
        null;
    } // End of the function
    function get EnergyMax()
    {
        return (_nEnergyMax);
    } // End of the function
    function set SummonedCreatures(value)
    {
        _nSummonedCreatures = Number(value);
        //return (this.SummonedCreatures());
        null;
    } // End of the function
    function get SummonedCreatures()
    {
        return (_nSummonedCreatures);
    } // End of the function
    function set MaxSummonedCreatures(value)
    {
        _nMaxSummonedCreatures = Number(value);
        //return (this.MaxSummonedCreatures());
        null;
    } // End of the function
    function get MaxSummonedCreatures()
    {
        return (_nMaxSummonedCreatures);
    } // End of the function
    function set currentJobID(value)
    {
        if (value == undefined)
        {
            delete this._nCurrentJobID;
        }
        else
        {
            _nCurrentJobID = Number(value);
        } // end else if
        //return (this.currentJobID());
        null;
    } // End of the function
    function get currentJobID()
    {
        return (_nCurrentJobID);
    } // End of the function
    function get currentJob()
    {
        var _loc2 = Jobs.findFirstItem("id", _nCurrentJobID);
        return (_loc2.item);
    } // End of the function
    function set currentWeight(value)
    {
        _nCurrentWeight = value;
        this.dispatchEvent({type: "currentWeightChanged", value: value});
        //return (this.currentWeight());
        null;
    } // End of the function
    function get currentWeight()
    {
        return (_nCurrentWeight);
    } // End of the function
    function set maxWeight(value)
    {
        _nMaxWeight = value;
        this.dispatchEvent({type: "maxWeightChanged", value: value});
        //return (this.maxWeight());
        null;
    } // End of the function
    function get maxWeight()
    {
        return (_nMaxWeight);
    } // End of the function
    function get isMutant()
    {
        //return (this.data() instanceof dofus.datacenter.Mutant);
    } // End of the function
    function set restrictions(value)
    {
        _nRestrictions = value;
        //return (this.restrictions());
        null;
    } // End of the function
    function get restrictions()
    {
        return (_nRestrictions);
    } // End of the function
    function set specialization(value)
    {
        _oSpecialization = value;
        this.dispatchEvent({type: "specializationChanged", value: value});
        //return (this.specialization());
        null;
    } // End of the function
    function get specialization()
    {
        return (_oSpecialization);
    } // End of the function
    function set alignment(value)
    {
        _oAlignment = value;
        this.dispatchEvent({type: "alignmentChanged", alignment: value});
        //return (this.alignment());
        null;
    } // End of the function
    function get alignment()
    {
        return (_oAlignment);
    } // End of the function
    function get canAssault()
    {
        return ((_nRestrictions & 1) != 1);
    } // End of the function
    function get canChallenge()
    {
        return ((_nRestrictions & 2) != 2);
    } // End of the function
    function get canExchange()
    {
        return ((_nRestrictions & 4) != 4);
    } // End of the function
    function get canAttack()
    {
        return ((_nRestrictions & 8) == 8);
    } // End of the function
    function get canChatToAll()
    {
        return ((_nRestrictions & 16) != 16);
    } // End of the function
    function get canBeMerchant()
    {
        return ((_nRestrictions & 32) != 32);
    } // End of the function
    function get canUseObject()
    {
        return ((_nRestrictions & 64) != 64);
    } // End of the function
    function get cantInteractWithTaxCollector()
    {
        return ((_nRestrictions & 128) == 128);
    } // End of the function
    function get canUseInteractiveObjects()
    {
        return ((_nRestrictions & 256) != 256);
    } // End of the function
    function get cantSpeakNPC()
    {
        return ((_nRestrictions & 512) == 512);
    } // End of the function
    function reset()
    {
        currentUseObject = null;
    } // End of the function
    function updateLP(dLP)
    {
        dLP = Number(dLP);
        if (this.__get__LP() + dLP > this.__get__LPmax())
        {
            dLP = this.__get__LPmax() - this.__get__LP();
        } // end if
        LP = LP + dLP;
    } // End of the function
    function hasEnoughAP(wantedAP)
    {
        return (data.AP >= wantedAP);
    } // End of the function
    function addItem(oItem)
    {
        if (oItem.position == 1)
        {
            this.setWeaponItem(oItem);
        } // end if
        Inventory.push(oItem);
    } // End of the function
    function updateItem(oNewItem)
    {
        var _loc2 = Inventory.findFirstItem("ID", oNewItem.ID);
        Inventory.updateItem(_loc2.index, oNewItem);
    } // End of the function
    function updateItemQuantity(nItemNum, nQuantity)
    {
        var _loc2 = Inventory.findFirstItem("ID", nItemNum);
        var _loc3 = _loc2.item;
        _loc3.Quantity = nQuantity;
        Inventory.updateItem(_loc2.index, _loc3);
    } // End of the function
    function updateItemPosition(nItemNum, nPosition)
    {
        var _loc3 = Inventory.findFirstItem("ID", nItemNum);
        var _loc2 = _loc3.item;
        if (_loc2.position == 1)
        {
            this.setWeaponItem();
        }
        else if (nPosition == 1)
        {
            this.setWeaponItem(_loc2);
        } // end else if
        _loc2.position = nPosition;
        Inventory.updateItem(_loc3.index, _loc2);
    } // End of the function
    function dropItem(nItemNum)
    {
        var _loc2 = Inventory.findFirstItem("ID", nItemNum);
        if (_loc2.item.position == 1)
        {
            this.setWeaponItem();
        } // end if
        Inventory.removeItems(_loc2.index, 1);
    } // End of the function
    function updateSpell(oSpell)
    {
        var _loc2 = Spells.findFirstItem("ID", oSpell.ID);
        if (_loc2.index != -1)
        {
            oSpell.position = _loc2.item.position;
            Spells.updateItem(_loc2.index, oSpell);
        }
        else
        {
            Spells.push(oSpell);
        } // end else if
    } // End of the function
    function updateSpellPosition(oSpell)
    {
        var _loc2 = Spells.findFirstItem("position", oSpell.position);
        var _loc4 = Spells.findFirstItem("ID", oSpell.ID);
        if (_loc2.index != -1)
        {
            _loc2.item.position = undefined;
            Spells.updateItem(_loc2.index, oSpell);
        } // end if
        if (_loc4.index != -1)
        {
            Spells.updateItem(_loc2.index, oSpell);
        }
        else
        {
            Spells.push(oSpell);
        } // end else if
    } // End of the function
    function removeSpell(nID)
    {
        var _loc2 = Spells.findFirstItem("ID", nID);
        if (_loc2.index != -1)
        {
            Spells.removeItems(_loc2.index, 1);
        } // end if
    } // End of the function
    function canBoost(nCharacID)
    {
        if (api.datacenter.Game.isRunning)
        {
            return (false);
        } // end if
        var _loc2 = this.getBoostCostAndCountForCharacteristic(nCharacID).cost;
        if (_nBonusPoints >= _loc2)
        {
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function getBoostCostAndCountForCharacteristic(nCharacID)
    {
        var _loc3 = api.lang.getClassText(_nGuild)["b" + nCharacID];
        var _loc7 = 1;
        var _loc6 = 1;
        var _loc5 = 0;
        switch (nCharacID)
        {
            case 10:
            {
                _loc5 = _nForce;
                break;
            } 
            case 11:
            {
                _loc5 = _nVitality;
                break;
            } 
            case 12:
            {
                _loc5 = _nWisdom;
                break;
            } 
            case 13:
            {
                _loc5 = _nChance;
                break;
            } 
            case 14:
            {
                _loc5 = _agility;
                break;
            } 
            case 15:
            {
                _loc5 = _intelligence;
                break;
            } 
        } // End of switch
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
    } // End of the function
    function isAtHome(nMapID)
    {
        var _loc2 = Number(api.lang.getHousesMapText(nMapID));
        if (_loc2 != undefined)
        {
            return (api.datacenter.Houses.getItemAt(_loc2).localOwner);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function clearEmotes()
    {
        Emotes = new ank.utils.ExtendedObject();
    } // End of the function
    function addEmote(nEmoteID)
    {
        Emotes.addItemAt(nEmoteID, true);
    } // End of the function
    function hasEmote(nEmoteID)
    {
        return (Emotes.getItemAt(nEmoteID) == true);
    } // End of the function
    function updateCloseCombat()
    {
        Spells[0] = new dofus.datacenter.CloseCombat(_oWeaponItem, _nGuild);
    } // End of the function
    function setWeaponItem(oItem)
    {
        _oWeaponItem = oItem;
        this.updateCloseCombat();
    } // End of the function
    var isAuthorized = false;
    var _nSummonedCreatures = 0;
} // End of Class
#endinitclip
