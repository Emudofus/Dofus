// Action script...

// [Initial MovieClip Action of sprite 20721]
#initclip 242
if (!dofus.aks.Game)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Game = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.__get__isBusy = function ()
    {
        return (this._bIsBusy);
    };
    _loc1.create = function ()
    {
        this.aks.send("GC" + dofus.aks.Game.TYPE_SOLO);
    };
    _loc1.leave = function (sSpriteID)
    {
        this.aks.send("GQ" + (sSpriteID == undefined ? ("") : (sSpriteID)));
    };
    _loc1.setPlayerPosition = function (nCellNum)
    {
        this.aks.send("Gp" + nCellNum, true);
    };
    _loc1.ready = function (bReady)
    {
        this.aks.send("GR" + (bReady ? ("1") : ("0")));
    };
    _loc1.getMapData = function (nMapID)
    {
        if (this.api.lang.getConfigText("ENABLE_CLIENT_MAP_REQUEST"))
        {
            this.aks.send("GD" + (nMapID != undefined ? (String(nMapID)) : ("")));
        } // end if
    };
    _loc1.getExtraInformations = function ()
    {
        this.aks.send("GI");
    };
    _loc1.turnEnd = function ()
    {
        if (this.api.datacenter.Player.isCurrentPlayer)
        {
            this.aks.send("Gt", false);
        } // end if
    };
    _loc1.turnOk = function (sSpriteID)
    {
        this.aks.send("GT" + (sSpriteID != undefined ? (sSpriteID) : ("")), false);
    };
    _loc1.turnOk2 = function (sSpriteID)
    {
        this.aks.send("GT" + (sSpriteID != undefined ? (sSpriteID) : ("")), false);
    };
    _loc1.askDisablePVPMode = function ()
    {
        this.aks.send("GP*", false);
    };
    _loc1.enabledPVPMode = function (bEnabled)
    {
        this.aks.send("GP" + (bEnabled ? ("+") : ("-")), false);
    };
    _loc1.freeMySoul = function ()
    {
        this.aks.send("GF", false);
    };
    _loc1.setFlag = function (nCellID)
    {
        this.aks.send("Gf" + nCellID, false);
    };
    _loc1.showFightChallengeTarget = function (challengeId)
    {
        this.aks.send("Gdi" + challengeId, false);
    };
    _loc1.onCreate = function (bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            ank.utils.Logger.err("[onCreate] Impossible de créer la partie");
            return;
        } // end if
        var _loc4 = sExtraData.split("|");
        var _loc5 = Number(_loc4[0]);
        if (_loc5 != 1)
        {
            ank.utils.Logger.err("[onCreate] Type incorrect");
            return;
        } // end if
        this.api.datacenter.Game = new dofus.datacenter.Game();
        this.api.datacenter.Game.state = _loc5;
        this.api.datacenter.Player.data.initAP(false);
        this.api.datacenter.Player.data.initMP(false);
        this.api.datacenter.Player.SpellsManager.clear();
        this.api.datacenter.Player.data.CharacteristicsManager.initialize();
        this.api.datacenter.Player.data.EffectsManager.initialize();
        this.api.datacenter.Player.clearSummon();
        this.api.gfx.cleanMap(1);
        this.onCreateSolo();
    };
    _loc1.onJoin = function (sExtraData)
    {
        this.api.ui.getUIComponent("Zoom").callClose();
        this.api.datacenter.Player.guildInfos.defendedTaxCollectorID = undefined;
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = _loc3[1] == "0" ? (false) : (true);
        var _loc6 = _loc3[2] == "0" ? (false) : (true);
        var _loc7 = _loc3[3] == "0" ? (false) : (true);
        var _loc8 = Number(_loc3[4]);
        var _loc9 = Number(_loc3[5]);
        this.api.datacenter.Game = new dofus.datacenter.Game();
        this.api.datacenter.Game.state = _loc4;
        this.api.datacenter.Game.fightType = _loc9;
        this.api.datacenter.Game.isSpectator = _loc7;
        if (!_loc7)
        {
            this.api.datacenter.Player.data.initAP(false);
            this.api.datacenter.Player.data.initMP(false);
            this.api.datacenter.Player.SpellsManager.clear();
        } // end if
        this.api.ui.getUIComponent("Banner").shortcuts.setCurrentTab("Spells");
        this.api.gfx.cleanMap(1);
        if (_loc6)
        {
            this.api.ui.loadUIComponent("ChallengeMenu", "ChallengeMenu", {labelReady: this.api.lang.getText("READY"), labelCancel: this.api.lang.getText("CANCEL_SMALL"), cancelButton: _loc5, ready: false}, {bStayIfPresent: true});
        } // end if
        if (!_global.isNaN(_loc8))
        {
            this.api.ui.getUIComponent("Banner").startTimer(_loc8 / 1000);
        } // end if
        this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_NONE);
        this.api.ui.unloadLastUIAutoHideComponent();
        this.api.ui.unloadUIComponent("Fights");
    };
    _loc1.onPositionStart = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0];
        var _loc5 = _loc3[1];
        var _loc6 = Number(_loc3[2]);
        this.api.datacenter.Basics.aks_current_team = _loc6;
        this.api.datacenter.Basics.aks_team1_starts = new Array();
        this.api.datacenter.Basics.aks_team2_starts = new Array();
        this.api.kernel.StreamingDisplayManager.onFightStart();
        this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
        this.api.datacenter.Game.setInteractionType("place");
        if (_loc6 == undefined)
        {
            ank.utils.Logger.err("[onPositionStart] Impossible de trouver l\'équipe du joueur local !");
        } // end if
        var _loc7 = 0;
        
        while (_loc7 = _loc7 + 2, _loc7 < _loc4.length)
        {
            var _loc8 = ank.utils.Compressor.decode64(_loc4.charAt(_loc7)) << 6;
            _loc8 = _loc8 + ank.utils.Compressor.decode64(_loc4.charAt(_loc7 + 1));
            this.api.datacenter.Basics.aks_team1_starts.push(_loc8);
            if (_loc6 == 0)
            {
                this.api.gfx.setInteractionOnCell(_loc8, ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
            } // end if
            this.api.gfx.select(_loc8, dofus.Constants.TEAMS_COLOR[0], "startPosition");
        } // end while
        var _loc9 = 0;
        
        while (_loc9 = _loc9 + 2, _loc9 < _loc5.length)
        {
            var _loc10 = ank.utils.Compressor.decode64(_loc5.charAt(_loc9)) << 6;
            _loc10 = _loc10 + ank.utils.Compressor.decode64(_loc5.charAt(_loc9 + 1));
            this.api.datacenter.Basics.aks_team2_starts.push(_loc10);
            if (_loc6 == 1)
            {
                this.api.gfx.setInteractionOnCell(_loc10, ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
            } // end if
            this.api.gfx.select(_loc10, dofus.Constants.TEAMS_COLOR[1], "startPosition");
        } // end while
        if (this.api.ui.getUIComponent("FightOptionButtons") == undefined)
        {
            this.api.ui.loadUIComponent("FightOptionButtons", "FightOptionButtons");
        } // end if
        this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_PLACEMENT);
    };
    _loc1.onPlayersCoordinates = function (sExtraData)
    {
        if (sExtraData != "e")
        {
            var _loc3 = sExtraData.split("|");
            var _loc4 = 0;
            
            while (++_loc4, _loc4 < _loc3.length)
            {
                var _loc5 = _loc3[_loc4].split(";");
                var _loc6 = _loc5[0];
                var _loc7 = Number(_loc5[1]);
                this.api.gfx.setSpritePosition(_loc6, _loc7);
            } // end while
        }
        else
        {
            this.api.sounds.events.onError();
        } // end else if
    };
    _loc1.onReady = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "1";
        var _loc4 = sExtraData.substr(1);
        if (_loc3)
        {
            this.api.gfx.addSpriteExtraClip(_loc4, dofus.Constants.READY_FILE);
        }
        else
        {
            this.api.gfx.removeSpriteExtraClip(_loc4);
        } // end else if
    };
    _loc1.onStartToPlay = function ()
    {
        this.api.ui.getUIComponent("Banner").stopTimer();
        this.aks.GameActions.onActionsFinish(this.api.datacenter.Player.ID);
        this.api.sounds.events.onGameStart(this.api.datacenter.Map.musics);
        this.api.kernel.StreamingDisplayManager.onFightStartEnd();
        var _loc2 = this.api.ui.getUIComponent("Banner");
        _loc2.showGiveUpButton(true);
        if (!this.api.datacenter.Game.isSpectator)
        {
            var _loc3 = this.api.datacenter.Player.data;
            _loc3.initAP();
            _loc3.initMP();
            _loc3.initLP();
            _loc2.showPoints(true);
            _loc2.showNextTurnButton(true);
            this.api.ui.loadUIComponent("CenterText", "CenterText", {text: this.api.lang.getText("GAME_LAUNCH"), background: true, timer: 2000}, {bForceLoad: true});
        } // end if
        this.api.ui.getUIComponent("FightOptionButtons").onGameRunning();
        this.api.ui.loadUIComponent("Timeline", "Timeline");
        this.api.ui.unloadUIComponent("ChallengeMenu");
        this.api.gfx.unSelect(true);
        this.api.gfx.drawGrid();
        this.api.datacenter.Game.setInteractionType("move");
        this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
        this.api.kernel.GameManager.signalFightActivity();
        this.api.datacenter.Game.isRunning = true;
        var _loc4 = this.api.datacenter.Sprites.getItems();
        for (var k in _loc4)
        {
            this.api.gfx.addSpriteExtraClip(k, dofus.Constants.CIRCLE_FILE, dofus.Constants.TEAMS_COLOR[_loc4[k].Team]);
        } // end of for...in
    };
    _loc1.onTurnStart = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0];
        var _loc5 = Number(_loc3[1]) / 1000;
        var _loc6 = this.api.datacenter.Sprites.getItemAt(_loc4);
        _loc6.GameActionsManager.clear();
        this.api.gfx.unSelect(true);
        this.api.datacenter.Game.currentPlayerID = _loc4;
        this.api.kernel.GameManager.cleanPlayer(this.api.datacenter.Game.lastPlayerID);
        this.api.ui.getUIComponent("Timeline").nextTurn(_loc4);
        if (this.api.datacenter.Player.isCurrentPlayer)
        {
            if (this.api.kernel.OptionsManager.getOption("StartTurnSound"))
            {
                this.api.sounds.events.onTurnStart();
            } // end if
            if (this.api.kernel.GameManager.autoSkip && this.api.datacenter.Game.isFight)
            {
                this.api.network.Game.turnEnd();
            } // end if
            this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
            this.api.datacenter.Player.SpellsManager.nextTurn();
            this.api.ui.getUIComponent("Banner").startTimer(_loc5);
            this.api.kernel.GameManager.startInactivityDetector();
            dofus.DofusCore.getInstance().forceMouseOver();
            this.api.gfx.mapHandler.resetEmptyCells();
        }
        else
        {
            this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
            this.api.ui.getUIComponent("Timeline").startChrono(_loc5);
        } // end else if
        if (this.api.kernel.OptionsManager.getOption("StringCourse"))
        {
            var _loc7 = new Array();
            _loc7[1] = _loc6.color1;
            _loc7[2] = _loc6.color2;
            _loc7[3] = _loc6.color3;
            this.api.ui.loadUIComponent("StringCourse", "StringCourse", {gfx: _loc6.artworkFile, name: _loc6.name, level: this.api.lang.getText("LEVEL_SMALL") + " " + _loc6.Level, colors: _loc7}, {bForceLoad: true});
        } // end if
        this.api.kernel.GameManager.cleanUpGameArea(true);
        ank.utils.Timer.setTimer(this.api.network.Ping, "GameDecoDetect", this.api.network, this.api.network.quickPing, _loc5 * 1000);
        this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_START);
    };
    _loc1.onTurnFinish = function (sExtraData)
    {
        var _loc3 = sExtraData;
        var _loc4 = this.api.datacenter.Sprites.getItemAt(_loc3);
        if (this.api.datacenter.Player.isCurrentPlayer)
        {
            this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
            this.api.kernel.GameManager.stopInactivityDetector();
            this.api.kernel.GameManager.onTurnEnd();
        } // end if
        this.api.datacenter.Game.lastPlayerID = this.api.datacenter.Game.currentPlayerID;
        this.api.datacenter.Game.currentPlayerID = undefined;
        this.api.ui.getUIComponent("Banner").stopTimer();
        this.api.ui.getUIComponent("Timeline").stopChrono();
        this.api.kernel.GameManager.cleanUpGameArea(true);
    };
    _loc1.onTurnlist = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        this.api.datacenter.Game.turnSequence = _loc3;
        this.api.ui.getUIComponent("Timeline").update();
    };
    _loc1.onTurnMiddle = function (sExtraData)
    {
        if (!this.api.datacenter.Game.isRunning)
        {
            ank.utils.Logger.err("[innerOnTurnMiddle] on est pas en combat");
            return;
        } // end if
        var _loc3 = sExtraData.split("|");
        var _loc4 = new Object();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc3.length)
        {
            var _loc6 = _loc3[_loc5].split(";");
            if (_loc6.length != 0)
            {
                var _loc7 = _loc6[0];
                var _loc8 = _loc6[1] == "1" ? (true) : (false);
                var _loc9 = Number(_loc6[2]);
                var _loc10 = Number(_loc6[3]);
                var _loc11 = Number(_loc6[4]);
                var _loc12 = Number(_loc6[5]);
                var _loc13 = Number(_loc6[6]);
                var _loc14 = Number(_loc6[7]);
                _loc4[_loc7] = true;
                var _loc15 = this.api.datacenter.Sprites.getItemAt(_loc7);
                if (_loc15 != undefined)
                {
                    _loc15.sequencer.clearAllNextActions();
                    if (_loc8)
                    {
                        _loc15.mc.clear();
                        this.api.gfx.removeSpriteOverHeadLayer(_loc7, "text");
                    }
                    else
                    {
                        _loc15.LP = _loc9;
                        _loc15.LPmax = _loc14;
                        _loc15.AP = _loc10;
                        _loc15.MP = _loc11;
                        if (!_global.isNaN(_loc12) && !_loc15.hasCarriedParent())
                        {
                            this.api.gfx.setSpritePosition(_loc7, _loc12);
                        } // end if
                        if (_loc15.hasCarriedChild())
                        {
                            _loc15.carriedChild.updateCarriedPosition();
                        } // end if
                    } // end else if
                    continue;
                } // end if
                ank.utils.Logger.err("[onTurnMiddle] le sprite n\'existe pas");
            } // end if
        } // end while
        var _loc16 = this.api.datacenter.Sprites.getItems();
        for (var k in _loc16)
        {
            if (!_loc4[k])
            {
                _loc16[k].mc.clear();
                this.api.datacenter.Sprites.removeItemAt(k);
            } // end if
        } // end of for...in
        this.api.ui.getUIComponent("Timeline").timelineControl.updateCharacters();
    };
    _loc1.onTurnReady = function (sExtraData)
    {
        var _loc3 = sExtraData;
        var _loc4 = this.api.datacenter.Sprites.getItemAt(_loc3);
        if (_loc4 != undefined)
        {
            var _loc5 = _loc4.sequencer;
            _loc5.addAction(false, this, this.turnOk);
            _loc5.execute();
        }
        else
        {
            ank.utils.Logger.err("[onTurnReday] le sprite " + _loc3 + " n\'existe pas");
            this.turnOk2();
        } // end else if
    };
    _loc1.onMapData = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0];
        var _loc5 = _loc3[1];
        var _loc6 = _loc3[2];
        if (Number(_loc4) == this.api.datacenter.Map.id)
        {
            if (!this.api.datacenter.Map.bOutdoor)
            {
                this.api.kernel.NightManager.noEffects();
            } // end if
            this.api.gfx.onMapLoaded();
            return;
        } // end if
        this.api.gfx.showContainer(false);
        this.nLastMapIdReceived = _global.parseInt(_loc4, 10);
        this.api.kernel.MapsServersManager.loadMap(_loc4, _loc5, _loc6);
    };
    _loc1.onMapLoaded = function ()
    {
        this.api.gfx.showContainer(true);
        if (dofus.Constants.SAVING_THE_WORLD)
        {
            dofus.SaveTheWorld.getInstance().nextAction();
        } // end if
    };
    _loc1.onMovement = function (sExtraData, bIsSummoned)
    {
        var _loc4 = sExtraData.split("|");
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc4.length)
        {
            var _loc6 = _loc4[_loc5];
            if (_loc6.length == 0)
            {
                continue;
            } // end if
            var _loc7 = false;
            var _loc8 = false;
            var _loc9 = _loc6.charAt(0);
            if (_loc9 == "+")
            {
                _loc8 = true;
            }
            else if (_loc9 == "~")
            {
                _loc8 = true;
                _loc7 = true;
            }
            else if (_loc9 != "-")
            {
                continue;
            } // end else if
            if (_loc8)
            {
                var _loc10 = _loc6.substr(1).split(";");
                var _loc11 = _loc10[0];
                var _loc12 = _loc10[1];
                var _loc13 = Number(_loc10[2]);
                var _loc14 = _loc10[3];
                var _loc15 = _loc10[4];
                var _loc16 = _loc10[5];
                var _loc17 = _loc10[6];
                var _loc18 = false;
                var _loc19 = true;
                if (_loc17.charAt(_loc17.length - 1) == "*")
                {
                    _loc17 = _loc17.substr(0, _loc17.length - 1);
                    _loc18 = true;
                } // end if
                if (_loc17.charAt(0) == "*")
                {
                    _loc19 = false;
                    _loc17 = _loc17.substr(1);
                } // end if
                var _loc20 = _loc17.split("^");
                var _loc21 = _loc20.length == 2 ? (_loc20[0]) : (_loc17);
                var _loc22 = _loc16.split(",");
                var _loc23 = _loc22[0];
                var _loc24 = _loc22[1];
                var _loc25;
                if (_loc24.length)
                {
                    var _loc26 = _loc24.split("*");
                    _loc25 = new dofus.datacenter.Title(_global.parseInt(_loc26[0]), _loc26[1]);
                } // end if
                var _loc27 = 100;
                var _loc28 = 100;
                if (_loc20.length == 2)
                {
                    var _loc29 = _loc20[1];
                    if (_global.isNaN(Number(_loc29)))
                    {
                        var _loc30 = _loc29.split("x");
                        _loc27 = _loc30.length == 2 ? (Number(_loc30[0])) : (100);
                        _loc28 = _loc30.length == 2 ? (Number(_loc30[1])) : (100);
                    }
                    else
                    {
                        _loc28 = Number(_loc29);
                        _loc27 = Number(_loc29);
                    } // end if
                } // end else if
                if (_loc7)
                {
                    var _loc31 = this.api.datacenter.Sprites.getItemAt(_loc14);
                    this.onSpriteMovement(false, _loc31);
                } // end if
                switch (_loc23)
                {
                    case "-1":
                    case "-2":
                    {
                        var _loc33 = new Object();
                        _loc33.spriteType = _loc23;
                        _loc33.gfxID = _loc21;
                        _loc33.scaleX = _loc27;
                        _loc33.scaleY = _loc28;
                        _loc33.noFlip = _loc18;
                        _loc33.cell = _loc11;
                        _loc33.dir = _loc12;
                        _loc33.powerLevel = _loc10[7];
                        _loc33.color1 = _loc10[8];
                        _loc33.color2 = _loc10[9];
                        _loc33.color3 = _loc10[10];
                        _loc33.accessories = _loc10[11];
                        if (this.api.datacenter.Game.isFight)
                        {
                            _loc33.LP = _loc10[12];
                            _loc33.AP = _loc10[13];
                            _loc33.MP = _loc10[14];
                            if (_loc10.length > 18)
                            {
                                _loc33.resistances = new Array(Number(_loc10[15]), Number(_loc10[16]), Number(_loc10[17]), Number(_loc10[18]), Number(_loc10[19]), Number(_loc10[20]), Number(_loc10[21]));
                                _loc33.team = _loc10[22];
                            }
                            else
                            {
                                _loc33.team = _loc10[15];
                            } // end else if
                            _loc33.summoned = bIsSummoned;
                        } // end if
                        if (_loc23 == -1)
                        {
                            _loc31 = this.api.kernel.CharactersManager.createCreature(_loc14, _loc15, _loc33);
                        }
                        else
                        {
                            _loc31 = this.api.kernel.CharactersManager.createMonster(_loc14, _loc15, _loc33);
                        } // end else if
                        break;
                    } 
                    case "-3":
                    {
                        var _loc34 = new Object();
                        _loc34.spriteType = _loc23;
                        _loc34.level = _loc10[7];
                        _loc34.scaleX = _loc27;
                        _loc34.scaleY = _loc28;
                        _loc34.noFlip = _loc18;
                        _loc34.cell = Number(_loc11);
                        _loc34.dir = _loc12;
                        var _loc35 = _loc10[8].split(",");
                        _loc34.color1 = _loc35[0];
                        _loc34.color2 = _loc35[1];
                        _loc34.color3 = _loc35[2];
                        _loc34.accessories = _loc10[9];
                        _loc34.bonusValue = _loc13;
                        var _loc36 = this.sliptGfxData(_loc17);
                        var _loc37 = _loc36.gfx;
                        this.splitGfxForScale(_loc37[0], _loc34);
                        _loc31 = this.api.kernel.CharactersManager.createMonsterGroup(_loc14, _loc15, _loc34);
                        if (this.api.kernel.OptionsManager.getOption("ViewAllMonsterInGroup") == true)
                        {
                            var _loc38 = _loc14;
                            var _loc39 = 1;
                            
                            while (++_loc39, _loc39 < _loc37.length)
                            {
                                if (_loc37[_loc5] == "")
                                {
                                    continue;
                                } // end if
                                this.splitGfxForScale(_loc37[_loc39], _loc34);
                                _loc35 = _loc10[8 + 2 * _loc39].split(",");
                                _loc34.color1 = _loc35[0];
                                _loc34.color2 = _loc35[1];
                                _loc34.color3 = _loc35[2];
                                _loc34.dir = random(4) * 2 + 1;
                                _loc34.accessories = _loc10[9 + 2 * _loc39];
                                var _loc40 = _loc14 + "_" + _loc39;
                                var _loc41 = this.api.kernel.CharactersManager.createMonsterGroup(_loc40, undefined, _loc34);
                                var _loc42 = _loc38;
                                if (random(3) != 0 && _loc39 != 1)
                                {
                                    _loc42 = _loc14 + "_" + (random(_loc39 - 1) + 1);
                                } // end if
                                var _loc43 = random(8);
                                this.api.gfx.addLinkedSprite(_loc40, _loc42, _loc43, _loc41);
                                if (!_global.isNaN(_loc41.scaleX))
                                {
                                    this.api.gfx.setSpriteScale(_loc41.id, _loc41.scaleX, _loc41.scaleY);
                                } // end if
                                switch (_loc36.shape)
                                {
                                    case "circle":
                                    {
                                        _loc43 = _loc39;
                                        break;
                                    } 
                                    case "line":
                                    {
                                        _loc42 = _loc40;
                                        _loc43 = 2;
                                        break;
                                    } 
                                } // End of switch
                            } // end while
                        } // end if
                        break;
                    } 
                    case "-4":
                    {
                        var _loc44 = new Object();
                        _loc44.spriteType = _loc23;
                        _loc44.gfxID = _loc21;
                        _loc44.scaleX = _loc27;
                        _loc44.scaleY = _loc28;
                        _loc44.cell = _loc11;
                        _loc44.dir = _loc12;
                        _loc44.sex = _loc10[7];
                        _loc44.color1 = _loc10[8];
                        _loc44.color2 = _loc10[9];
                        _loc44.color3 = _loc10[10];
                        _loc44.accessories = _loc10[11];
                        _loc44.extraClipID = _loc10[12] != undefined && !_global.isNaN(Number(_loc10[12])) ? (Number(_loc10[12])) : (-1);
                        _loc44.customArtwork = Number(_loc10[13]);
                        _loc31 = this.api.kernel.CharactersManager.createNonPlayableCharacter(_loc14, Number(_loc15), _loc44);
                        break;
                    } 
                    case "-5":
                    {
                        var _loc45 = new Object();
                        _loc45.spriteType = _loc23;
                        _loc45.gfxID = _loc21;
                        _loc45.scaleX = _loc27;
                        _loc45.scaleY = _loc28;
                        _loc45.cell = _loc11;
                        _loc45.dir = _loc12;
                        _loc45.color1 = _loc10[7];
                        _loc45.color2 = _loc10[8];
                        _loc45.color3 = _loc10[9];
                        _loc45.accessories = _loc10[10];
                        _loc45.guildName = _loc10[11];
                        _loc45.emblem = _loc10[12];
                        _loc45.offlineType = _loc10[13];
                        _loc31 = this.api.kernel.CharactersManager.createOfflineCharacter(_loc14, _loc15, _loc45);
                        break;
                    } 
                    case "-6":
                    {
                        var _loc46 = new Object();
                        _loc46.spriteType = _loc23;
                        _loc46.gfxID = _loc21;
                        _loc46.scaleX = _loc27;
                        _loc46.scaleY = _loc28;
                        _loc46.cell = _loc11;
                        _loc46.dir = _loc12;
                        _loc46.level = _loc10[7];
                        if (this.api.datacenter.Game.isFight)
                        {
                            _loc46.LP = _loc10[8];
                            _loc46.AP = _loc10[9];
                            _loc46.MP = _loc10[10];
                            _loc46.resistances = new Array(Number(_loc10[11]), Number(_loc10[12]), Number(_loc10[13]), Number(_loc10[14]), Number(_loc10[15]), Number(_loc10[16]), Number(_loc10[17]));
                            _loc46.team = _loc10[18];
                        }
                        else
                        {
                            _loc46.guildName = _loc10[8];
                            _loc46.emblem = _loc10[9];
                        } // end else if
                        _loc31 = this.api.kernel.CharactersManager.createTaxCollector(_loc14, _loc15, _loc46);
                        break;
                    } 
                    case "-7":
                    case "-8":
                    {
                        var _loc47 = new Object();
                        _loc47.spriteType = _loc23;
                        _loc47.gfxID = _loc21;
                        _loc47.scaleX = _loc27;
                        _loc47.scaleY = _loc28;
                        _loc47.cell = _loc11;
                        _loc47.dir = _loc12;
                        _loc47.sex = _loc10[7];
                        _loc47.powerLevel = _loc10[8];
                        _loc47.accessories = _loc10[9];
                        if (this.api.datacenter.Game.isFight)
                        {
                            _loc47.LP = _loc10[10];
                            _loc47.AP = _loc10[11];
                            _loc47.MP = _loc10[12];
                            _loc47.team = _loc10[20];
                        }
                        else
                        {
                            _loc47.emote = _loc10[10];
                            _loc47.emoteTimer = _loc10[11];
                            _loc47.restrictions = Number(_loc10[12]);
                        } // end else if
                        if (_loc23 == "-8")
                        {
                            _loc47.showIsPlayer = true;
                            var _loc48 = _loc15.split("~");
                            _loc47.monsterID = _loc48[0];
                            _loc47.playerName = _loc48[1];
                        }
                        else
                        {
                            _loc47.showIsPlayer = false;
                            _loc47.monsterID = _loc15;
                        } // end else if
                        _loc31 = this.api.kernel.CharactersManager.createMutant(_loc14, _loc47);
                        break;
                    } 
                    case "-9":
                    {
                        var _loc49 = new Object();
                        _loc49.spriteType = _loc23;
                        _loc49.gfxID = _loc21;
                        _loc49.scaleX = _loc27;
                        _loc49.scaleY = _loc28;
                        _loc49.cell = _loc11;
                        _loc49.dir = _loc12;
                        _loc49.ownerName = _loc10[7];
                        _loc49.level = _loc10[8];
                        _loc49.modelID = _loc10[9];
                        _loc31 = this.api.kernel.CharactersManager.createParkMount(_loc14, _loc15 != "" ? (_loc15) : (this.api.lang.getText("NO_NAME")), _loc49);
                        break;
                    } 
                    case "-10":
                    {
                        var _loc50 = new Object();
                        _loc50.spriteType = _loc23;
                        _loc50.gfxID = _loc21;
                        _loc50.scaleX = _loc27;
                        _loc50.scaleY = _loc28;
                        _loc50.cell = _loc11;
                        _loc50.dir = _loc12;
                        _loc50.level = _loc10[7];
                        _loc50.alignment = new dofus.datacenter.Alignment(Number(_loc10[9]), Number(_loc10[8]));
                        _loc31 = this.api.kernel.CharactersManager.createPrism(_loc14, _loc15, _loc50);
                        break;
                    } 
                    default:
                    {
                        var _loc52 = new Object();
                        _loc52.spriteType = _loc23;
                        _loc52.cell = _loc11;
                        _loc52.scaleX = _loc27;
                        _loc52.scaleY = _loc28;
                        _loc52.dir = _loc12;
                        _loc52.sex = _loc10[7];
                        if (this.api.datacenter.Game.isFight)
                        {
                            _loc52.level = _loc10[8];
                            var _loc51 = _loc10[9];
                            _loc52.color1 = _loc10[10];
                            _loc52.color2 = _loc10[11];
                            _loc52.color3 = _loc10[12];
                            _loc52.accessories = _loc10[13];
                            _loc52.LP = _loc10[14];
                            _loc52.AP = _loc10[15];
                            _loc52.MP = _loc10[16];
                            _loc52.resistances = new Array(Number(_loc10[17]), Number(_loc10[18]), Number(_loc10[19]), Number(_loc10[20]), Number(_loc10[21]), Number(_loc10[22]), Number(_loc10[23]));
                            _loc52.team = _loc10[24];
                            if (_loc10[25].indexOf(",") != -1)
                            {
                                var _loc53 = _loc10[25].split(",");
                                var _loc54 = Number(_loc53[0]);
                                var _loc55 = _global.parseInt(_loc53[1], 16);
                                var _loc56 = _global.parseInt(_loc53[2], 16);
                                var _loc57 = _global.parseInt(_loc53[3], 16);
                                if (_loc55 == -1 || _global.isNaN(_loc55))
                                {
                                    _loc55 = this.api.datacenter.Player.color1;
                                } // end if
                                if (_loc56 == -1 || _global.isNaN(_loc56))
                                {
                                    _loc56 = this.api.datacenter.Player.color2;
                                } // end if
                                if (_loc57 == -1 || _global.isNaN(_loc57))
                                {
                                    _loc57 = this.api.datacenter.Player.color3;
                                } // end if
                                if (!_global.isNaN(_loc54))
                                {
                                    var _loc58 = new dofus.datacenter.Mount(_loc54, Number(_loc21));
                                    _loc58.customColor1 = _loc55;
                                    _loc58.customColor2 = _loc56;
                                    _loc58.customColor3 = _loc57;
                                    _loc52.mount = _loc58;
                                } // end if
                            }
                            else
                            {
                                var _loc59 = Number(_loc10[25]);
                                if (!_global.isNaN(_loc59))
                                {
                                    _loc52.mount = new dofus.datacenter.Mount(_loc59, Number(_loc21));
                                } // end if
                            } // end else if
                        }
                        else
                        {
                            _loc51 = _loc10[8];
                            _loc52.color1 = _loc10[9];
                            _loc52.color2 = _loc10[10];
                            _loc52.color3 = _loc10[11];
                            _loc52.accessories = _loc10[12];
                            _loc52.aura = _loc10[13];
                            _loc52.emote = _loc10[14];
                            _loc52.emoteTimer = _loc10[15];
                            _loc52.guildName = _loc10[16];
                            _loc52.emblem = _loc10[17];
                            _loc52.restrictions = _loc10[18];
                            if (_loc10[19].indexOf(",") != -1)
                            {
                                var _loc60 = _loc10[19].split(",");
                                var _loc61 = Number(_loc60[0]);
                                var _loc62 = _global.parseInt(_loc60[1], 16);
                                var _loc63 = _global.parseInt(_loc60[2], 16);
                                var _loc64 = _global.parseInt(_loc60[3], 16);
                                if (_loc62 == -1 || _global.isNaN(_loc62))
                                {
                                    _loc62 = this.api.datacenter.Player.color1;
                                } // end if
                                if (_loc63 == -1 || _global.isNaN(_loc63))
                                {
                                    _loc63 = this.api.datacenter.Player.color2;
                                } // end if
                                if (_loc64 == -1 || _global.isNaN(_loc64))
                                {
                                    _loc64 = this.api.datacenter.Player.color3;
                                } // end if
                                if (!_global.isNaN(_loc61))
                                {
                                    var _loc65 = new dofus.datacenter.Mount(_loc61, Number(_loc21));
                                    _loc65.customColor1 = _loc62;
                                    _loc65.customColor2 = _loc63;
                                    _loc65.customColor3 = _loc64;
                                    _loc52.mount = _loc65;
                                } // end if
                            }
                            else
                            {
                                var _loc66 = Number(_loc10[19]);
                                if (!_global.isNaN(_loc66))
                                {
                                    _loc52.mount = new dofus.datacenter.Mount(_loc66, Number(_loc21));
                                } // end if
                            } // end else if
                        } // end else if
                        if (_loc7)
                        {
                            var _loc32 = [_loc14, this.createTransitionEffect(), _loc11, 10];
                        } // end if
                        var _loc67 = _loc51.split(",");
                        _loc52.alignment = new dofus.datacenter.Alignment(Number(_loc67[0]), Number(_loc67[1]));
                        _loc52.rank = new dofus.datacenter.Rank(Number(_loc67[2]));
                        _loc52.alignment.fallenAngelDemon = _loc67[4] == 1;
                        if (_loc67.length > 3 && _loc14 != this.api.datacenter.Player.ID)
                        {
                            if (this.api.lang.getAlignmentCanViewPvpGain(this.api.datacenter.Player.alignment.index, Number(_loc52.alignment.index)))
                            {
                                var _loc68 = Number(_loc67[3]) - _global.parseInt(_loc14);
                                var _loc69 = this.api.lang.getConfigText("PVP_VIEW_BONUS_MINOR_LIMIT");
                                var _loc70 = this.api.lang.getConfigText("PVP_VIEW_BONUS_MINOR_LIMIT_PRC");
                                var _loc71 = this.api.lang.getConfigText("PVP_VIEW_BONUS_MAJOR_LIMIT");
                                var _loc72 = this.api.lang.getConfigText("PVP_VIEW_BONUS_MAJOR_LIMIT_PRC");
                                var _loc73 = 0;
                                if (this.api.datacenter.Player.Level * (1 - _loc70 / 100) > _loc68)
                                {
                                    _loc73 = -1;
                                } // end if
                                if (this.api.datacenter.Player.Level - _loc68 > _loc69)
                                {
                                    _loc73 = -1;
                                } // end if
                                if (this.api.datacenter.Player.Level * (1 + _loc72 / 100) < _loc68)
                                {
                                    _loc73 = 1;
                                } // end if
                                if (this.api.datacenter.Player.Level - _loc68 < _loc71)
                                {
                                    _loc73 = 1;
                                } // end if
                                _loc52.pvpGain = _loc73;
                            } // end if
                        } // end if
                        if (!this.api.datacenter.Game.isFight && (_global.parseInt(_loc14, 10) != this.api.datacenter.Player.ID && ((this.api.datacenter.Player.alignment.index == 1 || this.api.datacenter.Player.alignment.index == 2) && ((_loc52.alignment.index == 1 || _loc52.alignment.index == 2) && (_loc52.alignment.index != this.api.datacenter.Player.alignment.index && (_loc52.rank.value && this.api.datacenter.Map.bCanAttack))))))
                        {
                            if (this.api.datacenter.Player.rank.value > _loc52.rank.value)
                            {
                                this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_NEW_ENEMY_WEAK);
                            } // end if
                            if (this.api.datacenter.Player.rank.value < _loc52.rank.value)
                            {
                                this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_NEW_ENEMY_STRONG);
                            } // end if
                        } // end if
                        var _loc74 = this.sliptGfxData(_loc17);
                        var _loc75 = _loc74.gfx;
                        this.splitGfxForScale(_loc75[0], _loc52);
                        _loc52.title = _loc25;
                        _loc31 = this.api.kernel.CharactersManager.createCharacter(_loc14, _loc15, _loc52);
                        (dofus.datacenter.Character)(_loc31).isClear = false;
                        _loc31.allowGhostMode = _loc19;
                        var _loc76 = _loc14;
                        var _loc77 = _loc74.shape == "circle" ? (0) : (2);
                        var _loc78 = 1;
                        
                        while (++_loc78, _loc78 < _loc75.length)
                        {
                            if (_loc75[_loc78] == "")
                            {
                                continue;
                            } // end if
                            var _loc79 = _loc14 + "_" + _loc78;
                            var _loc80 = new Object();
                            this.splitGfxForScale(_loc75[_loc78], _loc80);
                            var _loc81 = new ank.battlefield.datacenter.Sprite(_loc79, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + _loc80.gfxID + ".swf");
                            _loc81.allDirections = false;
                            this.api.gfx.addLinkedSprite(_loc79, _loc76, _loc77, _loc81);
                            if (!_global.isNaN(_loc80.scaleX))
                            {
                                this.api.gfx.setSpriteScale(_loc81.id, _loc80.scaleX, _loc80.scaleY);
                            } // end if
                            switch (_loc74.shape)
                            {
                                case "circle":
                                {
                                    _loc77 = _loc78;
                                    break;
                                } 
                                case "line":
                                {
                                    _loc76 = _loc79;
                                    _loc77 = 2;
                                    break;
                                } 
                            } // End of switch
                        } // end while
                        break;
                    } 
                } // End of switch
                this.onSpriteMovement(_loc8, _loc31, _loc32);
                continue;
            } // end if
            var _loc82 = _loc6.substr(1);
            var _loc83 = this.api.datacenter.Sprites.getItemAt(_loc82);
            this.onSpriteMovement(_loc8, _loc83);
        } // end while
    };
    _loc1.onCellData = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = _loc3[_loc4].split(";");
            var _loc6 = Number(_loc5[0]);
            var _loc7 = _loc5[1].substring(0, 10);
            var _loc8 = _loc5[1].substr(10);
            var _loc9 = _loc5[2] == "0" ? (0) : (1);
            this.api.gfx.updateCell(_loc6, _loc7, _loc8, _loc9);
        } // end while
    };
    _loc1.onZoneData = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = _loc3[_loc4];
            var _loc6 = _loc5.charAt(0) == "+" ? (true) : (false);
            var _loc7 = _loc5.substr(1).split(";");
            var _loc8 = Number(_loc7[0]);
            var _loc9 = Number(_loc7[1]);
            var _loc10 = _loc7[2];
            if (_loc6)
            {
                this.api.gfx.drawZone(_loc8, 0, _loc9, _loc10, dofus.Constants.ZONE_COLOR[_loc10]);
                continue;
            } // end if
            this.api.gfx.clearZone(_loc8, _loc9, _loc10);
        } // end while
    };
    _loc1.onCellObject = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = sExtraData.substr(1).split("|");
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc4.length)
        {
            var _loc6 = _loc4[_loc5].split(";");
            var _loc7 = Number(_loc6[0]);
            var _loc8 = _global.parseInt(_loc6[1]);
            if (_loc3)
            {
                var _loc9 = new dofus.datacenter.Item(0, _loc8);
                var _loc10 = Number(_loc6[2]);
                switch (_loc10)
                {
                    case 0:
                    {
                        this.api.gfx.updateCellObjectExternalWithExternalClip(_loc7, _loc9.iconFile, 1, true, true, _loc9);
                        break;
                    } 
                    case 1:
                    {
                        if (this.api.gfx.mapHandler.getCellData(_loc7).layerObjectExternalData.unicID != _loc8)
                        {
                            this.api.gfx.updateCellObjectExternalWithExternalClip(_loc7, _loc9.iconFile, 1, true, false, _loc9);
                        }
                        else
                        {
                            _loc9 = this.api.gfx.mapHandler.getCellData(_loc7).layerObjectExternalData;
                        } // end else if
                        _loc9.durability = Number(_loc6[3]);
                        _loc9.durabilityMax = Number(_loc6[4]);
                        break;
                    } 
                } // End of switch
                continue;
            } // end if
            this.api.gfx.initializeCell(_loc7, 1);
        } // end while
    };
    _loc1.onFrameObject2 = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = _loc3[_loc4].split(";");
            var _loc6 = Number(_loc5[0]);
            var _loc7 = _loc5[1];
            var _loc8 = _loc5[2] != undefined;
            var _loc9 = _loc5[2] == "1" ? (true) : (false);
            if (_loc8)
            {
                this.api.gfx.setObject2Interactive(_loc6, _loc9, 2);
            } // end if
            this.api.gfx.setObject2Frame(_loc6, _loc7);
        } // end while
    };
    _loc1.onFrameObjectExternal = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = _loc3[_loc4].split(";");
            var _loc6 = Number(_loc5[0]);
            var _loc7 = Number(_loc5[1]);
            this.api.gfx.setObjectExternalFrame(_loc6, _loc7);
        } // end while
    };
    _loc1.onEffect = function (sExtraData)
    {
        var _loc3 = sExtraData.split(";");
        var _loc4 = _loc3[0];
        var _loc5 = _loc3[1].split(",");
        var _loc6 = _loc3[2];
        var _loc7 = _loc3[3];
        var _loc8 = _loc3[4];
        var _loc9 = _loc3[5];
        var _loc10 = Number(_loc3[6]);
        var _loc11 = _loc3[7];
        var _loc12 = 0;
        
        while (++_loc12, _loc12 < _loc5.length)
        {
            var _loc13 = _loc5[_loc12];
            if (_loc13 == this.api.datacenter.Game.currentPlayerID)
            {
                ++_loc10;
            } // end if
            var _loc14 = new dofus.datacenter.Effect(Number(_loc4), Number(_loc6), Number(_loc7), Number(_loc8), _loc9, Number(_loc10), Number(_loc11));
            var _loc15 = this.api.datacenter.Sprites.getItemAt(_loc13);
            _loc15.EffectsManager.addEffect(_loc14);
        } // end while
    };
    _loc1.onClearAllEffect = function (sExtraData)
    {
        var _loc3 = this.api.datacenter.Sprites;
        for (var a in _loc3)
        {
            _loc3[a].EffectsManager.terminateAllEffects();
        } // end of for...in
    };
    _loc1.onChallenge = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = sExtraData.substr(1).split("|");
        var _loc5 = _loc4.shift().split(";");
        var _loc6 = Number(_loc5[0]);
        var _loc7 = Number(_loc5[1]);
        var _loc8 = (Math.cos(_loc6) + 1) * 8388607;
        if (_loc3)
        {
            var _loc9 = new dofus.datacenter.Challenge(_loc6, _loc7);
            this.api.datacenter.Challenges.addItemAt(_loc6, _loc9);
            var _loc10 = 0;
            
            while (++_loc10, _loc10 < _loc4.length)
            {
                var _loc11 = _loc4[_loc10].split(";");
                var _loc12 = _loc11[0];
                var _loc13 = Number(_loc11[1]);
                var _loc14 = Number(_loc11[2]);
                var _loc15 = Number(_loc11[3]);
                var _loc16 = dofus.Constants.getTeamFileFromType(_loc14, _loc15);
                var _loc17 = new dofus.datacenter.Team(_loc12, ank.battlefield.mc.Sprite, _loc16, _loc13, _loc8, _loc14, _loc15);
                _loc9.addTeam(_loc17);
                this.api.gfx.addSprite(_loc17.id, _loc17);
            } // end while
        }
        else
        {
            var _loc18 = this.api.datacenter.Challenges.getItemAt(_loc6).teams;
            for (var k in _loc18)
            {
                var _loc19 = _loc18[k];
                this.api.gfx.removeSprite(_loc19.id);
            } // end of for...in
            this.api.datacenter.Challenges.removeItemAt(_loc6);
        } // end else if
    };
    _loc1.onTeam = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3.shift());
        var _loc5 = this.api.datacenter.Sprites.getItemAt(_loc4);
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc3.length)
        {
            var _loc7 = _loc3[_loc6].split(";");
            var _loc8 = _loc7[0].charAt(0) == "+";
            var _loc9 = _loc7[0].substr(1);
            var _loc10 = _loc7[1];
            var _loc11 = _loc7[2];
            var _loc12 = _loc10.split(",");
            var _loc13 = Number(_loc10);
            if (_loc12.length > 1)
            {
                _loc10 = this.api.lang.getFullNameText(_loc12);
            }
            else if (!_global.isNaN(_loc13))
            {
                _loc10 = this.api.lang.getMonstersText(_loc13).n;
            } // end else if
            if (_loc8)
            {
                var _loc14 = new Object();
                _loc14.id = _loc9;
                _loc14.name = _loc10;
                _loc14.level = _loc11;
                _loc5.addPlayer(_loc14);
                continue;
            } // end if
            _loc5.removePlayer(_loc9);
        } // end while
    };
    _loc1.onFightOption = function (sExtraData)
    {
        var _loc3 = sExtraData.substr(2);
        var _loc4 = this.api.datacenter.Sprites.getItemAt(_loc3);
        if (_loc4 != undefined)
        {
            var _loc5 = sExtraData.charAt(0) == "+";
            var _loc6 = sExtraData.charAt(1);
            switch (_loc6)
            {
                case "H":
                {
                    _loc4.options[dofus.datacenter.Team.OPT_NEED_HELP] = _loc5;
                    break;
                } 
                case "S":
                {
                    _loc4.options[dofus.datacenter.Team.OPT_BLOCK_SPECTATOR] = _loc5;
                    break;
                } 
                case "A":
                {
                    _loc4.options[dofus.datacenter.Team.OPT_BLOCK_JOINER] = _loc5;
                    break;
                } 
                case "P":
                {
                    _loc4.options[dofus.datacenter.Team.OPT_BLOCK_JOINER_EXCEPT_PARTY_MEMBER] = _loc5;
                    break;
                } 
            } // End of switch
            this.api.gfx.addSpriteOverHeadItem(_loc3, "FightOptions", dofus.graphics.battlefield.FightOptionsOverHead, [_loc4], undefined);
        } // end if
    };
    _loc1.onLeave = function ()
    {
        this.api.datacenter.Game.currentPlayerID = undefined;
        this.api.ui.getUIComponent("Banner").stopTimer();
        this.api.ui.getUIComponent("Banner").hideRightPanel();
        this.api.ui.unloadUIComponent("Timeline");
        this.api.ui.unloadUIComponent("StringCourse");
        this.api.ui.unloadUIComponent("PlayerInfos");
        this.api.ui.unloadUIComponent("SpriteInfos");
        this.aks.GameActions.onActionsFinish(String(this.api.datacenter.Player.ID));
        this.api.datacenter.Player.reset();
        var _loc2 = (dofus.graphics.gapi.ui.FightChallenge)((dofus.graphics.gapi.ui.FightChallenge)(this.api.ui.getUIComponent("FightChallenge")));
        _loc2.cleanChallenge();
        this.create();
    };
    _loc1.onEnd = function (sExtraData)
    {
        if (this.api.kernel.MapsServersManager.isBuilding)
        {
            this.addToQueue({object: this, method: this.onEnd, params: [sExtraData]});
            return;
        } // end if
        this._bIsBusy = true;
        var _loc3 = (dofus.graphics.gapi.ui.FightChallenge)((dofus.graphics.gapi.ui.FightChallenge)(this.api.ui.getUIComponent("FightChallenge")));
        this.api.kernel.StreamingDisplayManager.onFightEnd();
        var _loc4 = {winners: [], loosers: [], collectors: [], challenges: _loc3.challenges.clone()};
        this.api.datacenter.Game.results = _loc4;
        _loc3.cleanChallenge();
        var _loc5 = sExtraData.split("|");
        var _loc6 = -1;
        if (!_global.isNaN(Number(_loc5[0])))
        {
            _loc4.duration = Number(_loc5[0]);
        }
        else
        {
            var _loc7 = _loc5[0].split(";");
            _loc4.duration = Number(_loc7[0]);
            _loc6 = Number(_loc7[1]);
        } // end else if
        this.api.datacenter.Basics.aks_game_end_bonus = _loc6;
        var _loc8 = Number(_loc5[1]);
        var _loc9 = Number(_loc5[2]);
        _loc4.fightType = _loc9;
        var _loc10 = new ank.utils.ExtendedArray();
        var _loc11 = 0;
        this.parsePlayerData(_loc4, 3, _loc8, _loc5, _loc9, _loc11, _loc10);
    };
    _loc1.parsePlayerData = function (oResults, nStartIndex, nSenderID, aTmp, nFightType, nKamaDrop, eaFightDrop)
    {
        var _loc9 = nStartIndex;
        var _loc10 = aTmp[_loc9].split(";");
        var _loc11 = new Object();
        if (Number(_loc10[0]) != 6)
        {
            _loc11.id = Number(_loc10[1]);
            if (_loc11.id == this.api.datacenter.Player.ID)
            {
                if (Number(_loc10[0]) == 0)
                {
                    this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_FIGHT_LOST);
                }
                else
                {
                    this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_FIGHT_WON);
                } // end if
            } // end else if
            var _loc13 = this.api.kernel.CharactersManager.getNameFromData(_loc10[2]);
            _loc11.name = _loc13.name;
            _loc11.type = _loc13.type;
            _loc11.level = Number(_loc10[3]);
            _loc11.bDead = _loc10[4] == "1" ? (true) : (false);
            switch (nFightType)
            {
                case 0:
                {
                    _loc11.minxp = Number(_loc10[5]);
                    _loc11.xp = Number(_loc10[6]);
                    _loc11.maxxp = Number(_loc10[7]);
                    _loc11.winxp = Number(_loc10[8]);
                    _loc11.guildxp = Number(_loc10[9]);
                    _loc11.mountxp = Number(_loc10[10]);
                    var _loc12 = _loc10[11].split(",");
                    if (_loc11.id == this.api.datacenter.Player.ID && _loc12.length > 10)
                    {
                        this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_GREAT_DROP);
                    } // end if
                    _loc11.kama = _loc10[12];
                    break;
                } 
                case 1:
                {
                    _loc11.minhonour = Number(_loc10[5]);
                    _loc11.honour = Number(_loc10[6]);
                    _loc11.maxhonour = Number(_loc10[7]);
                    _loc11.winhonour = Number(_loc10[8]);
                    _loc11.rank = Number(_loc10[9]);
                    _loc11.disgrace = Number(_loc10[10]);
                    _loc11.windisgrace = Number(_loc10[11]);
                    _loc11.maxdisgrace = this.api.lang.getMaxDisgracePoints();
                    _loc11.mindisgrace = 0;
                    _loc12 = _loc10[12].split(",");
                    if (_loc11.id == this.api.datacenter.Player.ID && _loc12.length > 10)
                    {
                        this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_GREAT_DROP);
                    } // end if
                    _loc11.kama = _loc10[13];
                    _loc11.minxp = Number(_loc10[14]);
                    _loc11.xp = Number(_loc10[15]);
                    _loc11.maxxp = Number(_loc10[16]);
                    _loc11.winxp = Number(_loc10[17]);
                    break;
                } 
            } // End of switch
        }
        else
        {
            _loc12 = _loc10[1].split(",");
            _loc11.kama = _loc10[2];
            nKamaDrop = nKamaDrop + Number(_loc11.kama);
        } // end else if
        _loc11.items = new Array();
        var _loc14 = _loc12.length;
        while (--_loc14 >= 0)
        {
            var _loc15 = _loc12[_loc14].split("~");
            var _loc16 = Number(_loc15[0]);
            var _loc17 = Number(_loc15[1]);
            if (_global.isNaN(_loc16))
            {
                break;
            } // end if
            if (_loc16 == 0)
            {
                continue;
            } // end if
            var _loc18 = new dofus.datacenter.Item(0, _loc16, _loc17);
            _loc11.items.push(_loc18);
        } // end while
        switch (Number(_loc10[0]))
        {
            case 0:
            {
                oResults.loosers.push(_loc11);
                break;
            } 
            case 2:
            {
                oResults.winners.push(_loc11);
                break;
            } 
            case 5:
            {
                oResults.collectors.push(_loc11);
                break;
            } 
            case 6:
            {
                eaFightDrop = eaFightDrop.concat(_loc11.items);
            } 
        } // End of switch
        ++_loc9;
        if (_loc9 < aTmp.length)
        {
            this.addToQueue({object: this, method: this.parsePlayerData, params: [oResults, _loc9, nSenderID, aTmp, nFightType, nKamaDrop, eaFightDrop]});
        }
        else
        {
            this.onParseItemEnd(nSenderID, oResults, eaFightDrop, nKamaDrop);
        } // end else if
    };
    _loc1.onParseItemEnd = function (nSenderID, oResults, eaFightDrop, nKamaDrop)
    {
        if (eaFightDrop.length)
        {
            var _loc6 = Math.ceil(eaFightDrop.length / oResults.winners.length);
            var _loc7 = 0;
            
            while (++_loc7, _loc7 < oResults.winners.length)
            {
                var _loc8 = eaFightDrop.length;
                oResults.winners[_loc7].kama = Math.ceil(nKamaDrop / _loc6);
                if (_loc7 == oResults.winners.length - 1)
                {
                    _loc6 = _loc8;
                } // end if
                var _loc9 = _loc8 - _loc6;
                
                while (++_loc9, _loc9 < _loc8)
                {
                    oResults.winners[_loc7].items.push(eaFightDrop.pop());
                } // end while
            } // end while
        } // end if
        if (nSenderID == this.api.datacenter.Player.ID)
        {
            this.aks.GameActions.onActionsFinish(String(nSenderID));
        } // end if
        this.api.datacenter.Game.isRunning = false;
        var _loc10 = this.api.datacenter.Sprites.getItemAt(nSenderID).sequencer;
        this._bIsBusy = false;
        if (_loc10 != undefined)
        {
            _loc10.addAction(false, this.api.kernel.GameManager, this.api.kernel.GameManager.terminateFight);
            _loc10.execute(false);
        }
        else
        {
            ank.utils.Logger.err("[AKS.Game.onEnd] Impossible de trouver le sequencer");
            ank.utils.Timer.setTimer(this, "game", this.api.kernel.GameManager, this.api.kernel.GameManager.terminateFight, 500);
        } // end else if
        this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_ENDFIGHT);
    };
    _loc1.onExtraClip = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0];
        var _loc5 = _loc3[1].split(";");
        var _loc6 = dofus.Constants.EXTRA_PATH + _loc4 + ".swf";
        var _loc7 = _loc4 == "-";
        for (var k in _loc5)
        {
            var _loc8 = _loc5[k];
            if (_loc7)
            {
                this.api.gfx.removeSpriteExtraClip(_loc8, false);
                continue;
            } // end if
            this.api.gfx.addSpriteExtraClip(_loc8, _loc6, undefined, false);
        } // end of for...in
    };
    _loc1.onPVP = function (sExtraData, bEnabled)
    {
        if (!bEnabled)
        {
            var _loc4 = Number(sExtraData);
            this.api.kernel.showMessage(undefined, this.api.lang.getText("ASK_DISABLE_PVP", [_loc4]), "CAUTION_YESNO", {name: "DisabledPVP", listener: this});
        }
        else
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("ASK_ENABLED_PVP"), "CAUTION_YESNO", {name: "EnabledPVP", listener: this});
        } // end else if
    };
    _loc1.onGameOver = function ()
    {
        this.api.network.softDisconnect();
        this.api.ui.loadUIComponent("GameOver", "GameOver", undefined, {bAlwaysOnTop: true});
    };
    _loc1.onCreateSolo = function ()
    {
        this.api.datacenter.Player.InteractionsManager.setState(false);
        this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT);
        this.api.ui.removeCursor();
        this.api.ui.getUIComponent("Banner").shortcuts.setCurrentTab("Items");
        this.api.datacenter.Basics.gfx_isSpritesHidden = false;
        this.api.gfx.spriteHandler.unmaskAllSprites();
        if (!this.api.gfx.isMapBuild)
        {
            if (this.api.ui.getUIComponent("Banner") == undefined)
            {
                this.api.kernel.OptionsManager.applyAllOptions();
                this.api.ui.loadUIComponent("Banner", "Banner", {data: this.api.datacenter.Player}, {bAlwaysOnTop: true});
                this.api.ui.setScreenSize(742, 432);
            } // end if
            this.addToQueue({object: this, method: this.getMapData, params: [this.api.datacenter.Map.id]});
        }
        else
        {
            var _loc2 = this.api.ui.getUIComponent("Banner");
            _loc2.showPoints(false);
            _loc2.showNextTurnButton(false);
            _loc2.showGiveUpButton(false);
            this.api.ui.unloadUIComponent("FightOptionButtons");
            this.api.ui.unloadUIComponent("ChallengeMenu");
            this.api.gfx.cleanMap(2);
            this.getMapData(this.api.datacenter.Map.id);
        } // end else if
    };
    _loc1.onSpriteMovement = function (bAdd, oSprite, aEffect)
    {
        if (oSprite instanceof dofus.datacenter.Character)
        {
            this.api.datacenter.Game.playerCount = this.api.datacenter.Game.playerCount + (bAdd ? (1) : (-1));
        } // end if
        if (bAdd)
        {
            if (aEffect != undefined)
            {
                this.api.gfx.spriteLaunchVisualEffect.apply(this.api.gfx, aEffect);
            } // end if
            this.api.gfx.addSprite(oSprite.id);
            if (!_global.isNaN(oSprite.scaleX))
            {
                this.api.gfx.setSpriteScale(oSprite.id, oSprite.scaleX, oSprite.scaleY);
            } // end if
            if (oSprite instanceof dofus.datacenter.OfflineCharacter)
            {
                oSprite.mc.addExtraClip(dofus.Constants.EXTRA_PATH + oSprite.offlineType + ".swf", undefined, true);
                return;
            } // end if
            if (oSprite instanceof dofus.datacenter.NonPlayableCharacter)
            {
                if (!_global.isNaN(oSprite.extraClipID))
                {
                    this.api.gfx.addSpriteExtraClip(oSprite.id, dofus.Constants.EXTRA_PATH + oSprite.extraClipID + ".swf", undefined, false);
                    return;
                } // end if
            } // end if
            if (this.api.datacenter.Game.isRunning)
            {
                this.api.gfx.addSpriteExtraClip(oSprite.id, dofus.Constants.CIRCLE_FILE, dofus.Constants.TEAMS_COLOR[oSprite.Team]);
            }
            else if (oSprite.Aura != 0 && (oSprite.Aura != undefined && this.api.kernel.OptionsManager.getOption("Aura")))
            {
                this.api.gfx.addSpriteExtraClip(oSprite.id, dofus.Constants.AURA_PATH + oSprite.Aura + ".swf", undefined, true);
            } // end else if
            if (oSprite.id == this.api.datacenter.Player.ID)
            {
                this.api.ui.getUIComponent("Banner").updateLocalPlayer();
            } // end if
        }
        else if (!this.api.datacenter.Game.isRunning)
        {
            this.api.gfx.removeSprite(oSprite.id);
        }
        else
        {
            var _loc5 = oSprite.sequencer;
            var _loc6 = oSprite.mc;
            _loc5.addAction(false, this.api.kernel, this.api.kernel.showMessage, [undefined, this.api.lang.getText("LEAVE_GAME", [oSprite.name]), "INFO_CHAT"]);
            _loc5.addAction(false, this.api.ui.getUIComponent("Timeline"), this.api.ui.getUIComponent("Timeline").hideItem, [oSprite.id]);
            _loc5.addAction(true, _loc6, _loc6.setAnim, ["Die"], 1500);
            if (oSprite.hasCarriedChild())
            {
                this.api.gfx.uncarriedSprite(oSprite.carriedChild.id, oSprite.cellNum, false, _loc5);
                _loc5.addAction(false, this.api.gfx, this.api.gfx.addSpriteExtraClip, [oSprite.carriedChild.id, dofus.Constants.CIRCLE_FILE, dofus.Constants.TEAMS_COLOR[oSprite.carriedChild.Team]]);
            } // end if
            _loc5.addAction(false, _loc6, _loc6.clear);
            _loc5.execute();
            if (this.api.datacenter.Game.currentPlayerID == oSprite.id)
            {
                this.api.ui.getUIComponent("Banner").stopTimer();
                this.api.ui.getUIComponent("Timeline").stopChrono();
            } // end else if
        } // end else if
        if (!this.api.datacenter.Game.isFight)
        {
            var _loc7 = this.api.datacenter.Game.playerCount;
            var _loc8 = this.api.kernel.OptionsManager.getOption("CreaturesMode");
            var _loc9 = _loc8 - 2;
            if (_loc7 >= _loc8)
            {
                var _loc10 = this.api.datacenter.Sprites.getItems();
                for (var k in _loc10)
                {
                    var _loc11 = _loc10[k];
                    if (!(_loc11 instanceof dofus.datacenter.Character))
                    {
                        continue;
                    } // end if
                    if (!_loc11.canSwitchInCreaturesMode)
                    {
                        continue;
                    } // end if
                    if (_loc11 instanceof dofus.datacenter.Mutant)
                    {
                        continue;
                    } // end if
                    if (!_loc11.bInCreaturesMode)
                    {
                        _loc11.tmpGfxFile = _loc11.gfxFile;
                        _loc11.tmpMount = _loc11.mount;
                        _loc11.mount = undefined;
                        var _loc12 = dofus.Constants.CLIPS_PERSOS_PATH + _loc11.Guild + "2.swf";
                        this.api.gfx.setSpriteGfx(_loc11.id, _loc12);
                        _loc11.bInCreaturesMode = true;
                    } // end if
                } // end of for...in
                this.api.datacenter.Game.isInCreaturesMode = true;
            } // end if
            if (_loc7 < _loc9)
            {
                var _loc13 = this.api.datacenter.Sprites.getItems();
                for (var k in _loc13)
                {
                    var _loc14 = _loc13[k];
                    if (!(_loc14 instanceof dofus.datacenter.Character))
                    {
                        continue;
                    } // end if
                    if (!_loc14.canSwitchInCreaturesMode)
                    {
                        continue;
                    } // end if
                    if (_loc14 instanceof dofus.datacenter.Mutant)
                    {
                        continue;
                    } // end if
                    if (_loc14.bInCreaturesMode)
                    {
                        _loc14.mount = _loc14.tmpMount;
                        delete _loc14.tmpMount;
                        var _loc15 = _loc14.tmpGfxFile == undefined ? (_loc14.gfxFile) : (_loc14.tmpGfxFile);
                        delete _loc14.tmpGfxFile;
                        this.api.gfx.setSpriteGfx(_loc14.id, _loc15);
                        _loc14.bInCreaturesMode = false;
                    } // end if
                } // end of for...in
                this.api.datacenter.Game.isInCreaturesMode = false;
            } // end if
        } // end if
    };
    _loc1.onFlag = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0];
        var _loc5 = Number(_loc3[1]);
        var _loc6 = this.api.datacenter.Sprites.getItemAt(_loc4);
        var _loc7 = new ank.battlefield.datacenter.VisualEffect();
        _loc7.file = dofus.Constants.CLIPS_PATH + "flag.swf";
        _loc7.bInFrontOfSprite = true;
        _loc7.bTryToBypassContainerColor = true;
        this.api.kernel.showMessage(undefined, this.api.lang.getText("PLAYER_SET_FLAG", [_loc6.name, _loc5]), "INFO_CHAT");
        this.api.gfx.spriteLaunchVisualEffect(_loc4, _loc7, _loc5, 11, undefined, undefined, undefined, true);
    };
    _loc1.onFightChallenge = function (sExtraData)
    {
        var _loc3 = sExtraData.split(";");
        if (!this.api.ui.getUIComponent("FightChallenge"))
        {
            this.api.ui.loadUIComponent("FightChallenge", "FightChallenge");
        } // end if
        var _loc4 = new dofus.datacenter.FightChallengeData(_global.parseInt(_loc3[0]), _loc3[1] == "1", _global.parseInt(_loc3[2]), _global.parseInt(_loc3[3]), _global.parseInt(_loc3[4]), _global.parseInt(_loc3[5]), _global.parseInt(_loc3[6]));
        (dofus.graphics.gapi.ui.FightChallenge)((dofus.graphics.gapi.ui.FightChallenge)(this.api.ui.getUIComponent("FightChallenge"))).addChallenge(_loc4);
    };
    _loc1.onFightChallengeUpdate = function (sExtraData, success)
    {
        var _loc4 = _global.parseInt(sExtraData);
        (dofus.graphics.gapi.ui.FightChallenge)((dofus.graphics.gapi.ui.FightChallenge)(this.api.ui.getUIComponent("FightChallenge"))).updateChallenge(_loc4, success);
        var _loc5 = success ? (this.api.lang.getText("FIGHT_CHALLENGE_DONE")) : (this.api.lang.getText("FIGHT_CHALLENGE_FAILED"));
        _loc5 = _loc5 + (" : " + this.api.lang.getFightChallenge(_loc4).n);
        this.api.kernel.showMessage(undefined, _loc5, "INFO_CHAT");
    };
    _loc1.sliptGfxData = function (sGfx)
    {
        if (sGfx.indexOf(",") != -1)
        {
            var _loc3 = sGfx.split(",");
            return ({shape: "circle", gfx: _loc3});
        }
        else if (sGfx.indexOf(":") != -1)
        {
            var _loc4 = sGfx.split(":");
            return ({shape: "line", gfx: _loc4});
        } // end else if
        return ({shape: "none", gfx: [sGfx]});
    };
    _loc1.createTransitionEffect = function ()
    {
        var _loc2 = new ank.battlefield.datacenter.VisualEffect();
        _loc2.id = 5;
        _loc2.file = dofus.Constants.SPELLS_PATH + "transition.swf";
        _loc2.level = 5;
        _loc2.params = [];
        _loc2.bInFrontOfSprite = true;
        _loc2.bTryToBypassContainerColor = false;
        return (_loc2);
    };
    _loc1.splitGfxForScale = function (sGfxInput, oData)
    {
        var _loc4 = sGfxInput.split("^");
        var _loc5 = _loc4.length == 2 ? (_loc4[0]) : (sGfxInput);
        var _loc6 = 100;
        var _loc7 = 100;
        if (_loc4.length == 2)
        {
            var _loc8 = _loc4[1];
            if (_global.isNaN(Number(_loc8)))
            {
                var _loc9 = _loc8.split("x");
                _loc6 = _loc9.length == 2 ? (Number(_loc9[0])) : (100);
                _loc7 = _loc9.length == 2 ? (Number(_loc9[1])) : (100);
            }
            else
            {
                _loc7 = Number(_loc8);
                _loc6 = Number(_loc8);
            } // end if
        } // end else if
        oData.gfxID = _loc5;
        oData.scaleX = _loc6;
        oData.scaleY = _loc7;
    };
    _loc1.cancel = function (oEvent)
    {
        
        
        oEvent.target._name;
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoEnabledPVP":
            {
                this.api.network.Game.enabledPVPMode(true);
                break;
            } 
            case "AskYesNoDisabledPVP":
            {
                this.api.network.Game.enabledPVPMode(false);
                break;
            } 
        } // End of switch
    };
    _loc1.no = function (oEvent)
    {
        
        
        oEvent.target._name;
    };
    _loc1.addProperty("isBusy", _loc1.__get__isBusy, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.aks.Game = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).TYPE_SOLO = 1;
    (_global.dofus.aks.Game = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).TYPE_FIGHT = 2;
    _loc1._bIsBusy = false;
    _loc1.nLastMapIdReceived = -1;
} // end if
#endinitclip
