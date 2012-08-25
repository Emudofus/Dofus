// Action script...

// [Initial MovieClip Action of sprite 20940]
#initclip 205
if (!dofus.aks.Infos)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Infos = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.getMaps = function ()
    {
        this.aks.send("IM");
    };
    _loc1.sendScreenInfo = function ()
    {
        Stage.scaleMode = "noScale";
        switch (Stage.displayState)
        {
            case "normal":
            {
                var _loc2 = "0";
                break;
            } 
            case "fullscreen":
            {
                _loc2 = "1";
                break;
            } 
            default:
            {
                _loc2 = "2";
            } 
        } // End of switch
        this.aks.send("Ir" + Stage.width + ";" + Stage.height + ";" + _loc2);
        Stage.scaleMode = "showAll";
    };
    _loc1.onInfoMaps = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
    };
    _loc1.onInfoCompass = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        var _loc6 = this.api.ui.getUIComponent("MapExplorer");
        if (_loc6 != undefined)
        {
            _loc6.select({coordinates: {x: _loc4, y: _loc5}});
        } // end if
        if (_global.isNaN(_loc4) && _global.isNaN(_loc5))
        {
            this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0], this.api.datacenter.Basics.banner_targetCoords[1], false);
        }
        else
        {
            this.api.kernel.GameManager.updateCompass(_loc4, _loc5, true);
        } // end else if
    };
    _loc1.onInfoCoordinatespHighlight = function (sExtraData)
    {
        var _loc3 = new Array();
        if (String(sExtraData).length != 0)
        {
            var _loc4 = sExtraData.split("|");
            var _loc5 = 0;
            
            while (++_loc5, _loc5 < _loc4.length)
            {
                var _loc6 = _loc4[_loc5].split(";");
                var _loc7 = Number(_loc6[0]);
                var _loc8 = Number(_loc6[1]);
                var _loc9 = Number(_loc6[2]);
                var _loc10 = Number(_loc6[3]);
                var _loc11 = Number(_loc6[4]);
                var _loc12 = String(_loc6[5]);
                _loc3.push({x: _loc7, y: _loc8, mapID: _loc9, type: _loc10, playerID: _loc11, playerName: _loc12});
            } // end while
        } // end if
        var _loc13 = this.api.ui.getUIComponent("MapExplorer");
        if (_loc13 != undefined)
        {
            _loc13.multipleSelect(_loc3);
        } // end if
        this.api.datacenter.Basics.aks_infos_highlightCoords = String(sExtraData).length == 0 ? (undefined) : (_loc3);
    };
    _loc1.onMessage = function (sExtraData)
    {
        var _loc3 = new Array();
        var _loc4 = sExtraData.charAt(0);
        var _loc5 = sExtraData.substr(1).split("|");
        var _loc7 = 0;
        
        while (++_loc7, _loc7 < _loc5.length)
        {
            var _loc8 = _loc5[_loc7].split(";");
            var _loc9 = _loc8[0];
            var _loc10 = Number(_loc9);
            var _loc11 = _loc8[1].split("~");
            switch (_loc4)
            {
                case "0":
                {
                    var _loc6 = "INFO_CHAT";
                    if (!_global.isNaN(_loc10))
                    {
                        var _loc13 = true;
                        switch (_loc10)
                        {
                            case 21:
                            case 22:
                            {
                                var _loc14 = new dofus.datacenter.Item(0, _loc11[1]);
                                _loc11 = [_loc11[0], _loc14.name];
                                break;
                            } 
                            case 17:
                            {
                                _loc11 = [_loc11[0], this.api.lang.getJobText(_loc11[1]).n];
                                break;
                            } 
                            case 2:
                            {
                                _loc11 = [this.api.lang.getJobText(Number(_loc11[0])).n];
                                break;
                            } 
                            case 3:
                            {
                                _loc11 = [this.api.lang.getSpellText(Number(_loc11[0])).n];
                                break;
                            } 
                            case 54:
                            case 55:
                            case 56:
                            {
                                _loc11[0] = this.api.lang.getQuestText(_loc11[0]);
                                break;
                            } 
                            case 65:
                            case 73:
                            {
                                var _loc15 = new dofus.datacenter.Item(0, _loc11[1]);
                                _loc11[2] = _loc15.name;
                                break;
                            } 
                            case 82:
                            case 83:
                            {
                                this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"), this.api.lang.getText("INFOS_" + _loc10, _loc11), "ERROR_BOX");
                                break;
                            } 
                            case 84:
                            {
                                break;
                            } 
                            case 120:
                            {
                                if (dofus.Constants.SAVING_THE_WORLD)
                                {
                                    dofus.SaveTheWorld.getInstance().safeWasBusy();
                                    dofus.SaveTheWorld.getInstance().nextAction();
                                } // end if
                                break;
                            } 
                            case 123:
                            {
                                var _loc12 = this.api.kernel.ChatManager.parseInlineItems(this.api.lang.getText("INFOS_" + _loc10), _loc11);
                                _loc13 = false;
                                break;
                            } 
                            case 150:
                            {
                                _loc6 = "MESSAGE_CHAT";
                                var _loc16 = new dofus.datacenter.Item(0, _loc11[0]);
                                var _loc17 = new Array();
                                var _loc18 = 3;
                                
                                while (++_loc18, _loc18 < _loc11.length)
                                {
                                    _loc17.push(_loc11[_loc18]);
                                } // end while
                                _loc11 = [_loc16.name, _loc11[1], this.api.lang.getText("OBJECT_CHAT_" + _loc11[2], _loc17)];
                                break;
                            } 
                            case 151:
                            {
                                _loc6 = "WHISP_CHAT";
                                var _loc19 = new dofus.datacenter.Item(0, _loc11[0]);
                                var _loc20 = new Array();
                                var _loc21 = 2;
                                
                                while (++_loc21, _loc21 < _loc11.length)
                                {
                                    _loc20.push(_loc11[_loc21]);
                                } // end while
                                _loc11 = [_loc19.name, this.api.lang.getText("OBJECT_CHAT_" + _loc11[1], _loc20)];
                                break;
                            } 
                        } // End of switch
                        if (_loc13)
                        {
                            _loc12 = this.api.lang.getText("INFOS_" + _loc10, _loc11);
                        } // end if
                    }
                    else
                    {
                        _loc12 = this.api.lang.getText(_loc9, _loc11);
                    } // end else if
                    if (_loc12 != undefined)
                    {
                        _loc3.push(_loc12);
                    } // end if
                    break;
                } 
                case "1":
                {
                    _loc6 = "ERROR_CHAT";
                    if (!_global.isNaN(_loc10))
                    {
                        var _loc23 = _loc10.toString(10);
                        switch (_loc10)
                        {
                            case 6:
                            case 46:
                            case 49:
                            {
                                _loc11 = [this.api.lang.getJobText(_loc11[0]).n];
                                break;
                            } 
                            case 7:
                            {
                                _loc11 = [this.api.lang.getSpellText(_loc11[0]).n];
                                break;
                            } 
                            case 89:
                            {
                                if (this.api.config.isStreaming)
                                {
                                    _loc23 = "89_MINICLIP";
                                } // end if
                                break;
                            } 
                        } // End of switch
                        var _loc22 = this.api.lang.getText("ERROR_" + _loc23, _loc11);
                    }
                    else
                    {
                        _loc22 = this.api.lang.getText(_loc9, _loc11);
                    } // end else if
                    if (_loc22 != undefined)
                    {
                        _loc3.push(_loc22);
                    } // end if
                    break;
                } 
                case "2":
                {
                    _loc6 = "PVP_CHAT";
                    if (!_global.isNaN(_loc10))
                    {
                        switch (_loc10)
                        {
                            case 41:
                            {
                                _loc11 = [this.api.lang.getMapSubAreaText(_loc11[0]).n, this.api.lang.getMapAreaText(_loc11[1]).n];
                                break;
                            } 
                            case 86:
                            case 87:
                            case 88:
                            case 89:
                            case 90:
                            {
                                _loc11[0] = this.api.lang.getMapAreaText(_loc11[0]).n;
                                break;
                            } 
                        } // End of switch
                        var _loc24 = this.api.lang.getText("PVP_" + _loc10, _loc11);
                    }
                    else
                    {
                        _loc24 = this.api.lang.getText(_loc9, _loc11);
                    } // end else if
                    if (_loc24 != undefined)
                    {
                        _loc3.push(_loc24);
                    } // end if
                    break;
                } 
            } // End of switch
        } // end while
        var _loc25 = _loc3.join(" ");
        if (_loc25 != "")
        {
            this.api.kernel.showMessage(undefined, _loc25, _loc6);
        } // end if
    };
    _loc1.onQuantity = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0];
        var _loc5 = _loc3[1];
        this.api.gfx.addSpritePoints(_loc4, _loc5, 11552256);
    };
    _loc1.onObject = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0];
        var _loc5 = _loc3[1].charAt(0) == "+";
        var _loc6 = _loc3[1].substr(1);
        var _loc7 = _loc6 == "" ? (undefined) : (new dofus.datacenter.Item(0, _loc6, 1));
        if (!this.api.datacenter.Basics.isCraftLooping)
        {
            this.api.gfx.addSpriteOverHeadItem(_loc4, "craft", dofus.graphics.battlefield.CraftResultOverHead, [_loc5, _loc7], 2000);
        } // end if
    };
    _loc1.onLifeRestoreTimerStart = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        _global.clearInterval(this.api.datacenter.Basics.aks_infos_lifeRestoreInterval);
        if (!_global.isNaN(_loc3))
        {
            var _loc4 = this.api.datacenter.Player;
            this.api.datacenter.Basics.aks_infos_lifeRestoreInterval = _global.setInterval(_loc4, "updateLP", _loc3, 1);
        } // end if
    };
    _loc1.onLifeRestoreTimerFinish = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        _global.clearInterval(this.api.datacenter.Basics.aks_infos_lifeRestoreInterval);
        if (_loc3 > 0)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("YOU_RESTORE_LIFE", [_loc3]), "INFO_CHAT");
        } // end if
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
