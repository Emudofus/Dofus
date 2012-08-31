// Action script...

// [Initial MovieClip Action of sprite 966]
#initclip 178
class dofus.graphics.battlefield.DofusBattlefield extends ank.battlefield.Battlefield
{
    var _oAPI, setInteraction, mapHandler, drawPointer, unSelect, hidePointer, addSpriteOverHeadItem, selectSprite, removeSpriteOverHeadLayer, __get__api;
    function DofusBattlefield()
    {
        super();
    } // End of the function
    function get api()
    {
        return (_oAPI);
    } // End of the function
    function initialize(oDatacenter, sGroundFile, sObjectFile, oAPI)
    {
        super.initialize(oDatacenter, sGroundFile, sObjectFile);
        _oAPI = oAPI;
    } // End of the function
    function addSpritePoints(sID, sValue, nColor)
    {
        if (api.kernel.OptionsManager.getOption("PointsOverHead"))
        {
            super.addSpritePoints(sID, sValue, nColor);
        } // end if
    } // End of the function
    function onInitError()
    {
        _root.onCriticalError(api.lang.getText("CRITICAL_ERROR_LOADING_BATTLEFIELD"));
    } // End of the function
    function onMapLoaded()
    {
        var _loc5 = api.datacenter.Map;
        api.ui.unloadUIComponent("CenterText");
        api.ui.unloadUIComponent("FightsInfos");
        this.setInteraction(ank.battlefield.Constants.INTERACTION_NONE);
        this.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
        this.setInteraction(ank.battlefield.Constants.INTERACTION_SPRITE_RELEASE_OVER_OUT);
        if (api.datacenter.Game.isFight)
        {
            this.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_NONE);
        }
        else
        {
            this.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT);
        } // end else if
        api.datacenter.Game.setInteractionType("move");
        api.datacenter.Game.isInCreaturesMode = false;
        api.network.Game.getExtraInformations();
        api.ui.unloadLastUIAutoHideComponent();
        api.ui.getUIComponent("MapInfos").update();
        var _loc7 = _loc5.area;
        if (_loc7 != api.datacenter.Basics.gfx_lastArea)
        {
            var _loc9 = api.datacenter.Areas.getItemAt(_loc7);
            var _loc8 = new String();
            if (_loc9 == undefined)
            {
                _loc8 = api.lang.getMapAreaText(String(_loc7)).n;
            }
            else
            {
                _loc8 = _loc9.name + " (" + _loc9.alignment.name + ")";
            } // end else if
            api.ui.loadUIComponent("CenterText", "CenterText", {text: _loc8, background: false, timer: 2000}, {bForceLoad: true});
            api.datacenter.Basics.gfx_lastArea = _loc7;
        } // end if
        if (api.datacenter.Player.isAtHome(_loc5.id))
        {
            var _loc6 = new Array();
            var _loc4 = api.lang.getHousesIndoorSkillsText();
            for (var _loc2 = 0; _loc2 < _loc4.length; ++_loc2)
            {
                var _loc3 = new dofus.datacenter.Skill(_loc4[_loc2]);
                _loc6.push(_loc3);
            } // end of for
            var _loc10 = api.lang.getHousesMapText(_loc5.id);
            if (_loc10 != undefined)
            {
                var _loc11 = api.datacenter.Houses.getItemAt(_loc10);
                api.ui.loadUIComponent("HouseIndoor", "HouseIndoor", {skills: _loc6, house: _loc11}, {bStayIfPresent: true});
            } // end if
            api.ui.getUIComponent("MapInfos")._visible = false;
        }
        else
        {
            api.ui.unloadUIComponent("HouseIndoor");
        } // end else if
        api.kernel.OptionsManager.setOption("Grid", false);
        api.ui.getUIComponent("Banner").setCircleXtraParams({currentCoords: [_loc5.x, _loc5.y]});
        api.sounds.playAmbiance(_loc5.ambianceID);
        api.sounds.playMusic(_loc5.musicID);
        if (!_loc5.bOutdoor)
        {
            api.kernel.NightManager.noEffects();
        } // end if
    } // End of the function
    function onCellRelease(mcCell)
    {
        if (api.kernel.TutorialManager.isTutorialMode)
        {
            api.kernel.TutorialManager.onWaitingCase({code: "CELL_RELEASE", params: [mcCell.num]});
            return (false);
        } // end if
        switch (api.datacenter.Game.interactionType)
        {
            case 1:
            {
                var _loc5 = api.datacenter.Player.data;
                var _loc3 = false;
                if (api.datacenter.Player.InteractionsManager.calculatePath(mapHandler, mcCell.num, true, api.datacenter.Game.isFight, false))
                {
                    if (api.datacenter.Game.isFight)
                    {
                        _loc3 = true;
                    }
                    else
                    {
                        _loc3 = api.datacenter.Basics.interactionsManager_path[api.datacenter.Basics.interactionsManager_path.length - 1].num == mcCell.num;
                    } // end if
                } // end else if
                if (!api.datacenter.Game.isFight && !_loc3)
                {
                    if (api.datacenter.Player.InteractionsManager.calculatePath(mapHandler, mcCell.num, true, api.datacenter.Game.isFight, true))
                    {
                        _loc3 = true;
                    } // end if
                } // end if
                if (_loc3)
                {
                    if (getTimer() - api.datacenter.Basics.gfx_lastActionTime < dofus.Constants.CLICK_MIN_DELAY)
                    {
                        ank.utils.Logger.err("T trop rapide du clic");
                        return (null);
                    } // end if
                    api.datacenter.Basics.gfx_lastActionTime = getTimer();
                    if (api.datacenter.Basics.interactionsManager_path.length != 0)
                    {
                        var _loc4 = ank.battlefield.utils.Compressor.compressPath(api.datacenter.Basics.interactionsManager_path);
                        if (_loc4 != undefined)
                        {
                            _loc5.GameActionsManager.transmittingMove(1, [_loc4]);
                            delete api.datacenter.Basics.interactionsManager_path;
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
                if (api.datacenter.Player.currentUseObject != null && api.datacenter.Basics.gfx_canLaunch == true)
                {
                    _loc5 = api.datacenter.Player.data;
                    _loc5.GameActionsManager.transmittingOther(300, [api.datacenter.Player.currentUseObject.ID, mcCell.num]);
                    api.datacenter.Player.currentUseObject = null;
                }
                else if (api.datacenter.Basics.spellManager_errorMsg != undefined)
                {
                    api.kernel.showMessage(undefined, api.datacenter.Basics.spellManager_errorMsg, "ERROR_CHAT");
                    delete api.datacenter.Basics.spellManager_errorMsg;
                } // end else if
                api.ui.removeCursor();
                api.datacenter.Game.setInteractionType("move");
                break;
            } 
            case 3:
            {
                if (api.datacenter.Player.currentUseObject != null && api.datacenter.Basics.gfx_canLaunch == true)
                {
                    _loc5 = api.datacenter.Player.data;
                    _loc5.GameActionsManager.transmittingOther(303, [mcCell.num]);
                    api.datacenter.Player.currentUseObject = null;
                } // end if
                api.ui.removeCursor();
                api.datacenter.Game.setInteractionType("move");
                break;
            } 
            case 4:
            {
                var _loc6 = mapHandler.getCellData(mcCell.num).__get__spriteOnID();
                if (_loc6 != undefined)
                {
                    break;
                } // end if
                api.network.Game.setPlayerPosition(mcCell.num);
                break;
            } 
            case 5:
            {
                if (api.datacenter.Player.currentUseObject != null && api.datacenter.Basics.gfx_canLaunch == true)
                {
                    api.network.Items.use(api.datacenter.Player.currentUseObject.ID, mapHandler.getCellData(mcCell.num).__get__spriteOnID(), mcCell.num);
                } // end if
                api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
                api.gfx.clearPointer();
                api.datacenter.Player.reset();
                api.ui.removeCursor();
                api.datacenter.Game.setInteractionType("move");
                break;
            } 
        } // End of switch
    } // End of the function
    function onCellRollOver(mcCell)
    {
        if (api.kernel.TutorialManager.isTutorialMode)
        {
            api.kernel.TutorialManager.onWaitingCase({code: "CELL_OVER", params: [mcCell.num]});
            return;
        } // end if
        if (api.datacenter.Game.isRunning && !api.datacenter.Player.isCurrentPlayer)
        {
            return;
        } // end if
        switch (api.datacenter.Game.interactionType)
        {
            case 1:
            {
                var _loc3 = api.datacenter.Player;
                var _loc6 = _loc3.data;
                var _loc9 = mapHandler.getCellData(mcCell.num).__get__spriteOnID();
                var _loc4 = api.datacenter.Sprites.getItemAt(_loc9);
                if (_loc4 != undefined)
                {
                    this.showSpriteInfosIfWeNeed(_loc4);
                } // end if
                if (ank.battlefield.utils.Pathfinding.checkRange(mapHandler, _loc6.cellNum, mcCell.num, false, 0, _loc6.MP, 0))
                {
                    api.datacenter.Player.InteractionsManager.setState(api.datacenter.Game.isFight);
                    api.datacenter.Player.InteractionsManager.calculatePath(mapHandler, mcCell.num, false, api.datacenter.Game.isFight);
                }
                else
                {
                    delete api.datacenter.Basics.interactionsManager_path;
                } // end else if
                break;
            } 
            case 2:
            case 3:
            {
                _loc3 = api.datacenter.Player;
                _loc6 = _loc3.data;
                var _loc11 = _loc6.cellNum;
                var _loc5 = _loc3.currentUseObject;
                var _loc7 = _loc3.SpellsManager;
                var _loc8 = _loc5.canBoostRange ? (_loc6.CharacteristicsManager.getModeratorValue(19) + _loc3.RangeModerator) : (0);
                api.datacenter.Basics.gfx_canLaunch = _loc7.checkCanLaunchSpellOnCell(mapHandler, _loc5, mapHandler.getCellData(mcCell.num), _loc8);
                if (api.datacenter.Basics.gfx_canLaunch)
                {
                    api.ui.setCursorForbidden(false);
                    this.drawPointer(mcCell.num);
                }
                else
                {
                    api.ui.setCursorForbidden(true, dofus.Constants.FORBIDDEN_FILE);
                } // end else if
                break;
            } 
            case 5:
            {
                api.datacenter.Basics.gfx_canLaunch = true;
                if (api.datacenter.Basics.gfx_canLaunch)
                {
                    api.ui.setCursorForbidden(false);
                    this.drawPointer(mcCell.num);
                } // end if
                break;
            } 
        } // End of switch
    } // End of the function
    function onCellRollOut(mcCell)
    {
        if (api.kernel.TutorialManager.isTutorialMode)
        {
            api.kernel.TutorialManager.onWaitingCase({code: "CELL_OUT", params: [mcCell.num]});
            return;
        } // end if
        if (api.datacenter.Game.isRunning && !api.datacenter.Player.isCurrentPlayer)
        {
            return;
        } // end if
        switch (api.datacenter.Game.interactionType)
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
                api.ui.setCursorForbidden(true, dofus.Constants.FORBIDDEN_FILE);
                this.hidePointer();
                api.datacenter.Basics.gfx_canLaunch = false;
                this.hideSpriteInfos();
                break;
            } 
            case 5:
            {
                api.ui.setCursorForbidden(true, dofus.Constants.FORBIDDEN_FILE);
                api.datacenter.Basics.gfx_canLaunch = false;
                this.hidePointer();
                break;
            } 
        } // End of switch
    } // End of the function
    function onSpriteRelease(mcSprite)
    {
        var _loc3 = mcSprite.data;
        var _loc8 = _loc3.id;
        if (api.kernel.TutorialManager.isTutorialMode)
        {
            api.kernel.TutorialManager.onWaitingCase({code: "SPRITE_RELEASE", params: [_loc3.id]});
            return;
        } // end if
        if (_loc3.hasParent)
        {
            this.onSpriteRelease(_loc3.linkedParent.mc);
            return;
        } // end if
        switch (api.datacenter.Game.interactionType)
        {
            case 5:
            {
                if (api.datacenter.Player.currentUseObject != null && api.datacenter.Basics.gfx_canLaunch == true)
                {
                    api.network.Items.use(api.datacenter.Player.currentUseObject.ID, _loc3.id, _loc3.cellNum);
                } // end if
                api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
                api.gfx.clearPointer();
                api.datacenter.Player.reset();
                api.ui.removeCursor();
                api.datacenter.Game.setInteractionType("move");
                break;
            } 
            default:
            {
                if (_loc3 instanceof dofus.datacenter.Mutant)
                {
                    if (!api.datacenter.Game.isRunning)
                    {
                        if (api.datacenter.Player.isMutant)
                        {
                            return;
                        } // end if
                    } // end if
                    var _loc17 = mapHandler.getCellData(_loc3.cellNum).mc;
                    this.onCellRelease(_loc17);
                }
                else if (_loc3 instanceof dofus.datacenter.Character)
                {
                    if (api.datacenter.Game.isFight)
                    {
                        if (api.datacenter.Game.isRunning)
                        {
                            _loc17 = mapHandler.getCellData(_loc3.cellNum).mc;
                            this.onCellRelease(_loc17);
                            return;
                        } // end if
                        if (!api.datacenter.Player.isMutant)
                        {
                            if (_loc8 != api.datacenter.Player.ID)
                            {
                                var _loc9 = api.ui.createPopupMenu();
                                _loc9.addItem(api.lang.getText("KICK"), api.network.Game, api.network.Game.leave, [_loc8]);
                                _loc9.show(_root._xmouse, _root._ymouse);
                            } // end if
                        } // end if
                        return;
                    } // end if
                    if (_loc8 == api.datacenter.Player.ID)
                    {
                        _loc9 = api.ui.createPopupMenu();
                        _loc9.addItem(api.lang.getText("HIT_HIMSELF"), api.network.Chat, api.network.Chat.send, ["Aie !", "*"]);
                        if (api.datacenter.Player.canBeMerchant)
                        {
                            _loc9.addItem(api.lang.getText("ORGANIZE_SHOP"), api.kernel.GameManager, api.kernel.GameManager.startExchange, [6]);
                            _loc9.addItem(api.lang.getText("MERCHANT_MODE"), api.kernel.GameManager, api.kernel.GameManager.offlineExchange);
                        } // end if
                        _loc9.show(_root._xmouse, _root._ymouse);
                    }
                    else
                    {
                        _loc9 = api.ui.createPopupMenu();
                        _loc9.addItem(api.lang.getText("ADD_TO_FRIENDS"), api.network.Friends, api.network.Friends.addFriend, [_loc3.name]);
                        _loc9.addItem(api.lang.getText("WISPER_MESSAGE"), api.kernel.GameManager, api.kernel.GameManager.askPrivateMessage, [_loc3.name]);
                        if (api.datacenter.Player.canExchange && _loc3.canExchange)
                        {
                            _loc9.addItem(api.lang.getText("EXCHANGE"), api.kernel.GameManager, api.kernel.GameManager.startExchange, [1, _loc8]);
                        } // end if
                        if (api.datacenter.Player.canChallenge && _loc3.canBeChallenge)
                        {
                            _loc9.addItem(api.lang.getText("CHALLENGE"), api.network.GameActions, api.network.GameActions.challenge, [_loc8], api.datacenter.Map.bCanChallenge);
                        } // end if
                        if (api.datacenter.Player.canAssault && _loc3.canBeAssault)
                        {
                            var _loc16 = api.datacenter.Player.data.alignment.index;
                            if (api.lang.getAlignmentCanAttack(_loc16, _loc3.alignment.index))
                            {
                                _loc9.addItem(api.lang.getText("ASSAULT"), api.kernel.GameManager, api.kernel.GameManager.askAttack, [[_loc8]], api.datacenter.Map.bCanAttack);
                            } // end if
                        } // end if
                        if (api.datacenter.Player.canAttack && _loc3.canBeAttack)
                        {
                            _loc17 = mapHandler.getCellData(_loc3.cellNum).mc;
                            _loc9.addItem(api.lang.getText("ATTACK"), api.network.GameActions, api.network.GameActions.mutantAttack, [_loc3.id]);
                        } // end if
                        if (api.datacenter.Player.guildInfos != undefined)
                        {
                            if (_loc3.guildName == undefined || _loc3.guildName.length == 0)
                            {
                                if (api.datacenter.Player.guildInfos.playerRights.canInvite)
                                {
                                    _loc9.addItem(api.lang.getText("INVITE_IN_GUILD"), api.network.Guild, api.network.Guild.invite, [_loc3.name]);
                                } // end if
                            } // end if
                        } // end if
                        if (api.datacenter.Player.isAtHome(api.datacenter.Map.id))
                        {
                            _loc9.addItem(api.lang.getText("KICKOFF"), api.network.Houses, api.network.Houses.kick, [_loc8]);
                        } // end if
                        _loc9.show(_root._xmouse, _root._ymouse);
                    } // end else if
                }
                else if (_loc3 instanceof dofus.datacenter.NonPlayableCharacter)
                {
                    if (api.datacenter.Player.cantSpeakNPC)
                    {
                        return;
                    } // end if
                    var _loc6 = _loc3.actions;
                    if (_loc6 != undefined && _loc6.length != 0)
                    {
                        _loc9 = api.ui.createPopupMenu();
                        var _loc5 = _loc6.length;
                        while (_loc5-- > 0)
                        {
                            var _loc4 = _loc6[_loc5].action;
                            _loc9.addItem(_loc6[_loc5].name, _loc4.object, _loc4.method, _loc4.params);
                        } // end while
                        _loc9.show(_root._xmouse, _root._ymouse);
                    } // end if
                }
                else if (_loc3 instanceof dofus.datacenter.Team)
                {
                    var _loc11 = api.datacenter.Player.data.alignment.index;
                    var _loc13 = _loc3.alignment.index;
                    var _loc14 = _loc3.enemyTeam.alignment.index;
                    var _loc18 = _loc3.challenge.fightType;
                    var _loc7 = false;
                    switch (_loc18)
                    {
                        case 0:
                        {
                            switch (_loc3.type)
                            {
                                case 0:
                                case 2:
                                {
                                    _loc7 = api.datacenter.Player.canChallenge && !api.datacenter.Player.isMutant;
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
                                    _loc7 = api.lang.getAlignmentCanJoin(_loc11, _loc13) && api.lang.getAlignmentCanAttack(_loc11, _loc14) && !api.datacenter.Player.isMutant;
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
                                    _loc7 = !api.datacenter.Player.isMutant;
                                    break;
                                } 
                                case 1:
                                {
                                    _loc7 = false;
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
                                    _loc7 = !api.datacenter.Player.isMutant;
                                    break;
                                } 
                                case 1:
                                {
                                    _loc7 = false;
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
                                    _loc7 = !api.datacenter.Player.isMutant && !api.datacenter.Player.cantInteractWithTaxCollector;
                                    break;
                                } 
                                case 3:
                                {
                                    _loc7 = false;
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
                                    _loc7 = !api.datacenter.Player.isMutant;
                                    break;
                                } 
                                case 2:
                                {
                                    _loc7 = api.datacenter.Player.isMutant;
                                    break;
                                } 
                            } // End of switch
                            break;
                        } 
                    } // End of switch
                    if (_loc7)
                    {
                        _loc9 = api.ui.createPopupMenu();
                        if (_loc3.challenge.count >= dofus.Constants.MAX_PLAYERS_IN_CHALLENGE)
                        {
                            _loc9.addItem(api.lang.getText("CHALENGE_FULL"));
                        }
                        else if (_loc3.count >= dofus.Constants.MAX_PLAYERS_IN_TEAM)
                        {
                            _loc9.addItem(api.lang.getText("TEAM_FULL"));
                        }
                        else
                        {
                            _loc9.addItem(api.lang.getText("JOIN_SMALL"), api.network.GameActions, api.network.GameActions.joinChallenge, [_loc3.challenge.id, _loc3.id]);
                        } // end else if
                        _loc9.show(_root._xmouse, _root._ymouse);
                    } // end if
                }
                else if (_loc3 instanceof dofus.datacenter.Creature)
                {
                    _loc17 = mapHandler.getCellData(_loc3.cellNum).mc;
                    this.onCellRelease(_loc17);
                }
                else if (api.datacenter.Player.isMutant)
                {
                    return;
                }
                else if (_loc3 instanceof dofus.datacenter.MonsterGroup || _loc3 instanceof dofus.datacenter.Monster)
                {
                    _loc17 = mapHandler.getCellData(_loc3.cellNum).mc;
                    this.onCellRelease(_loc17);
                }
                else if (_loc3 instanceof dofus.datacenter.OfflineCharacter)
                {
                    if (!api.datacenter.Player.canExchange)
                    {
                        return;
                    } // end if
                    _loc9 = api.ui.createPopupMenu();
                    _loc9.addStaticItem(api.lang.getText("SHOP") + " " + api.lang.getText("OF") + " " + _loc3.name);
                    _loc9.addItem(api.lang.getText("BUY"), api.kernel.GameManager, api.kernel.GameManager.startExchange, [4, _loc3.id, _loc3.cellNum]);
                    if (api.datacenter.Player.isAtHome(api.datacenter.Map.id))
                    {
                        _loc9.addItem(api.lang.getText("KICKOFF"), api.network.Basics, api.network.Basics.kick, [_loc3.cellNum]);
                    } // end if
                    _loc9.show(_root._xmouse, _root._ymouse);
                }
                else if (_loc3 instanceof dofus.datacenter.TaxCollector)
                {
                    if (api.datacenter.Player.cantInteractWithTaxCollector)
                    {
                        return;
                    } // end if
                    if (api.datacenter.Game.isFight)
                    {
                        _loc17 = mapHandler.getCellData(_loc3.cellNum).mc;
                        this.onCellRelease(_loc17);
                    }
                    else
                    {
                        var _loc10 = api.datacenter.Player.guildInfos.rights;
                        var _loc12 = _loc3.guildName == api.datacenter.Player.guildInfos.name;
                        var _loc15 = _loc12 && (_loc10.canCollectKamas || _loc10.canCollectObjects || _loc10.canCollectResources);
                        _loc9 = api.ui.createPopupMenu();
                        _loc9.addItem(api.lang.getText("SPEAK"), api.network.Dialog, api.network.Dialog.create, [_loc8]);
                        _loc9.addItem(api.lang.getText("COLLECT_TAX"), api.kernel.GameManager, api.kernel.GameManager.startExchange, [8, _loc8], _loc15);
                        _loc9.addItem(api.lang.getText("ATTACK"), api.network.GameActions, api.network.GameActions.attackTaxCollector, [[_loc8]], !_loc12);
                        _loc9.show(_root._xmouse, _root._ymouse);
                    } // end else if
                } // end else if
                break;
            } 
        } // End of switch
    } // End of the function
    function onSpriteRollOver(mcSprite)
    {
        var _loc7;
        var _loc5;
        var _loc2 = mcSprite.data;
        var _loc4 = dofus.Constants.OVERHEAD_TEXT_OTHER;
        if (_loc2.isClear)
        {
            return;
        } // end if
        if (_loc2.hasParent)
        {
            this.onSpriteRollOver(_loc2.linkedParent.mc);
            return;
        } // end if
        if (api.datacenter.Game.isRunning || api.datacenter.Game.interactionType == 5)
        {
            var _loc9 = mapHandler.getCellData(_loc2.cellNum).mc;
            if (_loc2.isVisible)
            {
                this.onCellRollOver(_loc9);
            } // end if
        } // end if
        var _loc3 = _loc2.name;
        if (_loc2 instanceof dofus.datacenter.Mutant || _loc2 instanceof dofus.datacenter.Creature || _loc2 instanceof dofus.datacenter.Monster)
        {
            _loc4 = dofus.Constants.NPC_ALIGNMENT_COLOR[_loc2.alignment.index];
            if (api.datacenter.Game.isRunning)
            {
                _loc3 = _loc3 + (" (" + _loc2.LP + ")");
                this.showSpriteInfosIfWeNeed(_loc2);
            }
            else
            {
                _loc3 = _loc3 + (" (" + _loc2.Level + ")");
            } // end else if
        }
        else if (_loc2 instanceof dofus.datacenter.Character)
        {
            _loc4 = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
            if (api.datacenter.Game.isRunning)
            {
                _loc3 = _loc3 + (" (" + _loc2.LP + ")");
                if (_loc2.isVisible)
                {
                    var _loc6 = _loc2.EffectsManager.getEffects();
                    if (_loc6.length != 0)
                    {
                        this.addSpriteOverHeadItem(_loc2.id, "effects", dofus.graphics.battlefield.EffectsOverHead, [_loc6]);
                    } // end if
                } // end if
                this.showSpriteInfosIfWeNeed(_loc2);
            }
            else if (api.datacenter.Game.isFight)
            {
                _loc3 = _loc3 + (" (" + _loc2.Level + ")");
            } // end else if
            if (!_loc2.isVisible)
            {
                return;
            } // end if
            _loc7 = dofus.Constants.DEMON_ANGEL_FILE;
            if (_loc2.alignment.index == 1)
            {
                _loc5 = _loc2.alignment.frame;
            }
            else if (_loc2.alignment.index == 2)
            {
                _loc5 = 5 + _loc2.alignment.frame;
            } // end else if
            if (_loc2.guildName != undefined && _loc2.guildName.length != 0)
            {
                _loc3 = "";
                this.addSpriteOverHeadItem(_loc2.id, "text", dofus.graphics.battlefield.GuildOverHead, [_loc2.guildName, _loc2.name, _loc2.emblem, _loc7, _loc5]);
            } // end if
        }
        else if (_loc2 instanceof dofus.datacenter.TaxCollector)
        {
            if (api.datacenter.Game.isRunning)
            {
                _loc3 = _loc3 + (" (" + _loc2.LP + ")");
                this.showSpriteInfosIfWeNeed(_loc2);
            }
            else if (api.datacenter.Game.isFight)
            {
                _loc3 = _loc3 + (" (" + _loc2.Level + ")");
            }
            else
            {
                _loc3 = "";
                this.addSpriteOverHeadItem(_loc2.id, "text", dofus.graphics.battlefield.GuildOverHead, [_loc2.guildName, _loc2.name, _loc2.emblem]);
            } // end else if
        }
        else if (_loc2 instanceof dofus.datacenter.OfflineCharacter)
        {
            _loc4 = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
            _loc3 = "";
            this.addSpriteOverHeadItem(_loc2.id, "text", dofus.graphics.battlefield.OfflineOverHead, [_loc2]);
        }
        else if (_loc2 instanceof dofus.datacenter.NonPlayableCharacter)
        {
            var _loc10 = api.datacenter.Map;
            var _loc8 = api.datacenter.Areas.getItemAt(_loc10.area);
            if (_loc8 != undefined)
            {
                _loc4 = dofus.Constants.NPC_ALIGNMENT_COLOR[_loc8.alignment.index];
            } // end if
        }
        else if (_loc2 instanceof dofus.datacenter.MonsterGroup || _loc2 instanceof dofus.datacenter.Team)
        {
            if (_loc2.alignment.index != -1)
            {
                _loc4 = dofus.Constants.NPC_ALIGNMENT_COLOR[_loc2.alignment.index];
            } // end else if
        } // end else if
        if (_loc2.isVisible)
        {
            if (_loc3 != "")
            {
                this.addSpriteOverHeadItem(_loc2.id, "text", dofus.graphics.battlefield.TextOverHead, [_loc3, _loc7, _loc4, _loc5]);
            } // end if
            this.selectSprite(_loc2.id, true);
        } // end if
    } // End of the function
    function onSpriteRollOut(mcSprite)
    {
        var _loc2 = mcSprite.data;
        if (_loc2.hasParent)
        {
            this.onSpriteRollOut(_loc2.linkedParent.mc);
            return;
        } // end if
        if (api.datacenter.Game.isRunning || api.datacenter.Game.interactionType == 5)
        {
            this.hideSpriteInfos();
            var _loc3 = mapHandler.getCellData(_loc2.cellNum).mc;
            this.onCellRollOut(_loc3);
        } // end if
        this.removeSpriteOverHeadLayer(_loc2.id, "text");
        this.removeSpriteOverHeadLayer(_loc2.id, "effects");
        this.selectSprite(_loc2.id, false);
    } // End of the function
    function onObjectRelease(mcObject)
    {
        var _loc19 = mcObject.cellData;
        var _loc3 = _loc19.mc;
        var _loc16 = _loc19.layerObject2Num;
        if (api.kernel.TutorialManager.isTutorialMode)
        {
            api.kernel.TutorialManager.onWaitingCase({code: "OBJECT_RELEASE", params: [_loc19.num, _loc16]});
            return;
        } // end if
        if (_loc16 >= 6700 && !isNaN(_loc16) && api.datacenter.Player.canUseInteractiveObjects && api.datacenter.Game.interactionType != 5)
        {
            var _loc18 = api.lang.getInteractiveObjectDataByGfxText(_loc16);
            var _loc17 = _loc18.n;
            var _loc4 = _loc18.sk;
            var _loc21 = _loc18.t;
            switch (_loc21)
            {
                case 1:
                case 2:
                case 3:
                case 4:
                case 7:
                {
                    var _loc22 = api.datacenter.Player.currentJobID != undefined;
                    var _loc12;
                    if (_loc22)
                    {
                        _loc12 = api.datacenter.Player.Jobs.findFirstItem("id", api.datacenter.Player.currentJobID).item.skills;
                    }
                    else
                    {
                        _loc12 = new ank.utils.ExtendedArray();
                    } // end else if
                    var _loc11 = api.ui.createPopupMenu();
                    _loc11.addStaticItem(_loc17);
                    for (var _loc15 in _loc4)
                    {
                        var _loc8 = _loc4[_loc15];
                        var _loc6 = new dofus.datacenter.Skill(_loc8);
                        var _loc10 = _loc12.findFirstItem("id", _loc8).index != -1;
                        var _loc9 = api.datacenter.Player.Level <= dofus.Constants.NOVICE_LEVEL;
                        var _loc5 = _loc6.getState(_loc10, false, false, false, false, _loc9);
                        if (_loc5 != "X")
                        {
                            _loc11.addItem(_loc6.description, api.kernel.GameManager, api.kernel.GameManager.useRessource, [_loc3, _loc3.num, _loc8], _loc5 == "V");
                        } // end if
                    } // end of for...in
                    _loc11.show(_root._xmouse, _root._ymouse);
                    break;
                } 
                case 5:
                {
                    _loc11 = api.ui.createPopupMenu();
                    var _loc20 = api.lang.getHousesDoorText(api.datacenter.Map.id, _loc3.num);
                    var _loc7 = api.datacenter.Houses.getItemAt(_loc20);
                    _loc11.addStaticItem(_loc17 + " " + _loc7.name);
                    if (_loc7.localOwner)
                    {
                        _loc11.addStaticItem(api.lang.getText("MY_HOME"));
                    }
                    else if (_loc7.ownerName != undefined)
                    {
                        _loc11.addStaticItem(api.lang.getText("HOME_OF", [_loc7.ownerName]));
                    } // end else if
                    for (var _loc15 in _loc4)
                    {
                        _loc8 = _loc4[_loc15];
                        _loc6 = new dofus.datacenter.Skill(_loc8);
                        _loc5 = _loc6.getState(true, _loc7.localOwner, _loc7.isForSale, _loc7.isLocked);
                        if (_loc5 != "X")
                        {
                            _loc11.addItem(_loc6.description, api.kernel.GameManager, api.kernel.GameManager.useRessource, [_loc3, _loc3.num, _loc8], _loc5 == "V");
                        } // end if
                    } // end of for...in
                    _loc11.show(_root._xmouse, _root._ymouse);
                    break;
                } 
                case 6:
                {
                    var _loc24 = api.datacenter.Map.id + "_" + _loc3.num;
                    var _loc23 = api.datacenter.Storages.getItemAt(_loc24);
                    var _loc13 = _loc23.isLocked;
                    var _loc14 = api.datacenter.Player.isAtHome(api.datacenter.Map.id);
                    _loc11 = api.ui.createPopupMenu();
                    _loc11.addStaticItem(_loc17);
                    for (var _loc15 in _loc4)
                    {
                        _loc8 = _loc4[_loc15];
                        _loc6 = new dofus.datacenter.Skill(_loc8);
                        _loc5 = _loc6.getState(true, _loc14, true, _loc13);
                        if (_loc5 != "X")
                        {
                            _loc11.addItem(_loc6.description, api.kernel.GameManager, api.kernel.GameManager.useRessource, [_loc3, _loc3.num, _loc8], _loc5 == "V");
                        } // end if
                    } // end of for...in
                    _loc11.show(_root._xmouse, _root._ymouse);
                    break;
                } 
            } // End of switch
        }
        else
        {
            this.onCellRelease(_loc3);
        } // end else if
    } // End of the function
    function onObjectRollOver(mcObject)
    {
        if (api.datacenter.Game.interactionType == 5)
        {
            var _loc2 = mcObject.cellData.mc;
            this.onCellRollOver(_loc2);
        } // end if
        mcObject.select(true);
    } // End of the function
    function onObjectRollOut(mcObject)
    {
        if (api.datacenter.Game.interactionType == 5)
        {
            var _loc2 = mcObject.cellData.mc;
            this.onCellRollOut(_loc2);
        } // end if
        mcObject.select(false);
    } // End of the function
    function showSpriteInfosIfWeNeed(oSprite)
    {
        if (api.ui.isCursorHidden())
        {
            if (api.kernel.OptionsManager.getOption("SpriteInfos"))
            {
                if (api.kernel.OptionsManager.getOption("SpriteMove") && oSprite.isVisible)
                {
                    api.gfx.drawZone(oSprite.cellNum, 0, oSprite.MP, "move", dofus.Constants.CELL_MOVE_RANGE_COLOR, "C");
                } // end if
                api.ui.getUIComponent("Banner").showRightPanel("BannerSpriteInfos", {data: oSprite});
            } // end if
        } // end if
    } // End of the function
    function hideSpriteInfos()
    {
        api.ui.getUIComponent("Banner").hideRightPanel();
        api.gfx.clearZoneLayer("move");
    } // End of the function
} // End of Class
#endinitclip
