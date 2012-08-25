// Action script...

// [Initial MovieClip Action of sprite 20566]
#initclip 87
if (!dofus.aks.Items)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Items = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.movement = function (nID, nPosition, nQuantity)
    {
        if (nPosition > 0)
        {
            this.api.kernel.GameManager.setAsModified(nPosition);
        } // end if
        this.aks.send("OM" + nID + "|" + nPosition + (_global.isNaN(nQuantity) ? ("") : ("|" + nQuantity)), true);
    };
    _loc1.drop = function (nID, nQuantity)
    {
        this.aks.send("OD" + nID + "|" + nQuantity, false);
    };
    _loc1.destroy = function (nID, nQuantity)
    {
        this.aks.send("Od" + nID + "|" + nQuantity, false);
    };
    _loc1.use = function (nID, sSpriteID, nCellNum, bConfirm)
    {
        this.aks.send("O" + (bConfirm ? ("u") : ("U")) + nID + (sSpriteID != undefined && !_global.isNaN(Number(sSpriteID)) ? ("|" + sSpriteID) : ("|")) + (nCellNum != undefined ? ("|" + nCellNum) : ("")), true);
    };
    _loc1.dissociate = function (nID, nPosition)
    {
        this.aks.send("Ox" + nID + "|" + nPosition, false);
    };
    _loc1.setSkin = function (nID, nPosition, nSkin)
    {
        this.aks.send("Os" + nID + "|" + nPosition + "|" + nSkin, false);
    };
    _loc1.feed = function (nID, nPosition, nFeededItemId)
    {
        this.aks.send("Of" + nID + "|" + nPosition + "|" + nFeededItemId, false);
    };
    _loc1.onAccessories = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0];
        var _loc5 = _loc3[1].split(",");
        var _loc6 = new Array();
        var _loc7 = 0;
        
        while (++_loc7, _loc7 < _loc5.length)
        {
            if (_loc5[_loc7].indexOf("~") != -1)
            {
                var _loc11 = _loc5[_loc7].split("~");
                var _loc8 = _global.parseInt(_loc11[0], 16);
                var _loc10 = _global.parseInt(_loc11[1]);
                var _loc9 = _global.parseInt(_loc11[2]) - 1;
            }
            else
            {
                _loc8 = _global.parseInt(_loc5[_loc7], 16);
                _loc10 = undefined;
                _loc9 = undefined;
            } // end else if
            if (!_global.isNaN(_loc8))
            {
                var _loc12 = new dofus.datacenter.Accessory(_loc8, _loc10, _loc9);
                _loc6[_loc7] = _loc12;
            } // end if
        } // end while
        var _loc13 = this.api.datacenter.Sprites.getItemAt(_loc4);
        _loc13.accessories = _loc6;
        this.api.gfx.setForcedSpriteAnim(_loc4, "static");
        if (_loc4 == this.api.datacenter.Player.ID)
        {
            this.api.datacenter.Player.updateCloseCombat();
        } // end if
    };
    _loc1.onDrop = function (bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            switch (sExtraData)
            {
                case "F":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("DROP_FULL"), "ERROR_BOX", {name: "DropFull"});
                    break;
                } 
                case "E":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_DROP_ITEM"), "ERROR_BOX");
                    break;
                } 
            } // End of switch
        } // end if
    };
    _loc1.onAdd = function (bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            switch (sExtraData)
            {
                case "F":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("INVENTORY_FULL"), "ERROR_BOX", {name: "Full"});
                    break;
                } 
                case "L":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("TOO_LOW_LEVEL_FOR_ITEM"), "ERROR_BOX", {name: "LowLevel"});
                    break;
                } 
                case "A":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("ALREADY_EQUIPED"), "ERROR_BOX", {name: "Already"});
                    break;
                } 
            } // End of switch
        }
        else
        {
            var _loc4 = sExtraData.split("*");
            var _loc5 = 0;
            
            while (++_loc5, _loc5 < _loc4.length)
            {
                var _loc6 = _loc4[_loc5];
                var _loc7 = _loc6.charAt(0);
                _loc6 = _loc6.substr(1);
                switch (_loc7)
                {
                    case "G":
                    {
                        break;
                    } 
                    case "O":
                    {
                        var _loc8 = _loc6.split(";");
                        var _loc9 = 0;
                        
                        while (++_loc9, _loc9 < _loc8.length)
                        {
                            var _loc10 = this.api.kernel.CharactersManager.getItemObjectFromData(_loc8[_loc9]);
                            if (_loc10 != undefined)
                            {
                                this.api.datacenter.Player.addItem(_loc10);
                            } // end if
                        } // end while
                        break;
                    } 
                    default:
                    {
                        ank.utils.Logger.err("Ajout d\'un type obj inconnu");
                        break;
                    } 
                } // End of switch
            } // end while
        } // end else if
    };
    _loc1.onChange = function (sExtraData)
    {
        var _loc3 = sExtraData.split("*");
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = _loc3[_loc4];
            var _loc6 = _loc5.split(";");
            var _loc7 = 0;
            
            while (++_loc7, _loc7 < _loc6.length)
            {
                var _loc8 = this.api.kernel.CharactersManager.getItemObjectFromData(_loc6[_loc7]);
                if (_loc8 != undefined)
                {
                    this.api.datacenter.Player.updateItem(_loc8);
                } // end if
            } // end while
        } // end while
    };
    _loc1.onRemove = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        this.api.datacenter.Player.dropItem(_loc3);
    };
    _loc1.onQuantity = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        this.api.datacenter.Player.updateItemQuantity(_loc4, _loc5);
    };
    _loc1.onMovement = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = _global.isNaN(Number(_loc3[1])) ? (-1) : (Number(_loc3[1]));
        this.api.datacenter.Player.updateItemPosition(_loc4, _loc5);
    };
    _loc1.onTool = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        if (_global.isNaN(_loc3))
        {
            this.api.datacenter.Player.currentJobID = undefined;
        }
        else
        {
            this.api.datacenter.Player.currentJobID = _loc3;
        } // end else if
    };
    _loc1.onWeight = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        this.api.datacenter.Player.maxWeight = _loc5;
        this.api.datacenter.Player.currentWeight = _loc4;
    };
    _loc1.onItemSet = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = sExtraData.substr(1).split("|");
        var _loc5 = Number(_loc4[0]);
        var _loc6 = String(_loc4[1]).split(";");
        var _loc7 = _loc4[2];
        if (_loc3)
        {
            var _loc8 = new dofus.datacenter.ItemSet(_loc5, _loc7, _loc6);
            this.api.datacenter.Player.ItemSets.addItemAt(_loc5, _loc8);
        }
        else
        {
            this.api.datacenter.Player.ItemSets.removeItemAt(_loc5);
        } // end else if
    };
    _loc1.onItemUseCondition = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0);
        switch (_loc3)
        {
            case "G":
            {
                var _loc4 = sExtraData.substr(1).split("|");
                var _loc5 = _global.isNaN(Number(_loc4[0])) ? (0) : (Number(_loc4[0]));
                var _loc6 = _global.isNaN(Number(_loc4[1])) ? (undefined) : (Number(_loc4[1]));
                var _loc7 = _global.isNaN(Number(_loc4[2])) ? (undefined) : (Number(_loc4[2]));
                var _loc8 = _global.isNaN(Number(_loc4[3])) ? (undefined) : (Number(_loc4[3]));
                var _loc9 = {name: "UseItemGold", listener: this, params: {objectID: _loc5, spriteID: _loc6, cellID: _loc7}};
                this.api.kernel.showMessage(undefined, this.api.lang.getText("ITEM_USE_CONDITION_GOLD", [_loc8]), "CAUTION_YESNO", _loc9);
                break;
            } 
            case "U":
            {
                var _loc10 = sExtraData.substr(1).split("|");
                var _loc11 = _global.isNaN(Number(_loc10[0])) ? (0) : (Number(_loc10[0]));
                var _loc12 = _global.isNaN(Number(_loc10[1])) ? (undefined) : (Number(_loc10[1]));
                var _loc13 = _global.isNaN(Number(_loc10[2])) ? (undefined) : (Number(_loc10[2]));
                var _loc14 = _global.isNaN(Number(_loc10[3])) ? (undefined) : (Number(_loc10[3]));
                var _loc15 = {name: "UseItem", listener: this, params: {objectID: _loc11, spriteID: _loc12, cellID: _loc13}};
                var _loc16 = new dofus.datacenter.Item(-1, _loc14, 1, 0, "", 0);
                this.api.kernel.showMessage(undefined, this.api.lang.getText("ITEM_USE_CONFIRMATION", [_loc16.name]), "CAUTION_YESNO", _loc15);
                break;
            } 
        } // End of switch
    };
    _loc1.onItemFound = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _global.isNaN(Number(_loc3[0])) ? (0) : (Number(_loc3[0]));
        var _loc5 = _global.isNaN(Number(_loc3[2])) ? (0) : (Number(_loc3[2]));
        var _loc6 = _loc3[1].split("~");
        var _loc7 = _global.isNaN(Number(_loc6[0])) ? (0) : (Number(_loc6[0]));
        var _loc8 = _global.isNaN(Number(_loc6[1])) ? (0) : (Number(_loc6[1]));
        if (_loc4 == 1)
        {
            if (_loc7 == 0)
            {
                var _loc9 = {iconFile: "KamaSymbol"};
            }
            else
            {
                _loc9 = new dofus.datacenter.Item(0, _loc7, _loc8);
            } // end else if
            this.api.gfx.addSpriteOverHeadItem(this.api.datacenter.Player.ID, "itemFound", dofus.graphics.battlefield.CraftResultOverHead, [true, _loc9], 2000);
        } // end if
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoUseItemGold":
            {
                this.use(oEvent.params.objectID, oEvent.params.spriteID, oEvent.params.cellID, true);
                break;
            } 
            case "AskYesNoUseItem":
            {
                this.use(oEvent.params.objectID, oEvent.params.spriteID, oEvent.params.cellID, true);
                break;
            } 
        } // End of switch
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
