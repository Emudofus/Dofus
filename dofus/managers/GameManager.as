// Action script...

// [Initial MovieClip Action of sprite 20543]
#initclip 64
if (!dofus.managers.GameManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.GameManager = function (oAPI)
    {
        super();
        dofus.managers.GameManager._sSelf = this;
        this.initialize(oAPI);
    }).prototype;
    _loc1.__get__isFullScreen = function ()
    {
        return (this._bIsFullScreen);
    };
    _loc1.__set__isFullScreen = function (value)
    {
        this._bIsFullScreen = value;
        //return (this.isFullScreen());
    };
    _loc1.__get__isAllowingScale = function ()
    {
        return (this._bIsAllowingScale);
    };
    _loc1.__set__isAllowingScale = function (value)
    {
        this._bIsAllowingScale = value;
        //return (this.isAllowingScale());
    };
    _loc1.__set__lastSpellLaunch = function (n)
    {
        this._nLastSpellLaunch = n;
        //return (this.lastSpellLaunch());
    };
    (_global.dofus.managers.GameManager = function (oAPI)
    {
        super();
        dofus.managers.GameManager._sSelf = this;
        this.initialize(oAPI);
    }).getInstance = function ()
    {
        return (dofus.managers.GameManager._sSelf);
    };
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI);
        this.api.ui.addEventListener("removeCursor", this);
    };
    _loc1.askPrivateMessage = function (sPlayerName)
    {
        var _loc3 = this.api.ui.loadUIComponent("AskPrivateChat", "AskPrivateChat", {title: this.api.lang.getText("WISPER_MESSAGE") + " " + this.api.lang.getText("TO_DESTINATION") + " " + sPlayerName, params: {playerName: sPlayerName}});
        _loc3.addEventListener("send", this);
        _loc3.addEventListener("addfriend", this);
    };
    _loc1.giveUpGame = function ()
    {
        if (this.api.datacenter.Game.fightType == dofus.managers.GameManager.FIGHT_TYPE_CHALLENGE || this.api.datacenter.Basics.aks_current_server.typeNum != dofus.datacenter.Server.SERVER_HARDCORE)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("DO_U_GIVEUP"), "CAUTION_YESNO", {name: "GiveUp", listener: this});
        }
        else
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("DO_U_SUICIDE"), "CAUTION_YESNO", {name: "GiveUp", listener: this});
        } // end else if
    };
    _loc1.offlineExchange = function ()
    {
        this.api.network.Exchange.askOfflineExchange();
    };
    _loc1.askOfflineExchange = function (allItemPrice, tax, priceToPay)
    {
        this.api.kernel.showMessage(undefined, this.api.lang.getText("DO_U_OFFLINEEXCHANGE", [allItemPrice, tax, priceToPay]), "CAUTION_YESNO", {name: "OfflineExchange", listener: this, price: priceToPay});
    };
    _loc1.startExchange = function (nExchangeType, sSpriteID, nCellNum)
    {
        var _loc5 = this.api.datacenter.Player.data;
        if (_loc5.isInMove)
        {
            _loc5.GameActionsManager.cancel(_loc5.cellNum, true);
        } // end if
        this.api.network.Exchange.request(nExchangeType, Number(sSpriteID), nCellNum);
    };
    _loc1.startDialog = function (sSpriteID)
    {
        var _loc3 = this.api.datacenter.Player.data;
        if (_loc3.isInMove)
        {
            _loc3.GameActionsManager.cancel(_loc3.cellNum, true);
        } // end if
        this.api.network.Dialog.create(sSpriteID);
    };
    _loc1.askAttack = function (sSpriteID)
    {
        var _loc3 = this.api.datacenter.Sprites.getItemAt(sSpriteID);
        var _loc4 = "";
        if (!this.api.datacenter.Player.rank.enable)
        {
            _loc4 = _loc4 + this.api.lang.getText("DO_U_ATTACK_WHEN_PVP_DISABLED");
        } // end if
        if (_loc3.rank.value == 0)
        {
            if (_loc4 != "")
            {
                _loc4 = _loc4 + "\n\n";
            } // end if
            _loc4 = _loc4 + this.api.lang.getText("DO_U_ATTACK_NEUTRAL");
        } // end if
        if (_loc4 != "")
        {
            _loc4 = _loc4 + "\n\n";
        } // end if
        if (!this.api.lang.getConfigText("SHOW_PVP_GAIN_WARNING_POPUP"))
        {
            _loc3.pvpGain = 0;
        } // end if
        switch (_loc3.pvpGain)
        {
            case -1:
            {
                _loc4 = _loc4 + this.api.lang.getText("DO_U_ATTACK_NO_GAIN", [_loc3.name]);
                break;
            } 
            case 1:
            {
                _loc4 = _loc4 + this.api.lang.getText("DO_U_ATTACK_BONUS_GAIN", [_loc3.name]);
                break;
            } 
            default:
            {
                _loc4 = _loc4 + this.api.lang.getText("DO_U_ATTACK", [_loc3.name]);
            } 
        } // End of switch
        this.api.kernel.showMessage(undefined, _loc4, "CAUTION_YESNO", {name: "Punish", listener: this, params: {spriteID: sSpriteID}});
    };
    _loc1.askRemoveTaxCollector = function (sSpriteID)
    {
        var _loc3 = this.api.datacenter.Sprites.getItemAt(sSpriteID).name;
        this.api.kernel.showMessage(undefined, this.api.lang.getText("DO_U_REMOVE_TAXCOLLECTOR", [_loc3]), "CAUTION_YESNO", {name: "RemoveTaxCollector", listener: this, params: {spriteID: sSpriteID}});
    };
    _loc1.useRessource = function (mcCell, nCellNum, nSkillID)
    {
        if (this.api.gfx.onCellRelease(mcCell))
        {
            this.api.network.GameActions.sendActions(500, [nCellNum, nSkillID]);
        } // end if
    };
    _loc1.useSkill = function (nSkillID)
    {
        this.api.network.GameActions.sendActions(507, [nSkillID]);
    };
    _loc1.setEnabledInteractionIfICan = function (nInteractionType)
    {
        if (this.api.datacenter.Player.isCurrentPlayer)
        {
            this.api.gfx.setInteraction(nInteractionType);
        } // end if
    };
    _loc1.cleanPlayer = function (sSpriteID)
    {
        if (sSpriteID != this.api.datacenter.Game.currentPlayerID)
        {
            var _loc3 = this.api.datacenter.Sprites.getItemAt(sSpriteID);
            _loc3.EffectsManager.nextTurn();
            _loc3.CharacteristicsManager.nextTurn();
            _loc3.GameActionsManager.clear();
        } // end if
    };
    _loc1.cleanUpGameArea = function (bKeepSelection)
    {
        if (bKeepSelection)
        {
            this.api.gfx.unSelect(true);
        } // end if
        this.api.ui.removeCursor();
        this.api.ui.getUIComponent("Banner").hideRightPanel();
        this.api.gfx.clearZoneLayer("spell");
        this.api.gfx.clearPointer();
        this.api.gfx.unSelect(true);
        delete this.api.datacenter.Player.currentUseObject;
        if (!(this.api.datacenter.Game.isFight && !this.api.datacenter.Game.isRunning))
        {
            this.api.datacenter.Game.setInteractionType("move");
        } // end if
        this.api.datacenter.Player.InteractionsManager.setState(this.api.datacenter.Game.isFight);
    };
    _loc1.terminateFight = function ()
    {
        this.api.sounds.events.onGameEnd();
        this.api.sounds.playMusic(this.api.datacenter.Map.musicID);
        this.api.kernel.showMessage(undefined, this.api.lang.getText("GAME_END"), "INFO_CHAT");
        this.api.ui.loadUIComponent("GameResult", "GameResult", {data: this.api.datacenter.Game.results}, {bAlwaysOnTop: true});
        this.api.gfx.cleanMap();
        this.api.network.Game.onLeave();
    };
    _loc1.switchToItemTarget = function (oItem)
    {
        if (this.api.datacenter.Game.isFight)
        {
            return;
        } // end if
        this.api.gfx.unSelect(true);
        this.api.gfx.clearPointer();
        this.api.gfx.addPointerShape("C", 0, dofus.Constants.CELL_SPELL_EFFECT_COLOR, this.api.datacenter.Player.data.cellNum);
        this.api.datacenter.Player.currentUseObject = oItem;
        this.api.datacenter.Game.setInteractionType("target");
        this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
        this.api.ui.setCursor(oItem, {width: 25, height: 25, x: 15, y: 15});
        this.api.datacenter.Basics.gfx_canLaunch = false;
        dofus.DofusCore.getInstance().forceMouseOver();
    };
    _loc1.switchToFlagSet = function ()
    {
        if (!this.api.datacenter.Game.isFight)
        {
            return;
        } // end if
        this.api.gfx.clearPointer();
        this.api.gfx.unSelectAllButOne("startPosition");
        this.api.gfx.addPointerShape("C", 0, dofus.Constants.CELL_SPELL_EFFECT_COLOR, this.api.datacenter.Player.data.cellNum);
        this.api.datacenter.Game.setInteractionType("flag");
        this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
        this.api.ui.removeCursor();
        this.api.datacenter.Basics.gfx_canLaunch = false;
        dofus.DofusCore.getInstance().forceMouseOver();
    };
    _loc1.switchToSpellLaunch = function (oSpell, bSpell, bForced)
    {
        if (bForced != true)
        {
            if (!this.api.datacenter.Game.isRunning)
            {
                return;
            } // end if
            if (this.api.datacenter.Player.data.sequencer.isPlaying())
            {
                return;
            } // end if
            if (this.api.datacenter.Player.data.GameActionsManager.isWaiting())
            {
                return;
            } // end if
            if (this.api.datacenter.Player.data.GameActionsManager.m_bNextAction)
            {
                return;
            } // end if
            if (this._nLastSpellLaunch + dofus.managers.GameManager.MINIMAL_SPELL_LAUNCH_DELAY > getTimer())
            {
                return;
            } // end if
            if (!this.api.datacenter.Player.SpellsManager.checkCanLaunchSpell(oSpell.ID, undefined))
            {
                if (this.api.datacenter.Basics.spellManager_errorMsg != undefined)
                {
                    this.api.kernel.showMessage(undefined, this.api.datacenter.Basics.spellManager_errorMsg, "ERROR_CHAT");
                    delete this.api.datacenter.Basics.spellManager_errorMsg;
                } // end if
                return;
            } // end if
        } // end if
        this.api.datacenter.Player.isCurrentSpellForced = bForced;
        delete this.api.datacenter.Basics.interactionsManager_path;
        this.api.gfx.unSelect(true);
        this.api.datacenter.Player.currentUseObject = oSpell;
        this.api.gfx.clearZoneLayer("spell");
        this.api.gfx.clearPointer();
        var _loc5 = this.api.datacenter.Player.data.cellNum;
        if (oSpell.rangeMax != 63)
        {
            var _loc6 = oSpell.rangeMax;
            var _loc7 = oSpell.rangeMin;
            if (_loc6 != 0)
            {
                var _loc8 = oSpell.canBoostRange ? (this.api.datacenter.Player.data.CharacteristicsManager.getModeratorValue(19) + this.api.datacenter.Player.RangeModerator) : (0);
                _loc6 = _loc6 + _loc8;
                _loc6 = Math.max(_loc7, _loc6);
            } // end if
            if (oSpell.lineOnly)
            {
                this.api.gfx.drawZone(_loc5, _loc7, _loc6, "spell", dofus.Constants.CELL_SPELL_RANGE_COLOR, "X");
                this.drawAllowedZone(true, _loc5, _loc7, _loc6);
            }
            else
            {
                this.api.gfx.drawZone(_loc5, _loc7, _loc6, "spell", dofus.Constants.CELL_SPELL_RANGE_COLOR, "C");
                this.drawAllowedZone(false, _loc5, _loc7, _loc6);
            } // end else if
        }
        else
        {
            this.api.gfx.drawZone(0, 0, 100, "spell", dofus.Constants.CELL_SPELL_RANGE_COLOR, "C");
        } // end else if
        var _loc9 = oSpell.effectZones;
        var _loc10 = 0;
        
        while (++_loc10, _loc10 < _loc9.length)
        {
            if (_loc9[_loc10].size < 63)
            {
                this.api.gfx.addPointerShape(_loc9[_loc10].shape, _loc9[_loc10].size, dofus.Constants.CELL_SPELL_EFFECT_COLOR, _loc5);
            } // end if
        } // end while
        if (bSpell)
        {
            this.api.datacenter.Game.setInteractionType("spell");
        }
        else
        {
            this.api.datacenter.Game.setInteractionType("cc");
        } // end else if
        this.api.ui.setCursor(oSpell, {width: 25, height: 25, x: 15, y: 15});
        this.api.ui.setCursorForbidden(true, dofus.Constants.FORBIDDEN_FILE);
        this.api.datacenter.Basics.gfx_canLaunch = false;
        dofus.DofusCore.getInstance().forceMouseOver();
    };
    _loc1.drawAllowedZone = function (lineOnly, originCell, innerRay, outerRay)
    {
        if (!this.api.kernel.OptionsManager.getOption("AdvancedLineOfSight"))
        {
            return;
        } // end if
        var _loc6 = this.api.gfx.mapHandler.getCellCount();
        var _loc7 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(this.api.gfx.mapHandler, originCell);
        var _loc8 = this.api.datacenter.Player.currentUseObject.canBoostRange ? (this.api.datacenter.Player.data.CharacteristicsManager.getModeratorValue(19) + this.api.datacenter.Player.RangeModerator) : (0);
        var _loc9 = 0;
        
        while (++_loc9, _loc9 < _loc6)
        {
            var _loc10 = ank.battlefield.utils.Pathfinding.goalDistance(this.api.gfx.mapHandler, originCell, _loc9);
            if (_loc10 >= innerRay && _loc10 <= outerRay)
            {
                if (lineOnly)
                {
                    var _loc11 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(this.api.gfx.mapHandler, _loc9);
                    if (_loc11.x != _loc7.x && _loc11.y != _loc7.y)
                    {
                        continue;
                    } // end if
                } // end if
                if (this.api.datacenter.Player.SpellsManager.checkCanLaunchSpellOnCell(this.api.gfx.mapHandler, this.api.datacenter.Player.currentUseObject, this.api.gfx.mapHandler.getCellData(_loc9), _loc8))
                {
                    this.api.gfx.select(_loc9, 26316, "spell", 50);
                } // end if
            } // end if
        } // end while
    };
    _loc1.showDisgraceSanction = function ()
    {
        var _loc2 = this.api.datacenter.Player.rank.disgrace;
        if (_loc2 > 0)
        {
            var _loc3 = "";
            var _loc4 = 1;
            
            while (++_loc4, _loc4 <= _loc2)
            {
                var _loc5 = this.api.lang.getText("DISGRACE_SANCTION_" + _loc4);
                if (_loc5 != undefined && (_loc5 != "undefined" && _loc5.charAt(0) != "!"))
                {
                    _loc3 = _loc3 + ("\n\n" + _loc5);
                } // end if
            } // end while
            if (_loc3 != "")
            {
                _loc3 = this.api.lang.getText("DISGRACE_SANCTION", [ank.utils.PatternDecoder.combine(this.api.lang.getText("POINTS", [_loc2]), "m", _loc2 < 2)]) + _loc3;
                this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"), _loc3, "ERROR_BOX");
            } // end if
        } // end if
    };
    _loc1.getSpellDescriptionWithEffects = function (aEffects, bVisibleOnly, nSpell)
    {
        var _loc5 = new Array();
        var _loc6 = aEffects.length;
        if (typeof(aEffects) == "object")
        {
            var _loc7 = 0;
            
            while (++_loc7, _loc7 < _loc6)
            {
                var _loc8 = aEffects[_loc7];
                var _loc9 = _loc8[0];
                var _loc10 = nSpell > 0 && this.api.kernel.SpellsBoostsManager.isBoostedHealingOrDamagingEffect(_loc9) ? (this.api.kernel.SpellsBoostsManager.getSpellModificator(_loc9, nSpell)) : (-1);
                var _loc11 = new dofus.datacenter.Effect(_loc9, _loc8[1], _loc8[2], _loc8[3], undefined, _loc8[4], undefined, _loc10);
                if (bVisibleOnly == true)
                {
                    if (_loc11.showInTooltip)
                    {
                        _loc5.push(_loc11.description);
                    } // end if
                    continue;
                } // end if
                _loc5.push(_loc11.description);
            } // end while
            return (_loc5.join(", "));
        }
        else
        {
            return (null);
        } // end else if
    };
    _loc1.getSpellEffects = function (aEffects, nSpell)
    {
        var _loc4 = new Array();
        var _loc5 = aEffects.length;
        if (typeof(aEffects) == "object")
        {
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < _loc5)
            {
                var _loc7 = aEffects[_loc6];
                var _loc8 = _loc7[0];
                var _loc9 = -1;
                if (nSpell > 0)
                {
                    if (this.api.kernel.SpellsBoostsManager.isBoostedHealingEffect(_loc8))
                    {
                        _loc9 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_HEAL, nSpell);
                    }
                    else if (this.api.kernel.SpellsBoostsManager.isBoostedDamagingEffect(_loc8))
                    {
                        _loc9 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_DMG, nSpell);
                    } // end if
                } // end else if
                var _loc10 = new dofus.datacenter.Effect(_loc8, _loc7[1], _loc7[2], _loc7[3], _loc7[6], _loc7[4], undefined, _loc9);
                _loc10.probability = _loc7[5];
                _loc4.push(_loc10);
            } // end while
            return (_loc4);
        }
        else
        {
            return (null);
        } // end else if
    };
    _loc1.removeCursor = function (oEvent)
    {
        switch (this.api.datacenter.Game.interactionType)
        {
            case 2:
            case 3:
            {
                if (!this.api.datacenter.Basics.gfx_canLaunch)
                {
                    this.api.datacenter.Game.setInteractionType("move");
                } // end if
                this.api.gfx.clearZoneLayer("spell");
                this.api.gfx.clearPointer();
                this.api.gfx.unSelect(true);
                break;
            } 
            case 5:
            {
                if (!this.api.datacenter.Basics.gfx_canLaunch)
                {
                    this.api.datacenter.Game.setInteractionType("move");
                } // end if
                this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
                this.api.gfx.clearPointer();
                this.api.gfx.unSelectAllButOne("startPosition");
                break;
            } 
        } // End of switch
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoGiveUp":
            {
                this.api.network.Game.leave();
                break;
            } 
            case "AskYesNoOfflineExchange":
            {
                this.api.network.Exchange.offlineExchange();
                break;
            } 
            case "AskYesNoPunish":
            {
                this.api.network.GameActions.attack(oEvent.params.spriteID);
                break;
            } 
            case "AskYesNoAttack":
            {
                this.api.network.GameActions.attack(oEvent.params.spriteID);
                break;
            } 
            case "AskYesNoRemoveTaxCollector":
            {
                this.api.network.Guild.removeTaxCollector(oEvent.params.spriteID);
                break;
            } 
        } // End of switch
    };
    _loc1.send = function (oEvent)
    {
        if (oEvent.message.length != 0)
        {
            this.api.kernel.Console.process("/w " + oEvent.params.playerName + " " + oEvent.message);
        } // end if
    };
    _loc1.addfriend = function (oEvent)
    {
        this.api.network.Friends.addFriend(oEvent.params.playerName);
    };
    _loc1.updateCompass = function (nX, nY, bForced)
    {
        var _loc5 = this.api.ui.getUIComponent("Banner");
        if (!bForced && (this.api.datacenter.Basics.banner_targetCoords[0] == nX && this.api.datacenter.Basics.banner_targetCoords[1] == nY) || (_global.isNaN(nX) || _global.isNaN(nY)))
        {
            this.api.datacenter.Basics.banner_targetCoords = undefined;
            delete this.api.datacenter.Basics.banner_targetCoords;
            if (_loc5.illustrationType != "map")
            {
                _loc5.showCircleXtra("artwork", true, {bMask: true});
            } // end if
            return (false);
        }
        else
        {
            var _loc6 = this.api.datacenter.Map;
            if (_loc5.illustrationType != "map")
            {
                _loc5.showCircleXtra("compass", true, undefined, {updateOnLoad: false});
            } // end if
            _loc5.setCircleXtraParams({allCoords: {targetCoords: [nX, nY], currentCoords: [_loc6.x, _loc6.y]}});
            this.api.datacenter.Basics.banner_targetCoords = [nX, nY];
            return (true);
        } // end else if
    };
    _loc1.isItemUseful = function (itemId, skillId, maxItem)
    {
        var _loc5 = this.api.lang.getSkillText(skillId).cl;
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc5.length)
        {
            var _loc7 = _loc5[_loc6];
            var _loc8 = this.api.lang.getCraftText(_loc7);
            if (_loc8.length <= maxItem)
            {
                var _loc9 = 0;
                
                while (++_loc9, _loc9 < _loc8.length)
                {
                    if (_loc8[_loc9][0] == itemId)
                    {
                        return (true);
                    } // end if
                } // end while
            } // end if
        } // end while
        return (false);
    };
    _loc1.analyseReceipts = function (ea, skillId, maxItem)
    {
        var _loc5 = this.api.lang.getSkillText(skillId).cl;
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc5.length)
        {
            var _loc7 = _loc5[_loc6];
            var _loc8 = this.api.lang.getCraftText(_loc7);
            if (_loc8.length <= maxItem)
            {
                var _loc9 = 0;
                var _loc10 = 0;
                
                while (++_loc10, _loc10 < _loc8.length)
                {
                    var _loc11 = _loc8[_loc10];
                    var _loc12 = _loc11[0];
                    var _loc13 = _loc11[1];
                    var _loc14 = ea.findFirstItem("unicID", _loc12);
                    if (_loc14.index != -1 && _loc14.item.Quantity == _loc13)
                    {
                        ++_loc9;
                        continue;
                    } // end if
                    break;
                } // end while
                if (_loc9 == _loc8.length)
                {
                    if (ea.length == _loc8.length)
                    {
                        return (_loc7);
                        continue;
                    } // end if
                    if (ea.length == _loc8.length + 1)
                    {
                        if (ea.findFirstItem("unicID", 7508).index != -1)
                        {
                            return (_loc7);
                        } // end if
                    } // end if
                } // end if
            } // end if
        } // end while
        return;
    };
    _loc1.mergeTwoInventory = function (a1, a2)
    {
        var _loc4 = new ank.utils.ExtendedArray();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < a1.length)
        {
            _loc4.push(a1[_loc5]);
        } // end while
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < a2.length)
        {
            _loc4.push(a2[_loc6]);
        } // end while
        return (_loc4);
    };
    _loc1.mergeUnicItemInInventory = function (inventory)
    {
        var _loc3 = new ank.utils.ExtendedArray();
        var _loc4 = new Object();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < inventory.length)
        {
            var _loc6 = inventory[_loc5];
            if (_loc4[_loc6.unicID] == undefined)
            {
                _loc4[_loc6.unicID] = _loc6.clone();
                continue;
            } // end if
            _loc4[_loc6.unicID].Quantity = _loc4[_loc6.unicID].Quantity + _loc6.Quantity;
        } // end while
        for (var a in _loc4)
        {
            _loc3.push(_loc4[a]);
        } // end of for...in
        return (_loc3);
    };
    _loc1.getRemainingString = function (nRemainingTime)
    {
        if (nRemainingTime == -1)
        {
            return (this.api.lang.getText("OPEN_BETA_ACCOUNT"));
        }
        else if (nRemainingTime == 0)
        {
            return (this.api.lang.getText("SUBSCRIPTION_OUT"));
        }
        else
        {
            var _loc3 = new Date();
            _loc3.setTime(nRemainingTime);
            var _loc4 = _loc3.getUTCFullYear() - 1970;
            var _loc5 = _loc3.getUTCMonth();
            var _loc6 = _loc3.getUTCDate() - 1;
            var _loc7 = _loc3.getUTCHours();
            var _loc8 = _loc3.getUTCMinutes();
            var _loc9 = " " + this.api.lang.getText("AND") + " ";
            var _loc10 = this.api.lang.getText("REMAINING_TIME") + " ";
            if (_loc4 != 0 && _loc5 == 0)
            {
                var _loc11 = ank.utils.PatternDecoder.combine(this.api.lang.getText("YEARS"), "m", _loc4 == 1);
                _loc10 = _loc10 + (_loc4 + " " + _loc11);
            }
            else if (_loc4 != 0 && _loc5 != 0)
            {
                var _loc12 = ank.utils.PatternDecoder.combine(this.api.lang.getText("YEARS"), "m", _loc4 == 1);
                var _loc13 = ank.utils.PatternDecoder.combine(this.api.lang.getText("MONTHS"), "m", _loc5 == 1);
                _loc10 = _loc10 + (_loc4 + " " + _loc12 + _loc9 + _loc5 + " " + _loc13);
            }
            else if (_loc5 != 0 && _loc6 == 0)
            {
                var _loc14 = ank.utils.PatternDecoder.combine(this.api.lang.getText("MONTHS"), "m", _loc5 == 1);
                _loc10 = _loc10 + (_loc5 + " " + _loc14);
            }
            else if (_loc5 != 0 && _loc6 != 0)
            {
                var _loc15 = ank.utils.PatternDecoder.combine(this.api.lang.getText("MONTHS"), "m", _loc5 == 1);
                var _loc16 = ank.utils.PatternDecoder.combine(this.api.lang.getText("DAYS"), "m", _loc6 == 1);
                _loc10 = _loc10 + (_loc5 + " " + _loc15 + _loc9 + _loc6 + " " + _loc16);
            }
            else if (_loc6 != 0 && _loc7 == 0)
            {
                var _loc17 = ank.utils.PatternDecoder.combine(this.api.lang.getText("DAYS"), "m", _loc6 == 1);
                _loc10 = _loc10 + (_loc6 + " " + _loc17);
            }
            else if (_loc6 != 0 && _loc7 != 0)
            {
                var _loc18 = ank.utils.PatternDecoder.combine(this.api.lang.getText("DAYS"), "m", _loc6 == 1);
                var _loc19 = ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"), "m", _loc7 == 1);
                _loc10 = _loc10 + (_loc6 + " " + _loc18 + _loc9 + _loc7 + " " + _loc19);
            }
            else if (_loc7 != 0 && _loc8 == 0)
            {
                var _loc20 = ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"), "m", _loc7 == 1);
                _loc10 = _loc10 + (_loc7 + " " + _loc20);
            }
            else if (_loc7 != 0 && _loc8 != 0)
            {
                var _loc21 = ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"), "m", _loc7 == 1);
                var _loc22 = ank.utils.PatternDecoder.combine(this.api.lang.getText("MINUTES"), "m", _loc8 == 1);
                _loc10 = _loc10 + (_loc7 + " " + _loc21 + _loc9 + _loc8 + " " + _loc22);
            }
            else if (_loc8 != 0)
            {
                var _loc23 = ank.utils.PatternDecoder.combine(this.api.lang.getText("MINUTES"), "m", _loc8 == 1);
                _loc10 = _loc10 + (_loc8 + " " + _loc23);
            } // end else if
            return (_loc10);
        } // end else if
        return (null);
    };
    _loc1.zoomGfx = function (nZoom, x, y, xScreenPos, yScreenPos)
    {
        var _loc7 = this.api.gfx.container;
        var _loc8 = ank.battlefield.Constants.CELL_WIDTH;
        var _loc9 = ank.battlefield.Constants.CELL_HEIGHT;
        if (nZoom != undefined)
        {
            var _loc10 = this.api.gfx.screenWidth;
            var _loc11 = this.api.gfx.screenHeight;
            if (x == undefined)
            {
                x = _loc10 / 2;
            } // end if
            if (y == undefined)
            {
                x = _loc11 / 2;
            } // end if
            if (xScreenPos == undefined)
            {
                xScreenPos = _loc10 / 2;
            } // end if
            if (yScreenPos == undefined)
            {
                yScreenPos = _loc11 / 2;
            } // end if
            var _loc12 = x * nZoom / 100;
            var _loc13 = y * nZoom / 100;
            var _loc14 = xScreenPos - _loc12;
            var _loc15 = yScreenPos - _loc13;
            var _loc16 = (this.api.datacenter.Map.width - 1) * _loc8 * nZoom / 100;
            var _loc17 = (this.api.datacenter.Map.height - 1) * _loc9 * nZoom / 100;
            if (_loc14 > 0)
            {
                _loc14 = 0;
            } // end if
            if (_loc14 + _loc16 < _loc10)
            {
                _loc14 = _loc10 - _loc16;
            } // end if
            if (_loc15 > 0)
            {
                _loc15 = 0;
            } // end if
            if (_loc15 + _loc17 < _loc11)
            {
                _loc15 = _loc11 - _loc17;
            } // end if
            _loc7.zoom(nZoom);
            _loc7.setXY(_loc14, _loc15);
        }
        else
        {
            if (!_loc7.zoomMap())
            {
                _loc7.zoom(100);
            } // end if
            _loc7.center();
        } // end else if
    };
    _loc1.showMonsterPopupMenu = function (oSpriteData)
    {
        var _loc3 = oSpriteData;
        if (_loc3 == null)
        {
            return;
        } // end if
        var _loc4 = this.api.datacenter.Game.isFight;
        var _loc5 = _loc3.id;
        var _loc6 = _loc3.name;
        var _loc7 = this.api.ui.createPopupMenu();
        _loc7.addStaticItem(_loc6);
        if (_loc4 && (!this.api.datacenter.Game.isRunning && (_loc3.kickable || this.api.datacenter.Player.isAuthorized)))
        {
            _loc7.addItem(this.api.lang.getText("KICK"), this.api.network.Game, this.api.network.Game.leave, [_loc5]);
        } // end if
        if (_loc7.items.length > 1)
        {
            _loc7.show(_root._xmouse, _root._ymouse, true);
        } // end if
    };
    _loc1.showPlayerPopupMenu = function (oSpriteData, sPlayerName, oPartyItem, bNoFriendsInvite, bNoGuildInvite, sUniqId, bShowJoinFriend)
    {
        var _loc9 = null;
        if (oSpriteData != undefined)
        {
            _loc9 = oSpriteData;
        }
        else if (sPlayerName != undefined)
        {
            var _loc10 = this.api.datacenter.Sprites.getItems();
            for (var a in _loc10)
            {
                var _loc11 = _loc10[a];
                if (_loc11.name.toUpperCase() == sPlayerName.toUpperCase())
                {
                    _loc9 = _loc11;
                    break;
                } // end if
            } // end of for...in
        }
        else
        {
            return;
        } // end else if
        var _loc12 = this.api.datacenter.Game.isFight;
        var _loc13 = _loc9.id;
        var _loc14 = sPlayerName == undefined ? (_loc9.name) : (sPlayerName);
        if (this.api.datacenter.Player.isAuthorized && Key.isDown(Key.SHIFT))
        {
            this.api.kernel.AdminManager.showAdminPopupMenu(_loc14);
        }
        else
        {
            var _loc15 = this.api.ui.createPopupMenu();
            _loc15.addStaticItem(_loc14);
            var _loc16 = this.api.kernel.ChatManager.isBlacklisted(_loc14);
            if (_loc16)
            {
                _loc15.addStaticItem("(" + this.api.lang.getText("IGNORED_WORD") + ")");
            } // end if
            if (_loc12)
            {
                if (!this.api.datacenter.Game.isRunning && (!this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant))
                {
                    if (_loc9 != null && _loc13 != this.api.datacenter.Player.ID)
                    {
                        _loc15.addItem(this.api.lang.getText("KICK"), this.api.network.Game, this.api.network.Game.leave, [_loc13]);
                    } // end if
                } // end if
            } // end if
            if (_loc13 == this.api.datacenter.Player.ID)
            {
                _loc15.addItem(this.api.lang.getText("HIT_HIMSELF"), this.api.network.Chat, this.api.network.Chat.send, [this.api.lang.getText("SLAP_SENTENCE"), "*"]);
                if (!_loc12 && this.api.datacenter.Player.canBeMerchant)
                {
                    _loc15.addItem(this.api.lang.getText("ORGANIZE_SHOP"), this.api.kernel.GameManager, this.api.kernel.GameManager.startExchange, [6]);
                    _loc15.addItem(this.api.lang.getText("MERCHANT_MODE"), this.api.kernel.GameManager, this.api.kernel.GameManager.offlineExchange);
                } // end if
                if (this.api.datacenter.Player.data.isTomb)
                {
                    _loc15.addItem(this.api.lang.getText("FREE_MY_SOUL"), this.api.network.Game, this.api.network.Game.freeMySoul);
                }
                else if (!_loc12)
                {
                    var _loc17 = _loc9.animation == "static";
                    _loc15.addItem(this.api.lang.getText("CHANGE_DIRECTION"), this.api.ui, this.api.ui.loadUIComponent, ["DirectionChooser", "DirectionChooser", {allDirections: this.api.datacenter.Player.canMoveInAllDirections, target: this.api.datacenter.Player.data.mc}]);
                } // end else if
            }
            else
            {
                if (sUniqId != undefined && (sUniqId.length > 0 && (sUniqId != "" && !_loc16)))
                {
                    var _loc18 = false;
                    var _loc19 = 0;
                    
                    while (++_loc19, _loc19 < this.api.lang.getConfigText("ENABLED_SERVER_REPORT_LIST").length)
                    {
                        if (this.api.lang.getConfigText("ENABLED_SERVER_REPORT_LIST")[_loc19] == this.api.datacenter.Basics.aks_current_server.id)
                        {
                            _loc18 = true;
                            break;
                        } // end if
                    } // end while
                    if (_loc18)
                    {
                        _loc15.addItem(this.api.lang.getText("REPORT_SENTANCE"), this.api.kernel.GameManager, this.api.kernel.GameManager.reportSentance, [_loc14, _loc13, sUniqId, _loc9]);
                    } // end if
                } // end if
                if (!this.api.kernel.ChatManager.isBlacklisted(_loc14))
                {
                    _loc15.addItem(this.api.lang.getText("BLACKLIST_TEMPORARLY"), this.api.kernel.GameManager, this.api.kernel.GameManager.reportSentance, [_loc14, _loc13, undefined, _loc9]);
                }
                else
                {
                    _loc15.addItem(this.api.lang.getText("BLACKLIST_REMOVE"), this.api.kernel.ChatManager, this.api.kernel.ChatManager.removeToBlacklist, [_loc14]);
                } // end else if
                if (!_loc12 || _loc12 && sPlayerName != undefined)
                {
                    _loc15.addItem(this.api.lang.getText("WHOIS"), this.api.network.Basics, this.api.network.Basics.whoIs, [_loc14]);
                    if (bNoFriendsInvite != true)
                    {
                        _loc15.addItem(this.api.lang.getText("ADD_TO_FRIENDS"), this.api.network.Friends, this.api.network.Friends.addFriend, [_loc14]);
                    } // end if
                    if (bNoFriendsInvite != true)
                    {
                        _loc15.addItem(this.api.lang.getText("ADD_TO_ENEMY"), this.api.network.Enemies, this.api.network.Enemies.addEnemy, [_loc14]);
                    } // end if
                    _loc15.addItem(this.api.lang.getText("WISPER_MESSAGE"), this.api.kernel.GameManager, this.api.kernel.GameManager.askPrivateMessage, [_loc14]);
                    if (oPartyItem == undefined)
                    {
                        _loc15.addItem(this.api.lang.getText("ADD_TO_PARTY"), this.api.network.Party, this.api.network.Party.invite, [_loc14]);
                    } // end if
                    if (this.api.datacenter.Player.guildInfos != undefined)
                    {
                        if (bNoGuildInvite != true)
                        {
                            if (_loc9 == null || (_loc9 != null && _loc9.guildName == undefined || _loc9.guildName.length == 0))
                            {
                                if (this.api.datacenter.Player.guildInfos.playerRights.canInvite)
                                {
                                    _loc15.addItem(this.api.lang.getText("INVITE_IN_GUILD"), this.api.network.Guild, this.api.network.Guild.invite, [_loc14]);
                                } // end if
                            } // end if
                        } // end if
                    } // end if
                    if (bShowJoinFriend)
                    {
                        if (this.api.datacenter.Player.isAuthorized)
                        {
                            _loc15.addItem(this.api.lang.getText("JOIN_SMALL"), this.api.kernel.AdminManager, this.api.kernel.AdminManager.sendCommand, ["join " + _loc14]);
                        }
                        else if (this.api.datacenter.Map.superarea == 3)
                        {
                            _loc15.addItem(this.api.lang.getText("JOIN_SMALL"), this.api.network.Friends, this.api.network.Friends.joinFriend, [_loc14]);
                        } // end if
                    } // end if
                } // end else if
                if (!_loc12 && (_loc9 != null && !bNoFriendsInvite))
                {
                    if (this.api.datacenter.Player.isAtHome(this.api.datacenter.Map.id))
                    {
                        _loc15.addItem(this.api.lang.getText("KICKOFF"), this.api.network.Houses, this.api.network.Houses.kick, [_loc13]);
                    } // end if
                    if (this.api.datacenter.Player.canExchange && _loc9.canExchange)
                    {
                        _loc15.addItem(this.api.lang.getText("EXCHANGE"), this.api.kernel.GameManager, this.api.kernel.GameManager.startExchange, [1, _loc13]);
                    } // end if
                    if (this.api.datacenter.Player.canChallenge && _loc9.canBeChallenge)
                    {
                        _loc15.addItem(this.api.lang.getText("CHALLENGE"), this.api.network.GameActions, this.api.network.GameActions.challenge, [_loc13], this.api.datacenter.Map.bCanChallenge);
                    } // end if
                    if (this.api.datacenter.Player.canAssault && !_loc9.showIsPlayer)
                    {
                        var _loc20 = this.api.datacenter.Player.data.alignment.index;
                        if (this.api.lang.getAlignmentCanAttack(_loc20, _loc9.alignment.index))
                        {
                            _loc15.addItem(this.api.lang.getText("ASSAULT"), this.api.kernel.GameManager, this.api.kernel.GameManager.askAttack, [[_loc13]], this.api.datacenter.Map.bCanAttack);
                        } // end if
                    } // end if
                    if (this.api.datacenter.Player.canAttack && (_loc9.canBeAttack && !_loc9.showIsPlayer))
                    {
                        _loc15.addItem(this.api.lang.getText("ATTACK"), this.api.network.GameActions, this.api.network.GameActions.mutantAttack, [_loc9.id]);
                    } // end if
                    var _loc21 = _loc9.multiCraftSkillsID;
                    if (_loc21 != undefined && _loc21.length > 0)
                    {
                        var _loc22 = 0;
                        
                        while (++_loc22, _loc22 < _loc21.length)
                        {
                            var _loc23 = Number(_loc21[_loc22]);
                            _loc15.addItem(this.api.lang.getText("ASK_TO") + " " + this.api.lang.getSkillText(_loc23).d, this.api.network.Exchange, this.api.network.Exchange.request, [13, _loc9.id, _loc23]);
                        } // end while
                    }
                    else
                    {
                        _loc21 = this.api.datacenter.Player.data.multiCraftSkillsID;
                        if (_loc21 != undefined && _loc21.length > 0)
                        {
                            var _loc24 = 0;
                            
                            while (++_loc24, _loc24 < _loc21.length)
                            {
                                var _loc25 = Number(_loc21[_loc24]);
                                _loc15.addItem(this.api.lang.getText("INVITE_TO") + " " + this.api.lang.getSkillText(_loc25).d, this.api.network.Exchange, this.api.network.Exchange.request, [12, _loc9.id, _loc25]);
                            } // end while
                        } // end if
                    } // end if
                } // end else if
            } // end else if
            if (oPartyItem != undefined)
            {
                oPartyItem.addPartyMenuItems(_loc15);
            } // end if
            if (_loc9 != null && (_loc9.isVisible && (this.api.ui.getUIComponent("Zoom") == undefined && !_loc12)))
            {
                _loc15.addItem(this.api.lang.getText("ZOOM"), this.api.ui, this.api.ui.loadUIAutoHideComponent, ["Zoom", "Zoom", {sprite: _loc9}]);
            } // end if
            if (_loc15.items.length > 0)
            {
                _loc15.show(_root._xmouse, _root._ymouse, true);
            } // end if
        } // end else if
    };
    _loc1.getDurationString = function (duration, bBig)
    {
        if (duration <= 0)
        {
            return ("-");
        }
        else
        {
            var _loc4 = new Date();
            _loc4.setTime(duration);
            var _loc5 = _loc4.getUTCHours();
            var _loc6 = _loc4.getUTCMinutes();
            if (bBig != true)
            {
                return ((_loc5 != 0 ? (_loc5 + " " + this.api.lang.getText("HOURS_SMALL") + " ") : ("")) + _loc6 + " " + this.api.lang.getText("MINUTES_SMALL"));
            }
            else
            {
                return ((_loc5 != 0 ? (_loc5 + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"), "m", _loc5 < 2) + " ") : ("")) + _loc6 + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("MINUTES"), "m", _loc6 < 2));
            } // end else if
        } // end else if
    };
    _loc1.insertItemInChat = function (oItem, sPrefix, sSuffix)
    {
        if (sPrefix == undefined)
        {
            sPrefix = "";
        } // end if
        if (sSuffix == undefined)
        {
            sSuffix = "";
        } // end if
        if (this.api.datacenter.Basics.chatParams.items == undefined)
        {
            this.api.datacenter.Basics.chatParams.items = new Array();
        } // end if
        if (this.api.lang.getConfigText("CHAT_MAXIMUM_LINKS") == undefined || this.api.datacenter.Basics.chatParams.items.length < this.api.lang.getConfigText("CHAT_MAXIMUM_LINKS"))
        {
            this.api.datacenter.Basics.chatParams.items.push(oItem);
            this.api.ui.getUIComponent("Banner").insertChat(sPrefix + "[" + oItem.name + "]" + sSuffix);
        }
        else
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("TOO_MANY_ITEM_LINK"), "ERROR_CHAT");
        } // end else if
    };
    _loc1.getLastModified = function (nSlot)
    {
        var _loc3 = this._aLastModified[nSlot];
        if (_loc3 == undefined || _global.isNaN(_loc3))
        {
            return (0);
        } // end if
        return (_loc3);
    };
    _loc1.setAsModified = function (nSlot)
    {
        if (nSlot < 0)
        {
            return;
        } // end if
        this._aLastModified[nSlot] = getTimer();
    };
    _loc1.getCriticalHitChance = function (nDice)
    {
        if (nDice == 0)
        {
            return (0);
        } // end if
        var _loc3 = Math.max(0, this.api.datacenter.Player.CriticalHitBonus);
        var _loc4 = Math.max(0, this.api.datacenter.Player.AgilityTotal);
        nDice = nDice - _loc3;
        if (_loc4 != 0)
        {
            nDice = Math.min(nDice, Number(nDice * (Math.E * 1.100000E+000 / Math.log(_loc4 + 12))));
        } // end if
        return (Math.floor(Math.max(nDice, 2)));
    };
    _loc1.reportSentance = function (sName, sID, sUniqId, oData)
    {
        if (sUniqId != undefined && (sUniqId.length > 0 && sUniqId != ""))
        {
            this.api.ui.loadUIComponent("AskReportMessage", "AskReportMessage" + sUniqId, {message: this.api.kernel.ChatManager.getMessageFromId(sUniqId), messageId: sUniqId, authorId: sID, authorName: sName});
        }
        else
        {
            this.api.kernel.ChatManager.addToBlacklist(sName, oData.gfxID);
            this.api.kernel.showMessage(undefined, this.api.lang.getText("TEMPORARY_BLACKLISTED", [sName]), "INFO_CHAT");
        } // end else if
    };
    _loc1.isInMyTeam = function (sprite)
    {
        if (this.api.datacenter.Basics.aks_current_team == 0)
        {
            var _loc3 = 0;
            
            while (++_loc3, _loc3 < this.api.datacenter.Basics.aks_team1_starts.length)
            {
                if (this.api.datacenter.Basics.aks_team1_starts[_loc3] == sprite.cellNum)
                {
                    return (true);
                } // end if
            } // end while
        }
        else if (this.api.datacenter.Basics.aks_current_team == 1)
        {
            var _loc4 = 0;
            
            while (++_loc4, _loc4 < this.api.datacenter.Basics.aks_team2_starts.length)
            {
                if (this.api.datacenter.Basics.aks_team2_starts[_loc4] == sprite.cellNum)
                {
                    return (true);
                } // end if
            } // end while
        } // end else if
        return (false);
    };
    _loc1.startInactivityDetector = function ()
    {
        this.stopInactivityDetector();
        this.signalActivity();
        this._nInactivityInterval = _global.setInterval(this, "inactivityCheck", 1000);
        this._bFightActivity = false;
        Mouse.addListener(this);
    };
    _loc1.signalActivity = function ()
    {
        this._nLastActivity = getTimer();
    };
    _loc1.stopInactivityDetector = function ()
    {
        if (this._nInactivityInterval != undefined)
        {
            _global.clearInterval(this._nInactivityInterval);
        } // end if
        this._nLastActivity = undefined;
    };
    _loc1.inactivityCheck = function ()
    {
        if (this._nLastActivity == undefined || !this.api.kernel.OptionsManager.getOption("RemindTurnTime"))
        {
            return;
        } // end if
        var _loc2 = this.api.lang.getConfigText("INACTIVITY_DISPLAY_COUNT");
        if (_global.isNaN(_loc2) || _loc2 == undefined)
        {
            _loc2 = 5;
        } // end if
        if (this.api.datacenter.Basics.inactivity_signaled > _loc2)
        {
            return;
        } // end if
        var _loc3 = this.api.lang.getConfigText("INACTIVITY_TIMING");
        if (_global.isNaN(_loc3) || (_loc3 == undefined || _loc3 < 1000))
        {
            _loc3 = 11000;
        } // end if
        if (this._nLastActivity + _loc3 < getTimer())
        {
            if (this.api.datacenter.Game.isFight && (this.api.datacenter.Game.isRunning && this.api.datacenter.Player.isCurrentPlayer))
            {
                if (this.autoSkip)
                {
                    this.api.network.Game.turnEnd();
                    return;
                } // end if
                this.api.kernel.showMessage(undefined, this.api.lang.getText("INFIGHT_INACTIVITY"), "ERROR_CHAT");
                this.api.kernel.TipsManager.pointGUI("Banner", ["_btnNextTurn"]);
                ++this.api.datacenter.Basics.inactivity_signaled;
            } // end if
            this.stopInactivityDetector();
        } // end if
    };
    _loc1.__get__livingPlayerInCurrentTeam = function ()
    {
        var _loc2 = this.api.datacenter.Basics.team(this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team);
        var _loc3 = 0;
        for (var i in _loc2)
        {
            if (_loc2[i].LP > 0)
            {
                ++_loc3;
            } // end if
        } // end of for...in
        return (_loc3);
    };
    _loc1.__get__autoSkip = function ()
    {
        return (!this._bFightActivity && (this._nFightTurnInactivity > 0 && (this.livingPlayerInCurrentTeam > 1 && this.api.lang.getConfigText("FIGHT_AUTO_SKIP"))));
    };
    _loc1.signalFightActivity = function ()
    {
        this._bFightActivity = true;
    };
    _loc1.onTurnEnd = function ()
    {
        if (!this._bFightActivity && (this.api.lang.getConfigText("FIGHT_AUTO_SKIP") && this.livingPlayerInCurrentTeam > 1))
        {
            ++this._nFightTurnInactivity;
            this.api.kernel.showMessage(undefined, this.api.lang.getText("INFIGHT_INACTIVITY_AUTO_SKIP"), "ERROR_CHAT");
        }
        else
        {
            this._nFightTurnInactivity = 0;
        } // end else if
    };
    _loc1.onMouseMove = function ()
    {
        this._bFightActivity = true;
    };
    _loc1.onMouseUp = function ()
    {
        this._bFightActivity = true;
    };
    _loc1.addProperty("livingPlayerInCurrentTeam", _loc1.__get__livingPlayerInCurrentTeam, function ()
    {
    });
    _loc1.addProperty("isAllowingScale", _loc1.__get__isAllowingScale, _loc1.__set__isAllowingScale);
    _loc1.addProperty("isFullScreen", _loc1.__get__isFullScreen, _loc1.__set__isFullScreen);
    _loc1.addProperty("lastSpellLaunch", function ()
    {
    }, _loc1.__set__lastSpellLaunch);
    _loc1.addProperty("autoSkip", _loc1.__get__autoSkip, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.GameManager = function (oAPI)
    {
        super();
        dofus.managers.GameManager._sSelf = this;
        this.initialize(oAPI);
    }).MINIMAL_SPELL_LAUNCH_DELAY = 500;
    (_global.dofus.managers.GameManager = function (oAPI)
    {
        super();
        dofus.managers.GameManager._sSelf = this;
        this.initialize(oAPI);
    })._sSelf = null;
    _loc1._aLastModified = new Array();
    _loc1._bIsFullScreen = false;
    _loc1._bIsAllowingScale = true;
    _loc1._nLastSpellLaunch = 0;
    (_global.dofus.managers.GameManager = function (oAPI)
    {
        super();
        dofus.managers.GameManager._sSelf = this;
        this.initialize(oAPI);
    }).FIGHT_TYPE_CHALLENGE = 0;
    (_global.dofus.managers.GameManager = function (oAPI)
    {
        super();
        dofus.managers.GameManager._sSelf = this;
        this.initialize(oAPI);
    }).FIGHT_TYPE_AGRESSION = 1;
    (_global.dofus.managers.GameManager = function (oAPI)
    {
        super();
        dofus.managers.GameManager._sSelf = this;
        this.initialize(oAPI);
    }).FIGHT_TYPE_PvMA = 2;
    (_global.dofus.managers.GameManager = function (oAPI)
    {
        super();
        dofus.managers.GameManager._sSelf = this;
        this.initialize(oAPI);
    }).FIGHT_TYPE_MXvM = 3;
    (_global.dofus.managers.GameManager = function (oAPI)
    {
        super();
        dofus.managers.GameManager._sSelf = this;
        this.initialize(oAPI);
    }).FIGHT_TYPE_PvM = 4;
    (_global.dofus.managers.GameManager = function (oAPI)
    {
        super();
        dofus.managers.GameManager._sSelf = this;
        this.initialize(oAPI);
    }).FIGHT_TYPE_PvT = 5;
    (_global.dofus.managers.GameManager = function (oAPI)
    {
        super();
        dofus.managers.GameManager._sSelf = this;
        this.initialize(oAPI);
    }).FIGHT_TYPE_PvMU = 6;
    _loc1._nFightTurnInactivity = 0;
} // end if
#endinitclip
