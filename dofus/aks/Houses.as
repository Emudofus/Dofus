// Action script...

// [Initial MovieClip Action of sprite 20903]
#initclip 168
if (!dofus.aks.Houses)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Houses = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.kick = function (nID)
    {
        this.aks.send("hQ" + nID);
    };
    _loc1.leave = function ()
    {
        this.aks.send("hV");
    };
    _loc1.sell = function (nPrice)
    {
        this.aks.send("hS" + nPrice, true);
    };
    _loc1.buy = function (nPrice)
    {
        this.aks.send("hB" + nPrice, true);
    };
    _loc1.state = function ()
    {
        this.aks.send("hG", true);
    };
    _loc1.share = function ()
    {
        this.aks.send("hG+", true);
    };
    _loc1.unshare = function ()
    {
        this.aks.send("hG-", true);
    };
    _loc1.rights = function (nRights)
    {
        this.aks.send("hG" + nRights, true);
    };
    _loc1.onList = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = sExtraData.substr(1).split("|");
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc4.length)
        {
            var _loc6 = _loc4[_loc5].split(";");
            var _loc7 = _loc6[0];
            var _loc8 = _loc6[1] == "1";
            var _loc9 = _loc6[2] == "1";
            var _loc10 = _loc4[3] == "1";
            var _loc11 = this.api.datacenter.Houses;
            if (_loc3)
            {
                var _loc12 = _loc11.getItemAt(_loc7);
                if (_loc12 == undefined)
                {
                    _loc12 = new dofus.datacenter.House(_loc7);
                } // end if
                _loc12.localOwner = _loc3;
                _loc12.isLocked = _loc8;
                _loc12.isForSale = _loc9;
                _loc12.isShared = _loc10;
                _loc11.addItemAt(_loc7, _loc12);
                continue;
            } // end if
            var _loc13 = _loc11.getItemAt(_loc7);
            _loc13.localOwner = false;
            var _loc14 = this.api.lang.getHousesMapText(this.api.datacenter.Map.id);
            if (_loc14 == _loc7)
            {
                this.api.ui.unloadUIComponent("HouseIndoor");
            } // end if
        } // end while
    };
    _loc1.onProperties = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = _loc3[1].split(";");
        var _loc6 = _loc5[0];
        var _loc7 = _loc5[1] == "1";
        var _loc8 = _loc5[2];
        var _loc9 = this.api.kernel.CharactersManager.createGuildEmblem(_loc5[3]);
        var _loc10 = (dofus.datacenter.House)(this.api.datacenter.Houses.getItemAt(_loc4));
        if (_loc10 == undefined)
        {
            _loc10 = new dofus.datacenter.House(_loc4);
            this.api.datacenter.Houses.addItemAt(_loc4, _loc10);
        } // end if
        _loc10.ownerName = _loc6;
        _loc10.isForSale = _loc7;
        _loc10.guildName = _loc8;
        _loc10.guildEmblem = _loc9;
    };
    _loc1.onLockedProperty = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = _loc3[1] == "1";
        var _loc6 = (dofus.datacenter.House)(this.api.datacenter.Houses.getItemAt(_loc4));
        if (_loc6 == undefined)
        {
            _loc6 = new dofus.datacenter.House(_loc4);
            this.api.datacenter.Houses.addItemAt(_loc4, _loc6);
        } // end if
        _loc6.isLocked = _loc5;
    };
    _loc1.onCreate = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        var _loc6 = (dofus.datacenter.House)(this.api.datacenter.Houses.getItemAt(_loc4));
        if (_loc6 == undefined)
        {
            _loc6 = new dofus.datacenter.House(_loc4);
        } // end if
        _loc6.price = _loc5;
        this.api.ui.loadUIComponent("HouseSale", "HouseSale", {house: _loc6});
    };
    _loc1.onSell = function (bSuccess, sExtraData)
    {
        var _loc4 = sExtraData.split("|");
        var _loc5 = Number(_loc4[0]);
        var _loc6 = Number(_loc4[1]);
        var _loc7 = (dofus.datacenter.House)(this.api.datacenter.Houses.getItemAt(_loc5));
        if (_loc7 == undefined)
        {
            _loc7 = new dofus.datacenter.House(_loc5);
        } // end if
        _loc7.isForSale = _loc6 > 0;
        _loc7.price = _loc6;
        if (_loc6 > 0)
        {
            if (bSuccess)
            {
                this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"), this.api.lang.getText("HOUSE_SELL", [_loc7.name, _loc7.price]), "ERROR_BOX", {name: "SellHouse"});
            }
            else
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_SELL_HOUSE"), "ERROR_BOX", {name: "SellHouse"});
            } // end else if
        }
        else
        {
            this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"), this.api.lang.getText("HOUSE_NOSELL", [_loc7.name]), "ERROR_BOX", {name: "NoSellHouse"});
        } // end else if
    };
    _loc1.onBuy = function (bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc4 = sExtraData.split("|");
            var _loc5 = Number(_loc4[0]);
            var _loc6 = Number(_loc4[1]);
            var _loc7 = (dofus.datacenter.House)(this.api.datacenter.Houses.getItemAt(_loc5));
            if (_loc7 == undefined)
            {
                _loc7 = new dofus.datacenter.House(_loc5);
            } // end if
            _loc7.price = _loc6;
            this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"), this.api.lang.getText("HOUSE_BUY", [_loc7.name, _loc7.price]), "ERROR_BOX", {name: "BuyHouse"});
            _loc7.isForSale = false;
            _loc7.price = 0;
        }
        else
        {
            switch (sExtraData.charAt(0))
            {
                case "C":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_BUY_HOUSE", [sExtraData.substr(1)]), "ERROR_BOX", {name: "BuyHouse"});
                    break;
                } 
            } // End of switch
        } // end else if
    };
    _loc1.onLeave = function ()
    {
        this.api.ui.unloadUIComponent("HouseSale");
    };
    _loc1.onGuildInfos = function (sExtraData)
    {
        var _loc3 = sExtraData.split(";");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = true;
        var _loc6 = new String();
        var _loc7 = new Object();
        var _loc8 = 0;
        if (_loc3.length < 4)
        {
            _loc5 = false;
        }
        else
        {
            _loc5 = true;
            _loc6 = _loc3[1];
            _loc7 = this.api.kernel.CharactersManager.createGuildEmblem(_loc3[2]);
            _loc8 = Number(_loc3[3]);
        } // end else if
        var _loc9 = (dofus.datacenter.House)(this.api.datacenter.Houses.getItemAt(_loc4));
        if (_loc9 == undefined)
        {
            _loc9 = new dofus.datacenter.House(_loc4);
            this.api.datacenter.Houses.addItemAt(_loc4, _loc9);
        } // end if
        _loc9.isShared = _loc5;
        _loc9.guildName = _loc6;
        _loc9.guildEmblem = _loc7;
        _loc9.guildRights = _loc8;
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
