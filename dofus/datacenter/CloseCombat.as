// Action script...

// [Initial MovieClip Action of sprite 20715]
#initclip 236
if (!dofus.datacenter.CloseCombat)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.CloseCombat = function (oItem, nClassID)
    {
        super();
        this.initialize(oItem, nClassID);
    }).prototype;
    _loc1.__get__ID = function ()
    {
        return (0);
    };
    _loc1.__get__isValid = function ()
    {
        return (true);
    };
    _loc1.__get__maxLevel = function ()
    {
        return (1);
    };
    _loc1.__get__position = function ()
    {
        return (0);
    };
    _loc1.__get__item = function ()
    {
        return (this._oItem);
    };
    _loc1.__get__summonSpell = function ()
    {
        return (false);
    };
    _loc1.__get__glyphSpell = function ()
    {
        return (false);
    };
    _loc1.__get__trapSpell = function ()
    {
        return (false);
    };
    _loc1.__get__iconFile = function ()
    {
        if (this._oItem == undefined)
        {
            return (dofus.Constants.DEFAULT_CC_ICON_FILE);
        }
        else
        {
            return (this._oItem.iconFile);
        } // end else if
    };
    _loc1.__get__name = function ()
    {
        return (this.api.lang.getText("CC_DAMAGES"));
    };
    _loc1.__get__apCost = function ()
    {
        if (this._oItem == undefined)
        {
            return (this.getDefaultProperty(2));
        }
        else
        {
            return (this._oItem.apCost);
        } // end else if
    };
    _loc1.__get__rangeMin = function ()
    {
        if (this._oItem == undefined)
        {
            return (this.getDefaultProperty(3));
        }
        else
        {
            return (this._oItem.rangeMin);
        } // end else if
    };
    _loc1.__get__rangeMax = function ()
    {
        if (this._oItem == undefined)
        {
            return (this.getDefaultProperty(4));
        }
        else
        {
            return (this._oItem.rangeMax);
        } // end else if
    };
    _loc1.__get__rangeStr = function ()
    {
        return ((this.rangeMin != 0 ? (this.rangeMin + " " + this.api.lang.getText("TO_RANGE") + " ") : ("")) + this.rangeMax);
    };
    _loc1.__get__criticalHit = function ()
    {
        if (this._oItem == undefined)
        {
            return (this.getDefaultProperty(5));
        }
        else
        {
            return (this._oItem.criticalHit);
        } // end else if
    };
    _loc1.__get__criticalFailure = function ()
    {
        if (this._oItem == undefined)
        {
            return (this.getDefaultProperty(6));
        }
        else
        {
            return (this._oItem.criticalFailure);
        } // end else if
    };
    _loc1.__get__lineOnly = function ()
    {
        if (this._oItem == undefined)
        {
            return (this.getDefaultProperty(7));
        }
        else
        {
            return (this._oItem.lineOnly);
        } // end else if
    };
    _loc1.__get__lineOfSight = function ()
    {
        if (this._oItem == undefined)
        {
            return (this.getDefaultProperty(8));
        }
        else
        {
            return (this._oItem.lineOfSight);
        } // end else if
    };
    _loc1.__get__freeCell = function ()
    {
        return (false);
    };
    _loc1.__get__canBoostRange = function ()
    {
        return (false);
    };
    _loc1.__get__classID = function ()
    {
        return (-1);
    };
    _loc1.__get__launchCountByTurn = function ()
    {
        return (0);
    };
    _loc1.__get__launchCountByPlayerTurn = function ()
    {
        return (0);
    };
    _loc1.__get__delayBetweenLaunch = function ()
    {
        return (0);
    };
    _loc1.__get__descriptionVisibleEffects = function ()
    {
        if (this._oItem == undefined)
        {
            var _loc2 = this.getDefaultProperty(0);
            return (this.api.kernel.GameManager.getSpellDescriptionWithEffects(_loc2, true, 0));
        }
        else
        {
            var _loc3 = this._oItem.visibleEffects;
            var _loc4 = new Array();
            var _loc5 = 0;
            
            while (++_loc5, _loc5 < _loc3.length)
            {
                _loc4.push(_loc3[_loc5].description);
            } // end while
            return (_loc4.join(", "));
        } // end else if
    };
    _loc1.__get__descriptionNormalHit = function ()
    {
        if (this._oItem == undefined)
        {
            var _loc2 = this.getDefaultProperty(0);
            return (this.api.kernel.GameManager.getSpellDescriptionWithEffects(_loc2, false, 0));
        }
        else
        {
            var _loc3 = this._oItem.normalHit;
            var _loc4 = new Array();
            var _loc5 = 0;
            
            while (++_loc5, _loc5 < _loc3.length)
            {
                _loc4.push(_loc3.description);
            } // end while
            return (_loc4.join(", "));
        } // end else if
    };
    _loc1.__get__descriptionCriticalHit = function ()
    {
        if (this._oItem == undefined)
        {
            var _loc2 = this.getDefaultProperty(1);
        }
        else
        {
            _loc2 = this._oItem.criticalHitBonus;
        } // end else if
        return (this.api.kernel.GameManager.getSpellDescriptionWithEffects(_loc2, false, 0));
    };
    _loc1.__get__effectsNormalHit = function ()
    {
        if (this._oItem == undefined)
        {
            var _loc2 = this.getDefaultProperty(0);
        }
        else
        {
            _loc2 = this._oItem.normalHit;
        } // end else if
        return (this.api.kernel.GameManager.getSpellEffects(_loc2, 0));
    };
    _loc1.__get__effectsCriticalHit = function ()
    {
        if (this._oItem == undefined)
        {
            var _loc2 = this.getDefaultProperty(1);
        }
        else
        {
            _loc2 = this._oItem.criticalHitBonus;
        } // end else if
        return (this.api.kernel.GameManager.getSpellEffects(_loc2, 0));
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
    _loc1.initialize = function (oItem, nClassID)
    {
        this.api = _global.API;
        this._oItem = oItem;
        if (oItem == undefined)
        {
            this._oCloseCombatClassInfos = this.api.lang.getClassText(nClassID).cc;
        } // end if
        var _loc4 = this.api.lang.getItemTypeText(this._oItem.type).z;
        if (_loc4 == undefined)
        {
            _loc4 = "Pa";
        } // end if
        var _loc5 = _loc4.split("");
        this._aEffectZones = new Array();
        var _loc6 = 0;
        
        while (_loc6 = _loc6 + 2, _loc6 < _loc5.length)
        {
            this._aEffectZones.push({shape: _loc5[_loc6], size: ank.utils.Compressor.decode64(_loc5[_loc6 + 1])});
        } // end while
        var _loc7 = this.api.lang.getClassText(this.api.datacenter.Player.Guild).cc;
        this._aRequiredStates = _loc7[9];
        this._aForbiddenStates = _loc7[10];
    };
    _loc1.getDefaultProperty = function (nPropertyIndex)
    {
        return (this._oCloseCombatClassInfos[nPropertyIndex]);
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
    _loc1.addProperty("item", _loc1.__get__item, function ()
    {
    });
    _loc1.addProperty("elements", _loc1.__get__elements, function ()
    {
    });
    _loc1.addProperty("classID", _loc1.__get__classID, function ()
    {
    });
    _loc1.addProperty("lineOnly", _loc1.__get__lineOnly, function ()
    {
    });
    _loc1.addProperty("descriptionVisibleEffects", _loc1.__get__descriptionVisibleEffects, function ()
    {
    });
    _loc1.addProperty("isValid", _loc1.__get__isValid, function ()
    {
    });
    _loc1.addProperty("requiredStates", _loc1.__get__requiredStates, function ()
    {
    });
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
    _loc1.addProperty("effectZones", _loc1.__get__effectZones, function ()
    {
    });
    _loc1.addProperty("ID", _loc1.__get__ID, function ()
    {
    });
    _loc1.addProperty("criticalHit", _loc1.__get__criticalHit, function ()
    {
    });
    _loc1.addProperty("effectsNormalHit", _loc1.__get__effectsNormalHit, function ()
    {
    });
    _loc1.addProperty("descriptionCriticalHit", _loc1.__get__descriptionCriticalHit, function ()
    {
    });
    _loc1.addProperty("position", _loc1.__get__position, function ()
    {
    });
    _loc1.addProperty("criticalFailure", _loc1.__get__criticalFailure, function ()
    {
    });
    _loc1.addProperty("rangeStr", _loc1.__get__rangeStr, function ()
    {
    });
    _loc1.addProperty("needStates", _loc1.__get__needStates, function ()
    {
    });
    _loc1.addProperty("launchCountByPlayerTurn", _loc1.__get__launchCountByPlayerTurn, function ()
    {
    });
    _loc1.addProperty("trapSpell", _loc1.__get__trapSpell, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("delayBetweenLaunch", _loc1.__get__delayBetweenLaunch, function ()
    {
    });
    _loc1.addProperty("freeCell", _loc1.__get__freeCell, function ()
    {
    });
    _loc1.addProperty("effectsCriticalHit", _loc1.__get__effectsCriticalHit, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
