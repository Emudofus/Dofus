// Action script...

// [Initial MovieClip Action of sprite 20790]
#initclip 55
if (!dofus.aks.Exchange)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Exchange = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.leave = function ()
    {
        this.aks.send("EV", true);
    };
    _loc1.request = function (type, id, cellNum)
    {
        this.aks.send("ER" + type + "|" + (id == undefined || _global.isNaN(id) ? ("") : (id)) + (cellNum == undefined || _global.isNaN(cellNum) ? ("") : ("|" + cellNum)), true);
    };
    _loc1.shop = function (nID)
    {
        this.aks.send("Es" + nID);
    };
    _loc1.accept = function ()
    {
        this.aks.send("EA", false);
    };
    _loc1.ready = function ()
    {
        this.aks.send("EK", true);
    };
    _loc1.movementItem = function (bAdd, nID, nQuantity, nPrice)
    {
        this.aks.send("EMO" + (bAdd ? ("+") : ("-")) + nID + "|" + nQuantity + (nPrice == undefined ? ("") : ("|" + nPrice)), true);
    };
    _loc1.movementItems = function (aItems)
    {
        var _loc3 = "";
        var _loc8 = 0;
        
        while (++_loc8, _loc8 < aItems.length)
        {
            var _loc4 = aItems[_loc8].Add;
            var _loc5 = aItems[_loc8].ID;
            var _loc6 = aItems[_loc8].Quantity;
            var _loc7 = aItems[_loc8].Price;
            _loc3 = _loc3 + ((_loc4 ? ("+") : ("-")) + _loc5 + "|" + _loc6 + (_loc7 == undefined ? ("") : ("|" + _loc7)));
        } // end while
        this.aks.send("EMO" + _loc3, true);
    };
    _loc1.movementPayItem = function (nGarbage, bAdd, nID, nQuantity, nPrice)
    {
        this.aks.send("EP" + nGarbage + "O" + (bAdd ? ("+") : ("-")) + nID + "|" + nQuantity + (nPrice == undefined ? ("") : ("|" + nPrice)), true);
    };
    _loc1.movementKama = function (nQuantity)
    {
        this.aks.send("EMG" + nQuantity, true);
    };
    _loc1.movementPayKama = function (nGarbage, nQuantity)
    {
        this.aks.send("EP" + nGarbage + "G" + nQuantity, true);
    };
    _loc1.sell = function (id, quantity)
    {
        this.aks.send("ES" + id + "|" + quantity, true);
    };
    _loc1.buy = function (nID, nQuantity)
    {
        this.aks.send("EB" + nID + "|" + nQuantity, true);
    };
    _loc1.offlineExchange = function ()
    {
        this.aks.send("EQ", true);
    };
    _loc1.askOfflineExchange = function ()
    {
        this.aks.send("Eq", true);
    };
    _loc1.bigStoreType = function (nTypeID)
    {
        this.aks.send("EHT" + nTypeID);
    };
    _loc1.bigStoreItemList = function (nUnicID)
    {
        this.aks.send("EHl" + nUnicID);
    };
    _loc1.bigStoreBuy = function (nID, nQuantityIndex, nPrice)
    {
        this.aks.send("EHB" + nID + "|" + nQuantityIndex + "|" + nPrice, true);
    };
    _loc1.bigStoreSearch = function (nType, nUnicID)
    {
        this.aks.send("EHS" + nType + "|" + nUnicID);
    };
    _loc1.setPublicMode = function (b)
    {
        this.aks.send("EW" + (b ? ("+") : ("-")), false);
    };
    _loc1.getCrafterForJob = function (nJobId)
    {
        this.aks.send("EJF" + nJobId, true);
    };
    _loc1.putInShedFromInventory = function (nMountID)
    {
        this.aks.send("Erp" + nMountID, true);
    };
    _loc1.putInInventoryFromShed = function (nMountID)
    {
        this.aks.send("Erg" + nMountID, true);
    };
    _loc1.putInCertificateFromShed = function (nMountID)
    {
        this.aks.send("Erc" + nMountID, true);
    };
    _loc1.putInShedFromCertificate = function (nCertifID)
    {
        this.aks.send("ErC" + nCertifID, true);
    };
    _loc1.putInMountParkFromShed = function (nMountID)
    {
        this.aks.send("Efp" + nMountID, true);
    };
    _loc1.putInShedFromMountPark = function (nMountID)
    {
        this.aks.send("Efg" + nMountID, true);
    };
    _loc1.killMountInPark = function (nMountID)
    {
        this.aks.send("Eff" + nMountID, false);
    };
    _loc1.killMount = function (nMountID)
    {
        this.aks.send("Erf" + nMountID, false);
    };
    _loc1.getItemMiddlePriceInBigStore = function (nItemID)
    {
        this.aks.send("EHP" + nItemID, false);
    };
    _loc1.replayCraft = function ()
    {
        this.aks.send("EL", false);
    };
    _loc1.repeatCraft = function (nHowManyTimes)
    {
        this._nItemsToCraft = nHowManyTimes;
        this.aks.send("EMR" + nHowManyTimes, false);
        this.api.datacenter.Basics.isCraftLooping = true;
    };
    _loc1.stopRepeatCraft = function ()
    {
        this.aks.send("EMr", false);
    };
    _loc1.onRequest = function (bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc4 = sExtraData.split("|");
            var _loc5 = _loc4[0];
            var _loc6 = _loc4[1];
            var _loc7 = Number(_loc4[2]);
            var _loc8 = this.api.datacenter.Player.ID == _loc5 ? (_loc6) : (_loc5);
            if (_loc7 == 12 || _loc7 == 13)
            {
                var _loc9 = new dofus.datacenter.SecureCraftExchange(_loc8);
            }
            else
            {
                _loc9 = new dofus.datacenter.Exchange(_loc8);
            } // end else if
            this.api.datacenter.Exchange = _loc9;
            if (this.api.datacenter.Player.ID == _loc5)
            {
                var _loc10 = this.api.datacenter.Sprites.getItemAt(_loc6);
                switch (_loc7)
                {
                    case 1:
                    {
                        var _loc11 = "WAIT_FOR_EXCHANGE";
                        break;
                    } 
                    case 12:
                    {
                        _loc11 = "WAIT_FOR_CRAFT_CLIENT";
                        break;
                    } 
                    case 13:
                    {
                        _loc11 = "WAIT_FOR_CRAFT_ARTISAN";
                        break;
                    } 
                } // End of switch
                this.api.kernel.showMessage(this.api.lang.getText("EXCHANGE"), this.api.lang.getText(_loc11, [_loc10.name]), "INFO_CANCEL", {name: "Exchange", listener: this});
            }
            else
            {
                var _loc12 = this.api.datacenter.Sprites.getItemAt(_loc5);
                if (this.api.kernel.ChatManager.isBlacklisted(_loc12.name))
                {
                    this.leave();
                    return;
                } // end if
                this.api.kernel.showMessage(undefined, this.api.lang.getText("CHAT_A_WANT_EXCHANGE", [this.api.kernel.ChatManager.getLinkName(_loc12.name)]), "INFO_CHAT");
                switch (_loc7)
                {
                    case 1:
                    {
                        var _loc13 = "A_WANT_EXCHANGE";
                        break;
                    } 
                    case 12:
                    {
                        _loc13 = "A_WANT_CRAFT_CLIENT";
                        break;
                    } 
                    case 13:
                    {
                        _loc13 = "A_WANT_CRAFT_ARTISAN";
                        break;
                    } 
                } // End of switch
                this.api.kernel.showMessage(this.api.lang.getText("EXCHANGE"), this.api.lang.getText(_loc13, [_loc12.name]), "CAUTION_YESNOIGNORE", {name: "Exchange", player: _loc12.name, listener: this, params: {player: _loc12.name}});
            } // end else if
        }
        else
        {
            var _loc14 = sExtraData.charAt(0);
            switch (_loc14)
            {
                case "O":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("ALREADY_EXCHANGE"), "ERROR_CHAT");
                    break;
                } 
                case "T":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("NOT_NEAR_CRAFT_TABLE"), "ERROR_CHAT");
                    break;
                } 
                case "J":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("ERROR_85"), "ERROR_CHAT");
                    break;
                } 
                case "o":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("ERROR_70"), "ERROR_CHAT");
                    break;
                } 
                case "S":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("ERROR_62"), "ERROR_CHAT");
                    break;
                } 
                case "I":
                default:
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_EXCHANGE"), "ERROR_CHAT");
                } 
            } // End of switch
        } // end else if
    };
    _loc1.onAskOfflineExchange = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]) / 10;
        var _loc6 = Number(_loc3[2]);
        this.api.kernel.GameManager.askOfflineExchange(_loc4, _loc5, _loc6);
    };
    _loc1.onReady = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "1";
        var _loc4 = Number(sExtraData.substr(1));
        var _loc5 = _loc4 == this.api.datacenter.Player.ID ? (0) : (1);
        this.api.datacenter.Exchange.readyStates.updateItem(_loc5, _loc3);
    };
    _loc1.onLeave = function (bSuccess, sExtraData)
    {
        delete this.api.datacenter.Basics.aks_exchange_echangeType;
        delete this.api.datacenter.Exchange;
        this.api.ui.unloadUIComponent("AskYesNoIgnoreExchange");
        this.api.ui.unloadUIComponent("AskCancelExchange");
        if (this.api.ui.getUIComponent("Exchange"))
        {
            if (sExtraData == "a")
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("EXCHANGE_OK"), "INFO_CHAT");
            }
            else
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("EXCHANGE_CANCEL"), "INFO_CHAT");
            } // end if
        } // end else if
        this.api.ui.unloadUIComponent("Exchange");
        this.api.ui.unloadUIComponent("Craft");
        this.api.ui.unloadUIComponent("NpcShop");
        this.api.ui.unloadUIComponent("PlayerShop");
        this.api.ui.unloadUIComponent("TaxCollectorStorage");
        this.api.ui.unloadUIComponent("PlayerShopModifier");
        this.api.ui.unloadUIComponent("Storage");
        this.api.ui.unloadUIComponent("BigStoreSell");
        this.api.ui.unloadUIComponent("BigStoreBuy");
        this.api.ui.unloadUIComponent("SecureCraft");
        this.api.ui.unloadUIComponent("CrafterList");
        this.api.ui.unloadUIComponent("ItemUtility");
        this.api.ui.unloadUIComponent("MountStorage");
        this.api.ui.unloadUIComponent("MountParkSale");
        this.api.ui.unloadUIComponent("HouseSale");
        if (dofus.Constants.SAVING_THE_WORLD)
        {
            dofus.SaveTheWorld.getInstance().nextAction();
        } // end if
    };
    _loc1.onCreate = function (bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            return;
        } // end if
        var _loc4 = sExtraData.split("|");
        var _loc5 = Number(_loc4[0]);
        var _loc6 = _loc4[1];
        this.api.datacenter.Basics.aks_exchange_echangeType = _loc5;
        var _loc7 = this.api.datacenter.Temporary;
        switch (_loc5)
        {
            case 0:
            case 4:
            {
                _loc7.Shop = new dofus.datacenter.Shop();
                var _loc8 = this.api.datacenter.Sprites.getItemAt(_loc6);
                _loc7.Shop.name = _loc8.name;
                _loc7.Shop.gfx = _loc8.gfxID;
                var _loc9 = new Array();
                _loc9[1] = _loc8.color1 == undefined ? (-1) : (_loc8.color1);
                _loc9[2] = _loc8.color2 == undefined ? (-1) : (_loc8.color2);
                _loc9[3] = _loc8.color3 == undefined ? (-1) : (_loc8.color3);
                if (_loc5 == 0)
                {
                    this.api.ui.loadUIComponent("NpcShop", "NpcShop", {data: _loc7.Shop, colors: _loc9});
                }
                else if (_loc5 == 4)
                {
                    this.api.ui.loadUIComponent("PlayerShop", "PlayerShop", {data: _loc7.Shop, colors: _loc9});
                } // end else if
                break;
            } 
            case 1:
            {
                this.api.datacenter.Exchange.inventory = this.api.datacenter.Player.Inventory.clone();
                this.api.ui.unloadUIComponent("AskYesNoIgnoreExchange");
                this.api.ui.unloadUIComponent("AskCancelExchange");
                this.api.ui.loadUIComponent("Exchange", "Exchange");
                break;
            } 
            case 2:
            case 9:
            case 17:
            case 18:
            case 3:
            {
                if (_loc5 == 3)
                {
                    this.api.datacenter.Exchange = new dofus.datacenter.Exchange();
                }
                else
                {
                    this.api.datacenter.Exchange = new dofus.datacenter.Exchange(Number(_loc6));
                } // end else if
                this.api.datacenter.Exchange.inventory = this.api.datacenter.Player.Inventory.clone();
                if (_loc5 == 3)
                {
                    _loc4 = _loc6.split(";");
                    var _loc10 = Number(_loc4[0]);
                    var _loc11 = Number(_loc4[1]);
                    if (_global.API.lang.getSkillForgemagus(_loc11) > 0)
                    {
                        this.api.ui.loadUIComponent("ForgemagusCraft", "Craft", {skillId: _loc11, maxItem: _loc10});
                    }
                    else
                    {
                        this.api.ui.loadUIComponent("Craft", "Craft", {skillId: _loc11, maxItem: _loc10});
                    } // end else if
                }
                else
                {
                    this.api.ui.unloadUIComponent("AskYesNoIgnoreExchange");
                    this.api.ui.unloadUIComponent("AskCancelExchange");
                    this.api.ui.loadUIComponent("Exchange", "Exchange");
                } // end else if
                break;
            } 
            case 5:
            {
                _loc7.Storage = new dofus.datacenter.Storage();
                this.api.ui.loadUIComponent("Storage", "Storage", {data: _loc7.Storage});
                break;
            } 
            case 8:
            {
                _loc7.Storage = new dofus.datacenter.TaxCollectorStorage();
                var _loc12 = this.api.datacenter.Sprites.getItemAt(_loc6);
                _loc7.Storage.name = _loc12.name;
                _loc7.Storage.gfx = _loc12.gfxID;
                this.api.ui.loadUIComponent("TaxCollectorStorage", "TaxCollectorStorage", {data: _loc7.Storage});
                break;
            } 
            case 6:
            {
                _loc7.Shop = new dofus.datacenter.Shop();
                this.api.ui.loadUIComponent("PlayerShopModifier", "PlayerShopModifier", {data: _loc7.Shop});
                break;
            } 
            case 10:
            {
                _loc7.Shop = new dofus.datacenter.BigStore();
                _loc4 = _loc6.split(";");
                var _loc13 = _loc4[0].split(",");
                _loc7.Shop.quantity1 = Number(_loc13[0]);
                _loc7.Shop.quantity2 = Number(_loc13[1]);
                _loc7.Shop.quantity3 = Number(_loc13[2]);
                _loc7.Shop.types = _loc4[1].split(",");
                _loc7.Shop.tax = Number(_loc4[2]);
                _loc7.Shop.maxLevel = Number(_loc4[3]);
                _loc7.Shop.maxItemCount = Number(_loc4[4]);
                _loc7.Shop.npcID = Number(_loc4[5]);
                _loc7.Shop.maxSellTime = Number(_loc4[6]);
                this.api.ui.loadUIComponent("BigStoreSell", "BigStoreSell", {data: _loc7.Shop});
                break;
            } 
            case 11:
            {
                _loc7.Shop = new dofus.datacenter.BigStore();
                _loc4 = _loc6.split(";");
                var _loc14 = _loc4[0].split(",");
                _loc7.Shop.quantity1 = Number(_loc14[0]);
                _loc7.Shop.quantity2 = Number(_loc14[1]);
                _loc7.Shop.quantity3 = Number(_loc14[2]);
                _loc7.Shop.types = _loc4[1].split(",");
                _loc7.Shop.tax = Number(_loc4[2]);
                _loc7.Shop.maxLevel = Number(_loc4[3]);
                _loc7.Shop.maxItemCount = Number(_loc4[4]);
                _loc7.Shop.npcID = Number(_loc4[5]);
                _loc7.Shop.maxSellTime = Number(_loc4[6]);
                this.api.ui.loadUIComponent("BigStoreBuy", "BigStoreBuy", {data: _loc7.Shop});
                break;
            } 
            case 12:
            case 13:
            {
                this.api.datacenter.Exchange.inventory = this.api.datacenter.Player.Inventory.clone();
                _loc4 = _loc6.split(";");
                var _loc15 = Number(_loc4[0]);
                var _loc16 = Number(_loc4[1]);
                this.api.ui.unloadUIComponent("AskYesNoIgnoreExchange");
                this.api.ui.unloadUIComponent("AskCancelExchange");
                this.api.ui.loadUIComponent("SecureCraft", "SecureCraft", {skillId: _loc16, maxItem: _loc15});
                break;
            } 
            case 14:
            {
                var _loc17 = new ank.utils.ExtendedArray();
                var _loc18 = _loc6.split(";");
                var _loc19 = 0;
                
                while (++_loc19, _loc19 < _loc18.length)
                {
                    var _loc20 = Number(_loc18[_loc19]);
                    _loc17.push({label: this.api.lang.getJobText(_loc20).n, id: _loc20});
                } // end while
                this.api.ui.loadUIComponent("CrafterList", "CrafterList", {crafters: new ank.utils.ExtendedArray(), jobs: _loc17});
                break;
            } 
            case 15:
            {
                this.api.ui.unloadUIComponent("Mount");
                _loc7.Storage = new dofus.datacenter.Storage();
                this.api.ui.loadUIComponent("Storage", "Storage", {isMount: true, data: _loc7.Storage});
                break;
            } 
            case 16:
            {
                var _loc21 = new ank.utils.ExtendedArray();
                var _loc22 = new ank.utils.ExtendedArray();
                _loc4 = _loc6.split("~");
                var _loc23 = _loc4[0].split(";");
                var _loc24 = _loc4[1].split(";");
                if (_loc23 != undefined)
                {
                    var _loc25 = 0;
                    
                    while (++_loc25, _loc25 < _loc23.length)
                    {
                        if (_loc23[_loc25] != "")
                        {
                            _loc21.push(this.api.network.Mount.createMount(_loc23[_loc25]));
                        } // end if
                    } // end while
                } // end if
                if (_loc24 != undefined)
                {
                    var _loc26 = 0;
                    
                    while (++_loc26, _loc26 < _loc24.length)
                    {
                        if (_loc24[_loc26] != "")
                        {
                            _loc22.push(this.api.network.Mount.createMount(_loc24[_loc26]));
                        } // end if
                    } // end while
                } // end if
                this.api.ui.loadUIComponent("MountStorage", "MountStorage", {mounts: _loc21, parkMounts: _loc22});
                break;
            } 
        } // End of switch
    };
    _loc1.onCrafterReference = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = Number(sExtraData.substr(1));
        this.api.kernel.showMessage(undefined, this.api.lang.getText(_loc3 ? ("CRAFTER_REFERENCE_ADD") : ("CRAFTER_REFERENCE_REMOVE"), [this.api.lang.getJobText(_loc4).n]), "INFO_CHAT");
    };
    _loc1.onCrafterListChanged = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = sExtraData.substr(1).split(";");
        var _loc5 = this.api.ui.getUIComponent("CrafterList").crafters;
        var _loc6 = Number(_loc4[0]);
        var _loc7 = _loc4[1];
        var _loc8 = _loc5.findFirstItem("id", _loc7);
        if (_loc3)
        {
            var _loc9 = _loc4[2];
            var _loc10 = Number(_loc4[3]);
            var _loc11 = Number(_loc4[4]);
            var _loc12 = Number(_loc4[5]);
            var _loc13 = Number(_loc4[6]);
            var _loc14 = Number(_loc4[7]);
            var _loc15 = _loc4[8].split(",");
            var _loc16 = _loc4[9];
            var _loc17 = _loc4[10].split(",");
            var _loc18 = new dofus.datacenter.Crafter(_loc7, _loc9);
            _loc18.job = new dofus.datacenter.Job(_loc6, new ank.utils.ExtendedArray(), new dofus.datacenter.JobOptions(Number(_loc17[0]), Number(_loc17[1])));
            _loc18.job.level = _loc10;
            _loc18.mapId = _loc11;
            _loc18.inWorkshop = _loc12;
            _loc18.breedId = _loc13;
            _loc18.sex = _loc14;
            _loc18.color1 = _loc15[0];
            _loc18.color2 = _loc15[1];
            _loc18.color3 = _loc15[2];
            this.api.kernel.CharactersManager.setSpriteAccessories(_loc18, _loc16);
            if (_loc8.index != -1)
            {
                _loc5.updateItem(_loc8.index, _loc18);
            }
            else
            {
                _loc5.push(_loc18);
            } // end else if
        }
        else if (_loc8.index != -1)
        {
            _loc5.removeItems(_loc8.index, 1);
        } // end else if
    };
    _loc1.onMountStorage = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0);
        var _loc4 = false;
        switch (_loc3)
        {
            case "~":
            {
                _loc4 = true;
            } 
            case "+":
            {
                this.api.ui.getUIComponent("MountStorage").mounts.push(this.api.network.Mount.createMount(sExtraData.substr(1), _loc4));
                break;
            } 
            case "-":
            {
                var _loc5 = Number(sExtraData.substr(1));
                var _loc6 = this.api.ui.getUIComponent("MountStorage").mounts;
                for (var a in _loc6)
                {
                    if (_loc6[a].ID == _loc5)
                    {
                        _loc6.removeItems(Number(a), 1);
                    } // end if
                } // end of for...in
                break;
            } 
            case "E":
            {
                break;
            } 
        } // End of switch
    };
    _loc1.onMountPark = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0);
        switch (_loc3)
        {
            case "+":
            {
                this.api.ui.getUIComponent("MountStorage").parkMounts.push(this.api.network.Mount.createMount(sExtraData.substr(1)));
                break;
            } 
            case "-":
            {
                var _loc4 = Number(sExtraData.substr(1));
                var _loc5 = this.api.ui.getUIComponent("MountStorage").parkMounts;
                for (var a in _loc5)
                {
                    if (_loc5[a].ID == _loc4)
                    {
                        _loc5.removeItems(Number(a), 1);
                    } // end if
                } // end of for...in
                break;
            } 
            case "E":
            {
                break;
            } 
        } // End of switch
    };
    _loc1.onCraft = function (bSuccess, sExtraData)
    {
        if (this.api.datacenter.Basics.aks_exchange_isForgemagus || !this.api.datacenter.Basics.isCraftLooping)
        {
            this.api.datacenter.Exchange.clearLocalGarbage();
        } // end if
        var _loc4 = this.api.datacenter.Basics.aks_exchange_echangeType;
        if (_loc4 == 12 || _loc4 == 13)
        {
            var _loc5 = this.api.datacenter.Exchange;
            _loc5.clearDistantGarbage();
            _loc5.clearPayGarbage();
            _loc5.clearPayIfSuccessGarbage();
            _loc5.payKama = 0;
            _loc5.payIfSuccessKama = 0;
            this.api.ui.getUIComponent("SecureCraft").updateInventory();
        } // end if
        var _loc6 = !this.api.datacenter.Basics.aks_exchange_isForgemagus;
        switch (sExtraData.substr(0, 1))
        {
            case "I":
            {
                if (!bSuccess)
                {
                    this.api.kernel.showMessage(this.api.lang.getText("CRAFT"), this.api.lang.getText("NO_CRAFT_RESULT"), "ERROR_BOX", {name: "Impossible"});
                } // end if
                break;
            } 
            case "F":
            {
                if (!bSuccess && _loc6)
                {
                    this.api.kernel.showMessage(this.api.lang.getText("CRAFT"), this.api.lang.getText("CRAFT_FAILED"), "ERROR_BOX", {name: "CraftFailed"});
                } // end if
                this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CRAFT_KO);
                break;
            } 
            case ";":
            {
                if (bSuccess)
                {
                    var _loc7 = sExtraData.substr(1).split(";");
                    if (_loc7.length == 1)
                    {
                        var _loc8 = new dofus.datacenter.Item(0, Number(_loc7[0]), undefined, undefined, undefined);
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("CRAFT_SUCCESS_SELF", [_loc8.name]), "INFO_CHAT");
                        this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CRAFT_KO);
                    }
                    else
                    {
                        var _loc9 = _loc7[1].substr(0, 1);
                        var _loc10 = _loc7[1].substr(1);
                        var _loc11 = Number(_loc7[0]);
                        var _loc12 = _loc7[2];
                        var _loc13 = new Array();
                        _loc13.push(_loc11);
                        _loc13.push(_loc12);
                        switch (_loc9)
                        {
                            case "T":
                            {
                                this.api.kernel.showMessage(undefined, this.api.kernel.ChatManager.parseInlineItems(this.api.lang.getText("CRAFT_SUCCESS_TARGET", [_loc10]), _loc13), "INFO_CHAT");
                                break;
                            } 
                            case "B":
                            {
                                this.api.kernel.showMessage(undefined, this.api.kernel.ChatManager.parseInlineItems(this.api.lang.getText("CRAFT_SUCCESS_OTHER", [_loc10]), _loc13), "INFO_CHAT");
                                break;
                            } 
                        } // End of switch
                    } // end if
                } // end else if
                break;
            } 
        } // End of switch
        if (!bSuccess)
        {
            this.api.datacenter.Exchange.clearCoopGarbage();
        } // end if
    };
    _loc1.onCraftLoop = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        this.api.kernel.showMessage(undefined, this.api.lang.getText("CRAFT_LOOP_PROCESS", [this._nItemsToCraft - _loc3 + 1, this._nItemsToCraft + 1]), "INFO_CHAT");
    };
    _loc1.onCraftLoopEnd = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        this.api.datacenter.Basics.isCraftLooping = false;
        switch (_loc3)
        {
            case 1:
            {
                var _loc4 = this.api.lang.getText("CRAFT_LOOP_END_OK");
                break;
            } 
            case 2:
            {
                _loc4 = this.api.lang.getText("CRAFT_LOOP_END_INTERRUPT");
                break;
            } 
            case 3:
            {
                _loc4 = this.api.lang.getText("CRAFT_LOOP_END_FAIL");
                break;
            } 
            case 4:
            {
                _loc4 = this.api.lang.getText("CRAFT_LOOP_END_INVALID");
                break;
            } 
        } // End of switch
        this.api.kernel.showMessage(undefined, _loc4, "INFO_CHAT");
        this.api.kernel.showMessage(this.api.lang.getText("CRAFT"), _loc4, "ERROR_BOX");
        this.api.ui.getUIComponent("Craft").onCraftLoopEnd();
        if (!this.api.datacenter.Basics.aks_exchange_isForgemagus)
        {
            this.api.datacenter.Exchange.clearLocalGarbage();
        } // end if
    };
    _loc1.onLocalMovement = function (bSuccess, sExtraData)
    {
        this.modifyLocal(sExtraData, this.api.datacenter.Exchange.localGarbage, "localKama");
    };
    _loc1.onDistantMovement = function (bSuccess, sExtraData)
    {
        switch (this.api.datacenter.Basics.aks_exchange_echangeType)
        {
            case 1:
            case 2:
            case 3:
            case 9:
            case 12:
            case 13:
            {
                this.modifyDistant(sExtraData, this.api.datacenter.Exchange.distantGarbage, "distantKama");
                break;
            } 
            case 10:
            {
                var _loc4 = sExtraData.charAt(0) == "+";
                var _loc5 = sExtraData.substr(1).split("|");
                var _loc6 = Number(_loc5[0]);
                var _loc7 = Number(_loc5[1]);
                var _loc8 = Number(_loc5[2]);
                var _loc9 = _loc5[3];
                var _loc10 = Number(_loc5[4]);
                var _loc11 = Number(_loc5[5]);
                var _loc12 = this.api.datacenter.Temporary.Shop;
                var _loc13 = _loc12.inventory.findFirstItem("ID", _loc6);
                if (_loc4)
                {
                    var _loc14 = new dofus.datacenter.Item(_loc6, _loc8, _loc7, -1, _loc9, _loc10);
                    _loc14.remainingHours = _loc11;
                    if (_loc13.index != -1)
                    {
                        _loc12.inventory.updateItem(_loc13.index, _loc14);
                    }
                    else
                    {
                        _loc12.inventory.push(_loc14);
                    } // end else if
                }
                else if (_loc13.index != -1)
                {
                    _loc12.inventory.removeItems(_loc13.index, 1);
                }
                else
                {
                    ank.utils.Logger.err("[onDistantMovement] cet objet n\'existe pas id=" + _loc6);
                } // end else if
                this.api.ui.getUIComponent("BigStoreSell").updateItemCount();
                break;
            } 
        } // End of switch
    };
    _loc1.onCoopMovement = function (bSuccess, sExtraData)
    {
        this.api.datacenter.Exchange.clearCoopGarbage();
        switch (this.api.datacenter.Basics.aks_exchange_echangeType)
        {
            case 12:
            {
                this.modifyDistant(sExtraData, this.api.datacenter.Exchange.coopGarbage, "distantKama", false);
                break;
            } 
            case 13:
            {
                this.modifyDistant(sExtraData, this.api.datacenter.Exchange.coopGarbage, "distantKama", true);
                break;
            } 
        } // End of switch
    };
    _loc1.onPayMovement = function (bSuccess, sExtraData)
    {
        var _loc4 = Number(sExtraData.charAt(0));
        var _loc5 = _loc4 == 1 ? (this.api.datacenter.Exchange.payGarbage) : (this.api.datacenter.Exchange.payIfSuccessGarbage);
        var _loc6 = _loc4 == 1 ? ("payKama") : ("payIfSuccessKama");
        switch (this.api.datacenter.Basics.aks_exchange_echangeType)
        {
            case 12:
            {
                this.modifyDistant(sExtraData.substr(2), _loc5, _loc6, false);
                break;
            } 
            case 13:
            {
                this.modifyLocal(sExtraData.substr(2), _loc5, _loc6);
                break;
            } 
        } // End of switch
    };
    _loc1.modifyLocal = function (sExtraData, ea, sKamaLocation)
    {
        var _loc5 = sExtraData.charAt(0);
        var _loc6 = this.api.datacenter.Exchange;
        switch (_loc5)
        {
            case "O":
            {
                var _loc7 = sExtraData.charAt(1) == "+";
                var _loc8 = sExtraData.substr(2).split("|");
                var _loc9 = Number(_loc8[0]);
                var _loc10 = Number(_loc8[1]);
                var _loc11 = this.api.datacenter.Player.Inventory.findFirstItem("ID", _loc9);
                var _loc12 = _loc6.inventory.findFirstItem("ID", _loc9);
                var _loc13 = ea.findFirstItem("ID", _loc9);
                if (_loc7)
                {
                    var _loc14 = _loc12.item;
                    var _loc15 = new dofus.datacenter.Item(_loc9, _loc14.unicID, _loc10, -2, _loc14.compressedEffects);
                    var _loc16 = -1;
                    var _loc17 = _loc11.item.Quantity - _loc10;
                    if (_loc17 == 0)
                    {
                        _loc16 = -3;
                    } // end if
                    _loc12.item.Quantity = _loc17;
                    _loc12.item.position = _loc16;
                    _loc6.inventory.updateItem(_loc12.index, _loc12.item);
                    if (_loc13.index != -1)
                    {
                        ea.updateItem(_loc13.index, _loc15);
                    }
                    else
                    {
                        ea.push(_loc15);
                    } // end else if
                }
                else if (_loc13.index != -1)
                {
                    _loc12.item.position = -1;
                    _loc12.item.Quantity = _loc11.item.Quantity;
                    _loc6.inventory.updateItem(_loc12.index, _loc12.item);
                    ea.removeItems(_loc13.index, 1);
                } // end else if
                break;
            } 
            case "G":
            {
                var _loc18 = Number(sExtraData.substr(1));
                _loc6[sKamaLocation] = _loc18;
                break;
            } 
        } // End of switch
    };
    _loc1.modifyDistant = function (sExtraData, ea, sKamaLocation, bForceModifyInventory)
    {
        var _loc6 = sExtraData.charAt(0);
        var _loc7 = this.api.datacenter.Exchange;
        switch (_loc6)
        {
            case "O":
            {
                var _loc8 = sExtraData.charAt(1) == "+";
                var _loc9 = sExtraData.substr(2).split("|");
                var _loc10 = Number(_loc9[0]);
                var _loc11 = Number(_loc9[1]);
                var _loc12 = Number(_loc9[2]);
                var _loc13 = _loc9[3];
                var _loc14 = ea.findFirstItem("ID", _loc10);
                if (_loc8)
                {
                    var _loc15 = new dofus.datacenter.Item(_loc10, _loc12, _loc11, -1, _loc13);
                    var _loc16 = bForceModifyInventory != undefined ? (bForceModifyInventory) : (_loc7.distantPlayerID == undefined);
                    if (_loc14.index != -1)
                    {
                        ea.updateItem(_loc14.index, _loc15);
                    }
                    else
                    {
                        ea.push(_loc15);
                    } // end else if
                    if (_loc16)
                    {
                        var _loc17 = _loc7.inventory.findFirstItem("ID", _loc10);
                        if (_loc17.index != -1)
                        {
                            _loc17.item.position = -1;
                            _loc17.item.Quantity = Number(_loc17.item.Quantity) + Number(_loc11);
                            _loc7.inventory.updateItem(_loc17.index, _loc17.item);
                        }
                        else
                        {
                            _loc7.inventory.push(_loc15);
                            _global.API.ui.getUIComponent("Craft").updateForgemagusResult(_loc15);
                        } // end if
                    } // end else if
                }
                else if (_loc14.index != -1)
                {
                    ea.removeItems(_loc14.index, 1);
                } // end else if
                break;
            } 
            case "G":
            {
                var _loc18 = Number(sExtraData.substr(1));
                _loc7[sKamaLocation] = _loc18;
                break;
            } 
        } // End of switch
    };
    _loc1.onStorageMovement = function (bSuccess, sExtraData)
    {
        var _loc4 = sExtraData.charAt(0);
        var _loc5 = this.api.datacenter.Temporary.Storage;
        switch (_loc4)
        {
            case "O":
            {
                var _loc6 = sExtraData.charAt(1) == "+";
                var _loc7 = sExtraData.substr(2).split("|");
                var _loc8 = Number(_loc7[0]);
                var _loc9 = Number(_loc7[1]);
                var _loc10 = Number(_loc7[2]);
                var _loc11 = _loc7[3];
                var _loc12 = _loc5.inventory.findFirstItem("ID", _loc8);
                if (_loc6)
                {
                    var _loc13 = new dofus.datacenter.Item(_loc8, _loc10, _loc9, -1, _loc11);
                    if (_loc12.index != -1)
                    {
                        _loc5.inventory.updateItem(_loc12.index, _loc13);
                    }
                    else
                    {
                        _loc5.inventory.push(_loc13);
                    } // end else if
                    break;
                }
                else if (_loc12.index != -1)
                {
                    _loc5.inventory.removeItems(_loc12.index, 1);
                }
                else
                {
                    ank.utils.Logger.err("[onStorageMovement] cet objet n\'existe pas id=" + _loc8);
                } // end else if
                break;
            } 
            case "G":
            {
                var _loc14 = Number(sExtraData.substr(1));
                _loc5.Kama = _loc14;
                break;
            } 
        } // End of switch
    };
    _loc1.onPlayerShopMovement = function (bSuccess, sExtraData)
    {
        var _loc4 = sExtraData.charAt(0) == "+";
        var _loc5 = sExtraData.substr(1).split("|");
        var _loc6 = Number(_loc5[0]);
        var _loc7 = Number(_loc5[1]);
        var _loc8 = Number(_loc5[2]);
        var _loc9 = _loc5[3];
        var _loc10 = Number(_loc5[4]);
        var _loc11 = this.api.datacenter.Temporary.Shop;
        var _loc12 = _loc11.inventory.findFirstItem("ID", _loc6);
        if (_loc4)
        {
            var _loc13 = new dofus.datacenter.Item(_loc6, _loc8, _loc7, -1, _loc9, _loc10);
            if (_loc12.index != -1)
            {
                _loc11.inventory.updateItem(_loc12.index, _loc13);
            }
            else
            {
                _loc11.inventory.push(_loc13);
            } // end else if
            
        }
        else if (_loc12.index != -1)
        {
            _loc11.inventory.removeItems(_loc12.index, 1);
        }
        else
        {
            ank.utils.Logger.err("[onPlayerShopMovement] cet objet n\'existe pas id=" + _loc6);
        } // end else if
    };
    _loc1.onList = function (sExtraData)
    {
        switch (this.api.datacenter.Basics.aks_exchange_echangeType)
        {
            case 0:
            {
                var _loc3 = sExtraData.split("|");
                var _loc4 = new ank.utils.ExtendedArray();
                for (var k in _loc3)
                {
                    var _loc5 = _loc3[k].split(";");
                    var _loc6 = Number(_loc5[0]);
                    var _loc7 = _loc5[1];
                    var _loc8 = new dofus.datacenter.Item(0, _loc6, undefined, undefined, _loc7);
                    _loc8.priceMultiplicator = this.api.lang.getConfigText("BUY_PRICE_MULTIPLICATOR");
                    _loc4.push(_loc8);
                } // end of for...in
                this.api.datacenter.Temporary.Shop.inventory = _loc4;
                break;
            } 
            case 5:
            case 15:
            case 8:
            {
                var _loc9 = sExtraData.split(";");
                var _loc10 = new ank.utils.ExtendedArray();
                for (var k in _loc9)
                {
                    var _loc11 = _loc9[k];
                    var _loc12 = _loc11.charAt(0);
                    var _loc13 = _loc11.substr(1);
                    switch (_loc12)
                    {
                        case "O":
                        {
                            var _loc14 = this.api.kernel.CharactersManager.getItemObjectFromData(_loc13);
                            _loc10.push(_loc14);
                            break;
                        } 
                        case "G":
                        {
                            this.onStorageKama(_loc13);
                            break;
                        } 
                    } // End of switch
                } // end of for...in
                this.api.datacenter.Temporary.Storage.inventory = _loc10;
                if (dofus.Constants.SAVING_THE_WORLD)
                {
                    dofus.SaveTheWorld.getInstance().newItems(sExtraData);
                    dofus.SaveTheWorld.getInstance().nextAction();
                } // end if
                break;
            } 
            case 4:
            case 6:
            {
                var _loc15 = sExtraData.split("|");
                var _loc16 = new ank.utils.ExtendedArray();
                for (var k in _loc15)
                {
                    var _loc17 = _loc15[k].split(";");
                    var _loc18 = Number(_loc17[0]);
                    var _loc19 = Number(_loc17[1]);
                    var _loc20 = Number(_loc17[2]);
                    var _loc21 = _loc17[3];
                    var _loc22 = Number(_loc17[4]);
                    var _loc23 = new dofus.datacenter.Item(_loc18, _loc20, _loc19, -1, _loc21, _loc22);
                    _loc16.push(_loc23);
                } // end of for...in
                this.api.datacenter.Temporary.Shop.inventory = _loc16;
                break;
            } 
            case 10:
            {
                var _loc24 = sExtraData.split("|");
                var _loc25 = new ank.utils.ExtendedArray();
                if (sExtraData.length != 0)
                {
                    for (var k in _loc24)
                    {
                        var _loc26 = _loc24[k].split(";");
                        var _loc27 = Number(_loc26[0]);
                        var _loc28 = Number(_loc26[1]);
                        var _loc29 = Number(_loc26[2]);
                        var _loc30 = _loc26[3];
                        var _loc31 = Number(_loc26[4]);
                        var _loc32 = Number(_loc26[5]);
                        var _loc33 = new dofus.datacenter.Item(_loc27, _loc29, _loc28, -1, _loc30, _loc31);
                        _loc33.remainingHours = _loc32;
                        _loc25.push(_loc33);
                    } // end of for...in
                } // end if
                this.api.datacenter.Temporary.Shop.inventory = _loc25;
                break;
            } 
        } // End of switch
    };
    _loc1.onSell = function (bSuccess)
    {
        if (bSuccess)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("SELL_DONE"), "INFO_CHAT");
        }
        else
        {
            this.api.kernel.showMessage(this.api.lang.getText("EXCHANGE"), this.api.lang.getText("CANT_SELL"), "ERROR_BOX", {name: "Sell"});
        } // end else if
    };
    _loc1.onBuy = function (bSuccess)
    {
        if (bSuccess)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("BUY_DONE"), "INFO_CHAT");
        }
        else
        {
            this.api.kernel.showMessage(this.api.lang.getText("EXCHANGE"), this.api.lang.getText("CANT_BUY"), "ERROR_BOX", {name: "Buy"});
        } // end else if
    };
    _loc1.onStorageKama = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        this.api.datacenter.Temporary.Storage.Kama = _loc3;
    };
    _loc1.onBigStoreTypeItemsList = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = _loc3[1].split(";");
        var _loc6 = new ank.utils.ExtendedArray();
        if (_loc3[1].length != 0)
        {
            var _loc7 = 0;
            
            while (++_loc7, _loc7 < _loc5.length)
            {
                var _loc8 = Number(_loc5[_loc7]);
                var _loc9 = new dofus.datacenter.Item(0, _loc8, 1, -1, "", 0);
                _loc6.push(_loc9);
            } // end while
        } // end if
        this.api.datacenter.Temporary.Shop.inventory = _loc6;
        this.api.ui.getUIComponent("BigStoreBuy").setType(_loc4);
    };
    _loc1.onItemMiddlePriceInBigStore = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        this.api.ui.getUIComponent("BigStoreBuy").setMiddlePrice(Number(_loc3[0]), Number(_loc3[1]));
        this.api.ui.getUIComponent("BigStoreSell").setMiddlePrice(Number(_loc3[0]), Number(_loc3[1]));
    };
    _loc1.onBigStoreTypeItemsMovement = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = Number(sExtraData.substr(1));
        var _loc5 = this.api.datacenter.Temporary.Shop;
        var _loc6 = _loc5.inventory.findFirstItem("unicID", _loc4);
        if (_loc3)
        {
            var _loc7 = new dofus.datacenter.Item(0, _loc4, 0, -1, "", 0);
            if (_loc6.index != -1)
            {
                _loc5.inventory.updateItem(_loc6.index, _loc7);
            }
            else
            {
                _loc5.inventory.push(_loc7);
            } // end else if
            
        }
        else if (_loc6.index != -1)
        {
            _loc5.inventory.removeItems(_loc6.index, 1);
        }
        else
        {
            ank.utils.Logger.err("[onBigStoreTypeItemsMovement] cet objet n\'existe pas unicID=" + _loc4);
        } // end else if
    };
    _loc1.onBigStoreItemsList = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        _loc3.shift();
        var _loc5 = new ank.utils.ExtendedArray();
        for (var k in _loc3)
        {
            var _loc6 = _loc3[k].split(";");
            var _loc7 = Number(_loc6[0]);
            var _loc8 = _loc6[1];
            var _loc9 = Number(_loc6[2]);
            var _loc10 = Number(_loc6[3]);
            var _loc11 = Number(_loc6[4]);
            var _loc12 = new dofus.datacenter.Item(_loc7, _loc4, 0, -1, _loc8, 0);
            var _loc13 = {id: _loc7, item: _loc12, priceSet1: _loc9, priceSet2: _loc10, priceSet3: _loc11};
            _loc5.push(_loc13);
        } // end of for...in
        this.api.datacenter.Temporary.Shop.inventory2 = _loc5;
        this.api.ui.getUIComponent("BigStoreBuy").setItem(_loc4);
    };
    _loc1.onBigStoreItemsMovement = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = sExtraData.substr(1).split("|");
        var _loc5 = Number(_loc4[0]);
        var _loc6 = Number(_loc4[1]);
        var _loc7 = _loc4[2];
        var _loc8 = Number(_loc4[3]);
        var _loc9 = Number(_loc4[4]);
        var _loc10 = Number(_loc4[5]);
        var _loc11 = this.api.datacenter.Temporary.Shop;
        var _loc12 = _loc11.inventory2.findFirstItem("id", _loc5);
        if (_loc3)
        {
            var _loc13 = new dofus.datacenter.Item(_loc5, _loc6, 0, -1, _loc7, 0);
            var _loc14 = {id: _loc5, item: _loc13, priceSet1: _loc8, priceSet2: _loc9, priceSet3: _loc10};
            if (_loc12.index != -1)
            {
                _loc11.inventory2.updateItem(_loc12.index, _loc14);
            }
            else
            {
                _loc11.inventory2.push(_loc14);
            } // end else if
            
        }
        else if (_loc12.index != -1)
        {
            _loc11.inventory2.removeItems(_loc12.index, 1);
        }
        else
        {
            ank.utils.Logger.err("[onBigStoreItemsMovement] cet objet n\'existe pas id=" + _loc5);
        } // end else if
    };
    _loc1.onSearch = function (sExtraData)
    {
        this.api.ui.getUIComponent("BigStoreBuy").onSearchResult(sExtraData == "K");
    };
    _loc1.onCraftPublicMode = function (sExtraData)
    {
        if (sExtraData.length == 1)
        {
            var _loc3 = sExtraData;
            this.api.datacenter.Player.craftPublicMode = _loc3 == "+" ? (true) : (false);
        }
        else
        {
            var _loc4 = sExtraData.charAt(0);
            var _loc5 = sExtraData.substr(1).split("|");
            var _loc6 = _loc5[0];
            var _loc7 = this.api.datacenter.Sprites.getItemAt(_loc6);
            if (_loc4 == "+" && _loc5[1].length > 0)
            {
                var _loc8 = _loc5[1].split(";");
                _loc7.multiCraftSkillsID = _loc8;
            }
            else
            {
                _loc7.multiCraftSkillsID = undefined;
            } // end else if
        } // end else if
    };
    _loc1.onMountPods = function (sExtraData)
    {
        var _loc3 = sExtraData.split(";");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        this.api.datacenter.Player.mount.podsMax = _loc5;
        this.api.datacenter.Player.mount.pods = _loc4;
    };
    _loc1.cancel = function (oEvent)
    {
        this.leave();
    };
    _loc1.yes = function (oEvent)
    {
        this.accept();
    };
    _loc1.no = function (oEvent)
    {
        this.leave();
    };
    _loc1.ignore = function (oEvent)
    {
        this.api.kernel.ChatManager.addToBlacklist(oEvent.params.player);
        this.api.kernel.showMessage(undefined, this.api.lang.getText("TEMPORARY_BLACKLISTED", [oEvent.params.player]), "INFO_CHAT");
        this.leave();
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
