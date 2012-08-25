// Action script...

// [Initial MovieClip Action of sprite 20876]
#initclip 141
if (!dofus.aks.Mount)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Mount = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.rename = function (sName)
    {
        this.aks.send("Rn" + sName, true);
    };
    _loc1.kill = function ()
    {
        this.aks.send("Rf");
    };
    _loc1.setXP = function (nValue)
    {
        this.aks.send("Rx" + nValue, true);
    };
    _loc1.ride = function ()
    {
        this.aks.send("Rr", false);
    };
    _loc1.data = function (nMountID, sTime)
    {
        this.aks.send("Rd" + nMountID + "|" + sTime, true);
    };
    _loc1.parkMountData = function (nSpriteID)
    {
        this.aks.send("Rp" + nSpriteID, true);
    };
    _loc1.removeObjectInPark = function (nCellNum)
    {
        this.aks.send("Ro" + nCellNum, true);
    };
    _loc1.mountParkSell = function (nPrice)
    {
        this.aks.send("Rs" + nPrice, true);
    };
    _loc1.mountParkBuy = function (nPrice)
    {
        this.aks.send("Rb" + nPrice, true);
    };
    _loc1.leave = function ()
    {
        this.aks.send("Rv");
    };
    _loc1.castrate = function ()
    {
        this.aks.send("Rc");
    };
    _loc1.onEquip = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0);
        switch (_loc3)
        {
            case "+":
            {
                this.api.datacenter.Player.mount = this.createMount(sExtraData.substr(1));
                break;
            } 
            case "-":
            {
                this.unequipMount();
                break;
            } 
            case "E":
            {
                this.equipError(sExtraData.charAt(1));
                break;
            } 
        } // End of switch
    };
    _loc1.onXP = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        if (!_global.isNaN(_loc3))
        {
            this.api.datacenter.Player.mountXPPercent = _loc3;
        } // end if
    };
    _loc1.onName = function (sExtraData)
    {
        this.api.datacenter.Player.mount.name = sExtraData;
    };
    _loc1.onData = function (sExtraData)
    {
        var _loc3 = this.createMount(sExtraData);
        this.api.ui.loadUIComponent("MountViewer", "MountViewer", {mount: _loc3});
    };
    _loc1.onMountPark = function (sExtraData)
    {
        var _loc3 = sExtraData.split(";");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        var _loc6 = Number(_loc3[2]);
        var _loc7 = Number(_loc3[3]);
        var _loc8 = _loc3[4];
        var _loc9 = _loc3[5];
        var _loc10 = this.api.kernel.CharactersManager.createGuildEmblem(_loc9);
        this.api.datacenter.Map.mountPark = new dofus.datacenter.MountPark(_loc4, _loc5, _loc6, _loc7, _loc8, _loc10);
    };
    _loc1.onRidingState = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0);
        switch (_loc3)
        {
            case "+":
            {
                this.api.datacenter.Player.isRiding = true;
                break;
            } 
            case "-":
            {
                this.api.datacenter.Player.isRiding = false;
                break;
            } 
        } // End of switch
    };
    _loc1.onMountParkBuy = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        this.api.ui.loadUIComponent("MountParkSale", "MountParkSale", {defaultPrice: Number(_loc3[1])});
    };
    _loc1.onLeave = function ()
    {
        this.api.ui.unloadUIComponent("MountParkSale");
    };
    _loc1.equipError = function (errorType)
    {
        switch (errorType)
        {
            case "-":
            {
                var _loc3 = this.api.lang.getText("MOUNT_ERROR_INVENTORY_NOT_EMPTY");
                break;
            } 
            case "+":
            {
                _loc3 = this.api.lang.getText("MOUNT_ERROR_ALREADY_HAVE_ONE");
                break;
            } 
            case "r":
            {
                _loc3 = this.api.lang.getText("MOUNT_ERROR_RIDE");
                break;
            } 
        } // End of switch
        this.api.kernel.showMessage(undefined, _loc3, "ERROR_CHAT");
    };
    _loc1.unequipMount = function ()
    {
        this.api.datacenter.Player.mount = undefined;
    };
    _loc1.createMount = function (sParams, newBorn)
    {
        var _loc4 = sParams.split(":");
        var _loc5 = Number(_loc4[1]);
        var _loc6 = new dofus.datacenter.Mount(_loc5, undefined, newBorn);
        _loc6.ID = _loc4[0];
        _loc6.ancestors = _loc4[2].split(",");
        var _loc7 = _loc4[3].split(",");
        _loc6.capacities = new ank.utils.ExtendedArray();
        var _loc8 = 0;
        
        while (++_loc8, _loc8 < _loc7.length)
        {
            var _loc9 = Number(_loc7[_loc8]);
            if (_loc9 != 0 && !_global.isNaN(_loc9))
            {
                _loc6.capacities.push({label: this.api.lang.getMountCapacity(_loc9).n, data: _loc9});
            } // end if
        } // end while
        _loc6.name = _loc4[4] == "" ? (this.api.lang.getText("NO_NAME")) : (_loc4[4]);
        _loc6.sex = Number(_loc4[5]);
        var _loc10 = _loc4[6].split(",");
        _loc6.xp = Number(_loc10[0]);
        _loc6.xpMin = Number(_loc10[1]);
        _loc6.xpMax = Number(_loc10[2]);
        _loc6.level = Number(_loc4[7]);
        _loc6.mountable = Number(_loc4[8]);
        _loc6.podsMax = Number(_loc4[9]);
        _loc6.wild = Number(_loc4[10]);
        var _loc11 = _loc4[11].split(",");
        _loc6.stamina = Number(_loc11[0]);
        _loc6.staminaMax = Number(_loc11[1]);
        var _loc12 = _loc4[12].split(",");
        _loc6.maturity = Number(_loc12[0]);
        _loc6.maturityMax = Number(_loc12[1]);
        var _loc13 = _loc4[13].split(",");
        _loc6.energy = Number(_loc13[0]);
        _loc6.energyMax = Number(_loc13[1]);
        var _loc14 = _loc4[14].split(",");
        _loc6.serenity = Number(_loc14[0]);
        _loc6.serenityMin = Number(_loc14[1]);
        _loc6.serenityMax = Number(_loc14[2]);
        var _loc15 = _loc4[15].split(",");
        _loc6.love = Number(_loc15[0]);
        _loc6.loveMax = Number(_loc15[1]);
        _loc6.fecondation = Number(_loc4[16]);
        _loc6.fecondable = Number(_loc4[17]);
        _loc6.setEffects(_loc4[18]);
        var _loc16 = _loc4[19].split(",");
        _loc6.tired = Number(_loc16[0]);
        _loc6.tiredMax = Number(_loc16[1]);
        var _loc17 = _loc4[20].split(",");
        _loc6.reprod = Number(_loc17[0]);
        _loc6.reprodMax = Number(_loc17[1]);
        return (_loc6);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
