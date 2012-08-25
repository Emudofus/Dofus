// Action script...

// [Initial MovieClip Action of sprite 20610]
#initclip 131
if (!dofus.graphics.battlefield.DofusBattlefield)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.battlefield)
    {
        _global.dofus.graphics.battlefield = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.battlefield.DofusBattlefield = function ()
    {
        super();
    }).prototype;
    _loc1.__get__api = function ()
    {
        return (this._oAPI);
    };
    _loc1.initialize = function (oDatacenter, sGroundFile, sObjectFile, sAccessoriesPath, oAPI)
    {
        super.initialize(oDatacenter, sGroundFile, sObjectFile, sAccessoriesPath);
        mx.events.EventDispatcher.initialize(this);
        this._oAPI = oAPI;
    };
    _loc1.addSpritePoints = function (sID, sValue, nColor)
    {
        if (this.api.kernel.OptionsManager.getOption("PointsOverHead"))
        {
            super.addSpritePoints(sID, sValue, nColor);
        } // end if
    };
    _loc1.onInitError = function ()
    {
        _root.onCriticalError(this.api.lang.getText("CRITICAL_ERROR_LOADING_BATTLEFIELD"));
    };
    _loc1.onMapLoaded = function ()
    {
        var _loc2 = this.api.datacenter.Map;
        this.api.ui.unloadUIComponent("CenterText");
        this.api.ui.unloadUIComponent("CenterTextMap");
        this.api.ui.unloadUIComponent("FightsInfos");
        this.setInteraction(ank.battlefield.Constants.INTERACTION_NONE);
        this.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
        this.setInteraction(ank.battlefield.Constants.INTERACTION_SPRITE_RELEASE_OVER_OUT);
        if (this.api.datacenter.Game.isFight)
        {
            this.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_NONE);
        }
        else
        {
            this.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT);
        } // end else if
        this.api.datacenter.Game.setInteractionType("move");
        this.api.datacenter.Game.isInCreaturesMode = false;
        this.api.network.Game.getExtraInformations();
        this.api.ui.unloadLastUIAutoHideComponent();
        this.api.ui.removePopupMenu();
        this.api.ui.getUIComponent("MapInfos").update();
        var _loc3 = _loc2.subarea;
        if (_loc3 != this.api.datacenter.Basics.gfx_lastSubarea)
        {
            var _loc4 = this.api.datacenter.Subareas.getItemAt(_loc3);
            var _loc5 = new String();
            var _loc6 = new String();
            var _loc7 = this.api.lang.getMapAreaText(_loc2.area).n;
            if (_loc4 == undefined)
            {
                _loc6 = String(this.api.lang.getMapSubAreaText(_loc3).n).substr(0, 2) == "//" ? (String(this.api.lang.getMapSubAreaText(_loc3).n).substr(2)) : (this.api.lang.getMapSubAreaText(_loc3).n);
                if (_loc7 != _loc6)
                {
                    _loc5 = _loc7 + "\n(" + _loc6 + ")";
                }
                else
                {
                    _loc5 = _loc7;
                } // end else if
            }
            else
            {
                _loc6 = _loc4.name;
                _loc5 = _loc4.name + " (" + _loc4.alignment.name + ")";
                if (_loc7 != _loc6)
                {
                    _loc5 = _loc7 + "\n(" + _loc6 + ")\n" + _loc4.alignment.name;
                }
                else
                {
                    _loc5 = _loc7 + "\n" + _loc4.alignment.name;
                } // end else if
            } // end else if
            if (!this.api.kernel.TutorialManager.isTutorialMode)
            {
                this.api.ui.loadUIComponent("CenterText", "CenterText", {text: _loc5, background: false, timer: 2000}, {bForceLoad: true});
            } // end if
            this.api.datacenter.Basics.gfx_lastSubarea = _loc3;
        } // end if
        if (this.api.datacenter.Player.isAtHome(_loc2.id))
        {
            var _loc8 = new Array();
            var _loc9 = this.api.lang.getHousesIndoorSkillsText();
            var _loc10 = 0;
            
            while (++_loc10, _loc10 < _loc9.length)
            {
                var _loc11 = new dofus.datacenter.Skill(_loc9[_loc10]);
                _loc8.push(_loc11);
            } // end while
            var _loc12 = this.api.lang.getHousesMapText(_loc2.id);
            if (_loc12 != undefined)
            {
                var _loc13 = this.api.datacenter.Houses.getItemAt(_loc12);
                this.api.ui.loadUIComponent("HouseIndoor", "HouseIndoor", {skills: _loc8, house: _loc13}, {bStayIfPresent: true});
            } // end if
            this.api.ui.getUIComponent("MapInfos")._visible = false;
        }
        else
        {
            this.api.ui.unloadUIComponent("HouseIndoor");
        } // end else if
        if (this.api.kernel.OptionsManager.getOption("Grid") == true)
        {
            this.api.gfx.drawGrid();
        }
        else
        {
            this.api.gfx.removeGrid();
        } // end else if
        this.api.ui.getUIComponent("Banner").setCircleXtraParams({currentCoords: [_loc2.x, _loc2.y]});
        if (Number(_loc2.ambianceID) > 0)
        {
            this.api.sounds.playEnvironment(_loc2.ambianceID);
        } // end if
        if (Number(_loc2.musicID) > 0)
        {
            this.api.sounds.playMusic(_loc2.musicID, true);
        } // end if
        if (!_loc2.bOutdoor)
        {
            this.api.kernel.NightManager.noEffects();
        } // end if
        var _loc14 = (Array)(this.api.lang.getMapText(_loc2.id).p);
        var _loc15 = 0;
        
        while (++_loc15, _loc14.length > _loc15)
        {
            var _loc16 = _loc14[_loc15][0];
            var _loc17 = _loc14[_loc15][1];
            var _loc18 = _loc14[_loc15][2];
            if (!dofus.utils.criterions.CriterionManager.fillingCriterions(_loc18))
            {
                var _loc19 = this.api.gfx.mapHandler.getCellData(_loc17);
                var _loc20 = 0;
                
                while (++_loc20, _loc20 < _loc16.length)
                {
                    if (_loc19.layerObject1Num == _loc16[_loc20])
                    {
                        _loc19.mcObject1._visible = false;
                    } // end if
                    if (_loc19.layerObject2Num == _loc16[_loc20])
                    {
                        _loc19.mcObject2._visible = false;
                    } // end if
                } // end while
            } // end if
        } // end while
        this.dispatchEvent({type: "mapLoaded"});
    };
    _loc1.onCellRelease = function (mcCell)
    {
        if (this.api.kernel.TutorialManager.isTutorialMode)
        {
            this.api.kernel.TutorialManager.onWaitingCase({code: "CELL_RELEASE", params: [mcCell.num]});
            return (false);
        } // end if
        switch (this.api.datacenter.Game.interactionType)
        {
            case 1:
            {
                var _loc3 = this.api.datacenter.Player.data;
                var _loc4 = false;
                var _loc5 = this.api.datacenter.Player.canMoveInAllDirections;
                if (this.api.datacenter.Player.InteractionsManager.calculatePath(this.mapHandler, mcCell.num, true, this.api.datacenter.Game.isFight, false, _loc5))
                {
                    if (this.api.datacenter.Game.isFight)
                    {
                        _loc4 = true;
                    }
                    else
                    {
                        _loc4 = this.api.datacenter.Basics.interactionsManager_path[this.api.datacenter.Basics.interactionsManager_path.length - 1].num == mcCell.num;
                    } // end if
                } // end else if
                if (!this.api.datacenter.Game.isFight && !_loc4)
                {
                    if (this.api.datacenter.Player.InteractionsManager.calculatePath(this.mapHandler, mcCell.num, true, this.api.datacenter.Game.isFight, true, _loc5))
                    {
                        _loc4 = true;
                    } // end if
                } // end if
                if (_loc4)
                {
                    if (getTimer() - this.api.datacenter.Basics.gfx_lastActionTime < dofus.Constants.CLICK_MIN_DELAY)
                    {
                        ank.utils.Logger.err("T trop rapide du clic");
                        return (null);
                    } // end if
                    this.api.datacenter.Basics.gfx_lastActionTime = getTimer();
                    if (this.api.datacenter.Basics.interactionsManager_path.length != 0)
                    {
                        var _loc6 = ank.battlefield.utils.Compressor.compressPath(this.api.datacenter.Basics.interactionsManager_path);
                        if (_loc6 != undefined)
                        {
                            _loc3.GameActionsManager.transmittingMove(1, [_loc6]);
                            delete this.api.datacenter.Basics.interactionsManager_path;
                        } // end if
                    } // end if
                    return (true);
                }
                else
                {
                    return (false);
                } // end else if
                break;
            } 
            case 2:
            {
                if (this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
                {
                    var _loc7 = this.api.datacenter.Player.data;
                    _loc7.GameActionsManager.transmittingOther(300, [this.api.datacenter.Player.currentUseObject.ID, mcCell.num]);
                    this.api.datacenter.Player.currentUseObject = null;
                }
                else if (this.api.datacenter.Basics.spellManager_errorMsg != undefined)
                {
                    this.api.kernel.showMessage(undefined, this.api.datacenter.Basics.spellManager_errorMsg, "ERROR_CHAT");
                    delete this.api.datacenter.Basics.spellManager_errorMsg;
                } // end else if
                this.api.ui.removeCursor();
                this.api.kernel.GameManager.lastSpellLaunch = getTimer();
                this.api.datacenter.Game.setInteractionType("move");
                break;
            } 
            case 3:
            {
                if (this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
                {
                    var _loc8 = this.api.datacenter.Player.data;
                    _loc8.GameActionsManager.transmittingOther(303, [mcCell.num]);
                    this.api.datacenter.Player.currentUseObject = null;
                } // end if
                this.api.ui.removeCursor();
                this.api.kernel.GameManager.lastSpellLaunch = getTimer();
                this.api.datacenter.Game.setInteractionType("move");
                break;
            } 
            case 4:
            {
                var _loc9 = this.mapHandler.getCellData(mcCell.num).spriteOnID;
                if (_loc9 != undefined)
                {
                    break;
                } // end if
                this.api.network.Game.setPlayerPosition(mcCell.num);
                break;
            } 
            case 5:
            {
                if (this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
                {
                    this.api.network.Items.use(this.api.datacenter.Player.currentUseObject.ID, this.mapHandler.getCellData(mcCell.num).spriteOnID, mcCell.num);
                } // end if
                this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
                this.api.gfx.clearPointer();
                this.unSelect(true);
                this.api.datacenter.Player.reset();
                this.api.ui.removeCursor();
                this.api.datacenter.Game.setInteractionType("move");
                break;
            } 
            case 6:
            {
                if (this.api.datacenter.Game.isFight)
                {
                    if (mcCell.num != undefined)
                    {
                        this.api.network.Game.setFlag(mcCell.num);
                    } // end if
                    this.api.gfx.clearPointer();
                    this.api.gfx.unSelectAllButOne("startPosition");
                    this.api.ui.removeCursor();
                    if (this.api.datacenter.Game.isRunning && this.api.datacenter.Game.currentPlayerID == this.api.datacenter.Player.ID)
                    {
                        this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
                        this.api.datacenter.Game.setInteractionType("move");
                    }
                    else
                    {
                        this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
                        this.api.datacenter.Game.setInteractionType("place");
                    } // end if
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.onCellRollOver = function (mcCell)
    {
        if (this.api.kernel.TutorialManager.isTutorialMode)
        {
            this.api.kernel.TutorialManager.onWaitingCase({code: "CELL_OVER", params: [mcCell.num]});
            return;
        } // end if
        if (this.api.datacenter.Game.isRunning && (!this.api.datacenter.Player.isCurrentPlayer && this.api.datacenter.Game.interactionType != 6))
        {
            return;
        } // end if
        switch (this.api.datacenter.Game.interactionType)
        {
            case 1:
            {
                var _loc3 = this.api.datacenter.Player;
                var _loc4 = _loc3.data;
                var _loc5 = this.mapHandler.getCellData(mcCell.num).spriteOnID;
                var _loc6 = this.api.datacenter.Sprites.getItemAt(_loc5);
                if (_loc6 != undefined)
                {
                    this.showSpriteInfosIfWeNeed(_loc6);
                } // end if
                if (ank.battlefield.utils.Pathfinding.checkRange(this.mapHandler, _loc4.cellNum, mcCell.num, false, 0, _loc4.MP, 0))
                {
                    this.api.datacenter.Player.InteractionsManager.setState(this.api.datacenter.Game.isFight);
                    this.api.datacenter.Player.InteractionsManager.calculatePath(this.mapHandler, mcCell.num, false, this.api.datacenter.Game.isFight);
                }
                else
                {
                    delete this.api.datacenter.Basics.interactionsManager_path;
                } // end else if
                break;
            } 
            case 2:
            case 3:
            {
                var _loc7 = this.api.datacenter.Player;
                var _loc8 = _loc7.data;
                var _loc9 = _loc8.cellNum;
                var _loc10 = _loc7.currentUseObject;
                var _loc11 = _loc7.SpellsManager;
                var _loc12 = _loc10.canBoostRange ? (_loc8.CharacteristicsManager.getModeratorValue(19) + _loc7.RangeModerator) : (0);
                this.api.datacenter.Basics.gfx_canLaunch = _loc11.checkCanLaunchSpellOnCell(this.mapHandler, _loc10, this.mapHandler.getCellData(mcCell.num), _loc12);
                if (this.api.datacenter.Basics.gfx_canLaunch)
                {
                    this.api.ui.setCursorForbidden(false);
                    this.drawPointer(mcCell.num);
                }
                else
                {
                    this.api.ui.setCursorForbidden(true, dofus.Constants.FORBIDDEN_FILE);
                } // end else if
                break;
            } 
            case 5:
            case 6:
            {
                this.api.datacenter.Basics.gfx_canLaunch = true;
                this.api.ui.setCursorForbidden(false);
                this.drawPointer(mcCell.num);
                break;
            } 
        } // End of switch
    };
    _loc1.onCellRollOut = function (mcCell)
    {
        if (this.api.kernel.TutorialManager.isTutorialMode)
        {
            this.api.kernel.TutorialManager.onWaitingCase({code: "CELL_OUT", params: [mcCell.num]});
            return;
        } // end if
        if (this.api.datacenter.Game.isRunning && (!this.api.datacenter.Player.isCurrentPlayer && this.api.datacenter.Game.interactionType != 6))
        {
            return;
        } // end if
        switch (this.api.datacenter.Game.interactionType)
        {
            case 1:
            {
                this.hideSpriteInfos();
                this.unSelect(true);
                break;
            } 
            case 2:
            case 3:
            {
                this.api.ui.setCursorForbidden(true, dofus.Constants.FORBIDDEN_FILE);
                this.hidePointer();
                this.api.datacenter.Basics.gfx_canLaunch = false;
                this.hideSpriteInfos();
                break;
            } 
            case 5:
            case 6:
            {
                this.api.ui.setCursorForbidden(true, dofus.Constants.FORBIDDEN_FILE);
                this.api.datacenter.Basics.gfx_canLaunch = false;
                this.hidePointer();
                break;
            } 
        } // End of switch
    };
    _loc1.onSpriteRelease = function (mcSprite)
    {
        var _loc3 = mcSprite.data;
        var _loc4 = _loc3.id;
        if (this.api.kernel.TutorialManager.isTutorialMode)
        {
            this.api.kernel.TutorialManager.onWaitingCase({code: "SPRITE_RELEASE", params: [_loc3.id]});
            return;
        } // end if
        if (_loc3.hasParent)
        {
            this.onSpriteRelease(_loc3.linkedParent.mc);
            return;
        } // end if
        switch (this.api.datacenter.Game.interactionType)
        {
            case 5:
            {
                if (this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
                {
                    this.api.network.Items.use(this.api.datacenter.Player.currentUseObject.ID, _loc3.id, _loc3.cellNum);
                } // end if
                this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
                this.api.gfx.clearPointer();
                this.unSelect(true);
                this.api.datacenter.Player.reset();
                this.api.ui.removeCursor();
                this.api.datacenter.Game.setInteractionType("move");
                break;
            } 
            default:
            {
                if (_loc3 instanceof dofus.datacenter.Mutant && !_loc3.showIsPlayer)
                {
                    if (!this.api.datacenter.Game.isRunning)
                    {
                        if (this.api.datacenter.Player.isMutant)
                        {
                            return;
                        } // end if
                    } // end if
                    var _loc5 = this.mapHandler.getCellData(_loc3.cellNum).mc;
                    this.onCellRelease(_loc5);
                }
                else if (_loc3 instanceof dofus.datacenter.Character || _loc3 instanceof dofus.datacenter.Mutant && _loc3.showIsPlayer)
                {
                    if (this.api.datacenter.Game.isFight)
                    {
                        if (this.api.datacenter.Game.isRunning)
                        {
                            var _loc6 = this.mapHandler.getCellData(_loc3.cellNum).mc;
                            this.onCellRelease(_loc6);
                            return;
                        } // end if
                    } // end if
                    this.api.kernel.GameManager.showPlayerPopupMenu(_loc3, undefined);
                }
                else if (_loc3 instanceof dofus.datacenter.NonPlayableCharacter)
                {
                    if (this.api.datacenter.Player.cantSpeakNPC)
                    {
                        return;
                    } // end if
                    var _loc7 = _loc3.actions;
                    if (_loc7 != undefined && _loc7.length != 0)
                    {
                        var _loc8 = this.api.ui.createPopupMenu();
                        var _loc9 = _loc7.length;
                        while (_loc9-- > 0)
                        {
                            var _loc10 = _loc7[_loc9].action;
                            _loc8.addItem(_loc7[_loc9].name, _loc10.object, _loc10.method, _loc10.params);
                        } // end while
                        _loc8.show(_root._xmouse, _root._ymouse);
                    } // end if
                }
                else if (_loc3 instanceof dofus.datacenter.Team)
                {
                    var _loc11 = this.api.datacenter.Player.data.alignment.index;
                    var _loc12 = _loc3.alignment.index;
                    var _loc13 = _loc3.enemyTeam.alignment.index;
                    var _loc14 = _loc3.challenge.fightType;
                    var _loc15 = false;
                    switch (_loc14)
                    {
                        case 0:
                        {
                            switch (_loc3.type)
                            {
                                case 0:
                                case 2:
                                {
                                    _loc15 = this.api.datacenter.Player.canChallenge && (!this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant);
                                    break;
                                } 
                            } // End of switch
                            break;
                        } 
                        case 1:
                        case 2:
                        {
                            switch (_loc3.type)
                            {
                                case 0:
                                case 1:
                                {
                                    if (_loc11 == _loc12)
                                    {
                                        _loc15 = !this.api.datacenter.Player.isMutant;
                                    }
                                    else
                                    {
                                        _loc15 = this.api.lang.getAlignmentCanJoin(_loc11, _loc12) && (this.api.lang.getAlignmentCanAttack(_loc11, _loc13) && !this.api.datacenter.Player.isMutant);
                                    } // end else if
                                    break;
                                } 
                            } // End of switch
                            break;
                        } 
                        case 3:
                        {
                            switch (_loc3.type)
                            {
                                case 0:
                                {
                                    _loc15 = !this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant;
                                    break;
                                } 
                                case 1:
                                {
                                    _loc15 = false;
                                    break;
                                } 
                            } // End of switch
                            break;
                        } 
                        case 4:
                        {
                            switch (_loc3.type)
                            {
                                case 0:
                                {
                                    _loc15 = !this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant;
                                    break;
                                } 
                                case 1:
                                {
                                    _loc15 = false;
                                    break;
                                } 
                            } // End of switch
                            break;
                        } 
                        case 5:
                        {
                            switch (_loc3.type)
                            {
                                case 0:
                                {
                                    _loc15 = !this.api.datacenter.Player.isMutant && !this.api.datacenter.Player.cantInteractWithTaxCollector;
                                    break;
                                } 
                                case 3:
                                {
                                    _loc15 = false;
                                    break;
                                } 
                            } // End of switch
                            break;
                        } 
                        case 6:
                        {
                            switch (_loc3.type)
                            {
                                case 0:
                                {
                                    _loc15 = !this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant;
                                    break;
                                } 
                                case 2:
                                {
                                    _loc15 = this.api.datacenter.Player.isMutant && !this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant == true;
                                    break;
                                } 
                            } // End of switch
                            break;
                        } 
                    } // End of switch
                    if (_loc15)
                    {
                        var _loc16 = this.api.ui.createPopupMenu();
                        var _loc17 = this.api.lang.getMapMaxTeam(this.api.datacenter.Map.id);
                        var _loc18 = this.api.lang.getMapMaxChallenge(this.api.datacenter.Map.id);
                        if (_loc3.challenge.count >= _loc18)
                        {
                            _loc16.addItem(this.api.lang.getText("CHALENGE_FULL"));
                        }
                        else if (_loc3.count >= _loc17)
                        {
                            _loc16.addItem(this.api.lang.getText("TEAM_FULL"));
                        }
                        else if (Key.isDown(Key.SHIFT))
                        {
                            this.api.network.GameActions.joinChallenge(_loc3.challenge.id, _loc3.id);
                            this.api.ui.hideTooltip();
                        }
                        else
                        {
                            _loc16.addItem(this.api.lang.getText("JOIN_SMALL"), this.api.network.GameActions, this.api.network.GameActions.joinChallenge, [_loc3.challenge.id, _loc3.id]);
                        } // end else if
                        _loc16.show(_root._xmouse, _root._ymouse);
                    } // end if
                }
                else if (_loc3 instanceof dofus.datacenter.ParkMount)
                {
                    if (_loc3.ownerName == this.api.datacenter.Player.Name || this.api.datacenter.Map.mountPark.guildName == this.api.datacenter.Player.guildInfos.name && this.api.datacenter.Player.guildInfos.playerRights.canManageOtherMount)
                    {
                        var _loc19 = this.api.ui.createPopupMenu();
                        _loc19.addStaticItem(this.api.lang.getText("MOUNT_OF", [_loc3.ownerName]));
                        _loc19.addItem(this.api.lang.getText("VIEW_MOUNT_DETAILS"), this.api.network.Mount, this.api.network.Mount.parkMountData, [_loc3.id]);
                        _loc19.show(_root._xmouse, _root._ymouse);
                    } // end if
                }
                else if (_loc3 instanceof dofus.datacenter.Creature)
                {
                    var _loc20 = this.mapHandler.getCellData(_loc3.cellNum).mc;
                    this.onCellRelease(_loc20);
                }
                else if (_loc3 instanceof dofus.datacenter.MonsterGroup || _loc3 instanceof dofus.datacenter.Monster)
                {
                    if (_loc3 instanceof dofus.datacenter.Monster && this.api.kernel.GameManager.isInMyTeam(_loc3))
                    {
                        this.api.kernel.GameManager.showMonsterPopupMenu(_loc3);
                    } // end if
                    if (!this.api.datacenter.Player.isMutant || (this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant || this.api.datacenter.Player.canAttackMonstersAnywhereWhenMutant))
                    {
                        var _loc21 = this.mapHandler.getCellData(_loc3.cellNum).mc;
                        this.onCellRelease(_loc21);
                    } // end if
                }
                else if (_loc3 instanceof dofus.datacenter.OfflineCharacter)
                {
                    if (!this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant)
                    {
                        if (!this.api.datacenter.Player.canExchange)
                        {
                            return;
                        } // end if
                        var _loc22 = this.api.ui.createPopupMenu();
                        _loc22.addStaticItem(this.api.lang.getText("SHOP") + " " + this.api.lang.getText("OF") + " " + _loc3.name);
                        _loc22.addItem(this.api.lang.getText("BUY"), this.api.kernel.GameManager, this.api.kernel.GameManager.startExchange, [4, _loc3.id, _loc3.cellNum]);
                        if (this.api.datacenter.Player.isAtHome(this.api.datacenter.Map.id))
                        {
                            _loc22.addItem(this.api.lang.getText("KICKOFF"), this.api.network.Basics, this.api.network.Basics.kick, [_loc3.cellNum]);
                        } // end if
                        _loc22.show(_root._xmouse, _root._ymouse);
                    } // end if
                }
                else if (_loc3 instanceof dofus.datacenter.TaxCollector)
                {
                    if (!this.api.datacenter.Player.isMutant)
                    {
                        if (this.api.datacenter.Player.cantInteractWithTaxCollector)
                        {
                            return;
                        } // end if
                        if (this.api.datacenter.Game.isFight)
                        {
                            var _loc23 = this.mapHandler.getCellData(_loc3.cellNum).mc;
                            this.onCellRelease(_loc23);
                        }
                        else
                        {
                            var _loc24 = this.api.datacenter.Player.guildInfos.playerRights;
                            var _loc25 = _loc3.guildName == this.api.datacenter.Player.guildInfos.name;
                            var _loc26 = _loc25 && _loc24.canHireTaxCollector;
                            var _loc27 = this.api.ui.createPopupMenu();
                            _loc27.addItem(this.api.lang.getText("SPEAK"), this.api.network.Dialog, this.api.network.Dialog.create, [_loc4]);
                            _loc27.addItem(this.api.lang.getText("COLLECT_TAX"), this.api.kernel.GameManager, this.api.kernel.GameManager.startExchange, [8, _loc4], _loc25);
                            _loc27.addItem(this.api.lang.getText("ATTACK"), this.api.network.GameActions, this.api.network.GameActions.attackTaxCollector, [[_loc4]], !_loc25);
                            _loc27.addItem(this.api.lang.getText("REMOVE"), this.api.kernel.GameManager, this.api.kernel.GameManager.askRemoveTaxCollector, [[_loc4]], _loc26);
                            _loc27.show(_root._xmouse, _root._ymouse);
                        } // end if
                    } // end else if
                }
                else if (_loc3 instanceof dofus.datacenter.PrismSprite)
                {
                    if (!this.api.datacenter.Player.isMutant)
                    {
                        if (this.api.datacenter.Game.isFight)
                        {
                            var _loc28 = this.mapHandler.getCellData(_loc3.cellNum).mc;
                            this.onCellRelease(_loc28);
                        }
                        else
                        {
                            var _loc29 = this.api.datacenter.Player.alignment.compareTo(_loc3.alignment) == 0;
                            var _loc30 = this.api.ui.createPopupMenu();
                            _loc30.addItem(this.api.lang.getText("USE_WORD"), this.api.network.GameActions, this.api.network.GameActions.usePrism, [[_loc4]], _loc29);
                            _loc30.addItem(this.api.lang.getText("ATTACK"), this.api.network.GameActions, this.api.network.GameActions.attackPrism, [[_loc4]], !_loc29);
                            _loc30.show(_root._xmouse, _root._ymouse);
                        } // end else if
                    } // end else if
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.onSpriteRollOver = function (mcSprite)
    {
        if (this.api.ui.getUIComponent("Zoom") != undefined)
        {
            return;
        } // end if
        var _loc5 = mcSprite.data;
        var _loc6 = dofus.Constants.OVERHEAD_TEXT_OTHER;
        if (_loc5.isClear)
        {
            return;
        } // end if
        if (_loc5.hasParent)
        {
            this.onSpriteRollOver(_loc5.linkedParent.mc);
            return;
        } // end if
        if (this.api.datacenter.Game.isRunning || this.api.datacenter.Game.interactionType == 5)
        {
            var _loc8 = this.mapHandler.getCellData(_loc5.cellNum).mc;
            if (_loc5.isVisible)
            {
                this.onCellRollOver(_loc8);
            } // end if
        } // end if
        var _loc9 = _loc5.name;
        if (_loc5 instanceof dofus.datacenter.Mutant && _loc5.showIsPlayer)
        {
            if (this.api.datacenter.Game.isRunning)
            {
                _loc9 = _loc5.playerName + " (" + _loc5.LP + ")";
                this.showSpriteInfosIfWeNeed(_loc5);
            }
            else
            {
                _loc9 = _loc5.playerName + " [" + _loc5.monsterName + " (" + _loc5.Level + ")]";
            } // end else if
        }
        else if (_loc5 instanceof dofus.datacenter.Mutant || (_loc5 instanceof dofus.datacenter.Creature || _loc5 instanceof dofus.datacenter.Monster))
        {
            _loc6 = dofus.Constants.NPC_ALIGNMENT_COLOR[_loc5.alignment.index];
            if (this.api.datacenter.Game.isRunning)
            {
                _loc9 = _loc9 + (" (" + _loc5.LP + ")");
                this.showSpriteInfosIfWeNeed(_loc5);
            }
            else
            {
                _loc9 = _loc9 + (" (" + _loc5.Level + ")");
            } // end else if
        }
        else if (_loc5 instanceof dofus.datacenter.Character)
        {
            _loc6 = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
            if (this.api.datacenter.Game.isRunning)
            {
                _loc9 = _loc9 + (" (" + _loc5.LP + ")");
                if (_loc5.isVisible)
                {
                    var _loc10 = _loc5.EffectsManager.getEffects();
                    if (_loc10.length != 0)
                    {
                        this.addSpriteOverHeadItem(_loc5.id, "effects", dofus.graphics.battlefield.EffectsOverHead, [_loc10]);
                    } // end if
                } // end if
                this.showSpriteInfosIfWeNeed(_loc5);
            }
            else if (this.api.datacenter.Game.isFight)
            {
                _loc9 = _loc9 + (" (" + _loc5.Level + ")");
            } // end else if
            if (!_loc5.isVisible)
            {
                return;
            } // end if
            var _loc3 = dofus.Constants.DEMON_ANGEL_FILE;
            if (_loc5.alignment.fallenAngelDemon)
            {
                _loc3 = dofus.Constants.FALLEN_DEMON_ANGEL_FILE;
            } // end if
            var _loc11 = _loc5.haveFakeAlignement ? (_loc5.fakeAlignment.index) : (_loc5.alignment.index);
            if (_loc5.rank.value > 0)
            {
                if (_loc11 == 1)
                {
                    var _loc4 = _loc5.rank.value;
                }
                else if (_loc11 == 2)
                {
                    _loc4 = 10 + _loc5.rank.value;
                }
                else if (_loc11 == 3)
                {
                    _loc4 = 20 + _loc5.rank.value;
                } // end else if
            } // end else if
            var _loc7 = _loc5.title;
            if (_loc5.guildName != undefined && _loc5.guildName.length != 0)
            {
                _loc9 = "";
                this.addSpriteOverHeadItem(_loc5.id, "text", dofus.graphics.battlefield.GuildOverHead, [_loc5.guildName, _loc5.name, _loc5.emblem, _loc3, _loc4, _loc5.pvpGain, _loc7], undefined, true);
            } // end if
        }
        else if (_loc5 instanceof dofus.datacenter.TaxCollector)
        {
            if (this.api.datacenter.Game.isRunning)
            {
                _loc9 = _loc9 + (" (" + _loc5.LP + ")");
                this.showSpriteInfosIfWeNeed(_loc5);
            }
            else if (this.api.datacenter.Game.isFight)
            {
                _loc9 = _loc9 + (" (" + _loc5.Level + ")");
            }
            else
            {
                _loc9 = "";
                this.addSpriteOverHeadItem(_loc5.id, "text", dofus.graphics.battlefield.GuildOverHead, [_loc5.guildName, _loc5.name, _loc5.emblem]);
            } // end else if
        }
        else if (_loc5 instanceof dofus.datacenter.PrismSprite)
        {
            _loc3 = dofus.Constants.DEMON_ANGEL_FILE;
            if (_loc5.alignment.value > 0)
            {
                if (_loc5.alignment.index == 1)
                {
                    _loc4 = _loc5.alignment.value;
                }
                else if (_loc5.alignment.index == 2)
                {
                    _loc4 = 10 + _loc5.alignment.value;
                }
                else if (_loc5.alignment.index == 3)
                {
                    _loc4 = 20 + _loc5.alignment.value;
                } // end else if
            } // end else if
            _loc6 = dofus.Constants.NPC_ALIGNMENT_COLOR[_loc5.alignment.index];
            this.addSpriteOverHeadItem(_loc5.id, "text", dofus.graphics.battlefield.TextOverHead, [_loc9, _loc3, _loc6, _loc4]);
        }
        else if (_loc5 instanceof dofus.datacenter.ParkMount)
        {
            _loc6 = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
            _loc9 = this.api.lang.getText("MOUNT_PARK_OVERHEAD", [_loc5.modelName, _loc5.level, _loc5.ownerName]);
            this.addSpriteOverHeadItem(_loc5.id, "text", dofus.graphics.battlefield.TextOverHead, [_loc9, _loc3, _loc6, _loc4]);
        }
        else if (_loc5 instanceof dofus.datacenter.OfflineCharacter)
        {
            _loc6 = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
            _loc9 = "";
            this.addSpriteOverHeadItem(_loc5.id, "text", dofus.graphics.battlefield.OfflineOverHead, [_loc5]);
        }
        else if (_loc5 instanceof dofus.datacenter.NonPlayableCharacter)
        {
            var _loc12 = this.api.datacenter.Map;
            var _loc13 = this.api.datacenter.Subareas.getItemAt(_loc12.subarea);
            if (_loc13 != undefined)
            {
                _loc6 = dofus.Constants.NPC_ALIGNMENT_COLOR[_loc13.alignment.index];
            } // end if
        }
        else if (_loc5 instanceof dofus.datacenter.MonsterGroup || _loc5 instanceof dofus.datacenter.Team)
        {
            if (_loc5.alignment.index != -1)
            {
                _loc6 = dofus.Constants.NPC_ALIGNMENT_COLOR[_loc5.alignment.index];
            } // end if
            var _loc14 = _loc5.challenge.fightType;
            if (_loc5.isVisible && (_loc5 instanceof dofus.datacenter.MonsterGroup || _loc5.type == 1 && (_loc14 == 2 || (_loc14 == 3 || _loc14 == 4))))
            {
                if (_loc9 != "")
                {
                    var _loc15 = dofus.Constants.OVERHEAD_TEXT_TITLE;
                    this.addSpriteOverHeadItem(_loc5.id, "text", dofus.graphics.battlefield.TextWithTitleOverHead, [_loc9, _loc3, _loc6, _loc4, this.api.lang.getText("LEVEL") + " " + _loc5.totalLevel, _loc15, _loc5.bonusValue]);
                } // end if
                this.selectSprite(_loc5.id, true);
                return;
            } // end else if
        } // end else if
        if (_loc5.isVisible)
        {
            if (_loc9 != "")
            {
                this.addSpriteOverHeadItem(_loc5.id, "text", dofus.graphics.battlefield.TextOverHead, [_loc9, _loc3, _loc6, _loc4, _loc5.pvpGain, _loc7]);
            } // end if
            this.selectSprite(_loc5.id, true);
        } // end if
    };
    _loc1.onSpriteRollOut = function (mcSprite)
    {
        var _loc3 = mcSprite.data;
        if (_loc3.hasParent)
        {
            this.onSpriteRollOut(_loc3.linkedParent.mc);
            return;
        } // end if
        if (this.api.datacenter.Game.isRunning || this.api.datacenter.Game.interactionType == 5)
        {
            this.hideSpriteInfos();
            var _loc4 = this.mapHandler.getCellData(_loc3.cellNum).mc;
            this.onCellRollOut(_loc4);
        } // end if
        this.removeSpriteOverHeadLayer(_loc3.id, "text");
        this.removeSpriteOverHeadLayer(_loc3.id, "effects");
        this.selectSprite(_loc3.id, false);
    };
    _loc1.onObjectRelease = function (mcObject)
    {
        this.api.ui.hideTooltip();
        var _loc3 = mcObject.cellData;
        var _loc4 = _loc3.mc;
        var _loc5 = _loc3.layerObject2Num;
        if (this.api.kernel.TutorialManager.isTutorialMode)
        {
            this.api.kernel.TutorialManager.onWaitingCase({code: "OBJECT_RELEASE", params: [_loc3.num, _loc5]});
            return;
        } // end if
        var _loc6 = _loc3.layerObjectExternalData;
        if (_loc6 != undefined)
        {
            if (_loc6.durability != undefined)
            {
                if (this.api.datacenter.Map.mountPark.isMine(this.api))
                {
                    var _loc7 = this.api.ui.createPopupMenu();
                    _loc7.addStaticItem(_loc6.name);
                    _loc7.addItem(this.api.lang.getText("REMOVE"), this.api.network.Mount, this.api.network.Mount.removeObjectInPark, [_loc4.num]);
                    _loc7.show(_root._xmouse, _root._ymouse);
                    return;
                } // end if
            } // end if
        } // end if
        if (!_global.isNaN(_loc5) && (this.api.datacenter.Player.canUseInteractiveObjects && this.api.datacenter.Game.interactionType != 5))
        {
            var _loc8 = this.api.lang.getInteractiveObjectDataByGfxText(_loc5);
            var _loc9 = _loc8.n;
            var _loc10 = _loc8.sk;
            var _loc11 = _loc8.t;
            switch (_loc11)
            {
                case 1:
                case 2:
                case 3:
                case 4:
                case 7:
                case 10:
                case 12:
                case 14:
                case 15:
                {
                    var _loc12 = this.api.datacenter.Player.currentJobID != undefined;
                    if (_loc12)
                    {
                        var _loc13 = this.api.datacenter.Player.Jobs.findFirstItem("id", this.api.datacenter.Player.currentJobID).item.skills;
                    }
                    else
                    {
                        _loc13 = new ank.utils.ExtendedArray();
                    } // end else if
                    var _loc14 = this.api.ui.createPopupMenu();
                    _loc14.addStaticItem(_loc9);
                    for (var k in _loc10)
                    {
                        var _loc15 = _loc10[k];
                        var _loc16 = new dofus.datacenter.Skill(_loc15);
                        var _loc17 = _loc13.findFirstItem("id", _loc15).index != -1;
                        var _loc18 = this.api.datacenter.Player.Level <= dofus.Constants.NOVICE_LEVEL;
                        var _loc19 = _loc16.getState(_loc17, false, false, false, false, _loc18);
                        if (_loc19 != "X")
                        {
                            _loc14.addItem(_loc16.description, this.api.kernel.GameManager, this.api.kernel.GameManager.useRessource, [_loc4, _loc4.num, _loc15], _loc19 == "V");
                        } // end if
                    } // end of for...in
                    _loc14.show(_root._xmouse, _root._ymouse);
                    break;
                } 
                case 5:
                {
                    var _loc20 = this.api.ui.createPopupMenu();
                    var _loc21 = this.api.lang.getHousesDoorText(this.api.datacenter.Map.id, _loc4.num);
                    var _loc22 = this.api.datacenter.Houses.getItemAt(_loc21);
                    _loc20.addStaticItem(_loc9 + " " + _loc22.name);
                    if (_loc22.localOwner)
                    {
                        _loc20.addStaticItem(this.api.lang.getText("MY_HOME"));
                    }
                    else if (_loc22.ownerName != undefined)
                    {
                        if (_loc22.ownerName == "?")
                        {
                            _loc20.addStaticItem(this.api.lang.getText("HOUSE_WITH_NO_OWNER"));
                        }
                        else
                        {
                            _loc20.addStaticItem(this.api.lang.getText("HOME_OF", [_loc22.ownerName]));
                        } // end else if
                    } // end else if
                    for (var k in _loc10)
                    {
                        var _loc23 = _loc10[k];
                        var _loc24 = new dofus.datacenter.Skill(_loc23);
                        var _loc25 = _loc24.getState(true, _loc22.localOwner, _loc22.isForSale, _loc22.isLocked);
                        if (_loc25 != "X")
                        {
                            _loc20.addItem(_loc24.description, this.api.kernel.GameManager, this.api.kernel.GameManager.useRessource, [_loc4, _loc4.num, _loc23], _loc25 == "V");
                        } // end if
                    } // end of for...in
                    _loc20.show(_root._xmouse, _root._ymouse);
                    break;
                } 
                case 6:
                {
                    var _loc26 = this.api.datacenter.Map.id + "_" + _loc4.num;
                    var _loc27 = this.api.datacenter.Storages.getItemAt(_loc26);
                    var _loc28 = _loc27.isLocked;
                    var _loc29 = this.api.datacenter.Player.isAtHome(this.api.datacenter.Map.id);
                    var _loc30 = this.api.ui.createPopupMenu();
                    _loc30.addStaticItem(_loc9);
                    for (var k in _loc10)
                    {
                        var _loc31 = _loc10[k];
                        var _loc32 = new dofus.datacenter.Skill(_loc31);
                        var _loc33 = _loc32.getState(true, _loc29, true, _loc28);
                        if (_loc33 != "X")
                        {
                            _loc30.addItem(_loc32.description, this.api.kernel.GameManager, this.api.kernel.GameManager.useRessource, [_loc4, _loc4.num, _loc31], _loc33 == "V");
                        } // end if
                    } // end of for...in
                    _loc30.show(_root._xmouse, _root._ymouse);
                    break;
                } 
                case 13:
                {
                    var _loc34 = this.api.datacenter.Map.mountPark;
                    var _loc35 = this.api.ui.createPopupMenu();
                    _loc35.addStaticItem(_loc9);
                    for (var k in _loc10)
                    {
                        var _loc36 = _loc10[k];
                        var _loc37 = new dofus.datacenter.Skill(_loc36);
                        var _loc38 = _loc37.getState(true, _loc34.isMine(this.api), _loc34.price > 0, _loc34.isPublic || _loc34.isMine(this.api), false, _loc34.isPublic);
                        if (_loc38 != "X")
                        {
                            _loc35.addItem(_loc37.description, this.api.kernel.GameManager, this.api.kernel.GameManager.useRessource, [_loc4, _loc4.num, _loc36], _loc38 == "V");
                        } // end if
                    } // end of for...in
                    _loc35.show(_root._xmouse, _root._ymouse);
                    break;
                } 
                default:
                {
                    this.onCellRelease(_loc4);
                } 
            } // End of switch
        }
        else
        {
            this.onCellRelease(_loc4);
        } // end else if
    };
    _loc1.onObjectRollOver = function (mcObject)
    {
        if (this.api.ui.getUIComponent("Zoom") != undefined)
        {
            return;
        } // end if
        var _loc3 = mcObject.cellData;
        var _loc4 = _loc3.mc;
        var _loc5 = _loc3.layerObject2Num;
        if (this.api.datacenter.Game.interactionType == 5)
        {
            _loc4 = mcObject.cellData.mc;
            this.onCellRollOver(_loc4);
        } // end if
        mcObject.select(true);
        var _loc6 = _loc3.layerObjectExternalData;
        if (_loc6 != undefined)
        {
            var _loc7 = _loc6.name;
            if (_loc6.durability != undefined)
            {
                if (this.api.datacenter.Map.mountPark.isMine(this.api))
                {
                    _loc7 = _loc7 + ("\n" + this.api.lang.getText("DURABILITY") + " : " + _loc6.durability + "/" + _loc6.durabilityMax);
                } // end if
            } // end if
            var _loc8 = new dofus.datacenter.Character("itemOnCell", ank.battlefield.mc.Sprite, "", _loc4.num, 0, 0);
            this.api.datacenter.Sprites.addItemAt("itemOnCell", _loc8);
            this.api.gfx.addSprite("itemOnCell");
            this.addSpriteOverHeadItem("itemOnCell", "text", dofus.graphics.battlefield.TextOverHead, [_loc7, "", dofus.Constants.OVERHEAD_TEXT_CHARACTER]);
        } // end if
        var _loc9 = this.api.lang.getInteractiveObjectDataByGfxText(_loc5);
        var _loc10 = _loc9.n;
        var _loc11 = _loc9.sk;
        var _loc12 = _loc9.t;
        switch (_loc12)
        {
            case 5:
            {
                var _loc13 = this.api.lang.getHousesDoorText(this.api.datacenter.Map.id, _loc4.num);
                var _loc14 = (dofus.datacenter.House)(this.api.datacenter.Houses.getItemAt(_loc13));
                if (_loc14.guildName.length > 0)
                {
                    var _loc15 = new dofus.datacenter.Character("porte", ank.battlefield.mc.Sprite, "", _loc4.num, 0, 0);
                    this.api.datacenter.Sprites.addItemAt("porte", _loc15);
                    this.api.gfx.addSprite("porte");
                    this.addSpriteOverHeadItem("porte", "text", dofus.graphics.battlefield.GuildOverHead, [this.api.lang.getText("GUILD_HOUSE"), _loc14.guildName, _loc14.guildEmblem]);
                } // end if
                break;
            } 
            case 13:
            {
                var _loc16 = this.api.datacenter.Map.mountPark;
                var _loc17 = new dofus.datacenter.Character("enclos", ank.battlefield.mc.Sprite, "", _loc4.num, 0, 0);
                this.api.datacenter.Sprites.addItemAt("enclos", _loc17);
                this.api.gfx.addSprite("enclos");
                if (_loc16.isPublic)
                {
                    this.addSpriteOverHeadItem("enclos", "text", dofus.graphics.battlefield.TextOverHead, [this.api.lang.getText("MOUNTPARK_PUBLIC"), "", dofus.Constants.OVERHEAD_TEXT_CHARACTER]);
                }
                else if (_loc16.hasNoOwner)
                {
                    this.addSpriteOverHeadItem("enclos", "text", dofus.graphics.battlefield.TextOverHead, [this.api.lang.getText("MOUNTPARK_TO_BUY", [_loc16.price, _loc16.size, _loc16.items]), "", dofus.Constants.OVERHEAD_TEXT_CHARACTER]);
                }
                else
                {
                    if (_loc16.price > 0)
                    {
                        var _loc18 = this.api.lang.getText("MOUNTPARK_PRIVATE_TO_BUY", [_loc16.price]);
                    }
                    else
                    {
                        _loc18 = this.api.lang.getText("MOUNTPARK_PRIVATE");
                    } // end else if
                    this.addSpriteOverHeadItem("enclos", "text", dofus.graphics.battlefield.GuildOverHead, [_loc16.guildName, _loc18, _loc16.guildEmblem]);
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.onObjectRollOut = function (mcObject)
    {
        this.api.ui.hideTooltip();
        if (this.api.datacenter.Game.interactionType == 5)
        {
            var _loc3 = mcObject.cellData.mc;
            this.onCellRollOut(_loc3);
        } // end if
        mcObject.select(false);
        this.removeSpriteOverHeadLayer("enclos", "text");
        this.removeSprite("enclos", false);
        this.removeSpriteOverHeadLayer("porte", "text");
        this.removeSprite("porte", false);
        this.removeSpriteOverHeadLayer("itemOnCell", "text");
        this.removeSprite("itemOnCell", false);
    };
    _loc1.showSpriteInfosIfWeNeed = function (oSprite)
    {
        if (this.api.ui.isCursorHidden())
        {
            if (this.api.kernel.OptionsManager.getOption("SpriteInfos"))
            {
                if (this.api.kernel.OptionsManager.getOption("SpriteMove") && oSprite.isVisible)
                {
                    this.api.gfx.drawZone(oSprite.cellNum, 0, oSprite.MP, "move", dofus.Constants.CELL_MOVE_RANGE_COLOR, "C");
                } // end if
                this.api.ui.getUIComponent("Banner").showRightPanel("BannerSpriteInfos", {data: oSprite});
            } // end if
        } // end if
    };
    _loc1.hideSpriteInfos = function ()
    {
        this.api.ui.getUIComponent("Banner").hideRightPanel();
        this.api.gfx.clearZoneLayer("move");
    };
    _loc1.addProperty("api", _loc1.__get__api, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
