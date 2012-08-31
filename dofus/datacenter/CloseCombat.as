// Action script...

// [Initial MovieClip Action of sprite 918]
#initclip 130
class dofus.datacenter.CloseCombat extends Object
{
    var _oItem, api, __get__rangeMin, __get__rangeMax, __get__effectsNormalHit, _aEffectZones, _oCloseCombatClassInfos, __get__ID, __get__apCost, __get__canBoostRange, __get__classID, __get__criticalFailure, __get__criticalHit, __get__delayBetweenLaunch, __get__descriptionCriticalHit, __get__descriptionNormalHit, __get__descriptionVisibleEffects, __get__effectZones, __get__effectsCriticalHit, __get__elements, __get__freeCell, __get__glyphSpell, __get__iconFile, __get__isValid, __get__item, __get__launchCountByPlayerTurn, __get__launchCountByTurn, __get__lineOfSight, __get__lineOnly, __get__maxLevel, __get__name, __get__position, __get__rangeStr, __get__summonSpell, __get__trapSpell;
    function CloseCombat(oItem, nClassID)
    {
        super();
        this.initialize(oItem, nClassID);
    } // End of the function
    function get ID()
    {
        return (0);
    } // End of the function
    function get isValid()
    {
        return (true);
    } // End of the function
    function get maxLevel()
    {
        return (1);
    } // End of the function
    function get position()
    {
        return (0);
    } // End of the function
    function get item()
    {
        return (_oItem);
    } // End of the function
    function get summonSpell()
    {
        return (false);
    } // End of the function
    function get glyphSpell()
    {
        return (false);
    } // End of the function
    function get trapSpell()
    {
        return (false);
    } // End of the function
    function get iconFile()
    {
        if (_oItem == undefined)
        {
            return (dofus.Constants.DEFAULT_CC_ICON_FILE);
        }
        else
        {
            return (_oItem.iconFile);
        } // end else if
    } // End of the function
    function get name()
    {
        return (api.lang.getText("CC_DAMAGES"));
    } // End of the function
    function get apCost()
    {
        if (_oItem == undefined)
        {
            return (this.getDefaultProperty(2));
        }
        else
        {
            return (_oItem.apCost);
        } // end else if
    } // End of the function
    function get rangeMin()
    {
        if (_oItem == undefined)
        {
            return (this.getDefaultProperty(3));
        }
        else
        {
            return (_oItem.rangeMin);
        } // end else if
    } // End of the function
    function get rangeMax()
    {
        if (_oItem == undefined)
        {
            return (this.getDefaultProperty(4));
        }
        else
        {
            return (_oItem.rangeMax);
        } // end else if
    } // End of the function
    function get rangeStr()
    {
        //return ((this.rangeMin() != 0 ? (this.__get__rangeMin() + " " + api.lang.getText("TO") + " ") : ("")) + this.__get__rangeMax());
    } // End of the function
    function get criticalHit()
    {
        if (_oItem == undefined)
        {
            return (this.getDefaultProperty(5));
        }
        else
        {
            return (_oItem.criticalHit);
        } // end else if
    } // End of the function
    function get criticalFailure()
    {
        if (_oItem == undefined)
        {
            return (this.getDefaultProperty(6));
        }
        else
        {
            return (_oItem.criticalFailure);
        } // end else if
    } // End of the function
    function get lineOnly()
    {
        if (_oItem == undefined)
        {
            return (this.getDefaultProperty(7));
        }
        else
        {
            return (_oItem.lineOnly);
        } // end else if
    } // End of the function
    function get lineOfSight()
    {
        if (_oItem == undefined)
        {
            return (this.getDefaultProperty(8));
        }
        else
        {
            return (_oItem.lineOfSight);
        } // end else if
    } // End of the function
    function get freeCell()
    {
        return (false);
    } // End of the function
    function get canBoostRange()
    {
        return (false);
    } // End of the function
    function get classID()
    {
        return (-1);
    } // End of the function
    function get launchCountByTurn()
    {
        return (0);
    } // End of the function
    function get launchCountByPlayerTurn()
    {
        return (0);
    } // End of the function
    function get delayBetweenLaunch()
    {
        return (0);
    } // End of the function
    function get descriptionVisibleEffects()
    {
        if (_oItem == undefined)
        {
            var _loc5 = this.getDefaultProperty(0);
            return (dofus.datacenter.Spell.getSpellDescriptionWithEffects(_loc5, true));
        }
        else
        {
            var _loc3 = _oItem.visibleEffects;
            var _loc4 = new Array();
            for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
            {
                _loc4.push(_loc3[_loc2].description);
            } // end of for
            return (_loc4.join(", "));
        } // end else if
    } // End of the function
    function get descriptionNormalHit()
    {
        var _loc5;
        if (_oItem == undefined)
        {
            _loc5 = this.getDefaultProperty(0);
            return (dofus.datacenter.Spell.getSpellDescriptionWithEffects(_loc5));
        }
        else
        {
            var _loc3 = _oItem.normalHit;
            var _loc4 = new Array();
            for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
            {
                _loc4.push(_loc3.description);
            } // end of for
            return (_loc4.join(", "));
        } // end else if
    } // End of the function
    function get descriptionCriticalHit()
    {
        var _loc2;
        if (_oItem == undefined)
        {
            _loc2 = this.getDefaultProperty(1);
        }
        else
        {
            _loc2 = _oItem.criticalHitBonus;
        } // end else if
        return (dofus.datacenter.Spell.getSpellDescriptionWithEffects(_loc2));
    } // End of the function
    function get effectsNormalHit()
    {
        var _loc2;
        if (_oItem == undefined)
        {
            _loc2 = this.getDefaultProperty(0);
        }
        else
        {
            _loc2 = _oItem.normalHit;
        } // end else if
        return (dofus.datacenter.Spell.getSpellEffects(_loc2));
    } // End of the function
    function get effectsCriticalHit()
    {
        var _loc2;
        if (_oItem == undefined)
        {
            _loc2 = this.getDefaultProperty(1);
        }
        else
        {
            _loc2 = _oItem.criticalHitBonus;
        } // end else if
        return (dofus.datacenter.Spell.getSpellEffects(_loc2));
    } // End of the function
    function get elements()
    {
        var _loc2 = {none: false, neutral: false, earth: false, fire: false, water: false, air: false};
        var _loc4 = this.__get__effectsNormalHit();
        for (var _loc5 in _loc4)
        {
            var _loc3 = _loc4[_loc5].element;
            switch (_loc3)
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
    } // End of the function
    function get effectZones()
    {
        return (_aEffectZones);
    } // End of the function
    function initialize(oItem, nClassID)
    {
        api = _global.API;
        _oItem = oItem;
        if (oItem == undefined)
        {
            _oCloseCombatClassInfos = api.lang.getClassText(nClassID).cc;
        } // end if
        var _loc7 = api.lang.getItemTypeText(_oItem.type).z;
        if (_loc7 == undefined)
        {
            _loc7 = "Pa";
        } // end if
        var _loc4 = _loc7.split("");
        _aEffectZones = new Array();
        for (var _loc3 = 0; _loc3 < _loc4.length; _loc3 = _loc3 + 2)
        {
            _aEffectZones.push({shape: _loc4[_loc3], size: ank.utils.Compressor.decode64(_loc4[_loc3 + 1])});
        } // end of for
    } // End of the function
    function getDefaultProperty(nPropertyIndex)
    {
        return (_oCloseCombatClassInfos[nPropertyIndex]);
    } // End of the function
} // End of Class
#endinitclip
