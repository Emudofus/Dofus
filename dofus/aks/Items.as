// Action script...

// [Initial MovieClip Action of sprite 947]
#initclip 159
class dofus.aks.Items extends dofus.aks.Handler
{
    var aks, api;
    function Items(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function movement(nID, nPosition, nQuantity)
    {
        aks.send("OM" + nID + "|" + nPosition + (isNaN(nQuantity) ? ("") : ("|" + nQuantity)), false);
    } // End of the function
    function drop(nID, nQuantity)
    {
        aks.send("OD" + nID + "|" + nQuantity, false);
    } // End of the function
    function destroy(nID, nQuantity)
    {
        aks.send("Od" + nID + "|" + nQuantity, false);
    } // End of the function
    function use(nID, sSpriteID, nCellNum)
    {
        aks.send("OU" + nID + (sSpriteID != undefined ? ("|" + sSpriteID) : ("|")) + (nCellNum != undefined ? ("|" + nCellNum) : ("")), false);
    } // End of the function
    function onAccessories(sExtraData)
    {
        var _loc8 = sExtraData.split("|");
        var _loc7 = _loc8[0];
        var _loc5 = _loc8[1].split(",");
        var _loc6 = new Array();
        for (var _loc2 = 0; _loc2 < _loc5.length; ++_loc2)
        {
            var _loc3 = parseInt(_loc5[_loc2], 16);
            if (!isNaN(_loc3))
            {
                var _loc4 = new dofus.datacenter.Accessory(_loc3);
                _loc6[_loc2] = _loc4;
            } // end if
        } // end of for
        var _loc9 = api.datacenter.Sprites.getItemAt(_loc7);
        _loc9.accessories = _loc6;
        api.gfx.setForcedSpriteAnim(_loc7, "static");
        if (_loc7 == api.datacenter.Player.ID)
        {
            api.datacenter.Player.updateCloseCombat();
        } // end if
    } // End of the function
    function onDrop(bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            switch (sExtraData)
            {
                case "F":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("DROP_FULL"), "ERROR_BOX", {name: "DropFull"});
                    break;
                } 
            } // End of switch
        } // end if
    } // End of the function
    function onAdd(bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            switch (sExtraData)
            {
                case "F":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("INVENTORY_FULL"), "ERROR_BOX", {name: "Full"});
                    break;
                } 
                case "L":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("TOO_LOW_LEVEL_FOR_ITEM"), "ERROR_BOX", {name: "LowLevel"});
                    break;
                } 
                case "A":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("ALREADY_EQUIPED"), "ERROR_BOX", {name: "Already"});
                    break;
                } 
            } // End of switch
        }
        else
        {
            var _loc8 = sExtraData.split("*");
            for (var _loc6 = 0; _loc6 < _loc8.length; ++_loc6)
            {
                var _loc4 = _loc8[_loc6];
                var _loc7 = _loc4.charAt(0);
                _loc4 = _loc4.substr(1);
                switch (_loc7)
                {
                    case "G":
                    {
                        break;
                    } 
                    case "O":
                    {
                        var _loc5 = _loc4.split(";");
                        for (var _loc2 = 0; _loc2 < _loc5.length; ++_loc2)
                        {
                            var _loc3 = api.kernel.CharactersManager.getItemObjectFromData(_loc5[_loc2]);
                            if (_loc3 != undefined)
                            {
                                api.datacenter.Player.addItem(_loc3);
                            } // end if
                        } // end of for
                        break;
                    } 
                    default:
                    {
                        ank.utils.Logger.err("Ajout d\'un type obj inconnu");
                        break;
                    } 
                } // End of switch
            } // end of for
        } // end else if
    } // End of the function
    function onChange(sExtraData)
    {
        var _loc7 = sExtraData.split("*");
        for (var _loc5 = 0; _loc5 < _loc7.length; ++_loc5)
        {
            var _loc6 = _loc7[_loc5];
            var _loc4 = _loc6.split(";");
            for (var _loc2 = 0; _loc2 < _loc4.length; ++_loc2)
            {
                var _loc3 = api.kernel.CharactersManager.getItemObjectFromData(_loc4[_loc2]);
                if (_loc3 != undefined)
                {
                    api.datacenter.Player.updateItem(_loc3);
                } // end if
            } // end of for
        } // end of for
    } // End of the function
    function onRemove(sExtraData)
    {
        var _loc2 = Number(sExtraData);
        api.datacenter.Player.dropItem(_loc2);
    } // End of the function
    function onQuantity(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc4 = Number(_loc2[0]);
        var _loc3 = Number(_loc2[1]);
        api.datacenter.Player.updateItemQuantity(_loc4, _loc3);
    } // End of the function
    function onMovement(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc4 = Number(_loc2[0]);
        var _loc3 = isNaN(Number(_loc2[1])) ? (-1) : (Number(_loc2[1]));
        api.datacenter.Player.updateItemPosition(_loc4, _loc3);
    } // End of the function
    function onTool(sExtraData)
    {
        var _loc2 = Number(sExtraData);
        if (isNaN(_loc2))
        {
            api.datacenter.Player.currentJobID = undefined;
        }
        else
        {
            api.datacenter.Player.currentJobID = _loc2;
        } // end else if
    } // End of the function
    function onWeight(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc4 = Number(_loc2[0]);
        var _loc3 = Number(_loc2[1]);
        api.datacenter.Player.maxWeight = _loc3;
        api.datacenter.Player.currentWeight = _loc4;
    } // End of the function
    function onItemSet(sExtraData)
    {
        var _loc6 = sExtraData.charAt(0) == "+";
        var _loc3 = sExtraData.substr(1).split("|");
        var _loc2 = Number(_loc3[0]);
        var _loc4 = String(_loc3[1]).split(";");
        var _loc5 = _loc3[2];
        if (_loc6)
        {
            var _loc7 = new dofus.datacenter.ItemSet(_loc2, _loc5, _loc4);
            api.datacenter.Player.ItemSets.addItemAt(_loc2, _loc7);
        }
        else
        {
            api.datacenter.Player.ItemSets.removeItemAt(_loc2);
        } // end else if
    } // End of the function
} // End of Class
#endinitclip
