// Action script...

// [Initial MovieClip Action of sprite 938]
#initclip 150
class dofus.aks.Game extends dofus.aks.Handler
{
    var aks, api, addToQueue;
    function Game(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function create()
    {
        aks.send("GC" + dofus.aks.Game.TYPE_SOLO);
    } // End of the function
    function leave(sSpriteID)
    {
        aks.send("GQ" + (sSpriteID == undefined ? ("") : (sSpriteID)));
    } // End of the function
    function setPlayerPosition(nCellNum)
    {
        aks.send("Gp" + nCellNum, false);
    } // End of the function
    function ready(bReady)
    {
        aks.send("GR" + (bReady ? ("1") : ("0")));
    } // End of the function
    function getMapData(nMapID)
    {
        aks.send("GD" + (nMapID != undefined ? (String(nMapID)) : ("")));
    } // End of the function
    function getExtraInformations()
    {
        aks.send("GI");
    } // End of the function
    function turnEnd()
    {
        if (api.datacenter.Player.isCurrentPlayer)
        {
            aks.send("Gt", false);
        } // end if
    } // End of the function
    function turnOk(sSpriteID)
    {
        aks.send("GT" + (sSpriteID != undefined ? (sSpriteID) : ("")), false);
    } // End of the function
    function onCreate(bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            ank.utils.Logger.err("[onCreate] Impossible de créer la partie");
            return;
        } // end if
        var _loc3 = sExtraData.split("|");
        var _loc2 = Number(_loc3[0]);
        if (_loc2 != 1)
        {
            ank.utils.Logger.err("[onCreate] Type incorrect");
            return;
        } // end if
        api.datacenter.Game = new dofus.datacenter.Game();
        api.datacenter.Game.state = _loc2;
        api.datacenter.Player.data.initAP(false);
        api.datacenter.Player.data.initMP(false);
        api.datacenter.Player.SpellsManager.clear();
        api.datacenter.Player.data.CharacteristicsManager.initialize();
        api.datacenter.Player.data.EffectsManager.initialize();
        api.datacenter.Player.clearSummon();
        api.gfx.cleanMap(1);
        this.onCreateSolo();
    } // End of the function
    function onJoin(sExtraData)
    {
        api.datacenter.Player.guildInfos.defendedTaxCollectorID = undefined;
        var _loc2 = sExtraData.split("|");
        var _loc5 = Number(_loc2[0]);
        var _loc7 = _loc2[1] == "0" ? (false) : (true);
        var _loc6 = _loc2[2] == "0" ? (false) : (true);
        var _loc4 = _loc2[3] == "0" ? (false) : (true);
        var _loc3 = Number(_loc2[4]);
        api.datacenter.Game = new dofus.datacenter.Game();
        api.datacenter.Game.state = _loc5;
        api.datacenter.Game.isSpectator = _loc4;
        if (!_loc4)
        {
            api.datacenter.Player.data.initAP(false);
            api.datacenter.Player.data.initMP(false);
            api.datacenter.Player.SpellsManager.clear();
        } // end if
        api.ui.getUIComponent("Banner").setCurrentTab("Spells");
        api.gfx.cleanMap(1);
        if (_loc6)
        {
            api.ui.loadUIComponent("ChallengeMenu", "ChallengeMenu", {labelReady: api.lang.getText("READY"), labelCancel: api.lang.getText("CANCEL_SMALL"), cancelButton: _loc7, ready: false});
        } // end if
        if (!isNaN(_loc3))
        {
            api.ui.getUIComponent("Banner").startTimer(_loc3 / 1000);
        } // end if
        api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_NONE);
        api.ui.unloadLastUIAutoHideComponent();
        api.ui.unloadUIComponent("Fights");
    } // End of the function
    function onPositionStart(sExtraData)
    {
        var _loc7 = sExtraData.split("|");
        var _loc4 = _loc7[0];
        var _loc5 = _loc7[1];
        var _loc6 = Number(_loc7[2]);
        api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
        api.datacenter.Game.setInteractionType("place");
        if (_loc6 == undefined)
        {
            ank.utils.Logger.err("[onPositionStart] Impossible de trouver l\'équipe du joueur local !");
        } // end if
        for (var _loc2 = 0; _loc2 < _loc4.length; _loc2 = _loc2 + 2)
        {
            var _loc3 = ank.utils.Compressor.decode64(_loc4.charAt(_loc2)) << 6;
            _loc3 = _loc3 + ank.utils.Compressor.decode64(_loc4.charAt(_loc2 + 1));
            if (_loc6 == 0)
            {
                api.gfx.setInteractionOnCell(_loc3, ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
            } // end if
            api.gfx.select(_loc3, dofus.Constants.TEAMS_COLOR[0]);
        } // end of for
        for (var _loc2 = 0; _loc2 < _loc5.length; _loc2 = _loc2 + 2)
        {
            _loc3 = ank.utils.Compressor.decode64(_loc5.charAt(_loc2)) << 6;
            _loc3 = _loc3 + ank.utils.Compressor.decode64(_loc5.charAt(_loc2 + 1));
            if (_loc6 == 1)
            {
                api.gfx.setInteractionOnCell(_loc3, ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
            } // end if
            api.gfx.select(_loc3, dofus.Constants.TEAMS_COLOR[1]);
        } // end of for
    } // End of the function
    function onPlayersCoordinates(sExtraData)
    {
        var _loc6 = sExtraData.split("|");
        for (var _loc2 = 0; _loc2 < _loc6.length; ++_loc2)
        {
            var _loc3 = _loc6[_loc2].split(";");
            var _loc5 = _loc3[0];
            var _loc4 = Number(_loc3[1]);
            api.gfx.setSpritePosition(_loc5, _loc4);
        } // end of for
    } // End of the function
    function onReady(sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "1";
        var _loc2 = sExtraData.substr(1);
        if (_loc3)
        {
            api.gfx.addSpriteExtraClip(_loc2, dofus.Constants.READY_FILE);
        }
        else
        {
            api.gfx.removeSpriteExtraClip(_loc2);
        } // end else if
    } // End of the function
    function onStartToPlay()
    {
        api.ui.getUIComponent("Banner").stopTimer();
        aks.GameActions.onActionsFinish(api.datacenter.Player.ID);
        api.sounds.onGameStart(api.datacenter.Map.musics);
        var _loc5 = api.ui.getUIComponent("Banner");
        _loc5.showGiveUpButton(true);
        if (!api.datacenter.Game.isSpectator)
        {
            var _loc4 = api.datacenter.Player.data;
            _loc4.initAP();
            _loc4.initMP();
            _loc4.initLP();
            false;
            _loc5.showPoints(true);
            _loc5.showNextTurnButton(true);
            api.ui.loadUIComponent("CenterText", "CenterText", {text: api.lang.getText("GAME_LAUNCH"), background: true, timer: 2000}, {bForceLoad: true});
        } // end if
        api.ui.loadUIComponent("Timeline", "Timeline");
        api.ui.unloadUIComponent("ChallengeMenu");
        api.gfx.unSelect(true);
        api.kernel.OptionsManager.setOption("Grid", true);
        api.datacenter.Game.setInteractionType("move");
        api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
        api.datacenter.Game.isRunning = true;
        var _loc2 = api.datacenter.Sprites.getItems();
        for (var _loc3 in _loc2)
        {
            api.gfx.addSpriteExtraClip(_loc3, dofus.Constants.CIRCLE_FILE, dofus.Constants.TEAMS_COLOR[_loc2[_loc3].Team]);
        } // end of for...in
    } // End of the function
    function onTurnStart(sExtraData)
    {
        var _loc4 = sExtraData.split("|");
        var _loc3 = _loc4[0];
        var _loc5 = Number(_loc4[1]) / 1000;
        var _loc2 = api.datacenter.Sprites.getItemAt(_loc3);
        _loc2.GameActionsManager.clear();
        api.gfx.unSelect(true);
        api.ui.getUIComponent("Timeline").nextTurn(_loc3);
        api.datacenter.Game.currentPlayerID = _loc3;
        if (api.datacenter.Player.isCurrentPlayer)
        {
            if (api.kernel.OptionsManager.getOption("StartTurnSound"))
            {
                api.sounds.onTurnStart();
            } // end if
            api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
            api.datacenter.Player.SpellsManager.nextTurn();
            api.ui.getUIComponent("Banner").startTimer(_loc5);
        }
        else
        {
            api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
            api.ui.getUIComponent("Timeline").startChrono(_loc5);
        } // end else if
        api.kernel.GameManager.cleanPlayer(api.datacenter.Game.lastPlayerID);
        if (api.kernel.OptionsManager.getOption("StringCourse"))
        {
            api.ui.loadUIComponent("StringCourse", "StringCourse", {gfx: _loc2.artworkFile, name: _loc2.name, level: api.lang.getText("LEVEL_SMALL") + " " + _loc2.Level}, {bForceLoad: true});
        } // end if
        api.kernel.GameManager.cleanUpGameArea(true);
    } // End of the function
    function onTurnFinish(sExtraData)
    {
        var _loc2 = sExtraData;
        var _loc3 = api.datacenter.Sprites.getItemAt(_loc2);
        if (api.datacenter.Player.isCurrentPlayer)
        {
            api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
        } // end if
        api.datacenter.Game.lastPlayerID = api.datacenter.Game.currentPlayerID;
        api.datacenter.Game.currentPlayerID = undefined;
        api.ui.getUIComponent("Banner").stopTimer();
        api.ui.getUIComponent("Timeline").stopChrono();
        api.kernel.GameManager.cleanUpGameArea(true);
    } // End of the function
    function onTurnlist(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        api.datacenter.Game.turnSequence = _loc2;
        api.ui.getUIComponent("Timeline").update();
    } // End of the function
    function onTurnMiddle(sExtraData)
    {
        if (!api.datacenter.Game.isRunning)
        {
            ank.utils.Logger.err("[innerOnTurnMiddle] on est pas en combat");
            return;
        } // end if
        var _loc11 = sExtraData.split("|");
        var _loc12 = new Object();
        for (var _loc5 = 0; _loc5 < _loc11.length; ++_loc5)
        {
            var _loc2 = _loc11[_loc5].split(";");
            if (_loc2.length != 0)
            {
                var _loc4 = _loc2[0];
                var _loc7 = _loc2[1] == "1" ? (true) : (false);
                var _loc9 = Number(_loc2[2]);
                var _loc10 = Number(_loc2[3]);
                var _loc8 = Number(_loc2[4]);
                var _loc6 = Number(_loc2[5]);
                var _loc14 = Number(_loc2[6]);
                _loc12[_loc4] = true;
                var _loc3 = api.datacenter.Sprites.getItemAt(_loc4);
                if (_loc3 != undefined)
                {
                    _loc3.sequencer.clearAllNextActions();
                    if (_loc7)
                    {
                        _loc3.mc.clear();
                        api.gfx.removeSpriteOverHeadLayer(_loc4, "text");
                    }
                    else
                    {
                        _loc3.LP = _loc9;
                        _loc3.AP = _loc10;
                        _loc3.MP = _loc8;
                        if (!isNaN(_loc6))
                        {
                            api.gfx.setSpritePosition(_loc4, _loc6);
                        } // end if
                    } // end else if
                    continue;
                } // end if
                ank.utils.Logger.err("[onTurnMiddle] le sprite n\'existe pas");
            } // end if
        } // end of for
        var _loc13 = api.datacenter.Sprites.getItems();
        for (var _loc15 in _loc13)
        {
            if (!_loc12[_loc15])
            {
                _loc13[_loc15].mc.clear();
                api.datacenter.Sprites.removeItemAt(_loc15);
            } // end if
        } // end of for...in
    } // End of the function
    function onTurnReady(sExtraData)
    {
        var _loc2 = sExtraData;
        var _loc3 = api.datacenter.Sprites.getItemAt(_loc2);
        if (_loc3 != undefined)
        {
            var _loc4 = _loc3.sequencer;
            _loc4.addAction(false, this, turnOk);
            _loc4.execute();
        }
        else
        {
            ank.utils.Logger.err("[onTurnReday] le sprite " + _loc2 + " n\'existe pas");
        } // end else if
    } // End of the function
    function onMapData(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc3 = _loc2[0];
        var _loc4 = _loc2[1];
        if (Number(_loc3) == api.datacenter.Map.id)
        {
            if (!api.datacenter.Map.bOutdoor)
            {
                api.kernel.NightManager.noEffects();
            } // end if
            api.gfx.onMapLoaded();
            return;
        } // end if
        api.gfx.showContainer(false);
        api.kernel.MapsServersManager.loadMap(_loc3, _loc4);
    } // End of the function
    function onMapLoaded()
    {
        api.gfx.showContainer(true);
    } // End of the function
    function onMovement(sExtraData)
    {
        var _loc22 = sExtraData.split("|");
        for (var _loc15 = 0; _loc15 < _loc22.length; ++_loc15)
        {
            var _loc14 = _loc22[_loc15];
            if (_loc14.length == 0)
            {
                continue;
            } // end if
            var _loc18 = false;
            if (_loc14.charAt(0) == "+")
            {
                _loc18 = true;
            }
            else if (_loc14.charAt(0) != "-")
            {
                continue;
            } // end else if
            if (_loc18)
            {
                var _loc2 = _loc14.substr(1).split(";");
                var _loc9 = _loc2[0];
                var _loc11 = _loc2[1];
                var _loc4 = _loc2[2];
                var _loc8 = _loc2[3];
                var _loc6 = _loc2[4];
                var _loc10 = _loc2[5];
                var _loc21;
                switch (_loc6)
                {
                    case "-1":
                    case "-2":
                    {
                        var _loc3 = new Object();
                        _loc3.spriteType = _loc6;
                        _loc3.gfxID = _loc10;
                        _loc3.cell = _loc9;
                        _loc3.dir = _loc11;
                        _loc3.powerLevel = _loc2[6];
                        _loc3.color1 = _loc2[7];
                        _loc3.color2 = _loc2[8];
                        _loc3.color3 = _loc2[9];
                        _loc3.accessories = _loc2[10];
                        if (api.datacenter.Game.isFight)
                        {
                            _loc3.LP = _loc2[11];
                            _loc3.AP = _loc2[12];
                            _loc3.MP = _loc2[13];
                            _loc3.team = _loc2[14];
                        } // end if
                        if (_loc6 == -1)
                        {
                            _loc21 = api.kernel.CharactersManager.createCreature(_loc4, _loc8, _loc3);
                        }
                        else
                        {
                            _loc21 = api.kernel.CharactersManager.createMonster(_loc4, _loc8, _loc3);
                        } // end else if
                        break;
                    } 
                    case "-3":
                    {
                        _loc3 = new Object();
                        _loc3.spriteType = _loc6;
                        _loc3.level = _loc2[6];
                        _loc3.cell = Number(_loc9);
                        _loc3.dir = _loc11;
                        _loc3.color1 = _loc2[7];
                        _loc3.color2 = _loc2[8];
                        _loc3.color3 = _loc2[9];
                        _loc3.accessories = _loc2[10];
                        var _loc17 = this.sliptGfxData(_loc10);
                        var _loc12 = _loc17.gfx;
                        _loc3.gfxID = _loc12[0];
                        _loc21 = api.kernel.CharactersManager.createMonsterGroup(_loc4, _loc8, _loc3);
                        var _loc16 = _loc4;
                        var _loc13 = _loc17.shape == "circle" ? (0) : (2);
                        for (var _loc5 = 1; _loc5 < _loc12.length; ++_loc5)
                        {
                            if (_loc12[_loc15] == "")
                            {
                                continue;
                            } // end if
                            _loc3.gfxID = _loc12[_loc5];
                            var _loc7 = _loc4 + "_" + _loc5;
                            var _loc19 = api.kernel.CharactersManager.createMonsterGroup(_loc7, undefined, _loc3);
                            api.gfx.addLinkedSprite(_loc7, _loc16, _loc13, _loc19);
                            switch (_loc17.shape)
                            {
                                case "circle":
                                {
                                    _loc13 = _loc5;
                                    break;
                                } 
                                case "line":
                                {
                                    _loc16 = _loc7;
                                    _loc13 = 2;
                                    break;
                                } 
                            } // End of switch
                        } // end of for
                        break;
                    } 
                    case "-4":
                    {
                        _loc3 = new Object();
                        _loc3.spriteType = _loc6;
                        _loc3.gfxID = _loc10;
                        _loc3.cell = _loc9;
                        _loc3.dir = _loc11;
                        _loc3.sex = _loc2[6];
                        _loc3.color1 = _loc2[7];
                        _loc3.color2 = _loc2[8];
                        _loc3.color3 = _loc2[9];
                        _loc3.accessories = _loc2[10];
                        _loc21 = api.kernel.CharactersManager.createNonPlayableCharacter(_loc4, Number(_loc8), _loc3);
                        break;
                    } 
                    case "-5":
                    {
                        _loc3 = new Object();
                        _loc3.spriteType = _loc6;
                        _loc3.gfxID = _loc10;
                        _loc3.cell = _loc9;
                        _loc3.dir = _loc11;
                        _loc3.color1 = _loc2[6];
                        _loc3.color2 = _loc2[7];
                        _loc3.color3 = _loc2[8];
                        _loc3.accessories = _loc2[9];
                        _loc3.guildName = _loc2[10];
                        _loc3.emblem = _loc2[11];
                        _loc3.offlineType = _loc2[12];
                        _loc21 = api.kernel.CharactersManager.createOfflineCharacter(_loc4, _loc8, _loc3);
                        break;
                    } 
                    case "-6":
                    {
                        _loc3 = new Object();
                        _loc3.spriteType = _loc6;
                        _loc3.gfxID = _loc10;
                        _loc3.cell = _loc9;
                        _loc3.dir = _loc11;
                        _loc3.level = _loc2[6];
                        if (api.datacenter.Game.isFight)
                        {
                            _loc3.LP = _loc2[7];
                            _loc3.AP = _loc2[8];
                            _loc3.MP = _loc2[9];
                            _loc3.team = _loc2[10];
                        }
                        else
                        {
                            _loc3.guildName = _loc2[7];
                            _loc3.emblem = _loc2[8];
                        } // end else if
                        _loc21 = api.kernel.CharactersManager.createTaxCollector(_loc4, _loc8, _loc3);
                        break;
                    } 
                    case "-7":
                    {
                        _loc3 = new Object();
                        _loc3.spriteType = _loc6;
                        _loc3.gfxID = _loc10;
                        _loc3.cell = _loc9;
                        _loc3.dir = _loc11;
                        _loc3.sex = _loc2[6];
                        _loc3.powerLevel = _loc2[7];
                        _loc3.accessories = _loc2[8];
                        if (api.datacenter.Game.isFight)
                        {
                            _loc3.LP = _loc2[9];
                            _loc3.AP = _loc2[10];
                            _loc3.MP = _loc2[11];
                            _loc3.team = _loc2[12];
                        }
                        else
                        {
                            _loc3.emote = _loc2[9];
                            _loc3.emoteTimer = _loc2[10];
                        } // end else if
                        _loc21 = api.kernel.CharactersManager.createMutant(_loc4, _loc8, _loc3);
                        break;
                    } 
                    default:
                    {
                        _loc3 = new Object();
                        _loc3.spriteType = _loc6;
                        _loc3.cell = _loc9;
                        _loc3.dir = _loc11;
                        _loc3.sex = _loc2[6];
                        if (api.datacenter.Game.isFight)
                        {
                            _loc3.level = _loc2[7];
                            _loc3.alignment = _loc2[8];
                            _loc3.color1 = _loc2[9];
                            _loc3.color2 = _loc2[10];
                            _loc3.color3 = _loc2[11];
                            _loc3.accessories = _loc2[12];
                            _loc3.LP = _loc2[13];
                            _loc3.AP = _loc2[14];
                            _loc3.MP = _loc2[15];
                            _loc3.resistances = new Array(Number(_loc2[16]), Number(_loc2[17]), Number(_loc2[18]), Number(_loc2[19]), Number(_loc2[20]), Number(_loc2[21]), Number(_loc2[22]));
                            _loc3.team = _loc2[23];
                        }
                        else
                        {
                            _loc3.alignment = _loc2[7];
                            _loc3.color1 = _loc2[8];
                            _loc3.color2 = _loc2[9];
                            _loc3.color3 = _loc2[10];
                            _loc3.accessories = _loc2[11];
                            _loc3.aura = _loc2[12];
                            _loc3.emote = _loc2[13];
                            _loc3.emoteTimer = _loc2[14];
                            _loc3.guildName = _loc2[15];
                            _loc3.emblem = _loc2[16];
                            _loc3.restrictions = _loc2[17];
                        } // end else if
                        _loc17 = this.sliptGfxData(_loc10);
                        _loc12 = _loc17.gfx;
                        _loc3.gfxID = _loc12[0];
                        _loc21 = api.kernel.CharactersManager.createCharacter(_loc4, _loc8, _loc3);
                        _loc16 = _loc4;
                        _loc13 = _loc17.shape == "circle" ? (0) : (2);
                        for (var _loc5 = 1; _loc5 < _loc12.length; ++_loc5)
                        {
                            if (_loc12[_loc5] == "")
                            {
                                continue;
                            } // end if
                            _loc7 = _loc4 + "_" + _loc5;
                            _loc19 = new ank.battlefield.datacenter.Sprite(_loc7, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + _loc12[_loc5] + ".swf");
                            api.gfx.addLinkedSprite(_loc7, _loc16, _loc13, _loc19);
                            switch (_loc17.shape)
                            {
                                case "circle":
                                {
                                    _loc13 = _loc5;
                                    break;
                                } 
                                case "line":
                                {
                                    _loc16 = _loc7;
                                    _loc13 = 2;
                                    break;
                                } 
                            } // End of switch
                        } // end of for
                        break;
                    } 
                } // End of switch
                this.onSpriteMovement(_loc18, _loc21);
                continue;
            } // end if
            var _loc20 = _loc14.substr(1);
            _loc21 = api.datacenter.Sprites.getItemAt(_loc20);
            this.onSpriteMovement(_loc18, _loc21);
        } // end of for
    } // End of the function
    function onCellData(sExtraData)
    {
        var _loc8 = sExtraData.split("|");
        for (var _loc3 = 0; _loc3 < _loc8.length; ++_loc3)
        {
            var _loc2 = _loc8[_loc3].split(";");
            var _loc5 = Number(_loc2[0]);
            var _loc7 = _loc2[1].substring(0, 10);
            var _loc4 = _loc2[1].substr(10);
            var _loc6 = _loc2[2] == "0" ? (0) : (1);
            api.gfx.updateCell(_loc5, _loc7, _loc4, _loc6);
        } // end of for
    } // End of the function
    function onZoneData(sExtraData)
    {
        var _loc9 = sExtraData.split("|");
        for (var _loc4 = 0; _loc4 < _loc9.length; ++_loc4)
        {
            var _loc6 = _loc9[_loc4];
            var _loc8 = _loc6.charAt(0) == "+" ? (true) : (false);
            var _loc3 = _loc6.substr(1).split(";");
            var _loc5 = Number(_loc3[0]);
            var _loc7 = Number(_loc3[1]);
            var _loc2 = _loc3[2];
            if (_loc8)
            {
                api.gfx.drawZone(_loc5, 0, _loc7, _loc2, dofus.Constants.ZONE_COLOR[_loc2]);
                continue;
            } // end if
            api.gfx.clearZone(_loc5, _loc7, _loc2);
        } // end of for
    } // End of the function
    function onCellObject(sExtraData)
    {
        var _loc8 = sExtraData.charAt(0) == "+";
        var _loc7 = sExtraData.substr(1).split("|");
        for (var _loc2 = 0; _loc2 < _loc7.length; ++_loc2)
        {
            var _loc4 = _loc7[_loc2].split(";");
            var _loc3 = Number(_loc4[0]);
            var _loc6 = Number(_loc4[1]);
            if (_loc8)
            {
                var _loc5 = new dofus.datacenter.Item(0, _loc6);
                api.gfx.updateCellObjectExternalWithExternalClip(_loc3, _loc5.iconFile, 1);
                false;
                continue;
            } // end if
            api.gfx.initializeCell(_loc3, 1);
        } // end of for
    } // End of the function
    function onFrameObject2(sExtraData)
    {
        var _loc8 = sExtraData.split("|");
        for (var _loc3 = 0; _loc3 < _loc8.length; ++_loc3)
        {
            var _loc2 = _loc8[_loc3].split(";");
            var _loc4 = Number(_loc2[0]);
            var _loc5 = _loc2[1];
            var _loc6 = _loc2[2] != undefined;
            var _loc7 = _loc2[2] == "1" ? (true) : (false);
            if (_loc6)
            {
                api.gfx.setObject2Interactive(_loc4, _loc7, 2);
            } // end if
            api.gfx.setObject2Frame(_loc4, _loc5);
        } // end of for
    } // End of the function
    function onEffect(sExtraData)
    {
        var _loc8 = sExtraData.split(";");
        var _loc13 = _loc8[0];
        var _loc7 = _loc8[1].split(",");
        var _loc12 = _loc8[2];
        var _loc11 = _loc8[3];
        var _loc10 = _loc8[4];
        var _loc9 = _loc8[5];
        var _loc6 = Number(_loc8[6]);
        var _loc14 = _loc8[7];
        for (var _loc2 = 0; _loc2 < _loc7.length; ++_loc2)
        {
            var _loc3 = _loc7[_loc2];
            if (_loc3 == api.datacenter.Game.currentPlayerID)
            {
                ++_loc6;
            } // end if
            var _loc4 = new dofus.datacenter.Effect(_loc13, _loc12, _loc11, _loc10, _loc9, _loc6, _loc14);
            var _loc5 = api.datacenter.Sprites.getItemAt(_loc3);
            _loc5.EffectsManager.addEffect(_loc4);
        } // end of for
    } // End of the function
    function onChallenge(sExtraData)
    {
        var _loc17 = sExtraData.charAt(0) == "+";
        var _loc10 = sExtraData.substr(1).split("|");
        var _loc16 = _loc10.shift().split(";");
        var _loc14 = Number(_loc16[0]);
        var _loc18 = Number(_loc16[1]);
        var _loc13 = (Math.cos(_loc14) + 1) * 8388607;
        if (_loc17)
        {
            var _loc12 = new dofus.datacenter.Challenge(_loc14, _loc18);
            api.datacenter.Challenges.addItemAt(_loc14, _loc12);
            for (var _loc3 = 0; _loc3 < _loc10.length; ++_loc3)
            {
                var _loc2 = _loc10[_loc3].split(";");
                var _loc9 = _loc2[0];
                var _loc7 = Number(_loc2[1]);
                var _loc4 = Number(_loc2[2]);
                var _loc5 = Number(_loc2[3]);
                var _loc6;
                _loc6 = dofus.Constants.getTeamFileFromType(_loc4, _loc5);
                var _loc8 = new dofus.datacenter.Team(_loc9, ank.battlefield.mc.Sprite, _loc6, _loc7, _loc13, _loc4, _loc5);
                _loc12.addTeam(_loc8);
                api.gfx.addSprite(_loc8.id, _loc8);
            } // end of for
        }
        else
        {
            var _loc11 = api.datacenter.Challenges.getItemAt(_loc14).teams;
            for (var _loc15 in _loc11)
            {
                _loc8 = _loc11[_loc15];
                api.gfx.removeSprite(_loc8.id);
            } // end of for...in
            api.datacenter.Challenges.removeItemAt(_loc14);
        } // end else if
    } // End of the function
    function onTeam(sExtraData)
    {
        var _loc11 = sExtraData.split("|");
        var _loc13 = Number(_loc11.shift());
        var _loc12 = api.datacenter.Sprites.getItemAt(_loc13);
        for (var _loc5 = 0; _loc5 < _loc11.length; ++_loc5)
        {
            var _loc4 = _loc11[_loc5].split(";");
            var _loc10 = _loc4[0].charAt(0) == "+";
            var _loc7 = _loc4[0].substr(1);
            var _loc2 = _loc4[1];
            var _loc9 = _loc4[2];
            var _loc6 = _loc2.split(",");
            var _loc8 = Number(_loc2);
            if (_loc6.length > 1)
            {
                _loc2 = api.lang.getFullNameText(_loc6);
            }
            else if (!isNaN(_loc8))
            {
                _loc2 = api.lang.getMonstersText(_loc8).n;
            } // end else if
            if (_loc10)
            {
                var _loc3 = new Object();
                _loc3.id = _loc7;
                _loc3.name = _loc2;
                _loc3.level = _loc9;
                _loc12.addPlayer(_loc3);
                continue;
            } // end if
            _loc12.removePlayer(_loc7);
        } // end of for
    } // End of the function
    function onLeave()
    {
        api.datacenter.Game.currentPlayerID = undefined;
        api.ui.getUIComponent("Banner").stopTimer();
        api.ui.getUIComponent("Banner").hideRightPanel();
        api.ui.unloadUIComponent("Timeline");
        api.ui.unloadUIComponent("StringCourse");
        api.ui.unloadUIComponent("PlayerInfos");
        api.ui.unloadUIComponent("SpriteInfos");
        aks.GameActions.onActionsFinish(String(api.datacenter.Player.ID));
        api.datacenter.Player.reset();
        this.create();
    } // End of the function
    function onEnd(sExtraData)
    {
        var _loc14 = sExtraData.split("|");
        var _loc15 = Number(_loc14.shift(0));
        api.datacenter.Game.results = new Object();
        var _loc13 = api.datacenter.Game.results;
        _loc13.winners = new ank.utils.ExtendedArray();
        _loc13.loosers = new ank.utils.ExtendedArray();
        for (var _loc10 = 0; _loc10 < _loc14.length; ++_loc10)
        {
            var _loc3 = _loc14[_loc10].split(";");
            var _loc2 = new Object();
            var _loc12 = _loc3[0] == "2" ? (true) : (false);
            _loc2.id = Number(_loc3[1]);
            var _loc11 = api.kernel.CharactersManager.getNameFromData(_loc3[2]);
            _loc2.name = _loc11.name;
            _loc2.type = _loc11.type;
            _loc2.level = Number(_loc3[3]);
            _loc2.bDead = _loc3[4] == "1" ? (true) : (false);
            _loc2.minxp = Number(_loc3[5]);
            _loc2.xp = Number(_loc3[6]);
            _loc2.maxxp = Number(_loc3[7]);
            _loc2.winxp = Number(_loc3[8]);
            var _loc9 = _loc3[9].split(",");
            _loc2.items = new Array();
            var _loc8 = _loc9.length;
            while (--_loc8 >= 0)
            {
                var _loc5 = _loc9[_loc8].split("~");
                var _loc4 = Number(_loc5[0]);
                var _loc6 = Number(_loc5[1]);
                if (isNaN(_loc4))
                {
                    break;
                } // end if
                var _loc7 = new dofus.datacenter.Item(0, _loc4, _loc6);
                _loc2.items.push(_loc7);
            } // end while
            _loc2.kama = _loc3[10];
            if (_loc12)
            {
                _loc13.winners.push(_loc2);
                continue;
            } // end if
            _loc13.loosers.push(_loc2);
        } // end of for
        if (_loc15 == api.datacenter.Player.ID)
        {
            aks.GameActions.onActionsFinish(String(_loc15));
        } // end if
        api.datacenter.Game.isRunning = false;
        var _loc16 = api.datacenter.Sprites.getItemAt(_loc15).sequencer;
        if (_loc16 != undefined)
        {
            _loc16.addAction(false, api.kernel.GameManager, api.kernel.GameManager.terminateFight);
            _loc16.execute(true);
        }
        else
        {
            ank.utils.Logger.err("[AKS.Game.onEnd] Impossible de trouver le sequencer");
            ank.utils.Timer.setTimer(this, "game", api.kernel.GameManager, api.kernel.GameManager.terminateFight, 6000);
        } // end else if
    } // End of the function
    function onCreateSolo()
    {
        api.datacenter.Player.InteractionsManager.setState(false);
        api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT);
        api.ui.removeCursor();
        api.ui.getUIComponent("Banner").setCurrentTab("Items");
        if (!api.gfx.isMapBuild)
        {
            if (api.ui.getUIComponent("Banner") == undefined)
            {
                api.kernel.OptionsManager.applyAllOptions();
                api.ui.loadUIComponent("Banner", "Banner", {data: api.datacenter.Player}, {bAlwaysOnTop: true});
                api.ui.setScreenSize(742, 432);
            } // end if
            this.addToQueue({object: this, method: getMapData, params: [api.datacenter.Map.id]});
        }
        else
        {
            var _loc2 = api.ui.getUIComponent("Banner");
            _loc2.showPoints(false);
            _loc2.showNextTurnButton(false);
            _loc2.showGiveUpButton(false);
            api.ui.unloadUIComponent("ChallengeMenu");
            api.gfx.cleanMap(2);
            this.getMapData(api.datacenter.Map.id);
        } // end else if
    } // End of the function
    function onSpriteMovement(bAdd, oSprite)
    {
        if (oSprite instanceof dofus.datacenter.Character)
        {
            api.datacenter.Game.playerCount = api.datacenter.Game.playerCount + (bAdd ? (1) : (-1));
        } // end if
        if (bAdd)
        {
            api.gfx.addSprite(oSprite.id);
            if (oSprite instanceof dofus.datacenter.OfflineCharacter)
            {
                oSprite.mc.addExtraClip(dofus.Constants.OFFLINE_PATH + oSprite.offlineType + ".swf", undefined, true);
                return;
            } // end if
            if (api.datacenter.Game.isRunning)
            {
                api.gfx.addSpriteExtraClip(oSprite.id, dofus.Constants.CIRCLE_FILE, dofus.Constants.TEAMS_COLOR[oSprite.Team]);
            }
            else if (oSprite.Aura != 0 && oSprite.Aura != undefined)
            {
                api.gfx.addSpriteExtraClip(oSprite.id, dofus.Constants.AURA_PATH + oSprite.Aura + ".swf", undefined, true);
            } // end else if
            if (oSprite.id == api.datacenter.Player.ID)
            {
                api.ui.getUIComponent("Banner").updateLocalPlayer();
            } // end if
        }
        else if (!api.datacenter.Game.isRunning)
        {
            api.gfx.removeSprite(oSprite.id);
        }
        else
        {
            var _loc6 = oSprite.sequencer;
            var _loc7 = oSprite.mc;
            _loc6.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("LEAVE_GAME", [oSprite.name]), "INFO_CHAT"]);
            _loc6.addAction(false, api.ui.getUIComponent("Timeline"), api.ui.getUIComponent("Timeline").hideItem, [oSprite.id]);
            _loc6.addAction(true, _loc7, _loc7.setAnim, ["Die"], 1500);
            _loc6.addAction(false, _loc7, _loc7.clear);
            _loc6.execute();
            if (api.datacenter.Game.currentPlayerID == oSprite.id)
            {
                api.ui.getUIComponent("Banner").stopTimer();
                api.ui.getUIComponent("Timeline").stopChrono();
            } // end else if
        } // end else if
        if (!api.datacenter.Game.isFight)
        {
            var _loc10 = api.datacenter.Game.playerCount;
            var _loc9 = api.kernel.OptionsManager.getOption("CreaturesMode");
            var _loc11 = _loc9 - 2;
            if (_loc10 >= _loc9)
            {
                var _loc5 = api.datacenter.Sprites.getItems();
                for (var _loc8 in _loc5)
                {
                    var _loc2 = _loc5[_loc8];
                    if (!(_loc2 instanceof dofus.datacenter.Character))
                    {
                        continue;
                    } // end if
                    if (!_loc2.canSwitchInCreaturesMode)
                    {
                        continue;
                    } // end if
                    if (_loc2 instanceof dofus.datacenter.Mutant)
                    {
                        continue;
                    } // end if
                    if (!_loc2.bInCreaturesMode)
                    {
                        _loc2.tmpGfxFile = _loc2.gfxFile;
                        var _loc3 = dofus.Constants.CLIPS_PERSOS_PATH + _loc2.Guild + "2.swf";
                        api.gfx.setSpriteGfx(_loc2.id, _loc3);
                        _loc2.bInCreaturesMode = true;
                    } // end if
                } // end of for...in
                api.datacenter.Game.isInCreaturesMode = true;
            } // end if
            if (_loc10 < _loc11)
            {
                _loc5 = api.datacenter.Sprites.getItems();
                for (var _loc8 in _loc5)
                {
                    _loc2 = _loc5[_loc8];
                    if (!(_loc2 instanceof dofus.datacenter.Character))
                    {
                        continue;
                    } // end if
                    if (!_loc2.canSwitchInCreaturesMode)
                    {
                        continue;
                    } // end if
                    if (_loc2 instanceof dofus.datacenter.Mutant)
                    {
                        continue;
                    } // end if
                    if (_loc2.bInCreaturesMode)
                    {
                        _loc3 = _loc2.tmpGfxFile == undefined ? (_loc2.gfxFile) : (_loc2.tmpGfxFile);
                        delete _loc2.tmpGfxFile;
                        api.gfx.setSpriteGfx(_loc2.id, _loc3);
                        _loc2.bInCreaturesMode = false;
                    } // end if
                } // end of for...in
                api.datacenter.Game.isInCreaturesMode = false;
            } // end if
        } // end if
    } // End of the function
    function sliptGfxData(sGfx)
    {
        if (sGfx.indexOf(",") != -1)
        {
            var _loc2 = sGfx.split(",");
            return ({shape: "circle", gfx: _loc2});
        }
        else if (sGfx.indexOf(":") != -1)
        {
            _loc2 = sGfx.split(":");
            return ({shape: "line", gfx: _loc2});
        } // end else if
        return ({shape: "none", gfx: [sGfx]});
    } // End of the function
    static var TYPE_SOLO = 1;
    static var TYPE_FIGHT = 2;
} // End of Class
#endinitclip
