// Action script...

// [Initial MovieClip Action of sprite 928]
#initclip 140
class dofus.aks.Friends extends dofus.aks.Handler
{
    var aks, api;
    function Friends(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function getFriendsList()
    {
        aks.send("FL", false);
    } // End of the function
    function addFriend(sName)
    {
        if (sName == undefined || sName.length == 0 || sName == "*")
        {
            return;
        } // end if
        aks.send("FA" + sName);
    } // End of the function
    function removeFriend(sName)
    {
        if (sName == undefined || sName.length == 0 || sName == "*")
        {
            return;
        } // end if
        aks.send("FD" + sName);
    } // End of the function
    function join(sType)
    {
        aks.send("FJ" + sType);
    } // End of the function
    function onAddFriend(bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc2 = this.getFriendObjectFromData(sExtraData);
            if (_loc2 != undefined)
            {
                api.datacenter.Player.Friends.push(_loc2);
            } // end if
            api.kernel.showMessage(undefined, api.lang.getText("ADD_TO_FRIEND_LIST", [_loc2.name]), "INFO_CHAT");
        }
        else
        {
            switch (sExtraData)
            {
                case "f":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CANT_ADD_FRIEND_NOT_FOUND"), "ERROR_CHAT");
                    break;
                } 
                case "y":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CANT_ADD_YOU"), "ERROR_CHAT");
                    break;
                } 
                case "a":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("ALREADY_YOUR_FRIEND"), "ERROR_CHAT");
                    break;
                } 
                case "m":
                {
                    api.kernel.showMessage(api.lang.getText("FRIENDS"), api.lang.getText("FRIENDS_LIST_FULL"), "ERROR_BOX", {name: "FriendsListFull"});
                    break;
                } 
            } // End of switch
        } // end else if
    } // End of the function
    function onRemoveFriend(bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            api.kernel.showMessage(undefined, api.lang.getText("REMOVE_FRIEND_OK"), "INFO_CHAT");
            this.getFriendsList();
        }
        else
        {
            switch (sExtraData)
            {
                case "f":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CANT_ADD_FRIEND_NOT_FOUND"), "ERROR_CHAT");
                    break;
                } 
            } // End of switch
        } // end else if
    } // End of the function
    function onFriendsList(sExtraData)
    {
        var _loc6 = sExtraData.split("|");
        api.datacenter.Player.Friends = new Array();
        for (var _loc2 = 0; _loc2 < _loc6.length; ++_loc2)
        {
            var _loc4 = this.getFriendObjectFromData(_loc6[_loc2]);
            if (_loc4 != undefined)
            {
                api.datacenter.Player.Friends.push(_loc4);
            } // end if
        } // end of for
        var _loc7 = api.ui.getUIComponent("Friends");
        var _loc3 = api.datacenter.Player.Friends;
        if (_loc7 != undefined)
        {
            _loc7.friendsList = _loc3;
        }
        else
        {
            var _loc5 = new String();
            if (_loc3.length != 0)
            {
                api.kernel.showMessage(undefined, "<b>" + api.lang.getText("YOUR_FRIEND_LIST") + " :</b>", "INFO_CHAT");
                for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
                {
                    _loc5 = " - " + _loc3[_loc2].account;
                    if (_loc3[_loc2].state != "DISCONNECT")
                    {
                        _loc5 = _loc5 + (" (" + _loc3[_loc2].name + ") " + api.lang.getText("LEVEL") + ":" + _loc3[_loc2].level + ", " + api.lang.getText(_loc3[_loc2].state));
                    } // end if
                    api.kernel.showMessage(undefined, _loc5, "INFO_CHAT");
                } // end of for
            }
            else
            {
                api.kernel.showMessage(undefined, api.lang.getText("EMPTY_FRIEND_LIST"), "INFO_CHAT");
            } // end else if
        } // end else if
    } // End of the function
    function onSpouse(sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc2 = new Object();
        _loc2.name = _loc3[0];
        _loc2.gfx = _loc3[1];
        _loc2.color1 = Number(_loc3[2]);
        _loc2.color2 = Number(_loc3[3]);
        _loc2.color3 = Number(_loc3[4]);
        _loc2.mapID = Number(_loc3[5]);
        _loc2.isConnected = !isNaN(_loc2.mapID);
        _loc2.level = Number(_loc3[6]);
        _loc2.isInFight = _loc3[7] == "1" ? (true) : (false);
        _loc2.sex = api.datacenter.Player.Sex == 0 ? ("f") : ("m");
        var _loc4 = api.ui.getUIComponent("Friends");
        _loc4.spouse = _loc2;
    } // End of the function
    function getFriendObjectFromData(sData)
    {
        var _loc2 = sData.split(";");
        var _loc1 = new Object();
        _loc1.account = String(_loc2[0]);
        if (_loc2[1] != undefined)
        {
            switch (_loc2[1])
            {
                case "1":
                {
                    _loc1.state = "IN_SOLO";
                    break;
                } 
                case "2":
                {
                    _loc1.state = "IN_MULTI";
                    break;
                } 
                case "?":
                {
                    _loc1.state = "IN_UNKNOW";
                    break;
                } 
            } // End of switch
            _loc1.name = _loc2[2];
            _loc1.level = _loc2[3];
            _loc1.guild = _loc2[4];
            _loc1.sex = _loc2[5];
            _loc1.gfxID = _loc2[6];
        }
        else
        {
            _loc1.name = _loc1.account;
            _loc1.state = "DISCONNECT";
        } // end else if
        return (_loc1.account.length != 0 ? (_loc1) : (undefined));
    } // End of the function
} // End of Class
#endinitclip
