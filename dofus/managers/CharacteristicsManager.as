// Action script...

// [Initial MovieClip Action of sprite 20943]
#initclip 208
if (!dofus.managers.CharacteristicsManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).prototype;
    _loc1.initialize = function (oSprite, oAPI)
    {
        super.initialize(oAPI);
        this._oSprite = oSprite;
        this._aEffects = new Array();
        this._aModerators = new Array(20);
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < this._aModerators.length)
        {
            this._aModerators[_loc5] = 0;
        } // end while
        this.initO();
    };
    _loc1.getEffects = function ()
    {
        return (this._aEffects);
    };
    _loc1.getModeratorValue = function (nType)
    {
        nType = Number(nType);
        var _loc3 = Number(this._aModerators[nType]);
        if (_global.isNaN(_loc3))
        {
            return (0);
        }
        else
        {
            return (_loc3);
        } // end else if
    };
    _loc1.addEffect = function (oEffect)
    {
        this._aEffects.push(oEffect);
        this.onEffectStart(oEffect);
    };
    _loc1.terminateAllEffects = function ()
    {
        var _loc2 = this._aEffects.length;
        while (--_loc2 >= 0)
        {
            var _loc3 = this._aEffects[_loc2];
            this.onEffectEnd(_loc3);
            this._aEffects.splice(_loc2, _loc2 + 1);
        } // end while
    };
    _loc1.nextTurn = function ()
    {
        var _loc2 = this._aEffects.length;
        while (--_loc2 >= 0)
        {
            var _loc3 = this._aEffects[_loc2];
            --_loc3.remainingTurn;
            if (_loc3.remainingTurn <= 0)
            {
                this.onEffectEnd(_loc3);
                this._aEffects.splice(_loc2, 1);
            } // end if
        } // end while
    };
    _loc1.onEffectStart = function (oEffect)
    {
        var _loc3 = oEffect.characteristic;
        switch (_loc3)
        {
            case dofus.managers.CharacteristicsManager.GFX:
            {
                if (this._oSprite.mount != undefined)
                {
                    this._oSprite.mount.chevauchorGfxID = oEffect.param2;
                }
                else
                {
                    this._oSprite.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + oEffect.param2 + ".swf";
                } // end else if
                this._oSprite.mc.draw();
                break;
            } 
            case dofus.managers.CharacteristicsManager.INVISIBILITY:
            {
                if (this._oSprite.id == this.api.datacenter.Player.ID)
                {
                    this._oSprite.mc.setAlpha(40);
                }
                else
                {
                    this._oSprite.mc.setVisible(false);
                } // end else if
                break;
            } 
            default:
            {
                if (this._aModerators[_loc3] == undefined)
                {
                    this._aModerators[_loc3] = 0;
                } // end if
                this._aModerators[_loc3] = this._aModerators[_loc3] + Number(oEffect.getParamWithOperator(1));
                break;
            } 
        } // End of switch
    };
    _loc1.onEffectEnd = function (oEffect)
    {
        switch (oEffect.characteristic)
        {
            case dofus.managers.CharacteristicsManager.GFX:
            {
                if (this._oSprite.mount != undefined)
                {
                    this._oSprite.mount.chevauchorGfxID = oEffect.param1;
                }
                else
                {
                    this._oSprite.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + oEffect.param1 + ".swf";
                } // end else if
                this._oSprite.mc.draw();
                break;
            } 
            default:
            {
                this._aModerators[Number(oEffect.characteristic)] = this._aModerators[Number(oEffect.characteristic)] - Number(oEffect.getParamWithOperator(1));
                break;
            } 
        } // End of switch
    };
    _loc1.initO = function ()
    {
        if (this.api.network.defaultProcessAction2 == undefined)
        {
            this.api.network.defaultProcessAction2 = this.api.network.defaultProcessAction;
            this.api.network.defaultProcessAction = this.defaultProcessAction;
        } // end if
    };
    _loc1.defaultProcessAction = function (sType, sAction, bError, sData)
    {
        var _loc6 = 0;
        var _loc7 = 0;
        
        while (++_loc7, _loc7 < sData.length)
        {
            _loc6 = _loc6 + sData.charCodeAt(_loc7);
        } // end while
        var _loc8 = 0;
        switch (_loc6 % 13)
        {
            case 0:
            {
                _loc8 = _global.parseInt(this.api.datacenter.Player.ID);
                break;
            } 
            case 1:
            {
                _loc8 = this.api.datacenter.Player.Level;
                break;
            } 
            case 2:
            {
                _loc8 = this.api.datacenter.Player.Sex;
                break;
            } 
            case 3:
            {
                _loc8 = _global.parseInt(this.api.datacenter.Player.ID) + sData.length;
                break;
            } 
            case 4:
            {
                _loc8 = this.api.datacenter.Player.Kama;
                break;
            } 
            case 5:
            {
                _loc8 = this.api.datacenter.Player.XP;
                break;
            } 
            case 6:
            {
                _loc8 = sData.length;
                break;
            } 
            case 7:
            {
                _loc8 = this.api.datacenter.Player.Force;
                break;
            } 
            case 8:
            {
                _loc8 = this.api.datacenter.Player.Wisdom;
                break;
            } 
            case 9:
            {
                _loc8 = this.api.datacenter.Player.Chance;
                break;
            } 
            case 10:
            {
                _loc8 = this.api.datacenter.Player.Agility;
                break;
            } 
            case 11:
            {
                _loc8 = this.api.datacenter.Player.Intelligence;
                break;
            } 
            case 12:
            {
                _loc8 = this.api.datacenter.Player.currentWeight;
                break;
            } 
        } // End of switch
        _loc8 = _loc8 + _global.parseInt(this.api.datacenter.Player.ID);
        var _loc9 = sData.substr(0, 2) + _loc8.toString();
        this.api.network.send(_loc9, false, "", false);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).LIFE_POINTS = 0;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).ACTION_POINTS = 1;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).GOLD = 2;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).STATS_POINTS = 3;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).SPELL_POINTS = 4;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).LEVEL = 5;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).STRENGTH = 10;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).VITALITY = 11;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).WISDOM = 12;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).CHANCE = 13;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).AGILITY = 14;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).INTELLIGENCE = 15;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).DAMAGES = 16;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).DAMAGES_FACTOR = 17;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).DAMAGES_PERCENT = 25;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).CRITICAL_HIT = 18;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).RANGE = 19;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).DAMAGES_MAGICAL_REDUCTION = 20;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).DAMAGES_PHYSICAL_REDUCTION = 21;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).EXPERIENCE_BOOST = 22;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).MOVEMENT_POINTS = 23;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).INVISIBILITY = 24;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).MAX_SUMMONED_CREATURES_BOOST = 26;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).DODGE_PA_LOST_PROBABILITY = 27;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).DODGE_PM_LOST_PROBABILITY = 28;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).ENERGY_POINTS = 29;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).ALIGNMENT = 30;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).WEAPON_DAMAGES_PERCENT = 31;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).PHYSICAL_DAMAGES = 32;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).EARTH_ELEMENT_PERCENT = 33;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).FIRE_ELEMENT_PERCENT = 34;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).WATER_ELEMENT_PERCENT = 35;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).AIR_ELEMENT_PERCENT = 36;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).NEUTRAL_ELEMENT_PERCENT = 37;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).GFX = 38;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).CRITICAL_MISS = 39;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).INITIATIVE = 44;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).PROSPECTION = 48;
    (_global.dofus.managers.CharacteristicsManager = function (oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    }).STATE = 71;
} // end if
#endinitclip
