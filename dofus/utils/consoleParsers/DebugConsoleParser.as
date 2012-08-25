// Action script...

// [Initial MovieClip Action of sprite 20937]
#initclip 202
if (!dofus.utils.consoleParsers.DebugConsoleParser)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.utils)
    {
        _global.dofus.utils = new Object();
    } // end if
    if (!dofus.utils.consoleParsers)
    {
        _global.dofus.utils.consoleParsers = new Object();
    } // end if
    var _loc1 = (_global.dofus.utils.consoleParsers.DebugConsoleParser = function (oAPI)
    {
        super();
        this.initialize(oAPI);
    }).prototype;
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI);
    };
    _loc1.process = function (sCmd)
    {
        super.process(sCmd);
        if (sCmd.charAt(0) == "/")
        {
            var _loc4 = sCmd.split(" ");
            var _loc5 = _loc4[0].substr(1).toUpperCase();
            _loc4.splice(0, 1);
            switch (_loc5)
            {
                case "TOGGLESPRITES":
                {
                    this.api.datacenter.Basics.gfx_isSpritesHidden = !this.api.datacenter.Basics.gfx_isSpritesHidden;
                    if (this.api.datacenter.Basics.gfx_isSpritesHidden)
                    {
                        this.api.gfx.spriteHandler.maskAllSprites();
                    }
                    else
                    {
                        this.api.gfx.spriteHandler.unmaskAllSprites();
                    } // end else if
                    break;
                } 
                case "INFOS":
                {
                    var _loc6 = "Svr:";
                    _loc6 = _loc6 + "\nNb:";
                    _loc6 = _loc6 + ("\n Map  : " + String(this.api.datacenter.Game.playerCount));
                    _loc6 = _loc6 + ("\n Cell : " + this.api.datacenter.Map.data[this.api.datacenter.Player.data.cellNum].spriteOnCount);
                    _loc6 = _loc6 + "\nDataServers:";
                    var _loc7 = 0;
                    
                    while (++_loc7, _loc7 < this.api.config.dataServers.length)
                    {
                        _loc6 = _loc6 + ("\n host : " + this.api.config.dataServers[_loc7].url);
                    } // end while
                    _loc6 = _loc6 + ("\n l   : " + this.api.config.language + " (" + this.api.lang.getLangVersion() + " & " + this.api.lang.getXtraVersion() + ")");
                    this.api.kernel.showMessage(undefined, _loc6, "DEBUG_LOG");
                    break;
                } 
                case "ZOOM":
                {
                    this.api.kernel.GameManager.zoomGfx(_loc4[0], _loc4[1], _loc4[2]);
                    break;
                } 
                case "TIMERSCOUNT":
                {
                    this.api.kernel.showMessage(undefined, String(ank.utils.Timer.getTimersCount()), "DEBUG_LOG");
                    break;
                } 
                case "VARS":
                {
                    this.api.kernel.showMessage(undefined, this.api.kernel.TutorialManager.vars, "DEBUG_LOG");
                    break;
                } 
                case "MOUNT":
                {
                    var _loc8 = this.api.gfx.getSprite(this.api.datacenter.Player.ID);
                    if (!_loc8.isMounting)
                    {
                        var _loc9 = _loc4[0] != undefined ? (_loc4[0] + ".swf") : ("7002.swf");
                        var _loc10 = _loc4[1] != undefined ? (_loc4[1] + ".swf") : ("10.swf");
                        var _loc11 = new ank.battlefield.datacenter.Mount(dofus.Constants.CLIPS_PERSOS_PATH + _loc9, dofus.Constants.CHEVAUCHOR_PATH + _loc10);
                        this.api.gfx.mountSprite(this.api.datacenter.Player.ID, _loc11);
                    }
                    else
                    {
                        this.api.gfx.unmountSprite(this.api.datacenter.Player.ID);
                    } // end else if
                    break;
                } 
                case "SCALE":
                {
                    this.api.gfx.setSpriteScale(this.api.datacenter.Player.ID, _loc4[0], _loc4.length == 2 ? (_loc4[1]) : (_loc4[0]));
                    break;
                } 
                case "ANIM":
                {
                    if (dofus.Constants.DEBUG)
                    {
                        if (_loc4.length > 1)
                        {
                            this.api.gfx.setSpriteLoopAnim(this.api.datacenter.Player.ID, _loc4[0], _loc4[1]);
                        }
                        else
                        {
                            this.api.gfx.setSpriteAnim(this.api.datacenter.Player.ID, _loc4.join(""));
                        } // end if
                    } // end else if
                    break;
                } 
                case "C":
                {
                    if (dofus.Constants.DEBUG)
                    {
                        var _loc12 = _loc4[0];
                        _loc4.splice(0, 1);
                        switch (_loc12)
                        {
                            case ">":
                            {
                                this.api.network.send(_loc4.join(" "));
                                break;
                            } 
                            case "<":
                            {
                                this.api.network.processCommand(_loc4.join(" "));
                                break;
                            } 
                        } // End of switch
                    } // end if
                    break;
                } 
                case "D":
                {
                    if (dofus.Constants.DEBUG)
                    {
                        var _loc13 = _loc4[0];
                        _loc4.splice(0, 1);
                        switch (_loc13)
                        {
                            case ">":
                            {
                                this.api.network.send(_loc4.join(" "), false, undefined, false, true);
                                break;
                            } 
                            case "<":
                            {
                                this.api.network.processCommand(_loc4.join(" "));
                                break;
                            } 
                        } // End of switch
                    } // end if
                    break;
                } 
                case "PING":
                {
                    this.api.network.ping();
                    break;
                } 
                case "MAPID":
                {
                    this.api.kernel.showMessage(undefined, "carte : " + this.api.datacenter.Map.id, "DEBUG_LOG");
                    this.api.kernel.showMessage(undefined, "Area : " + this.api.datacenter.Map.area, "DEBUG_LOG");
                    this.api.kernel.showMessage(undefined, "Sub area : " + this.api.datacenter.Map.subarea, "DEBUG_LOG");
                    this.api.kernel.showMessage(undefined, "Super Area : " + this.api.datacenter.Map.superarea, "DEBUG_LOG");
                    break;
                } 
                case "CELLID":
                {
                    this.api.kernel.showMessage(undefined, "cellule : " + this.api.datacenter.Player.data.cellNum, "DEBUG_LOG");
                    break;
                } 
                case "TIME":
                {
                    this.api.kernel.showMessage(undefined, "Heure : " + this.api.kernel.NightManager.time, "DEBUG_LOG");
                    break;
                } 
                case "CACHE":
                {
                    this.api.kernel.askClearCache();
                    break;
                } 
                case "REBOOT":
                {
                    this.api.kernel.reboot();
                    break;
                } 
                case "FPS":
                {
                    this.api.ui.getUIComponent("Debug").showFps();
                    break;
                } 
                case "UI":
                {
                    this.api.ui.loadUIComponent(_loc4[0], _loc4[0]);
                    break;
                } 
                case "DEBUG":
                {
                    dofus.Constants.DEBUG = !dofus.Constants.DEBUG;
                    this.api.kernel.showMessage(undefined, "DEBUG : " + dofus.Constants.DEBUG, "DEBUG_LOG");
                    break;
                } 
                case "ASKOK":
                {
                    this.api.ui.loadUIComponent("AskOk", "AskOkContent", {title: "AskOKDebug", text: this.api.lang.getText(_loc4[0], _loc4.splice(1))});
                    break;
                } 
                case "ASKOK2":
                {
                    var _loc14 = "";
                    var _loc15 = 0;
                    
                    while (++_loc15, _loc15 < _loc4.length)
                    {
                        if (_loc15 > 0)
                        {
                            _loc14 = _loc14 + " ";
                        } // end if
                        _loc14 = _loc14 + _loc4[_loc15];
                    } // end while
                    this.api.ui.loadUIComponent("AskOk", "AskOkContent", {title: "AskOKDebug", text: _loc14});
                    break;
                } 
                case "MOVIECLIP":
                {
                    this.api.kernel.findMovieClipPath();
                    break;
                } 
                case "LOS":
                {
                    var _loc16 = Number(_loc4[0]);
                    var _loc17 = Number(_loc4[1]);
                    if (_global.isNaN(_loc16) || (_loc16 == undefined || (_global.isNaN(_loc17) || _loc17 == undefined)))
                    {
                        this.api.kernel.showMessage(undefined, "Unable to resolve case ID", "DEBUG_LOG");
                        return;
                    } // end if
                    this.api.kernel.showMessage(undefined, "Line of sight between " + _loc16 + " and " + _loc17 + " -> " + ank.battlefield.utils.Pathfinding.checkView(this.api.gfx.mapHandler, _loc16, _loc17), "DEBUG_LOG");
                    break;
                } 
                case "CLEARCELL":
                {
                    var _loc18 = Number(_loc4[0]);
                    if (_global.isNaN(_loc18) || _loc18 == undefined)
                    {
                        this.api.kernel.showMessage(undefined, "I\'ll need an ID!", "DEBUG_LOG");
                        return;
                    } // end if
                    this.api.gfx.mapHandler.getCellData(_loc18).removeAllSpritesOnID();
                    this.api.kernel.showMessage(undefined, "Cell " + _loc18 + " cleaned.", "DEBUG_LOG");
                    break;
                } 
                case "CELLINFO":
                {
                    var _loc19 = Number(_loc4[0]);
                    if (_global.isNaN(_loc19) || _loc19 == undefined)
                    {
                        this.api.kernel.showMessage(undefined, "I\'ll need an ID!", "DEBUG_LOG");
                        return;
                    } // end if
                    var _loc20 = this.api.gfx.mapHandler.getCellData(_loc19);
                    this.api.kernel.showMessage(undefined, "Datas about cell " + _loc19 + ":", "DEBUG_LOG");
                    for (var k in _loc20)
                    {
                        this.api.kernel.showMessage(undefined, "    " + k + " -> " + _loc20[k], "DEBUG_LOG");
                        if (_loc20[k] instanceof Object)
                        {
                            for (var l in _loc20[k])
                            {
                                this.api.kernel.showMessage(undefined, "        " + l + " -> " + _loc20[k][l], "DEBUG_LOG");
                            } // end of for...in
                        } // end if
                    } // end of for...in
                    break;
                } 
                case "LANGFILE":
                {
                    this.api.kernel.showMessage(undefined, _loc4[0] + " lang file size : " + this.api.lang.getLangFileSize(_loc4[0]) + " octets", "DEBUG_LOG");
                    break;
                } 
                case "POINTSPRITE":
                {
                    this.api.kernel.TipsManager.pointSprite(-1, Number(_loc4[0]));
                    break;
                } 
                case "LISTSPRITES":
                {
                    var _loc21 = this.api.gfx.spriteHandler.getSprites().getItems();
                    for (var k in _loc21)
                    {
                        this.api.kernel.showMessage(undefined, "Sprite " + _loc21[k].gfxFile, "DEBUG_LOG");
                    } // end of for...in
                    break;
                } 
                case "LISTPICTOS":
                {
                    var _loc22 = this.api.gfx.mapHandler.getCellsData();
                    for (var k in _loc22)
                    {
                        if (_loc22[k].layerObject1Num != undefined && (!_global.isNaN(_loc22[k].layerObject1Num) && _loc22[k].layerObject1Num > 0))
                        {
                            this.api.kernel.showMessage(undefined, "Picto " + _loc22[k].layerObject1Num, "DEBUG_LOG");
                        } // end if
                        if (_loc22[k].layerObject2Num != undefined && (!_global.isNaN(_loc22[k].layerObject2Num) && _loc22[k].layerObject2Num > 0))
                        {
                            this.api.kernel.showMessage(undefined, "Picto " + _loc22[k].layerObject2Num, "DEBUG_LOG");
                        } // end if
                    } // end of for...in
                    break;
                } 
                case "POINTPICTO":
                {
                    this.api.kernel.TipsManager.pointPicto(-1, Number(_loc4[0]));
                    break;
                } 
                case "SAVETHEWORLD":
                {
                    if (dofus.Constants.SAVING_THE_WORLD)
                    {
                        dofus.SaveTheWorld.execute();
                    }
                    else
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("UNKNOW_COMMAND", [_loc5]), "DEBUG_ERROR");
                    } // end else if
                    break;
                } 
                case "STOPSAVETHEWORLD":
                {
                    if (dofus.Constants.SAVING_THE_WORLD)
                    {
                        dofus.SaveTheWorld.stop();
                    }
                    else
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("UNKNOW_COMMAND", [_loc5]), "DEBUG_ERROR");
                    } // end else if
                    break;
                } 
                case "NEXTSAVE":
                {
                    if (dofus.Constants.SAVING_THE_WORLD)
                    {
                        dofus.SaveTheWorld.getInstance().nextAction();
                    }
                    else
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("UNKNOW_COMMAND", [_loc5]), "DEBUG_ERROR");
                    } // end else if
                    break;
                } 
                case "SOMAPLAY":
                {
                    var _loc23 = _loc4.join(" ");
                    this.api.kernel.AudioManager.playSound(_loc23);
                    break;
                } 
                case "VERIFYIDENTITY":
                {
                    var _loc24 = _loc4[0];
                    if (this.api.network.isValidNetworkKey(_loc24))
                    {
                        this.api.kernel.showMessage(undefined, _loc24 + ": Ok!", "DEBUG_LOG");
                    }
                    else
                    {
                        this.api.kernel.showMessage(undefined, _loc24 + ": Failed.", "DEBUG_LOG");
                        if (_loc24 == undefined)
                        {
                            this.api.kernel.showMessage(undefined, " - Undefined identity.", "DEBUG_LOG");
                        } // end if
                        if (_loc24.length == 0)
                        {
                            this.api.kernel.showMessage(undefined, " - Zero-length identity.", "DEBUG_LOG");
                        } // end if
                        if (_loc24 == "")
                        {
                            this.api.kernel.showMessage(undefined, "\t- Empty string identity.", "DEBUG_LOG");
                        } // end if
                        if (dofus.aks.Aks.checksum(_loc24.substr(0, _loc24.length - 1)) != _loc24.substr(_loc24.length - 1))
                        {
                            this.api.kernel.showMessage(undefined, "\t- First checksum is wrong. Got " + _loc24.substr(_loc24.length - 1) + ", " + dofus.aks.Aks.checksum(_loc24.substr(0, _loc24.length - 1)) + " expected.", "DEBUG_LOG");
                        } // end if
                        if (dofus.aks.Aks.checksum(_loc24.substr(1, _loc24.length - 2)) != _loc24.substr(0, 1))
                        {
                            this.api.kernel.showMessage(undefined, "\t- Second checksum is wrong. Got " + _loc24.substr(0, 1) + ", " + dofus.aks.Aks.checksum(_loc24.substr(1, _loc24.length - 2)) + " expected.", "DEBUG_LOG");
                        } // end if
                    } // end else if
                    break;
                } 
                case "MONSTER":
                {
                    var _loc25 = _loc4[0];
                    var _loc26 = this.api.lang.getMonsters();
                    for (var i in _loc26)
                    {
                        if (_loc26[i].n.toUpperCase().indexOf(_loc25.toUpperCase()) != -1)
                        {
                            this.api.kernel.showMessage(undefined, " " + _loc26[i].n + " : " + i + " ( gfx:" + _loc26[i].g + ")", "DEBUG_LOG");
                        } // end if
                    } // end of for...in
                    break;
                } 
                default:
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("UNKNOW_COMMAND", [_loc5]), "DEBUG_ERROR");
                    break;
                } 
            } // End of switch
        }
        else if (this.api.datacenter.Basics.isLogged)
        {
            this.api.network.Basics.autorisedCommand(sCmd);
        }
        else
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("UNKNOW_COMMAND", [sCmd]), "DEBUG_ERROR");
        } // end else if
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
