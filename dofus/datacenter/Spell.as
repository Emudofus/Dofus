// Action script...

// [Initial MovieClip Action of sprite 20753]
#initclip 18
if (!dofus.datacenter.Spell)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Spell = function (nID, nLevel, sCompressedPosition)
    {
        super();
        this.initialize(nID, nLevel, sCompressedPosition);
    }).prototype;
    _loc1.__get__ID = function ()
    {
        return (this._nID);
    };
    _loc1.__get__isValid = function ()
    {
        return (this._oSpellText["l" + this._nLevel] != undefined);
    };
    _loc1.__get__maxLevel = function ()
    {
        return (this._nMaxLevel);
    };
    _loc1.__set__level = function (nLevel)
    {
        this._nLevel = nLevel;
        //return (this.level());
    };
    _loc1.__get__level = function ()
    {
        return (this._nLevel);
    };
    _loc1.__set__position = function (nPosition)
    {
        this._nPosition = nPosition;
        //return (this.position());
    };
    _loc1.__get__position = function ()
    {
        return (this._nPosition);
    };
    _loc1.__set__animID = function (nAnimID)
    {
        this._nAnimID = nAnimID;
        //return (this.animID());
    };
    _loc1.__get__animID = function ()
    {
        return (this._nAnimID);
    };
    _loc1.__get__summonSpell = function ()
    {
        return (this._bSummonSpell);
    };
    _loc1.__get__glyphSpell = function ()
    {
        return (this.searchIfGlyph(this.getSpellLevelText(0)));
    };
    _loc1.__get__trapSpell = function ()
    {
        return (this.searchIfTrap(this.getSpellLevelText(0)));
    };
    _loc1.__set__inFrontOfSprite = function (bInFrontOfSprite)
    {
        this._bInFrontOfSprite = bInFrontOfSprite;
        //return (this.inFrontOfSprite());
    };
    _loc1.__get__inFrontOfSprite = function ()
    {
        return (this._bInFrontOfSprite);
    };
    _loc1.__get__iconFile = function ()
    {
        return (dofus.Constants.SPELLS_ICONS_PATH + this._nID + ".swf");
    };
    _loc1.__get__file = function ()
    {
        return (dofus.Constants.SPELLS_PATH + this._nAnimID + ".swf");
    };
    _loc1.__get__name = function ()
    {
        return (this._oSpellText.n);
    };
    _loc1.__get__description = function ()
    {
        return (this._oSpellText.d);
    };
    _loc1.__get__apCost = function ()
    {
        var _loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_AP_COST, this._nID);
        var _loc3 = this.getSpellLevelText(2);
        if (_loc2 > -1)
        {
            return (_loc3 - _loc2);
        } // end if
        return (_loc3);
    };
    _loc1.__get__rangeMin = function ()
    {
        return (this.getSpellLevelText(3));
    };
    _loc1.__get__rangeMax = function ()
    {
        var _loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_RANGE, this._nID);
        var _loc3 = this.getSpellLevelText(4);
        if (_loc2 > -1)
        {
            return (_loc3 + _loc2);
        } // end if
        return (_loc3);
    };
    _loc1.__get__rangeStr = function ()
    {
        return ((this.rangeMin != 0 ? (this.rangeMin + " " + this.api.lang.getText("TO_RANGE") + " ") : ("")) + this.rangeMax);
    };
    _loc1.__get__criticalHit = function ()
    {
        var _loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CC, this._nID);
        var _loc3 = this.getSpellLevelText(5);
        if (_loc2 > -1)
        {
            return (_loc3 > 0 ? (Math.max(_loc3 - _loc2, 2)) : (0));
        } // end if
        return (_loc3);
    };
    _loc1.__get__actualCriticalHit = function ()
    {
        return (this.api.kernel.GameManager.getCriticalHitChance(this.criticalHit));
    };
    _loc1.__get__criticalFailure = function ()
    {
        return (this.getSpellLevelText(6));
    };
    _loc1.__get__lineOnly = function ()
    {
        var _loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CASTOUTLINE, this._nID);
        var _loc3 = this.getSpellLevelText(7);
        if (_loc2 > 0)
        {
            return (false);
        } // end if
        return (_loc3);
    };
    _loc1.__get__lineOfSight = function ()
    {
        var _loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_NOLINEOFSIGHT, this._nID);
        var _loc3 = this.getSpellLevelText(8);
        if (_loc2 > 0)
        {
            return (false);
        } // end if
        return (_loc3);
    };
    _loc1.__get__freeCell = function ()
    {
        return (this.getSpellLevelText(9));
    };
    _loc1.__get__canBoostRange = function ()
    {
        var _loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_RANGEABLE, this._nID);
        var _loc3 = this.getSpellLevelText(10);
        if (_loc2 > 0)
        {
            return (true);
        } // end if
        return (_loc3);
    };
    _loc1.__get__classID = function ()
    {
        return (this.getSpellLevelText(11));
    };
    _loc1.__get__launchCountByTurn = function ()
    {
        var _loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_MAXPERTURN, this._nID);
        var _loc3 = this.getSpellLevelText(12);
        if (_loc2 > -1)
        {
            return (_loc3 + _loc2);
        } // end if
        return (_loc3);
    };
    _loc1.__get__launchCountByPlayerTurn = function ()
    {
        var _loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_MAXPERTARGET, this._nID);
        var _loc3 = this.getSpellLevelText(13);
        if (_loc2 > -1)
        {
            return (_loc3 + _loc2);
        } // end if
        return (_loc3);
    };
    _loc1.__get__delayBetweenLaunch = function ()
    {
        var _loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CAST_INTVL, this._nID);
        var _loc3 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_SET_INTVL, this._nID);
        var _loc4 = _loc3 > -1 ? (_loc3) : (this.getSpellLevelText(14));
        if (_loc2 > -1)
        {
            return (_loc4 - _loc2);
        } // end if
        return (_loc4);
    };
    _loc1.__get__descriptionNormalHit = function ()
    {
        return (this.api.kernel.GameManager.getSpellDescriptionWithEffects(this.getSpellLevelText(0), false, this._nID));
    };
    _loc1.__get__descriptionCriticalHit = function ()
    {
        return (this.api.kernel.GameManager.getSpellDescriptionWithEffects(this.getSpellLevelText(1), false, this._nID));
    };
    _loc1.__get__effectsNormalHit = function ()
    {
        return (this.api.kernel.GameManager.getSpellEffects(this.getSpellLevelText(0), this._nID));
    };
    _loc1.__get__effectsCriticalHit = function ()
    {
        return (this.api.kernel.GameManager.getSpellEffects(this.getSpellLevelText(1), this._nID));
    };
    _loc1.__get__effectsNormalHitWithArea = function ()
    {
        var _loc2 = this.api.kernel.GameManager.getSpellEffects(this.getSpellLevelText(0), this._nID);
        var _loc3 = new ank.utils.ExtendedArray();
        var _loc4 = 0;
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc2.length)
        {
            var _loc6 = new Object();
            _loc6.fx = _loc2[_loc5];
            _loc6.at = this._aEffectZones[_loc4 + _loc5].shape;
            _loc6.ar = this._aEffectZones[_loc4 + _loc5].size;
            _loc3.push(_loc6);
        } // end while
        return (_loc3);
    };
    _loc1.__get__effectsCriticalHitWithArea = function ()
    {
        var _loc2 = this.api.kernel.GameManager.getSpellEffects(this.getSpellLevelText(1), this._nID);
        var _loc3 = new ank.utils.ExtendedArray();
        var _loc4 = this.effectsNormalHit.length;
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc2.length)
        {
            var _loc6 = new Object();
            _loc6.fx = _loc2[_loc5];
            _loc6.at = this._aEffectZones[_loc4 + _loc5].shape;
            _loc6.ar = this._aEffectZones[_loc4 + _loc5].size;
            _loc3.push(_loc6);
        } // end while
        return (_loc3);
    };
    _loc1.__get__requiredStates = function ()
    {
        return (this._aRequiredStates);
    };
    _loc1.__get__forbiddenStates = function ()
    {
        return (this._aForbiddenStates);
    };
    _loc1.__get__needStates = function ()
    {
        return (this._aRequiredStates.length > 0 || this._aForbiddenStates.length > 0);
    };
    _loc1.__get__minPlayerLevel = function ()
    {
        return (Number(this.getSpellLevelText(18)));
    };
    _loc1.__get__normalMinPlayerLevel = function ()
    {
        return (Number(this.getSpellLevelText(18, 1)));
    };
    _loc1.__get__criticalFailureEndsTheTurn = function ()
    {
        return (this.getSpellLevelText(19));
    };
    _loc1.__get__elements = function ()
    {
        var _loc2 = {none: false, neutral: false, earth: false, fire: false, water: false, air: false};
        var _loc3 = this.effectsNormalHit;
        for (var k in _loc3)
        {
            var _loc4 = _loc3[k].element;
            switch (_loc4)
            {
                case "N":
                {
                    _loc2.neutral = true;
                    break;
                } 
                case "E":
                {
                    _loc2.earth = true;
                    break;
                } 
                case "F":
                {
                    _loc2.fire = true;
                    break;
                } 
                case "W":
                {
                    _loc2.water = true;
                    break;
                } 
                case "A":
                {
                    _loc2.air = true;
                    break;
                } 
                default:
                {
                    _loc2.none = true;
                    break;
                } 
            } // End of switch
        } // end of for...in
        return (_loc2);
    };
    _loc1.__get__effectZones = function ()
    {
        return (this._aEffectZones);
    };
    _loc1.initialize = function (nID, nLevel, sCompressedPosition)
    {
        this.api = _global.API;
        this._nID = nID;
        this._nLevel = nLevel;
        this._nPosition = ank.utils.Compressor.decode64(sCompressedPosition);
        if (this._nPosition > 24 || this._nPosition < 1)
        {
            this._nPosition = null;
        } // end if
        this._oSpellText = this.api.lang.getSpellText(nID);
        var _loc5 = this.getSpellLevelText(15);
        var _loc6 = _loc5.split("");
        this._aEffectZones = new Array();
        var _loc7 = 0;
        
        while (_loc7 = _loc7 + 2, _loc7 < _loc6.length)
        {
            this._aEffectZones.push({shape: _loc6[_loc7], size: ank.utils.Compressor.decode64(_loc6[_loc7 + 1])});
        } // end while
        this._bSummonSpell = this.searchIfSummon(this.getSpellLevelText(0)) || this.searchIfSummon(this.getSpellLevelText(1));
        this._nMaxLevel = 1;
        var _loc8 = 1;
        
        while (++_loc8, _loc8 <= dofus.Constants.SPELL_BOOST_MAX_LEVEL)
        {
            if (this._oSpellText["l" + _loc8] == undefined)
            {
                break;
                continue;
            } // end if
            this._nMaxLevel = _loc8;
        } // end while
        this._aRequiredStates = this.getSpellLevelText(16);
        this._aForbiddenStates = this.getSpellLevelText(17);
        this._minPlayerLevel = this.normalMinPlayerLevel;
    };
    _loc1.getSpellLevelText = function (nPropertyIndex, nLevel)
    {
        if (nLevel == undefined)
        {
            nLevel = this._nLevel;
        } // end if
        return (this._oSpellText["l" + nLevel][nPropertyIndex]);
    };
    _loc1.searchIfSummon = function (aEffects)
    {
        var _loc3 = aEffects.length;
        if (typeof(aEffects) == "object")
        {
            var _loc4 = 0;
            
            while (++_loc4, _loc4 < _loc3)
            {
                var _loc5 = aEffects[_loc4][0];
                if (_loc5 == 180 || _loc5 == 181)
                {
                    return (true);
                } // end if
            } // end while
        } // end if
        return (false);
    };
    _loc1.searchIfGlyph = function (aEffects)
    {
        var _loc3 = aEffects.length;
        if (typeof(aEffects) == "object")
        {
            var _loc4 = 0;
            
            while (++_loc4, _loc4 < _loc3)
            {
                var _loc5 = aEffects[_loc4][0];
                if (_loc5 == 401)
                {
                    return (true);
                } // end if
            } // end while
        } // end if
        return (false);
    };
    _loc1.searchIfTrap = function (aEffects)
    {
        var _loc3 = aEffects.length;
        if (typeof(aEffects) == "object")
        {
            var _loc4 = 0;
            
            while (++_loc4, _loc4 < _loc3)
            {
                var _loc5 = aEffects[_loc4][0];
                if (_loc5 == 400)
                {
                    return (true);
                } // end if
            } // end while
        } // end if
        return (false);
    };
    _loc1.addProperty("rangeMin", _loc1.__get__rangeMin, function ()
    {
    });
    _loc1.addProperty("apCost", _loc1.__get__apCost, function ()
    {
    });
    _loc1.addProperty("glyphSpell", _loc1.__get__glyphSpell, function ()
    {
    });
    _loc1.addProperty("maxLevel", _loc1.__get__maxLevel, function ()
    {
    });
    _loc1.addProperty("forbiddenStates", _loc1.__get__forbiddenStates, function ()
    {
    });
    _loc1.addProperty("descriptionNormalHit", _loc1.__get__descriptionNormalHit, function ()
    {
    });
    _loc1.addProperty("canBoostRange", _loc1.__get__canBoostRange, function ()
    {
    });
    _loc1.addProperty("criticalFailureEndsTheTurn", _loc1.__get__criticalFailureEndsTheTurn, function ()
    {
    });
    _loc1.addProperty("effectsCriticalHitWithArea", _loc1.__get__effectsCriticalHitWithArea, function ()
    {
    });
    _loc1.addProperty("elements", _loc1.__get__elements, function ()
    {
    });
    _loc1.addProperty("level", _loc1.__get__level, _loc1.__set__level);
    _loc1.addProperty("classID", _loc1.__get__classID, function ()
    {
    });
    _loc1.addProperty("lineOnly", _loc1.__get__lineOnly, function ()
    {
    });
    _loc1.addProperty("actualCriticalHit", _loc1.__get__actualCriticalHit, function ()
    {
    });
    _loc1.addProperty("isValid", _loc1.__get__isValid, function ()
    {
    });
    _loc1.addProperty("requiredStates", _loc1.__get__requiredStates, function ()
    {
    });
    _loc1.addProperty("file", _loc1.__get__file, function ()
    {
    });
    _loc1.addProperty("animID", _loc1.__get__animID, _loc1.__set__animID);
    _loc1.addProperty("rangeMax", _loc1.__get__rangeMax, function ()
    {
    });
    _loc1.addProperty("launchCountByTurn", _loc1.__get__launchCountByTurn, function ()
    {
    });
    _loc1.addProperty("summonSpell", _loc1.__get__summonSpell, function ()
    {
    });
    _loc1.addProperty("iconFile", _loc1.__get__iconFile, function ()
    {
    });
    _loc1.addProperty("lineOfSight", _loc1.__get__lineOfSight, function ()
    {
    });
    _loc1.addProperty("position", _loc1.__get__position, _loc1.__set__position);
    _loc1.addProperty("effectZones", _loc1.__get__effectZones, function ()
    {
    });
    _loc1.addProperty("normalMinPlayerLevel", _loc1.__get__normalMinPlayerLevel, function ()
    {
    });
    _loc1.addProperty("ID", _loc1.__get__ID, function ()
    {
    });
    _loc1.addProperty("effectsNormalHit", _loc1.__get__effectsNormalHit, function ()
    {
    });
    _loc1.addProperty("criticalHit", _loc1.__get__criticalHit, function ()
    {
    });
    _loc1.addProperty("descriptionCriticalHit", _loc1.__get__descriptionCriticalHit, function ()
    {
    });
    _loc1.addProperty("criticalFailure", _loc1.__get__criticalFailure, function ()
    {
    });
    _loc1.addProperty("inFrontOfSprite", _loc1.__get__inFrontOfSprite, _loc1.__set__inFrontOfSprite);
    _loc1.addProperty("rangeStr", _loc1.__get__rangeStr, function ()
    {
    });
    _loc1.addProperty("effectsNormalHitWithArea", _loc1.__get__effectsNormalHitWithArea, function ()
    {
    });
    _loc1.addProperty("needStates", _loc1.__get__needStates, function ()
    {
    });
    _loc1.addProperty("launchCountByPlayerTurn", _loc1.__get__launchCountByPlayerTurn, function ()
    {
    });
    _loc1.addProperty("description", _loc1.__get__description, function ()
    {
    });
    _loc1.addProperty("trapSpell", _loc1.__get__trapSpell, function ()
    {
    });
    _loc1.addProperty("delayBetweenLaunch", _loc1.__get__delayBetweenLaunch, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("freeCell", _loc1.__get__freeCell, function ()
    {
    });
    _loc1.addProperty("minPlayerLevel", _loc1.__get__minPlayerLevel, function ()
    {
    });
    _loc1.addProperty("effectsCriticalHit", _loc1.__get__effectsCriticalHit, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
