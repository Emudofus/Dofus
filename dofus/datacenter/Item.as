// Action script...

// [Initial MovieClip Action of sprite 880]
#initclip 92
class dofus.datacenter.Item extends Object
{
    var _nQuantity, _nID, _nUnicID, _sEffects, __get__Quantity, _nPosition, __get__position, _nPriceMultiplicator, __get__priceMultiplicator, api, _oUnicInfos, __get__isFromItemSet, __get__itemSetID, __get__isEthereal, _aEffects, __get__type, __get__superType, __get__gfx, __get__level, __get__isCursed, __get__canUse, __get__canTarget, _nPrice, _aEffectZones, __get__apCost, __get__rangeMin, __get__rangeMax, __get__criticalHitBonus, __get__criticalHit, __get__criticalFailure, __get__ID, __set__Quantity, __get__canDestroy, __get__canDrop, __get__canEquip, __get__canMoveToShortut, __get__characteristics, __get__compressedEffects, __get__conditions, __get__description, __get__effectZones, __get__effects, __get__etherealResistance, __get__iconFile, __get__label, __get__lineOfSight, __get__lineOnly, __get__name, __get__normalHit, __set__position, __get__price, __set__priceMultiplicator, __get__style, __get__superTypeText, __get__typeText, __get__unicID, __get__visibleEffects, __get__weight;
    function Item(nID, nUnicID, nQuantity, nPosition, sEffects, nPrice)
    {
        super();
        this.initialize(nID, nUnicID, nQuantity, nPosition, sEffects, nPrice);
    } // End of the function
    function get label()
    {
        return (_nQuantity > 1 ? (_nQuantity) : (undefined));
    } // End of the function
    function get ID()
    {
        return (_nID);
    } // End of the function
    function get unicID()
    {
        return (_nUnicID);
    } // End of the function
    function get compressedEffects()
    {
        return (_sEffects);
    } // End of the function
    function set Quantity(value)
    {
        if (isNaN(Number(value)))
        {
            return;
        } // end if
        _nQuantity = Number(value);
        //return (this.Quantity());
        null;
    } // End of the function
    function get Quantity()
    {
        return (_nQuantity);
    } // End of the function
    function set position(value)
    {
        if (isNaN(Number(value)))
        {
            return;
        } // end if
        _nPosition = Number(value);
        //return (this.position());
        null;
    } // End of the function
    function get position()
    {
        return (_nPosition);
    } // End of the function
    function set priceMultiplicator(value)
    {
        if (isNaN(Number(value)))
        {
            return;
        } // end if
        _nPriceMultiplicator = Number(value);
        //return (this.priceMultiplicator());
        null;
    } // End of the function
    function get priceMultiplicator()
    {
        return (_nPriceMultiplicator);
    } // End of the function
    function get name()
    {
        return (ank.utils.PatternDecoder.getDescription(_oUnicInfos.n, api.lang.getItemUnicStringText()));
    } // End of the function
    function get description()
    {
        var _loc2 = "";
        if (this.__get__isFromItemSet())
        {
            var _loc3 = new dofus.datacenter.ItemSet(this.__get__itemSetID());
            _loc2 = "<u>" + _loc3.name + "</u>\n";
        } // end if
        return (_loc2 + ank.utils.PatternDecoder.getDescription(_oUnicInfos.d, api.lang.getItemUnicStringText()));
    } // End of the function
    function get type()
    {
        return (Number(_oUnicInfos.t));
    } // End of the function
    function get style()
    {
        if (this.__get__isFromItemSet())
        {
            return ("ItemSet");
        }
        else if (this.__get__isEthereal())
        {
            return ("Ethereal");
        }
        else
        {
            return ("");
        } // end else if
    } // End of the function
    function get isEthereal()
    {
        return (_oUnicInfos.et == true);
    } // End of the function
    function get etherealResistance()
    {
        if (this.__get__isEthereal())
        {
            for (var _loc3 in _aEffects)
            {
                var _loc2 = _aEffects[_loc3];
                if (_loc2[0] == 812)
                {
                    return (new dofus.datacenter.Effect(_loc2[0], _loc2[1], _loc2[2], _loc2[3]));
                } // end if
            } // end of for...in
        } // end if
        return (new Array());
    } // End of the function
    function get isFromItemSet()
    {
        return (_oUnicInfos.s != undefined);
    } // End of the function
    function get itemSetID()
    {
        return (_oUnicInfos.s);
    } // End of the function
    function get typeText()
    {
        //return (api.lang.getItemTypeText(this.type()));
    } // End of the function
    function get superType()
    {
        return (typeText.t);
    } // End of the function
    function get superTypeText()
    {
        //return (api.lang.getItemSuperTypeText(this.superType()));
    } // End of the function
    function get iconFile()
    {
        //return (dofus.Constants.ITEMS_PATH + this.type() + "/" + this.__get__gfx() + ".swf");
    } // End of the function
    function get effects()
    {
        return (dofus.datacenter.Item.getItemDescriptionEffects(_aEffects));
    } // End of the function
    function get visibleEffects()
    {
        return (dofus.datacenter.Item.getItemDescriptionEffects(_aEffects, true));
    } // End of the function
    function get canEquip()
    {
        if (api.datacenter.Player.Level < this.__get__level())
        {
            return (false);
        }
        else
        {
            return (true);
        } // end else if
    } // End of the function
    function get canUse()
    {
        return (_oUnicInfos.u == undefined ? (false) : (true));
    } // End of the function
    function get canTarget()
    {
        return (_oUnicInfos.ut == undefined ? (false) : (true));
    } // End of the function
    function get canDestroy()
    {
        //return (this.superType() != 14 && !this.__get__isCursed());
    } // End of the function
    function get canDrop()
    {
        //return (this.superType() != 14 && !this.__get__isCursed());
    } // End of the function
    function get canMoveToShortut()
    {
        //return (this.canUse() == true || this.__get__canTarget() == true);
    } // End of the function
    function get level()
    {
        return (_oUnicInfos.l);
    } // End of the function
    function get gfx()
    {
        return (_oUnicInfos.g);
    } // End of the function
    function get price()
    {
        if (_nPrice == undefined)
        {
            return (Math.ceil(Number(_oUnicInfos.p) * (_nPriceMultiplicator == undefined ? (1) : (_nPriceMultiplicator))));
        }
        else
        {
            return (_nPrice);
        } // end else if
    } // End of the function
    function get weight()
    {
        return (Number(_oUnicInfos.w));
    } // End of the function
    function get isCursed()
    {
        return (_oUnicInfos.m);
    } // End of the function
    function get normalHit()
    {
        return (_aEffects);
    } // End of the function
    function get criticalHitBonus()
    {
        return (this.getItemFightEffectsText(0));
    } // End of the function
    function get apCost()
    {
        return (this.getItemFightEffectsText(1));
    } // End of the function
    function get rangeMin()
    {
        return (this.getItemFightEffectsText(2));
    } // End of the function
    function get rangeMax()
    {
        return (this.getItemFightEffectsText(3));
    } // End of the function
    function get criticalHit()
    {
        return (this.getItemFightEffectsText(4));
    } // End of the function
    function get criticalFailure()
    {
        return (this.getItemFightEffectsText(5));
    } // End of the function
    function get lineOnly()
    {
        return (this.getItemFightEffectsText(6));
    } // End of the function
    function get lineOfSight()
    {
        return (this.getItemFightEffectsText(7));
    } // End of the function
    function get effectZones()
    {
        return (_aEffectZones);
    } // End of the function
    function get characteristics()
    {
        var _loc2 = new Array();
        _loc2.push(api.lang.getText("ITEM_AP", [this.__get__apCost()]));
        _loc2.push(api.lang.getText("ITEM_RANGE", [(this.__get__rangeMin() != 0 ? (this.__get__rangeMin() + " " + api.lang.getText("TO") + " ") : ("")) + this.__get__rangeMax()]));
        _loc2.push(api.lang.getText("ITEM_CRITICAL_BONUS", [this.__get__criticalHitBonus() > 0 ? ("+" + this.__get__criticalHitBonus()) : (String(this.__get__criticalHitBonus()))]));
        _loc2.push((this.__get__criticalHit() != 0 ? (api.lang.getText("ITEM_CRITICAL", [this.__get__criticalHit()])) : ("")) + (this.__get__criticalHit() != 0 && this.__get__criticalFailure() != 0 ? (" - ") : ("")) + (this.__get__criticalFailure() != 0 ? (api.lang.getText("ITEM_MISS", [this.__get__criticalFailure()])) : ("")));
        return (_loc2);
    } // End of the function
    function get conditions()
    {
        var _loc10 = [">", "<", "=", "!"];
        var _loc14 = _oUnicInfos.c;
        if (_loc14 == undefined || _loc14.length == 0)
        {
            return ([String(api.lang.getText("NO_CONDITIONS"))]);
        } // end if
        var _loc13 = _loc14.split("&");
        var _loc12 = new Array();
        for (var _loc11 = 0; _loc11 < _loc13.length; ++_loc11)
        {
            var _loc9 = _loc13[_loc11].split("|");
            for (var _loc6 = 0; _loc6 < _loc9.length; ++_loc6)
            {
                var _loc3;
                var _loc4;
                for (var _loc5 = 0; _loc5 < _loc10.length; ++_loc5)
                {
                    _loc4 = _loc10[_loc5];
                    _loc3 = _loc9[_loc6].split(_loc4);
                    if (_loc3.length > 1)
                    {
                        break;
                        continue;
                    } // end if
                    false;
                    false;
                } // end of for
                if (_loc3 != undefined)
                {
                    var _loc7 = String(_loc3[0]);
                    var _loc2 = _loc3[1];
                    switch (_loc7)
                    {
                        case "Ps":
                        {
                            _loc2 = api.lang.getAlignment(Number(_loc2));
                            break;
                        } 
                        case "Pr":
                        {
                            _loc2 = api.lang.getAlignmentSpecialization(Number(_loc2)).n;
                            break;
                        } 
                        case "Pg":
                        {
                            _loc2 = api.lang.getAlignmentFeat(Number(_loc2)).n;
                            break;
                        } 
                        case "PG":
                        {
                            _loc2 = api.lang.getClassText(Number(_loc2)).sn;
                            break;
                        } 
                        case "PJ":
                        case "Pj":
                        {
                            var _loc8 = _loc2.split(",");
                            _loc2 = api.lang.getJobText(_loc8[0]).n + (_loc8[1] == undefined ? ("") : (" (" + api.lang.getText("LEVEL_SMALL") + " " + _loc8[1] + ")"));
                            break;
                        } 
                        case "PM":
                        {
                            break;
                            
                        } 
                        default:
                        {
                            _loc7 = _loc7.replace(["CS", "Cs", "CV", "Cv", "CA", "Ca", "CI", "Ci", "CW", "Cw", "CC", "Cc", "CA", "PG", "PJ", "Pj", "PM", "PA", "PN", "PE", "PO", "PS", "PR", "PL", "PK", "Pg", "Pr", "Ps", "Pa"], api.lang.getText("ITEM_CHARACTERISTICS").split(","));
                            _loc4 = _loc4.replace(["!"], [api.lang.getText("ITEM_NO")]);
                            _loc12.push((_loc6 > 0 ? (api.lang.getText("ITEM_OR") + " ") : ("")) + _loc7 + " " + _loc4 + " " + _loc2);
                        } 
                    } // End of switch
                } // end if
            } // end of for
        } // end of for
        return (_loc12);
    } // End of the function
    function initialize(nID, nUnicID, nQuantity, nPosition, sEffects, nPrice)
    {
        api = _global.API;
        _nID = nID;
        _nUnicID = nUnicID;
        _nQuantity = nQuantity == undefined ? (1) : (nQuantity);
        _nPosition = nPosition == undefined ? (-1) : (nPosition);
        if (nPrice != undefined)
        {
            _nPrice = nPrice;
        } // end if
        _oUnicInfos = api.lang.getItemUnicText(nUnicID);
        this.setEffects(sEffects);
        var _loc7 = typeText.z;
        var _loc4 = _loc7.split("");
        _aEffectZones = new Array();
        for (var _loc3 = 0; _loc3 < _loc4.length; _loc3 = _loc3 + 2)
        {
            _aEffectZones.push({shape: _loc4[_loc3], size: ank.utils.Compressor.decode64(_loc4[_loc3 + 1])});
        } // end of for
    } // End of the function
    function setEffects(compressedData)
    {
        _sEffects = compressedData;
        _aEffects = new Array();
        var _loc4 = compressedData.split(",");
        for (var _loc3 = 0; _loc3 < _loc4.length; ++_loc3)
        {
            var _loc2 = _loc4[_loc3].split("#");
            _loc2[0] = parseInt(_loc2[0], 16);
            _loc2[1] = _loc2[1] == "0" ? (undefined) : (parseInt(_loc2[1], 16));
            _loc2[2] = _loc2[2] == "0" ? (undefined) : (parseInt(_loc2[2], 16));
            _loc2[3] = _loc2[3] == "0" ? (undefined) : (parseInt(_loc2[3], 16));
            _aEffects.push(_loc2);
        } // end of for
    } // End of the function
    function clone()
    {
        return (new dofus.datacenter.Item(_nID, _nUnicID, _nQuantity, _nPosition, _sEffects));
    } // End of the function
    function getItemFightEffectsText(nPropertyIndex)
    {
        return (_oUnicInfos.e[nPropertyIndex]);
    } // End of the function
    static function getItemDescriptionEffects(aEffects, bVisibleOnly)
    {
        var _loc5 = new Array();
        var _loc7 = aEffects.length;
        if (typeof(aEffects) == "object")
        {
            for (var _loc3 = 0; _loc3 < _loc7; ++_loc3)
            {
                var _loc1 = aEffects[_loc3];
                var _loc4 = _loc1[0];
                var _loc2 = new dofus.datacenter.Effect(_loc4, _loc1[1], _loc1[2], _loc1[3]);
                if (_loc2.description == undefined)
                {
                    continue;
                } // end if
                if (bVisibleOnly == true)
                {
                    if (_loc2.showInTooltip)
                    {
                        _loc5.push(_loc2);
                    } // end if
                }
                else
                {
                    _loc5.push(_loc2);
                } // end else if
                false;
                false;
                false;
            } // end of for
            return (_loc5);
        }
        else
        {
            return (null);
        } // end else if
    } // End of the function
} // End of Class
#endinitclip
