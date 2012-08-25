// Action script...

// [Initial MovieClip Action of sprite 20496]
#initclip 17
if (!dofus.aks.Enemies)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Enemies = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.getEnemiesList = function ()
    {
        this.aks.send("iL", true);
    };
    _loc1.addEnemy = function (sName)
    {
        if (sName == undefined || (sName.length == 0 || sName == "*"))
        {
            return;
        } // end if
        this.aks.send("iA" + sName);
    };
    _loc1.removeEnemy = function (sName)
    {
        if (sName == undefined || (sName.length == 0 || sName == "*"))
        {
            return;
        } // end if
        this.aks.send("iD" + sName);
    };
    _loc1.onAddEnemy = function (bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc4 = this.getEnemyObjectFromData(sExtraData);
            if (_loc4 != undefined)
            {
                this.api.datacenter.Player.Enemies.push(_loc4);
            } // end if
            this.api.kernel.showMessage(undefined, this.api.lang.getText("ADD_TO_ENEMY_LIST", [_loc4.name]), "INFO_CHAT");
        }
        else
        {
            switch (sExtraData)
            {
                case "f":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_ADD_FRIEND_NOT_FOUND"), "ERROR_CHAT");
                    break;
                } 
                case "y":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_ADD_YOU_AS_ENEMY"), "ERROR_CHAT");
                    break;
                } 
                case "a":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("ALREADY_YOUR_ENEMY"), "ERROR_CHAT");
                    break;
                } 
                case "m":
                {
                    this.api.kernel.showMessage(this.api.lang.getText("ENEMIES"), this.api.lang.getText("ENEMIES_LIST_FULL"), "ERROR_BOX", {name: "EnemiesListFull"});
                    break;
                } 
            } // End of switch
        } // end else if
    };
    _loc1.onRemoveEnemy = function (bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("REMOVE_ENEMY_OK"), "INFO_CHAT");
            this.getEnemiesList();
        }
        else
        {
            switch (sExtraData)
            {
                case "f":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_ADD_FRIEND_NOT_FOUND"), "ERROR_CHAT");
                    break;
                } 
            } // End of switch
        } // end else if
    };
    _loc1.onEnemiesList = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        this.api.datacenter.Player.Enemies = new Array();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = this.getEnemyObjectFromData(_loc3[_loc4]);
            if (_loc5 != undefined)
            {
                this.api.datacenter.Player.Enemies.push(_loc5);
            } // end if
        } // end while
        var _loc6 = this.api.ui.getUIComponent("Friends");
        var _loc7 = this.api.datacenter.Player.Enemies;
        if (_loc6 != undefined)
        {
            _loc6.enemiesList = _loc7;
        }
        else
        {
            var _loc8 = new String();
            if (_loc7.length != 0)
            {
                this.api.kernel.showMessage(undefined, "<b>" + this.api.lang.getText("YOUR_ENEMY_LIST") + " :</b>", "INFO_CHAT");
                var _loc9 = 0;
                
                while (++_loc9, _loc9 < _loc7.length)
                {
                    _loc8 = " - " + _loc7[_loc9].account;
                    if (_loc7[_loc9].state != "DISCONNECT")
                    {
                        _loc8 = _loc8 + (" (" + _loc7[_loc9].name + ") " + this.api.lang.getText("LEVEL") + ":" + _loc7[_loc9].level + ", " + this.api.lang.getText(_loc7[_loc9].state));
                    } // end if
                    this.api.kernel.showMessage(undefined, _loc8, "INFO_CHAT");
                } // end while
            }
            else
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("EMPTY_ENEMY_LIST"), "INFO_CHAT");
            } // end else if
        } // end else if
    };
    _loc1.getEnemyObjectFromData = function (sData)
    {
        var _loc3 = sData.split(";");
        var _loc4 = new Object();
        _loc4.account = String(_loc3[0]);
        if (_loc3[1] != undefined)
        {
            switch (_loc3[1])
            {
                case "1":
                {
                    _loc4.state = "IN_SOLO";
                    break;
                } 
                case "2":
                {
                    _loc4.state = "IN_MULTI";
                    break;
                } 
                case "?":
                {
                    _loc4.state = "IN_UNKNOW";
                    break;
                } 
            } // End of switch
            _loc4.name = _loc3[2];
            _loc4.level = _loc3[3];
            _loc4.sortLevel = _loc4.level == "?" ? (-1) : (Number(_loc4.level));
            _loc4.alignement = Number(_loc3[4]);
            _loc4.guild = _loc3[5];
            _loc4.sex = _loc3[6];
            _loc4.gfxID = _loc3[7];
        }
        else
        {
            _loc4.name = _loc4.account;
            _loc4.state = "DISCONNECT";
        } // end else if
        return (_loc4.account.length != 0 ? (_loc4) : (undefined));
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
