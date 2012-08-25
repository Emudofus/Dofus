// Action script...

// [Initial MovieClip Action of sprite 20909]
#initclip 174
if (!dofus.aks.Conquest)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Conquest = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.getAlignedBonus = function ()
    {
        this.aks.send("CB", true);
    };
    _loc1.prismInfosJoin = function ()
    {
        this.api.datacenter.Conquest.clear();
        this.aks.send("CIJ", true);
    };
    _loc1.prismInfosLeave = function ()
    {
        this.aks.send("CIV", false);
    };
    _loc1.prismFightJoin = function ()
    {
        this.aks.send("CFJ", true);
    };
    _loc1.prismFightLeave = function ()
    {
        this.aks.send("CFV", false);
    };
    _loc1.worldInfosJoin = function ()
    {
        this.aks.send("CWJ", false);
    };
    _loc1.worldInfosLeave = function ()
    {
        this.aks.send("CWV", false);
    };
    _loc1.switchPlaces = function (id)
    {
        this.aks.send("CFS" + id, true);
    };
    _loc1.requestBalance = function ()
    {
        this.aks.send("Cb", true);
    };
    _loc1.onAreaAlignmentChanged = function (sExtraData)
    {
        var _loc3 = String(sExtraData).split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        var _loc6 = this.api.lang.getMapAreaText(_loc4).n;
        var _loc7 = this.api.lang.getAlignment(_loc5).n;
        if (_loc5 == -1)
        {
            this.api.kernel.showMessage(undefined, "<b>" + this.api.lang.getText("AREA_ALIGNMENT_PRISM_REMOVED", [_loc6]) + "</b>", "PVP_CHAT");
        }
        else
        {
            this.api.kernel.showMessage(undefined, "<b>" + this.api.lang.getText("AREA_ALIGNMENT_IS", [_loc6, _loc7]) + "</b>", "PVP_CHAT");
        } // end else if
    };
    _loc1.onConquestBonus = function (sExtraData)
    {
        var _loc3 = sExtraData.split(";");
        var _loc4 = String(_loc3[0]).split(",");
        var _loc5 = new dofus.datacenter.ConquestBonusData();
        _loc5.xp = Number(_loc4[0]);
        _loc5.drop = Number(_loc4[1]);
        _loc5.recolte = Number(_loc4[2]);
        _loc4 = String(_loc3[1]).split(",");
        var _loc6 = new dofus.datacenter.ConquestBonusData();
        _loc6.xp = Number(_loc4[0]);
        _loc6.drop = Number(_loc4[1]);
        _loc6.recolte = Number(_loc4[2]);
        _loc4 = String(_loc3[2]).split(",");
        var _loc7 = new dofus.datacenter.ConquestBonusData();
        _loc7.xp = Number(_loc4[0]);
        _loc7.drop = Number(_loc4[1]);
        _loc7.recolte = Number(_loc4[2]);
        this.api.datacenter.Conquest.alignBonus = _loc5;
        this.api.datacenter.Conquest.rankMultiplicator = _loc6;
        this.api.datacenter.Conquest.alignMalus = _loc7;
    };
    _loc1.onConquestBalance = function (sExtraData)
    {
        var _loc3 = (dofus.graphics.gapi.ui.Conquest)(this.api.ui.getUIComponent("Conquest"));
        var _loc4 = sExtraData.split(";");
        _loc3.setBalance(Number(_loc4[0]), Number(_loc4[1]));
    };
    _loc1.onWorldData = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = new dofus.datacenter.ConquestWorldData();
        _loc4.ownedAreas = Number(_loc3[0]);
        _loc4.totalAreas = Number(_loc3[1]);
        _loc4.possibleAreas = Number(_loc3[2]);
        var _loc5 = _loc3[3];
        var _loc6 = _loc5.split(";");
        _loc4.areas = new ank.utils.ExtendedArray();
        for (var i in _loc6)
        {
            var _loc7 = String(_loc6[i]).split(",");
            if (_loc7.length < 5)
            {
                continue;
            } // end if
            var _loc8 = new dofus.datacenter.ConquestZoneData(Number(_loc7[0]), Number(_loc7[1]), Number(_loc7[2]) == 1, Number(_loc7[3]), Number(_loc7[4]) == 1);
            _loc4.areas.push(_loc8);
        } // end of for...in
        _loc4.areas.sortOn("areaName");
        _loc4.ownedVillages = Number(_loc3[4]);
        _loc4.totalVillages = Number(_loc3[5]);
        var _loc9 = _loc3[6];
        var _loc10 = _loc9.split(";");
        _loc4.villages = new ank.utils.ExtendedArray();
        for (var i in _loc10)
        {
            var _loc11 = String(_loc10[i]).split(",");
            if (_loc11.length != 4)
            {
                continue;
            } // end if
            var _loc12 = new dofus.datacenter.ConquestVillageData(Number(_loc11[0]), Number(_loc11[1]), Number(_loc11[2]) == 1, Number(_loc11[3]) == 1);
            _loc4.villages.push(_loc12);
        } // end of for...in
        _loc4.villages.sortOn("areaName");
        this.api.datacenter.Conquest.worldDatas = _loc4;
    };
    _loc1.onPrismInfosJoined = function (sExtraData)
    {
        var _loc3 = sExtraData.split(";");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = (dofus.graphics.gapi.ui.Conquest)(this.api.ui.getUIComponent("Conquest"));
        if (_loc4 == 0)
        {
            var _loc6 = Number(_loc3[1]);
            var _loc7 = Number(_loc3[2]);
            var _loc8 = Number(_loc3[3]);
            var _loc9 = new Object();
            _loc9.error = 0;
            _loc9.timer = _loc6;
            _loc9.maxTimer = _loc7;
            _loc9.timerReference = getTimer();
            _loc9.maxTeamPositions = _loc8;
            _loc5.sharePropertiesWithTab(_loc9);
        }
        else
        {
            var _loc10 = new Object();
            switch (_loc4)
            {
                case -1:
                case -2:
                case -3:
                {
                    _loc10.error = _loc4;
                    break;
                } 
            } // End of switch
            _loc5.sharePropertiesWithTab(_loc10);
        } // end else if
    };
    _loc1.onPrismInfosClosing = function (sExtraData)
    {
        var _loc3 = (dofus.graphics.gapi.ui.Conquest)(this.api.ui.getUIComponent("Conquest"));
        _loc3.sharePropertiesWithTab({noUnsubscribe: true});
        this.api.ui.unloadUIComponent("Conquest");
    };
    _loc1.onPrismAttacked = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = _loc3[1];
        var _loc6 = _loc3[2];
        var _loc7 = "[" + _loc5 + ", " + _loc6 + "]";
        var _loc8 = Number(this.api.lang.getMapText(_loc4).sa);
        var _loc9 = String(this.api.lang.getMapSubAreaText(_loc8).n).substr(0, 2) == "//" ? (String(this.api.lang.getMapSubAreaText(_loc8).n).substr(2)) : (this.api.lang.getMapSubAreaText(_loc8).n);
        if (_loc8 == this.api.datacenter.Basics.gfx_lastSubarea)
        {
            this.api.kernel.showMessage(undefined, "<img src=\"CautionIcon\" hspace=\'0\' vspace=\'0\' width=\'13\' height=\'13\' />" + this.api.lang.getText("PRISM_ATTACKED", [_loc9, _loc7]), "PVP_CHAT");
            this.api.sounds.events.onTaxcollectorAttack();
        }
        else
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("PRISM_ATTACKED", [_loc9, _loc7]), "PVP_CHAT");
        } // end else if
    };
    _loc1.onPrismSurvived = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = _loc3[1];
        var _loc6 = _loc3[2];
        var _loc7 = "[" + _loc5 + ", " + _loc6 + "]";
        var _loc8 = Number(this.api.lang.getMapText(_loc4).sa);
        var _loc9 = String(this.api.lang.getMapSubAreaText(_loc8).n).substr(0, 2) == "//" ? (String(this.api.lang.getMapSubAreaText(_loc8).n).substr(2)) : (this.api.lang.getMapSubAreaText(_loc8).n);
        this.api.kernel.showMessage(undefined, this.api.lang.getText("PRISM_ATTACKED_SUVIVED", [_loc9, _loc7]), "PVP_CHAT");
    };
    _loc1.onPrismDead = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = _loc3[1];
        var _loc6 = _loc3[2];
        var _loc7 = "[" + _loc5 + ", " + _loc6 + "]";
        var _loc8 = Number(this.api.lang.getMapText(_loc4).sa);
        var _loc9 = String(this.api.lang.getMapSubAreaText(_loc8).n).substr(0, 2) == "//" ? (String(this.api.lang.getMapSubAreaText(_loc8).n).substr(2)) : (this.api.lang.getMapSubAreaText(_loc8).n);
        this.api.kernel.showMessage(undefined, this.api.lang.getText("PRISM_ATTACKED_DIED", [_loc9, _loc7]), "PVP_CHAT");
    };
    _loc1.onPrismFightAddPlayer = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = sExtraData.substr(1).split("|");
        var _loc5 = _global.parseInt(_loc4[0], 36);
        var _loc6 = 1;
        
        while (++_loc6, _loc6 < _loc4.length)
        {
            var _loc7 = _loc4[_loc6].split(";");
            if (_loc3)
            {
                var _loc8 = new Object();
                _loc8.id = _global.parseInt(_loc7[0], 36);
                _loc8.name = _loc7[1];
                _loc8.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + _loc7[2] + ".swf";
                _loc8.level = Number(_loc7[3]);
                _loc8.color1 = _global.parseInt(_loc7[4], 36);
                _loc8.color2 = _global.parseInt(_loc7[5], 36);
                _loc8.color3 = _global.parseInt(_loc7[6], 36);
                _loc8.reservist = _loc7[7] == "1";
                var _loc9 = this.api.datacenter.Conquest.players.findFirstItem("id", _loc8.id);
                if (_loc9.index != -1)
                {
                    this.api.datacenter.Conquest.players.updateItem(_loc9.index, _loc8);
                }
                else
                {
                    this.api.datacenter.Conquest.players.push(_loc8);
                } // end else if
                continue;
            } // end if
            var _loc10 = _global.parseInt(_loc7[0], 36);
            var _loc11 = this.api.datacenter.Conquest.players.findFirstItem("id", _loc10);
            if (_loc11.index != -1)
            {
                this.api.datacenter.Conquest.players.removeItems(_loc11.index, 1);
            } // end if
        } // end while
    };
    _loc1.onPrismFightAddEnemy = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = sExtraData.substr(1).split("|");
        var _loc5 = _global.parseInt(_loc4[0], 36);
        var _loc6 = this.api.datacenter.Conquest.attackers;
        var _loc7 = 1;
        
        while (++_loc7, _loc7 < _loc4.length)
        {
            var _loc8 = _loc4[_loc7].split(";");
            if (_loc3)
            {
                var _loc9 = new Object();
                _loc9.id = _global.parseInt(_loc8[0], 36);
                _loc9.name = _loc8[1];
                _loc9.level = Number(_loc8[2]);
                var _loc10 = _loc6.findFirstItem("id", _loc9.id);
                if (_loc10.index != -1)
                {
                    _loc6.updateItem(_loc10.index, _loc9);
                }
                else
                {
                    _loc6.push(_loc9);
                } // end else if
                continue;
            } // end if
            var _loc11 = _global.parseInt(_loc8[0], 36);
            var _loc12 = _loc6.findFirstItem("id", _loc11);
            if (_loc12.index != -1)
            {
                _loc6.removeItems(_loc12.index, 1);
            } // end if
        } // end while
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
