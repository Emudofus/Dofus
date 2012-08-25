// Action script...

// [Initial MovieClip Action of sprite 20765]
#initclip 30
if (!dofus.aks.Basics)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Basics = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.autorisedCommand = function (sCommand)
    {
        this.aks.send("BA" + sCommand, false, undefined, true);
    };
    _loc1.autorisedMoveCommand = function (nX, nY)
    {
        this.aks.send("BaM" + nX + "," + nY, false);
    };
    _loc1.autorisedKickCommand = function (sPlayerName, nTempo, sMessage)
    {
        this.aks.send("BaK" + sPlayerName + "|" + nTempo + "|" + sMessage, false);
    };
    _loc1.whoAmI = function ()
    {
        this.whoIs("");
    };
    _loc1.whoIs = function (sName)
    {
        this.aks.send("BW" + sName);
    };
    _loc1.kick = function (nCellNum)
    {
        this.aks.send("BQ" + nCellNum, false);
    };
    _loc1.away = function ()
    {
        this.aks.send("BYA", false);
    };
    _loc1.invisible = function ()
    {
        this.aks.send("BYI", false);
    };
    _loc1.getDate = function ()
    {
        this.aks.send("BD", false);
    };
    _loc1.fileCheckAnswer = function (nCheckID, nFileSize)
    {
        this.aks.send("BC" + nCheckID + ";" + nFileSize, false);
    };
    _loc1.sanctionMe = function (nSanctionID, nWordID)
    {
        this.aks.send("BK" + nSanctionID + "|" + nWordID, false);
    };
    _loc1.averagePing = function ()
    {
        this.aks.send("Bp" + this.api.network.getAveragePing() + "|" + this.api.network.getAveragePingPacketsCount() + "|" + this.api.network.getAveragePingBufferSize(), false);
    };
    _loc1.onAuthorizedInterfaceOpen = function (sExtraData)
    {
        this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"), this.api.lang.getText("A_GIVE_U_RIGHTS", [sExtraData]), "ERROR_BOX");
        this.api.datacenter.Player.isAuthorized = true;
    };
    _loc1.onAuthorizedInterfaceClose = function (sExtraData)
    {
        this.api.ui.unloadUIComponent("Debug");
        this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"), this.api.lang.getText("A_REMOVE_U_RIGHTS", [sExtraData]), "ERROR_BOX");
        this.api.datacenter.Player.isAuthorized = false;
    };
    _loc1.onAuthorizedCommand = function (bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc4 = Number(sExtraData.charAt(0));
            var _loc5 = "DEBUG_LOG";
            switch (_loc4)
            {
                case 1:
                {
                    _loc5 = "DEBUG_ERROR";
                    break;
                } 
                case 2:
                {
                    _loc5 = "DEBUG_INFO";
                    break;
                } 
            } // End of switch
            if (this.api.ui.getUIComponent("Debug") == undefined)
            {
                this.api.ui.loadUIComponent("Debug", "Debug", undefined, {bStayIfPresent: true});
            } // end if
            var _loc6 = sExtraData.substr(1);
            this.api.kernel.showMessage(undefined, _loc6, _loc5);
            if (dofus.Constants.SAVING_THE_WORLD)
            {
                if (_loc6.indexOf("BotKick inactif") == 0)
                {
                    dofus.SaveTheWorld.getInstance().nextAction();
                } // end if
            } // end if
        }
        else
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("UNKNOW_COMMAND", ["/a"]), "ERROR_CHAT");
        } // end else if
    };
    _loc1.onAuthorizedCommandPrompt = function (sExtraData)
    {
        this.api.datacenter.Basics.aks_a_prompt = sExtraData;
        this.api.ui.getUIComponent("Debug").setPrompt(sExtraData);
    };
    _loc1.onAuthorizedCommandClear = function ()
    {
        this.api.ui.getUIComponent("Debug").clear();
    };
    _loc1.onAuthorizedLine = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        var _loc6 = _loc3[2];
        var _loc7 = this.api.datacenter.Basics.aks_a_logs.split("<br/>");
        var _loc8 = "<font color=\"#FFFFFF\">" + _loc6 + "</font>";
        switch (_loc5)
        {
            case 1:
            {
                _loc8 = "<font color=\"#FF0000\">" + _loc6 + "</font>";
                break;
            } 
            case 2:
            {
                _loc8 = "<font color=\"#00FF00\">" + _loc6 + "</font>";
                break;
            } 
        } // End of switch
        if (!_global.isNaN(_loc4) && _loc4 < _loc7.length)
        {
            _loc7[_loc7.length - _loc4] = _loc8;
            this.api.datacenter.Basics.aks_a_logs = _loc7.join("<br/>");
            this.api.ui.getUIComponent("Debug").refresh();
        } // end if
    };
    _loc1.onReferenceTime = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        this.api.kernel.NightManager.setReferenceTime(_loc3);
    };
    _loc1.onDate = function (sExtraData)
    {
        this.api.datacenter.Basics.lastDateUpdate = getTimer();
        var _loc3 = sExtraData.split("|");
        this.api.kernel.NightManager.setReferenceDate(Number(_loc3[0]), Number(_loc3[1]), Number(_loc3[2]));
    };
    _loc1.onWhoIs = function (bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc4 = sExtraData.split("|");
            if (_loc4.length != 4)
            {
                return;
            } // end if
            var _loc5 = _loc4[0];
            var _loc6 = _loc4[1];
            var _loc7 = _loc4[2];
            var _loc8 = Number(_loc4[3]) != -1 ? (this.api.lang.getMapAreaText(Number(_loc4[3])).n) : (this.api.lang.getText("UNKNOWN_AREA"));
            if (_loc5.toLowerCase() == this.api.datacenter.Basics.login)
            {
                switch (_loc6)
                {
                    case "1":
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("I_AM_IN_SINGLE_GAME", [_loc7, _loc5, _loc8]), "INFO_CHAT");
                        break;
                    } 
                    case "2":
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("I_AM_IN_GAME", [_loc7, _loc5, _loc8]), "INFO_CHAT");
                        break;
                    } 
                } // End of switch
            }
            else
            {
                switch (_loc6)
                {
                    case "1":
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("IS_IN_SINGLE_GAME", [_loc7, _loc5, _loc8]), "INFO_CHAT");
                        break;
                    } 
                    case "2":
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("IS_IN_GAME", [_loc7, _loc5, _loc8]), "INFO_CHAT");
                        break;
                    } 
                } // End of switch
            } // end else if
        }
        else
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_FIND_ACCOUNT_OR_CHARACTER", [sExtraData]), "ERROR_CHAT");
        } // end else if
    };
    _loc1.onFileCheck = function (sExtraData)
    {
        var _loc3 = sExtraData.split(";");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = _loc3[1];
        dofus.utils.Api.getInstance().checkFileSize(_loc5, _loc4);
    };
    _loc1.onAveragePing = function (sExtraData)
    {
        this.averagePing();
    };
    _loc1.onSubscriberRestriction = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        if (_loc3)
        {
            var _loc4 = Number(sExtraData.substr(1));
            if (_loc4 != 10)
            {
                this.api.ui.loadUIComponent("PayZoneDialog2", "PayZoneDialog2", {dialogID: _loc4, name: "El Pemy", gfx: "9059"});
            }
            else
            {
                this.api.ui.loadUIComponent("PayZone", "PayZone", {dialogID: _loc4}, {bForceLoad: true});
                this.api.datacenter.Basics.payzone_isFirst = false;
            } // end else if
        }
        else
        {
            this.api.ui.unloadUIComponent("PayZone");
        } // end else if
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
