// Action script...

// [Initial MovieClip Action of sprite 20938]
#initclip 203
if (!dofus.datacenter.Item)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Item = function (nID, nUnicID, nQuantity, nPosition, sEffects, nPrice, nSkin, nMood)
    {
        super();
        this.initialize(nID, nUnicID, nQuantity, nPosition, sEffects, nPrice, nSkin, nMood);
    }).prototype;
    _loc1.__get__label = function ()
    {
        return (this._nQuantity > 1 ? (this._nQuantity) : (undefined));
    };
    _loc1.__get__ID = function ()
    {
        return (this._nID);
    };
    _loc1.__get__unicID = function ()
    {
        return (this._nUnicID);
    };
    _loc1.__get__compressedEffects = function ()
    {
        return (this._sEffects);
    };
    _loc1.__set__Quantity = function (value)
    {
        if (_global.isNaN(Number(value)))
        {
            return;
        } // end if
        this._nQuantity = Number(value);
        //return (this.Quantity());
    };
    _loc1.__get__Quantity = function ()
    {
        return (this._nQuantity);
    };
    _loc1.__set__remainingHours = function (nRemainingHours)
    {
        this._nRemainingHours = nRemainingHours;
        //return (this.remainingHours());
    };
    _loc1.__get__remainingHours = function ()
    {
        return (this._nRemainingHours);
    };
    _loc1.__set__position = function (value)
    {
        if (_global.isNaN(Number(value)))
        {
            return;
        } // end if
        this._nPosition = Number(value);
        //return (this.position());
    };
    _loc1.__get__position = function ()
    {
        return (this._nPosition);
    };
    _loc1.__set__priceMultiplicator = function (value)
    {
        if (_global.isNaN(Number(value)))
        {
            return;
        } // end if
        this._nPriceMultiplicator = Number(value);
        //return (this.priceMultiplicator());
    };
    _loc1.__get__priceMultiplicator = function ()
    {
        return (this._nPriceMultiplicator);
    };
    _loc1.__get__name = function ()
    {
        return (ank.utils.PatternDecoder.getDescription(this.api.lang.fetchString(this._oUnicInfos.n), this.api.lang.getItemUnicStringText()));
    };
    _loc1.__get__description = function ()
    {
        var _loc2 = this.api.lang.getItemTypeText(this.type).n;
        var _loc3 = "";
        if (this.isFromItemSet)
        {
            var _loc4 = new dofus.datacenter.ItemSet(this.itemSetID);
            _loc3 = "<u>" + _loc4.name + " (" + this.api.lang.getText("ITEM_TYPE") + " : " + _loc2 + ")</u>\n";
        }
        else
        {
            _loc3 = "<u>" + this.api.lang.getText("ITEM_TYPE") + " : " + _loc2 + "</u>\n";
        } // end else if
        return (_loc3 + ank.utils.PatternDecoder.getDescription(this.api.lang.fetchString(this._oUnicInfos.d), this.api.lang.getItemUnicStringText()));
    };
    _loc1.__get__type = function ()
    {
        if (this._nRealType)
        {
            return (this._nRealType);
        } // end if
        return (Number(this._oUnicInfos.t));
    };
    _loc1.__set__type = function (nType)
    {
        this._nRealType = nType;
        //return (this.type());
    };
    _loc1.__get__realType = function ()
    {
        return (Number(this._oUnicInfos.t));
    };
    _loc1.__get__enhanceable = function ()
    {
        return (this._oUnicInfos.fm);
    };
    _loc1.__get__style = function ()
    {
        if (this.isFromItemSet)
        {
            return ("ItemSet");
        }
        else if (this.isEthereal)
        {
            return ("Ethereal");
        }
        else
        {
            return ("");
        } // end else if
    };
    _loc1.__get__needTwoHands = function ()
    {
        return (this._oUnicInfos.tw == true);
    };
    _loc1.__get__isEthereal = function ()
    {
        return (this._oUnicInfos.et == true);
    };
    _loc1.__get__isHidden = function ()
    {
        return (this._oUnicInfos.h == true);
    };
    _loc1.__get__etherealResistance = function ()
    {
        if (this.isEthereal)
        {
            for (var k in this._aEffects)
            {
                var _loc2 = this._aEffects[k];
                if (_loc2[0] == 812)
                {
                    return (new dofus.datacenter.Effect(_loc2[0], _loc2[1], _loc2[2], _loc2[3]));
                } // end if
            } // end of for...in
        } // end if
        return (new Array());
    };
    _loc1.__get__isFromItemSet = function ()
    {
        return (this._oUnicInfos.s != undefined);
    };
    _loc1.__get__itemSetID = function ()
    {
        return (this._oUnicInfos.s);
    };
    _loc1.__get__typeText = function ()
    {
        return (this.api.lang.getItemTypeText(this.type));
    };
    _loc1.__get__superType = function ()
    {
        return (this.typeText.t);
    };
    _loc1.__get__superTypeText = function ()
    {
        return (this.api.lang.getItemSuperTypeText(this.superType));
    };
    _loc1.__get__iconFile = function ()
    {
        return (dofus.Constants.ITEMS_PATH + this.type + "/" + this.gfx + ".swf");
    };
    _loc1.__get__effects = function ()
    {
        return (dofus.datacenter.Item.getItemDescriptionEffects(this._aEffects));
    };
    _loc1.__get__visibleEffects = function ()
    {
        return (dofus.datacenter.Item.getItemDescriptionEffects(this._aEffects, true));
    };
    _loc1.__get__canUse = function ()
    {
        return (this._oUnicInfos.u == undefined ? (false) : (true));
    };
    _loc1.__get__canTarget = function ()
    {
        return (this._oUnicInfos.ut == undefined ? (false) : (true));
    };
    _loc1.__get__canDestroy = function ()
    {
        return (this.superType != 14 && !this.isCursed);
    };
    _loc1.__get__canDrop = function ()
    {
        return (this.superType != 14 && !this.isCursed);
    };
    _loc1.__get__canMoveToShortut = function ()
    {
        return (this.canUse == true || this.canTarget == true);
    };
    _loc1.__get__level = function ()
    {
        return (Number(this._oUnicInfos.l));
    };
    _loc1.__get__gfx = function ()
    {
        if (this._sGfx)
        {
            return (this._sGfx);
        } // end if
        return (this._oUnicInfos.g);
    };
    _loc1.__set__gfx = function (sGfx)
    {
        this._sGfx = sGfx;
        //return (this.gfx());
    };
    _loc1.__get__realGfx = function ()
    {
        return (this._sRealGfx);
    };
    _loc1.__get__price = function ()
    {
        if (this._nPrice == undefined)
        {
            return (Math.max(0, Math.round(Number(this._oUnicInfos.p) * (this._nPriceMultiplicator == undefined ? (0) : (this._nPriceMultiplicator)))));
        }
        else
        {
            return (this._nPrice);
        } // end else if
    };
    _loc1.__get__weight = function ()
    {
        return (Number(this._oUnicInfos.w));
    };
    _loc1.__get__isCursed = function ()
    {
        return (this._oUnicInfos.m);
    };
    _loc1.__get__normalHit = function ()
    {
        return (this._aEffects);
    };
    _loc1.__get__criticalHitBonus = function ()
    {
        return (this.getItemFightEffectsText(0));
    };
    _loc1.__get__apCost = function ()
    {
        return (this.getItemFightEffectsText(1));
    };
    _loc1.__get__rangeMin = function ()
    {
        return (this.getItemFightEffectsText(2));
    };
    _loc1.__get__rangeMax = function ()
    {
        return (this.getItemFightEffectsText(3));
    };
    _loc1.__get__criticalHit = function ()
    {
        return (this.getItemFightEffectsText(4));
    };
    _loc1.__get__criticalFailure = function ()
    {
        return (this.getItemFightEffectsText(5));
    };
    _loc1.__get__lineOnly = function ()
    {
        return (this.getItemFightEffectsText(6));
    };
    _loc1.__get__lineOfSight = function ()
    {
        return (this.getItemFightEffectsText(7));
    };
    _loc1.__get__effectZones = function ()
    {
        return (this._aEffectZones);
    };
    _loc1.__get__characteristics = function ()
    {
        var _loc2 = new Array();
        _loc2.push(this.api.lang.getText("ITEM_AP", [this.apCost]));
        _loc2.push(this.api.lang.getText("ITEM_RANGE", [(this.rangeMin != 0 ? (this.rangeMin + " " + this.api.lang.getText("TO_RANGE") + " ") : ("")) + this.rangeMax]));
        _loc2.push(this.api.lang.getText("ITEM_CRITICAL_BONUS", [this.criticalHitBonus > 0 ? ("+" + this.criticalHitBonus) : (String(this.criticalHitBonus))]));
        _loc2.push((this.criticalHit != 0 ? (this.api.lang.getText("ITEM_CRITICAL", [this.criticalHit])) : ("")) + (this.criticalHit != 0 && this.criticalFailure != 0 ? (" - ") : ("")) + (this.criticalFailure != 0 ? (this.api.lang.getText("ITEM_MISS", [this.criticalFailure])) : ("")));
        if (this.criticalHit > 0 && this.ID == this.api.datacenter.Player.weaponItem.ID)
        {
            var _loc3 = this.api.kernel.GameManager.getCriticalHitChance(this.criticalHit);
            _loc2.push(this.api.lang.getText("ITEM_CRITICAL_REAL", ["1/" + _loc3]));
        } // end if
        return (_loc2);
    };
    _loc1.__get__conditions = function ()
    {
        var _loc2 = [">", "<", "=", "!"];
        var _loc3 = this._oUnicInfos.c;
        if (_loc3 == undefined || _loc3.length == 0)
        {
            return ([String(this.api.lang.getText("NO_CONDITIONS"))]);
        } // end if
        var _loc4 = _loc3.split("&");
        var _loc5 = new Array();
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc4.length)
        {
            _loc4[_loc6] = new ank.utils.ExtendedString(_loc4[_loc6]).replace(["(", ")"], ["", ""]);
            var _loc7 = _loc4[_loc6].split("|");
            var _loc8 = 0;
            
            while (++_loc8, _loc8 < _loc7.length)
            {
                var _loc11 = 0;
                
                while (++_loc11, _loc11 < _loc2.length)
                {
                    var _loc10 = _loc2[_loc11];
                    var _loc9 = _loc7[_loc8].split(_loc10);
                    if (_loc9.length > 1)
                    {
                        break;
                        continue;
                    } // end if
                } // end while
                if (_loc9 != undefined)
                {
                    var _loc12 = String(_loc9[0]);
                    var _loc13 = _loc9[1];
                    if (_loc12 == "PZ")
                    {
                        break;
                    } // end if
                    switch (_loc12)
                    {
                        case "Ps":
                        {
                            _loc13 = this.api.lang.getAlignment(Number(_loc13)).n;
                            break;
                        } 
                        case "PS":
                        {
                            _loc13 = _loc13 == "1" ? (this.api.lang.getText("FEMELE")) : (this.api.lang.getText("MALE"));
                            break;
                        } 
                        case "Pr":
                        {
                            _loc13 = this.api.lang.getAlignmentSpecialization(Number(_loc13)).n;
                            break;
                        } 
                        case "Pg":
                        {
                            var _loc14 = _loc13.split(",");
                            if (_loc14.length == 2)
                            {
                                _loc13 = this.api.lang.getAlignmentFeat(Number(_loc14[0])).n + " (" + Number(_loc14[1]) + ")";
                            }
                            else
                            {
                                _loc13 = this.api.lang.getAlignmentFeat(Number(_loc13)).n;
                            } // end else if
                            break;
                        } 
                        case "PG":
                        {
                            _loc13 = this.api.lang.getClassText(Number(_loc13)).sn;
                            break;
                        } 
                        case "PJ":
                        case "Pj":
                        {
                            var _loc15 = _loc13.split(",");
                            _loc13 = this.api.lang.getJobText(_loc15[0]).n + (_loc15[1] == undefined ? ("") : (" (" + this.api.lang.getText("LEVEL_SMALL") + " " + _loc15[1] + ")"));
                            break;
                        } 
                        case "PM":
                        {
                            continue;
                            break;
                        } 
                        case "PO":
                        {
                            var _loc16 = new dofus.datacenter.Item(-1, Number(_loc13), 1, 0, "", 0);
                            _loc13 = _loc16.name;
                            break;
                        } 
                    } // End of switch
                    _loc12 = new ank.utils.ExtendedString(_loc12).replace(["CS", "Cs", "CV", "Cv", "CA", "Ca", "CI", "Ci", "CW", "Cw", "CC", "Cc", "CA", "PG", "PJ", "Pj", "PM", "PA", "PN", "PE", "<NO>", "PS", "PR", "PL", "PK", "Pg", "Pr", "Ps", "Pa", "PP", "PZ", "CM"], this.api.lang.getText("ITEM_CHARACTERISTICS").split(","));
                    var _loc17 = _loc10 == "!";
                    _loc10 = new ank.utils.ExtendedString(_loc10).replace(["!"], [this.api.lang.getText("ITEM_NO")]);
                    switch (_loc12)
                    {
                        case "BI":
                        {
                            _loc5.push(this.api.lang.getText("UNUSABLE"));
                            break;
                        } 
                        case "PO":
                        {
                            if (_loc17)
                            {
                                _loc5.push(this.api.lang.getText("ITEM_DO_NOT_POSSESS", [_loc13]) + " <" + _loc10 + ">");
                            }
                            else
                            {
                                _loc5.push(this.api.lang.getText("ITEM_DO_POSSESS", [_loc13]) + " <" + _loc10 + ">");
                            } // end else if
                            break;
                        } 
                        default:
                        {
                            _loc5.push((_loc8 > 0 ? (this.api.lang.getText("ITEM_OR") + " ") : ("")) + _loc12 + " " + _loc10 + " " + _loc13);
                            break;
                        } 
                    } // End of switch
                } // end if
            } // end while
        } // end while
        return (_loc5);
    };
    _loc1.__get__mood = function ()
    {
        return (this._nMood);
    };
    _loc1.__get__skin = function ()
    {
        return (this._nSkin);
    };
    _loc1.__set__skin = function (nSkin)
    {
        this._nSkin = nSkin;
        //return (this.skin());
    };
    _loc1.__get__params = function ()
    {
        if (!this.isLeavingItem)
        {
            return;
        } // end if
        var _loc3 = this.skin;
        if (_loc3 == undefined || _global.isNaN(_loc3))
        {
            _loc3 = 0;
        } // end if
        switch (this.mood)
        {
            case 1:
            {
                var _loc2 = "H";
                break;
            } 
            case 2:
            case 0:
            {
                _loc2 = "U";
                break;
            } 
            default:
            {
                _loc2 = "H";
            } 
        } // End of switch
        return ({frame: _loc2 + _loc3, forceReload: this.isLeavingItem});
    };
    _loc1.__get__skineable = function ()
    {
        return (this._bIsSkineable);
    };
    _loc1.__get__isAssociate = function ()
    {
        return (this.skineable && this.realType != 113);
    };
    _loc1.__get__realUnicId = function ()
    {
        if (this._nRealUnicId)
        {
            return (this._nRealUnicId);
        } // end if
        return (this._nUnicID);
    };
    _loc1.__get__maxSkin = function ()
    {
        var _loc2 = 1;
        
        while (++_loc2, _loc2 < dofus.datacenter.Item.LEVEL_STEP.length)
        {
            if (this._nLivingXp < dofus.datacenter.Item.LEVEL_STEP[_loc2])
            {
                return (_loc2);
            } // end if
        } // end while
        return (dofus.datacenter.Item.LEVEL_STEP.length);
    };
    _loc1.__get__currentLivingXp = function ()
    {
        return (this._nLivingXp);
    };
    _loc1.__get__currentLivingLevelXpMax = function ()
    {
        var _loc2 = 1;
        
        while (++_loc2, _loc2 < dofus.datacenter.Item.LEVEL_STEP.length)
        {
            if (this._nLivingXp < dofus.datacenter.Item.LEVEL_STEP[_loc2])
            {
                return (dofus.datacenter.Item.LEVEL_STEP[_loc2]);
            } // end if
        } // end while
        return (-1);
    };
    _loc1.__get__currentLivingLevelXpMin = function ()
    {
        var _loc2 = 1;
        
        while (++_loc2, _loc2 < dofus.datacenter.Item.LEVEL_STEP.length)
        {
            if (this._nLivingXp < dofus.datacenter.Item.LEVEL_STEP[_loc2])
            {
                return (dofus.datacenter.Item.LEVEL_STEP[_loc2 - 1]);
            } // end if
        } // end while
        return (-1);
    };
    _loc1.__get__isSpeakingItem = function ()
    {
        return (this.isAssociate || this.realType == 113);
    };
    _loc1.__get__isLeavingItem = function ()
    {
        return (this.isAssociate || this.realType == 113);
    };
    _loc1.__get__canBeExchange = function ()
    {
        return (this._bCanBeExchange);
    };
    _loc1.initialize = function (nID, nUnicID, nQuantity, nPosition, sEffects, nPrice, nSkin, nMood)
    {
        this.api = _global.API;
        this._itemDateId = dofus.datacenter.Item.DATE_ID--;
        this._nID = nID;
        this._nUnicID = nUnicID;
        this._nQuantity = nQuantity == undefined ? (1) : (nQuantity);
        this._nPosition = nPosition == undefined ? (-1) : (nPosition);
        if (nPrice != undefined)
        {
            this._nPrice = nPrice;
        } // end if
        this._bCanBeExchange = true;
        this._oUnicInfos = this.api.lang.getItemUnicText(nUnicID);
        this.setEffects(sEffects);
        this._bIsSkineable = false;
        this.updateDataFromEffect();
        var _loc10 = this.typeText.z;
        var _loc11 = _loc10.split("");
        this._aEffectZones = new Array();
        var _loc12 = 0;
        
        while (_loc12 = _loc12 + 2, _loc12 < _loc11.length)
        {
            this._aEffectZones.push({shape: _loc11[_loc12], size: ank.utils.Compressor.decode64(_loc11[_loc12 + 1])});
        } // end while
        this._itemLevel = this.level;
        this._itemType = this.type;
        this._itemPrice = this.price;
        this._itemName = this.name;
        this._itemWeight = this.weight;
        if (nSkin != undefined)
        {
            this._nSkin = nSkin;
        } // end if
        if (nMood != undefined)
        {
            this._nMood = nMood;
        } // end if
    };
    _loc1.setEffects = function (compressedData)
    {
        this._sEffects = compressedData;
        this._aEffects = new Array();
        var _loc3 = compressedData.split(",");
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = _loc3[_loc4].split("#");
            _loc5[0] = _global.parseInt(_loc5[0], 16);
            _loc5[1] = _loc5[1] == "0" ? (undefined) : (_global.parseInt(_loc5[1], 16));
            _loc5[2] = _loc5[2] == "0" ? (undefined) : (_global.parseInt(_loc5[2], 16));
            _loc5[3] = _loc5[3] == "0" ? (undefined) : (_global.parseInt(_loc5[3], 16));
            _loc5[4] = _loc5[4];
            this._aEffects.push(_loc5);
        } // end while
    };
    _loc1.clone = function ()
    {
        return (new dofus.datacenter.Item(this._nID, this._nUnicID, this._nQuantity, this._nPosition, this._sEffects));
    };
    _loc1.equals = function (item)
    {
        return (this.unicID == item.unicID);
    };
    _loc1.getItemFightEffectsText = function (nPropertyIndex)
    {
        return (this._oUnicInfos.e[nPropertyIndex]);
    };
    _loc1.updateDataFromEffect = function ()
    {
        for (var k in this._aEffects)
        {
            var _loc2 = this._aEffects[k];
            switch (_loc2[0])
            {
                case 974:
                {
                    this._nLivingXp = _loc2[3] ? (_loc2[3]) : (0);
                    break;
                } 
                case 973:
                {
                    this._nRealType = _loc2[3] ? (_loc2[3]) : (0);
                    break;
                } 
                case 972:
                {
                    this._nSkin = _loc2[3] ? (_global.parseInt(_loc2[3]) - 1) : (0);
                    this._bIsSkineable = true;
                    break;
                } 
                case 971:
                {
                    this._nMood = _loc2[3] ? (_loc2[3]) : (0);
                    break;
                } 
                case 970:
                {
                    this._sRealGfx = this._oUnicInfos.g;
                    this._sGfx = this.api.lang.getItemUnicText(_loc2[3] ? (_loc2[3]) : (0)).g;
                    this._nRealUnicId = _loc2[3];
                    break;
                } 
                case 983:
                {
                    this._bCanBeExchange = false;
                    break;
                } 
            } // End of switch
        } // end of for...in
    };
    (_global.dofus.datacenter.Item = function (nID, nUnicID, nQuantity, nPosition, sEffects, nPrice, nSkin, nMood)
    {
        super();
        this.initialize(nID, nUnicID, nQuantity, nPosition, sEffects, nPrice, nSkin, nMood);
    }).getItemDescriptionEffects = function (aEffects, bVisibleOnly)
    {
        var _loc4 = new Array();
        var _loc5 = aEffects.length;
        if (typeof(aEffects) == "object")
        {
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < _loc5)
            {
                var _loc7 = aEffects[_loc6];
                var _loc8 = _loc7[0];
                var _loc9 = new dofus.datacenter.Effect(_loc8, _loc7[1], _loc7[2], _loc7[3], _loc7[4]);
                if (_loc9.description == undefined)
                {
                    continue;
                } // end if
                if (bVisibleOnly == true)
                {
                    if (_loc9.showInTooltip)
                    {
                        _loc4.push(_loc9);
                    } // end if
                    continue;
                } // end if
                _loc4.push(_loc9);
            } // end while
            return (_loc4);
        }
        else
        {
            return (null);
        } // end else if
    };
    _loc1.addProperty("label", _loc1.__get__label, function ()
    {
    });
    _loc1.addProperty("position", _loc1.__get__position, _loc1.__set__position);
    _loc1.addProperty("effectZones", _loc1.__get__effectZones, function ()
    {
    });
    _loc1.addProperty("conditions", _loc1.__get__conditions, function ()
    {
    });
    _loc1.addProperty("visibleEffects", _loc1.__get__visibleEffects, function ()
    {
    });
    _loc1.addProperty("priceMultiplicator", _loc1.__get__priceMultiplicator, _loc1.__set__priceMultiplicator);
    _loc1.addProperty("canUse", _loc1.__get__canUse, function ()
    {
    });
    _loc1.addProperty("criticalHitBonus", _loc1.__get__criticalHitBonus, function ()
    {
    });
    _loc1.addProperty("level", _loc1.__get__level, function ()
    {
    });
    _loc1.addProperty("skin", _loc1.__get__skin, _loc1.__set__skin);
    _loc1.addProperty("isHidden", _loc1.__get__isHidden, function ()
    {
    });
    _loc1.addProperty("currentLivingXp", _loc1.__get__currentLivingXp, function ()
    {
    });
    _loc1.addProperty("criticalFailure", _loc1.__get__criticalFailure, function ()
    {
    });
    _loc1.addProperty("type", _loc1.__get__type, _loc1.__set__type);
    _loc1.addProperty("normalHit", _loc1.__get__normalHit, function ()
    {
    });
    _loc1.addProperty("compressedEffects", _loc1.__get__compressedEffects, function ()
    {
    });
    _loc1.addProperty("effects", _loc1.__get__effects, function ()
    {
    });
    _loc1.addProperty("superTypeText", _loc1.__get__superTypeText, function ()
    {
    });
    _loc1.addProperty("unicID", _loc1.__get__unicID, function ()
    {
    });
    _loc1.addProperty("apCost", _loc1.__get__apCost, function ()
    {
    });
    _loc1.addProperty("etherealResistance", _loc1.__get__etherealResistance, function ()
    {
    });
    _loc1.addProperty("weight", _loc1.__get__weight, function ()
    {
    });
    _loc1.addProperty("realUnicId", _loc1.__get__realUnicId, function ()
    {
    });
    _loc1.addProperty("rangeMax", _loc1.__get__rangeMax, function ()
    {
    });
    _loc1.addProperty("characteristics", _loc1.__get__characteristics, function ()
    {
    });
    _loc1.addProperty("isCursed", _loc1.__get__isCursed, function ()
    {
    });
    _loc1.addProperty("itemSetID", _loc1.__get__itemSetID, function ()
    {
    });
    _loc1.addProperty("iconFile", _loc1.__get__iconFile, function ()
    {
    });
    _loc1.addProperty("isLeavingItem", _loc1.__get__isLeavingItem, function ()
    {
    });
    _loc1.addProperty("Quantity", _loc1.__get__Quantity, _loc1.__set__Quantity);
    _loc1.addProperty("criticalHit", _loc1.__get__criticalHit, function ()
    {
    });
    _loc1.addProperty("style", _loc1.__get__style, function ()
    {
    });
    _loc1.addProperty("canTarget", _loc1.__get__canTarget, function ()
    {
    });
    _loc1.addProperty("enhanceable", _loc1.__get__enhanceable, function ()
    {
    });
    _loc1.addProperty("isEthereal", _loc1.__get__isEthereal, function ()
    {
    });
    _loc1.addProperty("canBeExchange", _loc1.__get__canBeExchange, function ()
    {
    });
    _loc1.addProperty("remainingHours", _loc1.__get__remainingHours, _loc1.__set__remainingHours);
    _loc1.addProperty("price", _loc1.__get__price, function ()
    {
    });
    _loc1.addProperty("rangeMin", _loc1.__get__rangeMin, function ()
    {
    });
    _loc1.addProperty("gfx", _loc1.__get__gfx, _loc1.__set__gfx);
    _loc1.addProperty("canDrop", _loc1.__get__canDrop, function ()
    {
    });
    _loc1.addProperty("needTwoHands", _loc1.__get__needTwoHands, function ()
    {
    });
    _loc1.addProperty("superType", _loc1.__get__superType, function ()
    {
    });
    _loc1.addProperty("description", _loc1.__get__description, function ()
    {
    });
    _loc1.addProperty("currentLivingLevelXpMax", _loc1.__get__currentLivingLevelXpMax, function ()
    {
    });
    _loc1.addProperty("canMoveToShortut", _loc1.__get__canMoveToShortut, function ()
    {
    });
    _loc1.addProperty("realType", _loc1.__get__realType, function ()
    {
    });
    _loc1.addProperty("lineOnly", _loc1.__get__lineOnly, function ()
    {
    });
    _loc1.addProperty("lineOfSight", _loc1.__get__lineOfSight, function ()
    {
    });
    _loc1.addProperty("isAssociate", _loc1.__get__isAssociate, function ()
    {
    });
    _loc1.addProperty("realGfx", _loc1.__get__realGfx, function ()
    {
    });
    _loc1.addProperty("params", _loc1.__get__params, function ()
    {
    });
    _loc1.addProperty("ID", _loc1.__get__ID, function ()
    {
    });
    _loc1.addProperty("maxSkin", _loc1.__get__maxSkin, function ()
    {
    });
    _loc1.addProperty("canDestroy", _loc1.__get__canDestroy, function ()
    {
    });
    _loc1.addProperty("skineable", _loc1.__get__skineable, function ()
    {
    });
    _loc1.addProperty("mood", _loc1.__get__mood, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("isFromItemSet", _loc1.__get__isFromItemSet, function ()
    {
    });
    _loc1.addProperty("isSpeakingItem", _loc1.__get__isSpeakingItem, function ()
    {
    });
    _loc1.addProperty("currentLivingLevelXpMin", _loc1.__get__currentLivingLevelXpMin, function ()
    {
    });
    _loc1.addProperty("typeText", _loc1.__get__typeText, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.datacenter.Item = function (nID, nUnicID, nQuantity, nPosition, sEffects, nPrice, nSkin, nMood)
    {
        super();
        this.initialize(nID, nUnicID, nQuantity, nPosition, sEffects, nPrice, nSkin, nMood);
    }).LEVEL_STEP = [0, 10, 21, 33, 46, 60, 75, 91, 108, 126, 145, 165, 186, 208, 231, 255, 280, 306, 333, 361];
    (_global.dofus.datacenter.Item = function (nID, nUnicID, nQuantity, nPosition, sEffects, nPrice, nSkin, nMood)
    {
        super();
        this.initialize(nID, nUnicID, nQuantity, nPosition, sEffects, nPrice, nSkin, nMood);
    }).DATE_ID = 0;
} // end if
#endinitclip
