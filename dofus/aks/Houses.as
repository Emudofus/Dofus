// Action script...

// [Initial MovieClip Action of sprite 943]
#initclip 155
class dofus.aks.Houses extends dofus.aks.Handler
{
    var aks, api;
    function Houses(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function kick(nID)
    {
        aks.send("hQ" + nID);
    } // End of the function
    function leave()
    {
        aks.send("hV");
    } // End of the function
    function sell(nPrice)
    {
        aks.send("hS" + nPrice);
    } // End of the function
    function buy(nPrice)
    {
        aks.send("hB" + nPrice);
    } // End of the function
    function onList(sExtraData)
    {
        var _loc11 = sExtraData.charAt(0) == "+";
        var _loc10 = sExtraData.substr(1).split("|");
        for (var _loc4 = 0; _loc4 < _loc10.length; ++_loc4)
        {
            var _loc3 = _loc10[_loc4].split(";");
            var _loc2 = _loc3[0];
            var _loc7 = _loc3[1] == "1";
            var _loc8 = _loc3[2] == "1";
            var _loc5 = api.datacenter.Houses;
            if (_loc11)
            {
                var _loc9 = _loc5.getItemAt(_loc2);
                if (_loc9 == undefined)
                {
                    _loc9 = new dofus.datacenter.House(_loc2);
                } // end if
                _loc9.localOwner = _loc11;
                _loc9.isLocked = _loc7;
                _loc9.isForSale = _loc8;
                _loc5.addItemAt(_loc2, _loc9);
                continue;
            } // end if
            _loc9 = _loc5.getItemAt(_loc2);
            _loc9.localOwner = false;
            var _loc6 = api.lang.getHousesMapText(api.datacenter.Map.id);
            if (_loc6 == _loc2)
            {
                api.ui.unloadUIComponent("HouseIndoor");
            } // end if
        } // end of for
    } // End of the function
    function onProperties(sExtraData)
    {
        var _loc4 = sExtraData.split("|");
        var _loc3 = Number(_loc4[0]);
        var _loc5 = _loc4[1].split(";");
        var _loc6 = _loc5[0];
        var _loc7 = _loc5[1] == "1";
        var _loc2 = api.datacenter.Houses.getItemAt(_loc3);
        if (_loc2 == undefined)
        {
            _loc2 = new dofus.datacenter.House(_loc3);
            api.datacenter.Houses.addItemAt(_loc3, _loc2);
        } // end if
        _loc2.ownerName = _loc6;
        _loc2.isForSale = _loc7;
    } // End of the function
    function onLockedProperty(sExtraData)
    {
        var _loc4 = sExtraData.split("|");
        var _loc3 = Number(_loc4[0]);
        var _loc5 = _loc4[1] == "1";
        var _loc2 = api.datacenter.Houses.getItemAt(_loc3);
        if (_loc2 == undefined)
        {
            _loc2 = new dofus.datacenter.House(_loc3);
            api.datacenter.Houses.addItemAt(_loc3, _loc2);
        } // end if
        _loc2.isLocked = _loc5;
    } // End of the function
    function onCreate(sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        var _loc2 = api.datacenter.Houses.getItemAt(_loc4);
        if (_loc2 == undefined)
        {
            _loc2 = new dofus.datacenter.House(_loc4);
        } // end if
        _loc2.price = _loc5;
        api.ui.loadUIComponent("HouseSale", "HouseSale", {house: _loc2});
    } // End of the function
    function onSell(bSuccess, sExtraData)
    {
        var _loc4 = sExtraData.split("|");
        var _loc5 = Number(_loc4[0]);
        var _loc3 = Number(_loc4[1]);
        var _loc2 = api.datacenter.Houses.getItemAt(_loc5);
        if (_loc2 == undefined)
        {
            _loc2 = new dofus.datacenter.House(_loc5);
        } // end if
        _loc2.isForSale = _loc3 > 0;
        _loc2.price = _loc3;
        if (_loc3 > 0)
        {
            if (bSuccess)
            {
                api.kernel.showMessage(api.lang.getText("INFORMATIONS"), api.lang.getText("HOUSE_SELL", [_loc2.name, _loc2.price]), "ERROR_BOX", {name: "SellHouse"});
            }
            else
            {
                api.kernel.showMessage(undefined, api.lang.getText("CANT_SELL_HOUSE"), "ERROR_BOX", {name: "SellHouse"});
            } // end else if
        }
        else
        {
            api.kernel.showMessage(api.lang.getText("INFORMATIONS"), api.lang.getText("HOUSE_NOSELL", [_loc2.name]), "ERROR_BOX", {name: "NoSellHouse"});
        } // end else if
    } // End of the function
    function onBuy(bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc3 = sExtraData.split("|");
            var _loc4 = Number(_loc3[0]);
            var _loc5 = Number(_loc3[1]);
            var _loc2 = api.datacenter.Houses.getItemAt(_loc4);
            if (_loc2 == undefined)
            {
                _loc2 = new dofus.datacenter.House(_loc4);
            } // end if
            _loc2.price = _loc5;
            api.kernel.showMessage(api.lang.getText("INFORMATIONS"), api.lang.getText("HOUSE_BUY", [_loc2.name, _loc2.price]), "ERROR_BOX", {name: "BuyHouse"});
            _loc2.isForSale = false;
            _loc2.price = 0;
        }
        else
        {
            switch (sExtraData.charAt(0))
            {
                case "C":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CANT_BUY_HOUSE", [sExtraData.substr(1)]), "ERROR_BOX", {name: "BuyHouse"});
                    break;
                } 
            } // End of switch
        } // end else if
    } // End of the function
    function onLeave()
    {
        api.ui.unloadUIComponent("HouseSale");
    } // End of the function
} // End of Class
#endinitclip
