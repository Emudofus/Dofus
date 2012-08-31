// Action script...

// [Initial MovieClip Action of sprite 933]
#initclip 145
class dofus.aks.Exchange extends dofus.aks.Handler
{
    var aks, api;
    function Exchange(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function leave()
    {
        aks.send("EV", false);
    } // End of the function
    function request(type, id, cellNum)
    {
        aks.send("ER" + type + (id == undefined ? ("") : (id)) + (cellNum == undefined ? ("") : ("|" + cellNum)), true);
    } // End of the function
    function shop(nID)
    {
        aks.send("Es" + nID);
    } // End of the function
    function accept()
    {
        aks.send("EA", false);
    } // End of the function
    function ready()
    {
        aks.send("EK", false);
    } // End of the function
    function movementItem(bAdd, nID, nQuantity, nPrice)
    {
        aks.send("EMO" + (bAdd ? ("+") : ("-")) + nID + "|" + nQuantity + (nPrice == undefined ? ("") : ("|" + nPrice)), false);
    } // End of the function
    function movementKama(nQuantity)
    {
        aks.send("EMG" + nQuantity, false);
    } // End of the function
    function sell(id, quantity)
    {
        aks.send("ES" + id + "|" + quantity, true);
    } // End of the function
    function buy(nID, nQuantity)
    {
        aks.send("EB" + nID + "|" + nQuantity, true);
    } // End of the function
    function offlineExchange()
    {
        aks.send("EQ", false);
    } // End of the function
    function onRequest(bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc3 = sExtraData.split("|");
            var _loc2 = _loc3[0];
            var _loc4 = _loc3[1];
            var _loc5 = api.datacenter.Player.ID == _loc2 ? (_loc4) : (_loc2);
            var _loc11 = api.datacenter.Exchange = new dofus.datacenter.Exchange(_loc5);
            if (api.datacenter.Player.ID == _loc2)
            {
                var _loc6 = api.datacenter.Sprites.getItemAt(_loc4);
                api.kernel.showMessage(api.lang.getText("EXCHANGE"), api.lang.getText("WAIT_FOR_EXCHANGE", [_loc6.name]), "INFO_CANCEL", {name: "Exchange", listener: this});
            }
            else
            {
                _loc6 = api.datacenter.Sprites.getItemAt(_loc2);
                api.kernel.showMessage(api.lang.getText("EXCHANGE"), api.lang.getText("A_WANT_EXCHANGE", [_loc6.name]), "CAUTION_YESNO", {name: "Exchange", listener: this});
            } // end else if
        }
        else
        {
            var _loc7 = sExtraData.charAt(0);
            switch (_loc7)
            {
                case "O":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("ALREADY_EXCHANGE"), "ERROR_CHAT");
                    break;
                } 
                case "I":
                default:
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CANT_EXCHANGE"), "ERROR_CHAT");
                } 
            } // End of switch
        } // end else if
    } // End of the function
    function onReady(sExtraData)
    {
        var _loc2 = sExtraData.charAt(0) == "1";
        var _loc3 = Number(sExtraData.substr(1));
        var _loc4 = _loc3 == api.datacenter.Player.ID ? (0) : (1);
        api.datacenter.Exchange.readyStates.updateItem(_loc4, _loc2);
    } // End of the function
    function onLeave(bSuccess, sExtraData)
    {
        delete api.datacenter.Basics.aks_exchange_echangeType;
        delete api.datacenter.Exchange;
        api.ui.unloadUIComponent("AskYesNoExchange");
        api.ui.unloadUIComponent("AskCancelExchange");
        api.ui.unloadUIComponent("Exchange");
        api.ui.unloadUIComponent("Craft");
        api.ui.unloadUIComponent("NpcShop");
        api.ui.unloadUIComponent("PlayerShop");
        api.ui.unloadUIComponent("TaxCollectorStorage");
        api.ui.unloadUIComponent("PlayerShopModifier");
        api.ui.unloadUIComponent("Storage");
    } // End of the function
    function onCreate(bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            return;
        } // end if
        var _loc10 = sExtraData.split("|");
        var _loc8 = Number(_loc10[0]);
        var _loc9 = _loc10[1];
        false;
        api.datacenter.Basics.aks_exchange_echangeType = _loc8;
        var _loc5 = api.datacenter.Temporary;
        switch (_loc8)
        {
            case 0:
            case 4:
            {
                _loc5.Shop = new dofus.datacenter.Shop();
                var _loc11 = api.datacenter.Sprites.getItemAt(_loc9);
                _loc5.Shop.name = _loc11.name;
                _loc5.Shop.gfx = _loc11.gfxID;
                if (_loc8 == 0)
                {
                    api.ui.loadUIComponent("NpcShop", "NpcShop", {data: _loc5.Shop});
                }
                else if (_loc8 == 4)
                {
                    api.ui.loadUIComponent("PlayerShop", "PlayerShop", {data: _loc5.Shop});
                } // end else if
                break;
            } 
            case 1:
            {
                var _loc6 = api.datacenter.Player.Inventory;
                var _loc7 = new ank.utils.ExtendedArray();
                for (var _loc2 = 0; _loc2 < _loc6.length; ++_loc2)
                {
                    var _loc3 = _loc6[_loc2];
                    if (_loc3.position == -1)
                    {
                        var _loc4 = _loc3.clone();
                        _loc7.push(_loc4);
                    } // end if
                } // end of for
                api.datacenter.Exchange.inventory = _loc7;
                api.ui.unloadUIComponent("AskYesNoExchange");
                api.ui.unloadUIComponent("AskCancelExchange");
                api.ui.loadUIComponent("Exchange", "Exchange");
                break;
            } 
            case 2:
            case 9:
            case 3:
            {
                if (_loc8 == 3)
                {
                    api.datacenter.Exchange = new dofus.datacenter.Exchange();
                }
                else
                {
                    api.datacenter.Exchange = new dofus.datacenter.Exchange(Number(_loc9));
                } // end else if
                _loc6 = api.datacenter.Player.Inventory;
                _loc7 = new ank.utils.ExtendedArray();
                for (var _loc2 = 0; _loc2 < _loc6.length; ++_loc2)
                {
                    _loc3 = _loc6[_loc2];
                    if (_loc3.position == -1)
                    {
                        _loc7.push(_loc3.clone());
                    } // end if
                } // end of for
                api.datacenter.Exchange.inventory = _loc7;
                if (_loc8 == 3)
                {
                    api.ui.loadUIComponent("Craft", "Craft", {maxItem: _loc9});
                }
                else
                {
                    api.ui.unloadUIComponent("AskYesNoExchange");
                    api.ui.unloadUIComponent("AskCancelExchange");
                    api.ui.loadUIComponent("Exchange", "Exchange");
                } // end else if
                break;
            } 
            case 5:
            {
                _loc5.Storage = new dofus.datacenter.Storage();
                api.ui.loadUIComponent("Storage", "Storage", {data: _loc5.Storage});
                break;
            } 
            case 8:
            {
                _loc5.Storage = new dofus.datacenter.TaxCollectorStorage();
                var _loc12 = api.datacenter.Sprites.getItemAt(_loc9);
                _loc5.Storage.name = _loc12.name;
                _loc5.Storage.gfx = _loc12.gfxID;
                api.ui.loadUIComponent("TaxCollectorStorage", "TaxCollectorStorage", {data: _loc5.Storage});
                break;
            } 
            case 6:
            {
                _loc5.Shop = new dofus.datacenter.Shop();
                api.ui.loadUIComponent("PlayerShopModifier", "PlayerShopModifier", {data: _loc5.Shop});
                break;
            } 
        } // End of switch
    } // End of the function
    function onCraft(bSuccess, sExtraData)
    {
        api.datacenter.Exchange.clearLocalGarbage();
        if (!bSuccess)
        {
            switch (sExtraData)
            {
                case "I":
                {
                    api.kernel.showMessage(api.lang.getText("CRAFT"), api.lang.getText("NO_CRAFT_RESULT"), "ERROR_BOX", {name: "Impossible"});
                    break;
                } 
                case "F":
                {
                    api.kernel.showMessage(api.lang.getText("CRAFT"), api.lang.getText("CRAFT_FAILED"), "ERROR_BOX", {name: "CraftFailed"});
                    break;
                } 
            } // End of switch
        } // end if
    } // End of the function
    function onLocalMovement(bSuccess, sExtraData)
    {
        var _loc14 = sExtraData.charAt(0);
        var _loc3 = api.datacenter.Exchange;
        switch (_loc14)
        {
            case "O":
            {
                var _loc15 = sExtraData.charAt(1) == "+";
                var _loc8 = sExtraData.substr(2).split("|");
                var _loc4 = Number(_loc8[0]);
                var _loc13 = Number(_loc8[1]);
                var _loc6 = api.datacenter.Player.Inventory.findFirstItem("ID", _loc4);
                var _loc2 = _loc3.inventory.findFirstItem("ID", _loc4);
                var _loc5 = _loc3.localGarbage.findFirstItem("ID", _loc4);
                if (_loc15)
                {
                    var _loc9 = _loc2.item;
                    var _loc12 = new dofus.datacenter.Item(_loc4, _loc9.unicID, _loc13, -2, _loc9.compressedEffects);
                    var _loc7 = -1;
                    var _loc10 = _loc6.item.Quantity - _loc13;
                    if (_loc10 == 0)
                    {
                        _loc7 = -3;
                    } // end if
                    _loc2.item.Quantity = _loc10;
                    _loc2.item.position = _loc7;
                    _loc3.inventory.updateItem(_loc2.index, _loc2.item);
                    if (_loc5.index != -1)
                    {
                        _loc3.localGarbage.updateItem(_loc5.index, _loc12);
                    }
                    else
                    {
                        _loc3.localGarbage.push(_loc12);
                    } // end else if
                }
                else if (_loc5.index != -1)
                {
                    _loc2.item.position = -1;
                    _loc2.item.Quantity = _loc6.item.Quantity;
                    _loc3.inventory.updateItem(_loc2.index, _loc2.item);
                    _loc3.localGarbage.removeItems(_loc5.index, 1);
                } // end else if
                break;
            } 
            case "G":
            {
                _loc13 = Number(sExtraData.substr(1));
                _loc3.localKama = _loc13;
                break;
            } 
        } // End of switch
    } // End of the function
    function onDistantMovement(bSuccess, sExtraData)
    {
        var _loc12 = sExtraData.charAt(0);
        var _loc2 = api.datacenter.Exchange;
        switch (_loc12)
        {
            case "O":
            {
                var _loc13 = sExtraData.charAt(1) == "+";
                var _loc4 = sExtraData.substr(2).split("|");
                var _loc6 = Number(_loc4[0]);
                var _loc9 = Number(_loc4[1]);
                var _loc11 = Number(_loc4[2]);
                var _loc10 = _loc4[3];
                var _loc5 = _loc2.distantGarbage.findFirstItem("ID", _loc6);
                if (_loc13)
                {
                    var _loc7 = new dofus.datacenter.Item(_loc6, _loc11, _loc9, -1, _loc10);
                    var _loc14 = _loc2.distantPlayerID == undefined;
                    if (_loc5.index != -1)
                    {
                        _loc2.distantGarbage.updateItem(_loc5.index, _loc7);
                    }
                    else
                    {
                        _loc2.distantGarbage.push(_loc7);
                    } // end else if
                    if (_loc14)
                    {
                        var _loc3 = _loc2.inventory.findFirstItem("ID", _loc6);
                        if (_loc3.index != -1)
                        {
                            _loc3.item.position = -1;
                            _loc3.item.Quantity = Number(_loc3.item.Quantity) + Number(_loc9);
                            _loc2.inventory.updateItem(_loc3.index, _loc3.item);
                        }
                        else
                        {
                            _loc2.inventory.push(_loc7);
                        } // end if
                    } // end else if
                }
                else if (_loc5.index != -1)
                {
                    _loc2.distantGarbage.removeItems(_loc5.index, 1);
                } // end else if
                break;
            } 
            case "G":
            {
                _loc9 = Number(sExtraData.substr(1));
                _loc2.distantKama = _loc9;
                break;
            } 
        } // End of switch
    } // End of the function
    function onStorageMovement(bSuccess, sExtraData)
    {
        var _loc11 = sExtraData.charAt(0);
        var _loc2 = api.datacenter.Temporary.Storage;
        switch (_loc11)
        {
            case "O":
            {
                var _loc12 = sExtraData.charAt(1) == "+";
                var _loc3 = sExtraData.substr(2).split("|");
                var _loc5 = Number(_loc3[0]);
                var _loc8 = Number(_loc3[1]);
                var _loc10 = Number(_loc3[2]);
                var _loc9 = _loc3[3];
                var _loc4 = _loc2.inventory.findFirstItem("ID", _loc5);
                if (_loc12)
                {
                    var _loc7 = new dofus.datacenter.Item(_loc5, _loc10, _loc8, -1, _loc9);
                    if (_loc4.index != -1)
                    {
                        _loc2.inventory.updateItem(_loc4.index, _loc7);
                    }
                    else
                    {
                        _loc2.inventory.push(_loc7);
                    } // end else if
                    break;
                }
                else if (_loc4.index != -1)
                {
                    _loc2.inventory.removeItems(_loc4.index, 1);
                }
                else
                {
                    ank.utils.Logger.err("[onStorageMovement] cet objet n\'existe pas id=" + _loc5);
                } // end else if
                break;
            } 
            case "G":
            {
                _loc8 = Number(sExtraData.substr(1));
                _loc2.Kama = _loc8;
                break;
            } 
        } // End of switch
    } // End of the function
    function onPlayerShopMovement(bSuccess, sExtraData)
    {
        var _loc11 = sExtraData.charAt(0) == "+";
        var _loc2 = sExtraData.substr(1).split("|");
        var _loc5 = Number(_loc2[0]);
        var _loc7 = Number(_loc2[1]);
        var _loc10 = Number(_loc2[2]);
        var _loc8 = _loc2[3];
        var _loc9 = Number(_loc2[4]);
        var _loc4 = api.datacenter.Temporary.Shop;
        var _loc3 = _loc4.inventory.findFirstItem("ID", _loc5);
        if (_loc11)
        {
            var _loc6 = new dofus.datacenter.Item(_loc5, _loc10, _loc7, -1, _loc8, _loc9);
            if (_loc3.index != -1)
            {
                _loc4.inventory.updateItem(_loc3.index, _loc6);
            }
            else
            {
                _loc4.inventory.push(_loc6);
            } // end else if
        }
        else if (_loc3.index != -1)
        {
            _loc4.inventory.removeItems(_loc3.index, 1);
        }
        else
        {
            ank.utils.Logger.err("[onPlayerShopMovement] cet objet n\'existe pas id=" + _loc5);
        } // end else if
    } // End of the function
    function onList(sExtraData)
    {
        switch (api.datacenter.Basics.aks_exchange_echangeType)
        {
            case 0:
            {
                var _loc14 = sExtraData.split("|");
                var _loc15 = new ank.utils.ExtendedArray();
                for (var _loc16 in _loc14)
                {
                    var _loc2 = _loc14[_loc16].split(";");
                    var _loc10 = Number(_loc2[0]);
                    var _loc11 = _loc2[1];
                    var _loc13 = new dofus.datacenter.Item(0, _loc10, undefined, undefined, _loc11);
                    _loc13.priceMultiplicator = api.lang.getConfigText("BUY_PRICE_MULTIPLICATOR");
                    _loc15.push(_loc13);
                } // end of for...in
                api.datacenter.Temporary.Shop.inventory = _loc15;
                break;
            } 
            case 5:
            case 8:
            {
                _loc14 = sExtraData.split(";");
                _loc15 = new ank.utils.ExtendedArray();
                for (var _loc16 in _loc14)
                {
                    var _loc3 = _loc14[_loc16];
                    var _loc12 = _loc3.charAt(0);
                    var _loc4 = _loc3.substr(1);
                    switch (_loc12)
                    {
                        case "O":
                        {
                            _loc13 = api.kernel.CharactersManager.getItemObjectFromData(_loc4);
                            _loc15.push(_loc13);
                            break;
                        } 
                        case "G":
                        {
                            this.onStorageKama(_loc4);
                            break;
                        } 
                    } // End of switch
                } // end of for...in
                api.datacenter.Temporary.Storage.inventory = _loc15;
                break;
            } 
            case 4:
            case 6:
            {
                _loc14 = sExtraData.split("|");
                _loc15 = new ank.utils.ExtendedArray();
                for (var _loc16 in _loc14)
                {
                    _loc2 = _loc14[_loc16].split(";");
                    var _loc8 = Number(_loc2[0]);
                    var _loc5 = Number(_loc2[1]);
                    var _loc9 = Number(_loc2[2]);
                    var _loc6 = _loc2[3];
                    var _loc7 = Number(_loc2[4]);
                    _loc13 = new dofus.datacenter.Item(_loc8, _loc9, _loc5, -1, _loc6, _loc7);
                    _loc15.push(_loc13);
                } // end of for...in
                api.datacenter.Temporary.Shop.inventory = _loc15;
                break;
            } 
        } // End of switch
    } // End of the function
    function onSell(bSuccess)
    {
        if (bSuccess)
        {
            api.kernel.showMessage(undefined, api.lang.getText("SELL_DONE"), "INFO_CHAT");
        }
        else
        {
            api.kernel.showMessage(api.lang.getText("EXCHANGE"), api.lang.getText("CANT_SELL"), "ERROR_BOX", {name: "Sell"});
        } // end else if
    } // End of the function
    function onBuy(bSuccess)
    {
        if (bSuccess)
        {
            api.kernel.showMessage(undefined, api.lang.getText("BUY_DONE"), "INFO_CHAT");
        }
        else
        {
            api.kernel.showMessage(api.lang.getText("EXCHANGE"), api.lang.getText("CANT_BUY"), "ERROR_BOX", {name: "Buy"});
        } // end else if
    } // End of the function
    function onStorageKama(sExtraData)
    {
        var _loc2 = Number(sExtraData);
        api.datacenter.Temporary.Storage.Kama = _loc2;
    } // End of the function
    function cancel(oEvent)
    {
        this.leave();
    } // End of the function
    function yes(oEvent)
    {
        this.accept();
    } // End of the function
    function no(oEvent)
    {
        this.leave();
    } // End of the function
} // End of Class
#endinitclip
