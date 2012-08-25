// Action script...

// [Initial MovieClip Action of sprite 20719]
#initclip 240
if (!dofus.graphics.gapi.ui.Banner)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.Banner = function ()
    {
        super();
    }).prototype;
    _loc1.__set__data = function (oData)
    {
        this._oData = oData;
        //return (this.data());
    };
    _loc1.__set__fightsCount = function (nFightsCount)
    {
        this._nFightsCount = nFightsCount;
        this._btnFights._visible = nFightsCount != 0 && (!this.api.datacenter.Game.isFight && this._msShortcuts.currentTab == dofus.graphics.gapi.controls.MouseShortcuts.TAB_ITEMS);
        if (this._btnFights.icon == "")
        {
            this._btnFights.icon = "Eye2";
        } // end if
        //return (this.fightsCount());
    };
    _loc1.__get__chatAutoFocus = function ()
    {
        return (this._bChatAutoFocus);
    };
    _loc1.__set__chatAutoFocus = function (bChatAutoFocus)
    {
        this._bChatAutoFocus = bChatAutoFocus;
        //return (this.chatAutoFocus());
    };
    _loc1.__set__txtConsole = function (sText)
    {
        this._txtConsole.text = sText;
        //return (this.txtConsole());
    };
    _loc1.__get__chat = function ()
    {
        return (this._cChat);
    };
    _loc1.__get__shortcuts = function ()
    {
        return (this._msShortcuts);
    };
    _loc1.__get__illustration = function ()
    {
        return (this._mcXtra);
    };
    _loc1.__get__illustrationType = function ()
    {
        return (this._sCurrentCircleXtra);
    };
    _loc1.updateEye = function ()
    {
        this._btnFights._visible = this._nFightsCount != 0 && (!this.api.datacenter.Game.isFight && this._msShortcuts.currentTab == dofus.graphics.gapi.controls.MouseShortcuts.TAB_ITEMS);
        if (this._btnFights.icon == "")
        {
            this._btnFights.icon = "Eye2";
        } // end if
    };
    _loc1.setSelectable = function (bSelectable)
    {
        this._cChat.selectable = bSelectable;
    };
    _loc1.insertChat = function (sText)
    {
        this._txtConsole.text = this._txtConsole.text + sText;
    };
    _loc1.showNextTurnButton = function (bShow)
    {
        this._btnNextTurn._visible = bShow;
    };
    _loc1.showGiveUpButton = function (bShow)
    {
        this.setXtraFightMask(bShow);
        this._btnGiveUp._visible = bShow;
    };
    _loc1.showPoints = function (bShow)
    {
        this._pvAP._visible = bShow;
        this._pvMP._visible = bShow;
        this._cChat.showSitDown(!bShow);
        if (bShow)
        {
            this._oData.data.addEventListener("lpChanged", this);
            this._oData.data.addEventListener("apChanged", this);
            this._oData.data.addEventListener("mpChanged", this);
            this.apChanged({value: Math.max(0, this._oData.data.AP)});
            this.mpChanged({value: Math.max(0, this._oData.data.MP)});
        } // end if
    };
    _loc1.setXtraFightMask = function (bInFight)
    {
        if (!bInFight)
        {
            if (this._sDefaultMaskType == "big")
            {
                this._mcXtra.setMask(this._mcCircleXtraMaskBig);
            }
            else
            {
                this._mcXtra.setMask(this._mcCircleXtraMask);
            } // end else if
        }
        else
        {
            this._mcXtra.setMask(this._mcCircleXtraMask);
        } // end else if
        this.displayMovableBar(this.api.kernel.OptionsManager.getOption("MovableBar") && (!this.api.kernel.OptionsManager.getOption("HideSpellBar") || this.api.datacenter.Game.isFight));
    };
    _loc1.showCircleXtra = function (sXtraName, bShow, oParams, oComponentParams)
    {
        if (sXtraName == undefined)
        {
            return (null);
        } // end if
        if (sXtraName == this._sCurrentCircleXtra && bShow)
        {
            return (null);
        } // end if
        if (sXtraName != this._sCurrentCircleXtra && !bShow)
        {
            return (null);
        } // end if
        if (this._sCurrentCircleXtra != undefined && bShow)
        {
            this.showCircleXtra(this._sCurrentCircleXtra, false);
        } // end if
        var _loc7 = new Object();
        var _loc8 = new Array();
        if (oComponentParams == undefined)
        {
            oComponentParams = new Object();
        } // end if
        this.api.kernel.OptionsManager.setOption("BannerIllustrationMode", sXtraName);
        switch (sXtraName)
        {
            case "artwork":
            {
                var _loc6 = "Loader";
                _loc7 = {_x: this._mcCircleXtraMask._x, _y: this._mcCircleXtraMask._y, contentPath: dofus.Constants.GUILDS_FACES_PATH + this._oData.data.gfxID + ".swf", enabled: true};
                _loc8 = ["complete", "click"];
                break;
            } 
            case "compass":
            {
                var _loc9 = this.api.datacenter.Map;
                _loc6 = "Compass";
                _loc7 = {_x: this._mcCircleXtraPlacer._x, _y: this._mcCircleXtraPlacer._y, _width: this._mcCircleXtraPlacer._width, _height: this._mcCircleXtraPlacer._height, arrow: "UI_BannerCompassArrow", noArrow: "UI_BannerCompassNoArrow", background: "UI_BannerCompassBack", targetCoords: this.api.datacenter.Basics.banner_targetCoords, currentCoords: [_loc9.x, _loc9.y]};
                _loc8 = ["click", "over", "out"];
                break;
            } 
            case "clock":
            {
                _loc6 = "Clock";
                _loc7 = {_x: this._mcCircleXtraPlacer._x, _y: this._mcCircleXtraPlacer._y, _width: this._mcCircleXtraPlacer._width, _height: this._mcCircleXtraPlacer._height, arrowHours: "UI_BannerClockArrowHours", arrowMinutes: "UI_BannerClockArrowMinutes", background: "UI_BannerClockBack", updateFunction: {object: this.api.kernel.NightManager, method: this.api.kernel.NightManager.getCurrentTime}};
                _loc8 = ["click", "over", "out"];
                break;
            } 
            case "helper":
            {
                _loc6 = "Loader";
                _loc7 = {_x: this._mcCircleXtraPlacer._x, _y: this._mcCircleXtraPlacer._y, contentPath: "Helper", enabled: true};
                _loc8 = ["click", "over", "out"];
                break;
            } 
            case "map":
            {
                _loc6 = "MiniMap";
                _loc7 = {_x: this._mcCircleXtraPlacer._x, _y: this._mcCircleXtraPlacer._y, contentPath: "Map", enabled: true};
                _loc8 = [];
                break;
            } 
            default:
            {
                _loc6 = "Loader";
                _loc7 = {_x: this._mcCircleXtraPlacer._x, _y: this._mcCircleXtraPlacer._y, _width: this._mcCircleXtraPlacer._width, _height: this._mcCircleXtraPlacer._height};
                break;
            } 
        } // End of switch
        var _loc10 = null;
        if (bShow)
        {
            for (var k in _loc7)
            {
                oComponentParams[k] = _loc7[k];
            } // end of for...in
            _loc10 = this.attachMovie(_loc6, "_mcXtra", this.getNextHighestDepth(), oComponentParams);
            if (oParams.bMask)
            {
                this._sDefaultMaskType = oParams.sMaskSize;
                if (oParams.sMaskSize == "big" && !this.api.datacenter.Game.isFight)
                {
                    this._mcXtra.setMask(this._mcCircleXtraMaskBig);
                }
                else
                {
                    this._mcXtra.setMask(this._mcCircleXtraMask);
                } // end if
            } // end else if
            for (var k in _loc8)
            {
                this._mcXtra.addEventListener(_loc8[k], this);
            } // end of for...in
            this._mcXtra.swapDepths(this._mcCircleXtraPlacer);
            this._sCurrentCircleXtra = sXtraName;
        }
        else if (this._mcXtra != undefined)
        {
            for (var k in _loc8)
            {
                this._mcXtra.removeEventListener(_loc8[k], this);
            } // end of for...in
            this._mcCircleXtraPlacer.swapDepths(this._mcXtra);
            this._mcXtra.removeMovieClip();
            delete this._sCurrentCircleXtra;
        } // end else if
        return (_loc10);
    };
    _loc1.setCircleXtraParams = function (oParams)
    {
        for (var k in oParams)
        {
            this._mcXtra[k] = oParams[k];
        } // end of for...in
    };
    _loc1.startTimer = function (nDuration)
    {
        this.setXtraFightMask(true);
        this._ccChrono.startTimer(nDuration);
    };
    _loc1.stopTimer = function ()
    {
        this._ccChrono.stopTimer();
    };
    _loc1.setChatText = function (sText)
    {
        this._cChat.setText(sText);
    };
    _loc1.showRightPanel = function (sPanelName, oParams)
    {
        if (this._mcRightPanel.className == sPanelName)
        {
            return;
        } // end if
        if (this._mcRightPanel != undefined)
        {
            this.hideRightPanel();
        } // end if
        oParams._x = this._mcRightPanelPlacer._x;
        oParams._y = this._mcRightPanelPlacer._y;
        var _loc4 = this.attachMovie(sPanelName, "_mcRightPanel", this.getNextHighestDepth(), oParams);
        _loc4.swapDepths(this._mcRightPanelPlacer);
    };
    _loc1.hideRightPanel = function ()
    {
        if (this._mcRightPanel != undefined)
        {
            this._mcRightPanel.swapDepths(this._mcRightPanelPlacer);
            this._mcRightPanel.removeMovieClip();
        } // end if
    };
    _loc1.updateSmileysEmotes = function ()
    {
        this._cChat.updateSmileysEmotes();
    };
    _loc1.showSmileysEmotesPanel = function (bShow)
    {
        if (bShow == undefined)
        {
            bShow = true;
        } // end if
        this._cChat.hideSmileys(!bShow);
    };
    _loc1.updateLocalPlayer = function ()
    {
        if (this._sCurrentCircleXtra == "artwork")
        {
            this._mcXtra.contentPath = dofus.Constants.GUILDS_FACES_PATH + this._oData.data.gfxID + ".swf";
        } // end if
        this._msShortcuts.meleeVisible = !this._oData.isMutant && this._msShortcuts.currentTab == dofus.graphics.gapi.controls.MouseShortcuts.TAB_SPELLS;
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Banner.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this._btnFights._visible = false;
        this.addToQueue({object: this, method: this.hideEpisodicContent});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.showPoints(false);
        this.showNextTurnButton(false);
        this.showGiveUpButton(false);
        this._mcRightPanelPlacer._visible = false;
        this._mcCircleXtraPlacer._visible = false;
        this.api.ui.unloadUIComponent("FightOptionButtons");
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
        this.api.kernel.KeyManager.addKeysListener("onKeys", this);
        this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_ON_CONNECT);
        this.api.network.Game.nLastMapIdReceived = -1;
        this._txtConsole.onSetFocus = function ()
        {
            this._parent.onSetFocus();
        };
        this._txtConsole.onKillFocus = function ()
        {
            this._parent.onKillFocus();
        };
        this._txtConsole.maxChars = dofus.Constants.MAX_MESSAGE_LENGTH + dofus.Constants.MAX_MESSAGE_LENGTH_MARGIN;
        ank.battlefield.Battlefield.useCacheAsBitmapOnStaticAnim = this.api.lang.getConfigText("USE_CACHEASBITMAP_ON_STATICANIM");
    };
    _loc1.linkMovableContainer = function ()
    {
        var _loc2 = this._mcbMovableBar.containers;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < _loc2.length)
        {
            var _loc4 = _loc2[_loc3];
            this._msShortcuts.setContainer(_loc3 + 15, _loc4);
            _loc4.addEventListener("click", this);
            _loc4.addEventListener("dblClick", this);
            _loc4.addEventListener("over", this);
            _loc4.addEventListener("out", this);
            _loc4.addEventListener("drag", this);
            _loc4.addEventListener("drop", this);
            _loc4.params = {position: _loc3 + 15};
        } // end while
    };
    _loc1.addListeners = function ()
    {
        this._btnPvP.addEventListener("click", this);
        this._btnMount.addEventListener("click", this);
        this._btnGuild.addEventListener("click", this);
        this._btnStatsJob.addEventListener("click", this);
        this._btnSpells.addEventListener("click", this);
        this._btnInventory.addEventListener("click", this);
        this._btnQuests.addEventListener("click", this);
        this._btnMap.addEventListener("click", this);
        this._btnFriends.addEventListener("click", this);
        this._btnFights.addEventListener("click", this);
        this._btnHelp.addEventListener("click", this);
        this._btnPvP.addEventListener("over", this);
        this._btnMount.addEventListener("over", this);
        this._btnGuild.addEventListener("over", this);
        this._btnStatsJob.addEventListener("over", this);
        this._btnSpells.addEventListener("over", this);
        this._btnInventory.addEventListener("over", this);
        this._btnQuests.addEventListener("over", this);
        this._btnMap.addEventListener("over", this);
        this._btnFriends.addEventListener("over", this);
        this._btnFights.addEventListener("over", this);
        this._btnHelp.addEventListener("over", this);
        this._btnPvP.addEventListener("out", this);
        this._btnMount.addEventListener("out", this);
        this._btnGuild.addEventListener("out", this);
        this._btnStatsJob.addEventListener("out", this);
        this._btnSpells.addEventListener("out", this);
        this._btnInventory.addEventListener("out", this);
        this._btnQuests.addEventListener("out", this);
        this._btnMap.addEventListener("out", this);
        this._btnFriends.addEventListener("out", this);
        this._btnFights.addEventListener("out", this);
        this._btnHelp.addEventListener("out", this);
        this._btnStatsJob.tabIndex = 0;
        this._btnSpells.tabIndex = 1;
        this._btnInventory.tabIndex = 2;
        this._btnQuests.tabIndex = 3;
        this._btnMap.tabIndex = 4;
        this._btnFriends.tabIndex = 5;
        this._btnGuild.tabIndex = 6;
        this._ccChrono.addEventListener("finalCountDown", this);
        this._ccChrono.addEventListener("beforeFinalCountDown", this);
        this._ccChrono.addEventListener("tictac", this);
        this._ccChrono.addEventListener("finish", this);
        this._cChat.addEventListener("filterChanged", this);
        this._cChat.addEventListener("selectSmiley", this);
        this._cChat.addEventListener("selectEmote", this);
        this._cChat.addEventListener("href", this);
        this._oData.addEventListener("lpChanged", this);
        this._oData.addEventListener("lpmaxChanged", this);
        this._btnNextTurn.addEventListener("click", this);
        this._btnNextTurn.addEventListener("over", this);
        this._btnNextTurn.addEventListener("out", this);
        this._btnGiveUp.addEventListener("click", this);
        this._btnGiveUp.addEventListener("over", this);
        this._btnGiveUp.addEventListener("out", this);
        this._oData.SpellsManager.addEventListener("spellLaunched", this);
        this._oData.SpellsManager.addEventListener("nextTurn", this);
        this._pvAP.addEventListener("over", this);
        this._pvAP.addEventListener("out", this);
        this._pvMP.addEventListener("over", this);
        this._pvMP.addEventListener("out", this);
        this._oData.Spells.addEventListener("modelChanged", this);
        this._oData.Inventory.addEventListener("modelChanged", this);
        this._hHeart.onRollOver = function ()
        {
            this._parent.over({target: this});
        };
        this._hHeart.onRollOut = function ()
        {
            this._parent.out({target: this});
        };
        this._hHeart.onRelease = function ()
        {
            this.toggleDisplay();
        };
    };
    _loc1.initData = function ()
    {
        switch (this.api.kernel.OptionsManager.getOption("BannerIllustrationMode"))
        {
            case "artwork":
            {
                this.showCircleXtra("artwork", true, {bMask: true});
                break;
            } 
            case "clock":
            {
                this.showCircleXtra("clock", true, {bMask: true});
                break;
            } 
            case "compass":
            {
                this.showCircleXtra("compass", true);
            } 
            case "helper":
            {
                this.showCircleXtra("helper", true);
            } 
            case "map":
            {
                this.showCircleXtra("map", true, {bMask: true, sMaskSize: "big"});
            } 
        } // End of switch
        this.drawBar();
        this.lpmaxChanged({value: this._oData.LPmax});
        this.lpChanged({value: this._oData.LP});
        this.api.kernel.ChatManager.refresh();
        if (this.api.kernel.OptionsManager.getOption("MovableBar"))
        {
            this.displayMovableBar(this.api.kernel.OptionsManager.getOption("MovableBar") && (!this.api.kernel.OptionsManager.getOption("HideSpellBar") || this.api.datacenter.Game.isFight));
        } // end if
    };
    _loc1.setChatFocus = function ()
    {
        Selection.setFocus(this._txtConsole);
    };
    _loc1.isChatFocus = function ()
    {
        return (Selection.getFocus()._name == "_txtConsole");
    };
    _loc1.placeCursorAtTheEnd = function ()
    {
        Selection.setFocus(this._txtConsole);
        Selection.setSelection(this._txtConsole.text.length, dofus.Constants.MAX_MESSAGE_LENGTH + dofus.Constants.MAX_MESSAGE_LENGTH_MARGIN);
    };
    _loc1.setChatFocusWithLastKey = function ()
    {
        if (!this._bChatAutoFocus)
        {
            return;
        } // end if
        if (Selection.getFocus() != undefined)
        {
            return;
        } // end if
        this.setChatFocus();
        this.placeCursorAtTheEnd();
    };
    _loc1.setChatPrefix = function (sPrefix)
    {
        this._sChatPrefix = sPrefix;
        if (sPrefix != "")
        {
            this._btnHelp.label = sPrefix;
            this._btnHelp.icon = "";
        }
        else
        {
            this._btnHelp.label = "";
            this._btnHelp.icon = "UI_BannerChatCommandAll";
        } // end else if
        this.addToQueue({object: this, method: this.placeCursorAtTheEnd});
    };
    _loc1.getChatCommand = function ()
    {
        var _loc2 = this._txtConsole.text;
        var _loc3 = _loc2.split(" ");
        if (_loc3[0].charAt(0) == "/")
        {
            return (_loc2);
        }
        else if (this._sChatPrefix != "")
        {
            return (this._sChatPrefix + " " + _loc2);
        } // end else if
        return (_loc2);
    };
    _loc1.hideEpisodicContent = function ()
    {
        this._btnPvP._visible = this.api.datacenter.Basics.aks_current_regional_version >= 16;
        this._btnMount._visible = this.api.datacenter.Basics.aks_current_regional_version >= 20;
        this._btnGuild._visible = !this.api.config.isStreaming;
        var _loc2 = this._btnStatsJob._x;
        var _loc3 = this._btnPvP._x;
        var _loc4 = new Array();
        _loc4.push(this._btnStatsJob);
        _loc4.push(this._btnSpells);
        _loc4.push(this._btnInventory);
        _loc4.push(this._btnQuests);
        _loc4.push(this._btnMap);
        _loc4.push(this._btnFriends);
        if (this._btnGuild._visible)
        {
            _loc4.push(this._btnGuild);
        } // end if
        if (this._btnMount._visible)
        {
            _loc4.push(this._btnMount);
        } // end if
        if (this._btnPvP._visible)
        {
            _loc4.push(this._btnPvP);
        } // end if
        var _loc5 = (_loc3 - _loc2) / (_loc4.length - 1);
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc4.length)
        {
            _loc4[_loc6]._x = _loc6 * _loc5 + _loc2;
        } // end while
    };
    _loc1.displayChatHelp = function ()
    {
        this.api.kernel.Console.process("/help");
        this._cChat.open(false);
    };
    _loc1.displayMovableBar = function (bShow)
    {
        if (bShow == undefined)
        {
            bShow = this._mcbMovableBar == undefined;
        } // end if
        if (bShow)
        {
            if (this._mcbMovableBar._name != undefined)
            {
                return;
            } // end if
            this._mcbMovableBar = (dofus.graphics.gapi.ui.MovableContainerBar)(this.api.ui.loadUIComponent("MovableContainerBar", "MovableBar", [], {bAlwaysOnTop: true}));
            this._mcbMovableBar.addEventListener("drawBar", this);
            this._mcbMovableBar.addEventListener("drop", this);
            this._mcbMovableBar.addEventListener("dblClick", this);
            var _loc3 = {left: 0, top: 0, right: this.gapi.screenWidth, bottom: this.gapi.screenHeight};
            var _loc4 = this.api.kernel.OptionsManager.getOption("MovableBarSize");
            var _loc5 = this.api.kernel.OptionsManager.getOption("MovableBarCoord");
            _loc5 = _loc5 ? (_loc5) : ({x: 0, y: (this.gapi.screenHeight - this._mcbMovableBar._height) / 2});
            this.addToQueue({object: this._mcbMovableBar, method: this._mcbMovableBar.setOptions, params: [9, 20, _loc3, _loc4, _loc5]});
        }
        else
        {
            this.api.ui.unloadUIComponent("MovableBar");
        } // end else if
    };
    _loc1.setMovableBarSize = function (nSize)
    {
        this._mcbMovableBar.size = nSize;
    };
    _loc1.onKeys = function (sKey)
    {
        if (this._lastKeyIsShortcut)
        {
            this._lastKeyIsShortcut = false;
            return;
        } // end if
        this.setChatFocusWithLastKey();
    };
    _loc1.onShortcut = function (sShortcut)
    {
        var _loc3 = true;
        switch (sShortcut)
        {
            case "CTRL_STATE_CHANGED_ON":
            {
                if (this._bIsOnFocus && !(this.api.config.isLinux || this.api.config.isMac))
                {
                    getURL("FSCommand:" add "trapallkeys", "false");
                } // end if
                break;
            } 
            case "CTRL_STATE_CHANGED_OFF":
            {
                if (this._bIsOnFocus && !(this.api.config.isLinux || this.api.config.isMac))
                {
                    getURL("FSCommand:" add "trapallkeys", "true");
                } // end if
                break;
            } 
            case "ESCAPE":
            {
                if (this.isChatFocus())
                {
                    Selection.setFocus(null);
                    _loc3 = false;
                } // end if
                break;
            } 
            case "SEND_CHAT_MSG":
            {
                if (this.isChatFocus())
                {
                    if (this._txtConsole.text.length != 0)
                    {
                        this.api.kernel.Console.process(this.getChatCommand(), this.api.datacenter.Basics.chatParams);
                        this.api.datacenter.Basics.chatParams = new Object();
                        if (this._txtConsole.text != undefined)
                        {
                            this._txtConsole.text = "";
                        } // end if
                        _loc3 = false;
                    } // end if
                }
                else if (Selection.getFocus() == undefined && this._bChatAutoFocus)
                {
                    this.setChatFocus();
                } // end else if
                break;
            } 
            case "TEAM_MESSAGE":
            {
                if (this.isChatFocus())
                {
                    if (this._txtConsole.text.length != 0)
                    {
                        var _loc4 = this.getChatCommand();
                        if (_loc4.charAt(0) == "/")
                        {
                            _loc4 = _loc4.substr(_loc4.indexOf(" ") + 1);
                        } // end if
                        this.api.kernel.Console.process("/t " + _loc4, this.api.datacenter.Basics.chatParams);
                        this.api.datacenter.Basics.chatParams = new Object();
                        if (this._txtConsole.text != undefined)
                        {
                            this._txtConsole.text = "";
                        } // end if
                        _loc3 = false;
                    } // end if
                }
                else if (Selection.getFocus() == undefined && this._bChatAutoFocus)
                {
                    this.setChatFocus();
                } // end else if
                break;
            } 
            case "GUILD_MESSAGE":
            {
                if (this.isChatFocus())
                {
                    if (this._txtConsole.text.length != 0)
                    {
                        var _loc5 = this.getChatCommand();
                        if (_loc5.charAt(0) == "/")
                        {
                            _loc5 = _loc5.substr(_loc5.indexOf(" ") + 1);
                        } // end if
                        this.api.kernel.Console.process("/g " + _loc5, this.api.datacenter.Basics.chatParams);
                        this.api.datacenter.Basics.chatParams = new Object();
                        if (this._txtConsole.text != undefined)
                        {
                            this._txtConsole.text = "";
                        } // end if
                        _loc3 = false;
                    } // end if
                }
                else if (Selection.getFocus() == undefined && this._bChatAutoFocus)
                {
                    this.setChatFocus();
                } // end else if
                break;
            } 
            case "WHISPER_HISTORY_UP":
            {
                if (this.isChatFocus())
                {
                    this._txtConsole.text = this.api.kernel.Console.getWhisperHistoryUp();
                    this.addToQueue({object: this, method: this.placeCursorAtTheEnd});
                    _loc3 = false;
                } // end if
                break;
            } 
            case "WHISPER_HISTORY_DOWN":
            {
                if (this.isChatFocus())
                {
                    this._txtConsole.text = this.api.kernel.Console.getWhisperHistoryDown();
                    this.addToQueue({object: this, method: this.placeCursorAtTheEnd});
                    _loc3 = false;
                } // end if
                break;
            } 
            case "HISTORY_UP":
            {
                if (this.isChatFocus())
                {
                    var _loc6 = this.api.kernel.Console.getHistoryUp();
                    if (_loc6 != undefined)
                    {
                        this.api.datacenter.Basics.chatParams = _loc6.params;
                        this._txtConsole.text = _loc6.value;
                    } // end if
                    this.addToQueue({object: this, method: this.placeCursorAtTheEnd});
                    _loc3 = false;
                } // end if
                break;
            } 
            case "HISTORY_DOWN":
            {
                if (this.isChatFocus())
                {
                    var _loc7 = this.api.kernel.Console.getHistoryDown();
                    if (_loc7 != undefined)
                    {
                        this.api.datacenter.Basics.chatParams = _loc7.params;
                        this._txtConsole.text = _loc7.value;
                    }
                    else
                    {
                        this._txtConsole.text = "";
                    } // end else if
                    this.addToQueue({object: this, method: this.placeCursorAtTheEnd});
                    _loc3 = false;
                } // end if
                break;
            } 
            case "AUTOCOMPLETE":
            {
                var _loc8 = new Array();
                var _loc9 = this.api.datacenter.Sprites.getItems();
                for (var k in _loc9)
                {
                    if (_loc9[k] instanceof dofus.datacenter.Character)
                    {
                        _loc8.push(_loc9[k].name);
                    } // end if
                } // end of for...in
                var _loc10 = this.api.kernel.Console.autoCompletion(_loc8, this._txtConsole.text);
                if (!_loc10.isFull)
                {
                    if (_loc10.list == undefined || _loc10.list.length == 0)
                    {
                        this.api.sounds.events.onError();
                    }
                    else
                    {
                        this.api.ui.showTooltip(_loc10.list.sort().join(", "), 0, 520);
                    } // end if
                } // end else if
                this._txtConsole.text = _loc10.result + (_loc10.isFull ? (" ") : (""));
                this.placeCursorAtTheEnd();
                break;
            } 
            case "NEXTTURN":
            {
                if (this.api.datacenter.Game.isFight)
                {
                    this.api.network.Game.turnEnd();
                    _loc3 = false;
                } // end if
                break;
            } 
            case "MAXI":
            {
                this._cChat.open(false);
                _loc3 = false;
                break;
            } 
            case "MINI":
            {
                this._cChat.open(true);
                _loc3 = false;
                break;
            } 
            case "CHARAC":
            {
                if (this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
                {
                    this.click({target: this._btnStatsJob});
                    _loc3 = false;
                } // end if
                break;
            } 
            case "SPELLS":
            {
                if (this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
                {
                    this.click({target: this._btnSpells});
                    _loc3 = false;
                } // end if
                break;
            } 
            case "INVENTORY":
            {
                if (this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
                {
                    this.click({target: this._btnInventory});
                    _loc3 = false;
                } // end if
                break;
            } 
            case "QUESTS":
            {
                if (this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
                {
                    this.click({target: this._btnQuests});
                    _loc3 = false;
                } // end if
                break;
            } 
            case "MAP":
            {
                if (this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
                {
                    this.click({target: this._btnMap});
                    _loc3 = false;
                } // end if
                break;
            } 
            case "FRIENDS":
            {
                if (this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
                {
                    this.click({target: this._btnFriends});
                    _loc3 = false;
                } // end if
                break;
            } 
            case "GUILD":
            {
                if (this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
                {
                    this.click({target: this._btnGuild});
                    _loc3 = false;
                } // end if
                break;
            } 
            case "MOUNT":
            {
                if (this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
                {
                    this.click({target: this._btnMount});
                    _loc3 = false;
                } // end if
                break;
            } 
        } // End of switch
        this._lastKeyIsShortcut = _loc3;
        return (_loc3);
    };
    _loc1.click = function (oEvent)
    {
        this.api.kernel.GameManager.signalFightActivity();
        switch (oEvent.target._name)
        {
            case "_btnPvP":
            {
                this.api.sounds.events.onBannerRoundButtonClick();
                if (this.api.datacenter.Player.data.alignment.index == 0)
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("NEED_ALIGNMENT"), "ERROR_CHAT");
                }
                else
                {
                    this.showSmileysEmotesPanel(false);
                    this.gapi.loadUIAutoHideComponent("Conquest", "Conquest", {currentTab: "Stats"});
                } // end else if
                break;
            } 
            case "_btnMount":
            {
                this.api.sounds.events.onBannerRoundButtonClick();
                if (this._oData.isMutant)
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_U_ARE_MUTANT"), "ERROR_CHAT");
                    return;
                } // end if
                if (this._oData.mount != undefined)
                {
                    this.showSmileysEmotesPanel(false);
                    if (this.gapi.getUIComponent("MountAncestorsViewer") != undefined)
                    {
                        this.gapi.unloadUIComponent("MountAncestorsViewer");
                        this.gapi.unloadUIComponent("Mount");
                    }
                    else
                    {
                        this.gapi.loadUIAutoHideComponent("Mount", "Mount");
                    } // end else if
                }
                else
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("UI_ONLY_FOR_MOUNT"), "ERROR_CHAT");
                } // end else if
                break;
            } 
            case "_btnGuild":
            {
                this.api.sounds.events.onBannerRoundButtonClick();
                if (this._oData.isMutant)
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_U_ARE_MUTANT"), "ERROR_CHAT");
                    return;
                } // end if
                if (this._oData.guildInfos != undefined)
                {
                    this.showSmileysEmotesPanel(false);
                    this.gapi.loadUIAutoHideComponent("Guild", "Guild", {currentTab: "Members"});
                }
                else
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("UI_ONLY_FOR_GUILD"), "ERROR_CHAT");
                } // end else if
                break;
            } 
            case "_btnStatsJob":
            {
                this.api.sounds.events.onBannerRoundButtonClick();
                if (this._oData.isMutant)
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_U_ARE_MUTANT"), "ERROR_CHAT");
                    return;
                } // end if
                this.showSmileysEmotesPanel(false);
                this.gapi.loadUIAutoHideComponent("StatsJob", "StatsJob");
                break;
            } 
            case "_btnSpells":
            {
                this.api.sounds.events.onBannerRoundButtonClick();
                if (this._oData.isMutant)
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_U_ARE_MUTANT"), "ERROR_CHAT");
                    return;
                } // end if
                this.showSmileysEmotesPanel(false);
                this.gapi.loadUIAutoHideComponent("Spells", "Spells");
                break;
            } 
            case "_btnInventory":
            {
                this.api.sounds.events.onBannerRoundButtonClick();
                this.showSmileysEmotesPanel(false);
                this.gapi.loadUIAutoHideComponent("Inventory", "Inventory");
                break;
            } 
            case "_btnQuests":
            {
                this.api.sounds.events.onBannerRoundButtonClick();
                this.showSmileysEmotesPanel(false);
                this.gapi.loadUIAutoHideComponent("Quests", "Quests");
                break;
            } 
            case "_btnMap":
            {
                this.api.sounds.events.onBannerRoundButtonClick();
                this.showSmileysEmotesPanel(false);
                this.gapi.loadUIAutoHideComponent("MapExplorer", "MapExplorer");
                break;
            } 
            case "_btnFriends":
            {
                this.api.sounds.events.onBannerRoundButtonClick();
                this.showSmileysEmotesPanel(false);
                this.gapi.loadUIAutoHideComponent("Friends", "Friends");
                break;
            } 
            case "_btnFights":
            {
                if (!this.api.datacenter.Game.isFight)
                {
                    this.gapi.loadUIComponent("FightsInfos", "FightsInfos");
                } // end if
                break;
            } 
            case "_btnHelp":
            {
                var _loc3 = this.api.lang.getConfigText("CHAT_FILTERS");
                var _loc4 = this.api.ui.createPopupMenu();
                _loc4.addStaticItem(this.api.lang.getText("CHAT_PREFIX"));
                _loc4.addItem(this.api.lang.getText("DEFAUT"), this, this.setChatPrefix, [""]);
                _loc4.addItem(this.api.lang.getText("TEAM") + " (/t)", this, this.setChatPrefix, ["/t"], this.api.datacenter.Game.isFight);
                _loc4.addItem(this.api.lang.getText("PARTY") + " (/p)", this, this.setChatPrefix, ["/p"], this.api.ui.getUIComponent("Party") != undefined);
                _loc4.addItem(this.api.lang.getText("GUILD") + " (/g)", this, this.setChatPrefix, ["/g"], this.api.datacenter.Player.guildInfos != undefined);
                if (_loc3[4])
                {
                    _loc4.addItem(this.api.lang.getText("ALIGNMENT") + " (/a)", this, this.setChatPrefix, ["/a"], this.api.datacenter.Player.alignment.index != 0);
                } // end if
                if (_loc3[5])
                {
                    _loc4.addItem(this.api.lang.getText("RECRUITMENT") + " (/r)", this, this.setChatPrefix, ["/r"]);
                } // end if
                if (_loc3[6])
                {
                    _loc4.addItem(this.api.lang.getText("TRADE") + " (/b)", this, this.setChatPrefix, ["/b"]);
                } // end if
                if (_loc3[7])
                {
                    _loc4.addItem(this.api.lang.getText("MEETIC") + " (/i)", this, this.setChatPrefix, ["/i"]);
                } // end if
                if (this.api.datacenter.Player.isAuthorized)
                {
                    _loc4.addItem(this.api.lang.getText("PRIVATE_CHANNEL") + " (/q)", this, this.setChatPrefix, ["/q"]);
                } // end if
                _loc4.addItem(this.api.lang.getText("HELP"), this, this.displayChatHelp, []);
                _loc4.show(this._btnHelp._x, this._btnHelp._y, true);
                break;
            } 
            case "_btnNextTurn":
            {
                if (this.api.datacenter.Game.isFight)
                {
                    this.api.network.Game.turnEnd();
                } // end if
                break;
            } 
            case "_btnGiveUp":
            {
                if (this.api.datacenter.Game.isFight)
                {
                    if (this.api.datacenter.Game.isSpectator)
                    {
                        this.api.network.Game.leave();
                    }
                    else
                    {
                        this.api.kernel.GameManager.giveUpGame();
                    } // end if
                } // end else if
                break;
            } 
            case "_mcXtra":
            {
                if (!Key.isDown(Key.SHIFT))
                {
                    if (this._sCurrentCircleXtra == "helper" && dofus.managers.TipsManager.getInstance().hasNewTips())
                    {
                        dofus.managers.TipsManager.getInstance().displayNextTips();
                        break;
                    } // end if
                    var _loc5 = this.api.ui.createPopupMenu();
                    if (this._sCurrentCircleXtra == "helper")
                    {
                        _loc5.addStaticItem(this.api.lang.getText("HELP_ME"));
                        _loc5.addItem(this.api.lang.getText("KB_TITLE"), this.api.ui, this.api.ui.loadUIComponent, ["KnownledgeBase", "KnownledgeBase"], true);
                        _loc5.addStaticItem(this.api.lang.getText("OTHER_DISPLAY_OPTIONS"));
                    } // end if
                    _loc5.addItem(this.api.lang.getText("BANNER_ARTWORK"), this, this.showCircleXtra, ["artwork", true, {bMask: true}], this._sCurrentCircleXtra != "artwork");
                    _loc5.addItem(this.api.lang.getText("BANNER_CLOCK"), this, this.showCircleXtra, ["clock", true, {bMask: true}], this._sCurrentCircleXtra != "clock");
                    _loc5.addItem(this.api.lang.getText("BANNER_COMPASS"), this, this.showCircleXtra, ["compass", true], this._sCurrentCircleXtra != "compass");
                    _loc5.addItem(this.api.lang.getText("BANNER_HELPER"), this, this.showCircleXtra, ["helper", true], this._sCurrentCircleXtra != "helper");
                    _loc5.addItem(this.api.lang.getText("BANNER_MAP"), this, this.showCircleXtra, ["map", true, {bMask: true, sMaskSize: "big"}], this._sCurrentCircleXtra != "map");
                    _loc5.show(_root._xmouse, _root._ymouse, true);
                }
                else
                {
                    this.api.kernel.GameManager.showPlayerPopupMenu(undefined, this.api.datacenter.Player.Name);
                } // end else if
                break;
            } 
            default:
            {
                switch (this._msShortcuts.currentTab)
                {
                    case "Spells":
                    {
                        this.api.sounds.events.onBannerSpellSelect();
                        if (this.api.kernel.TutorialManager.isTutorialMode)
                        {
                            this.api.kernel.TutorialManager.onWaitingCase({code: "SPELL_CONTAINER_SELECT", params: [Number(oEvent.target._name.substr(4))]});
                            break;
                        } // end if
                        if (this.gapi.getUIComponent("Spells") != undefined)
                        {
                            return;
                        } // end if
                        var _loc6 = oEvent.target.contentData;
                        if (_loc6 == undefined)
                        {
                            return;
                        } // end if
                        this.api.kernel.GameManager.switchToSpellLaunch(_loc6, true);
                        break;
                    } 
                    case "Items":
                    {
                        if (this.api.kernel.TutorialManager.isTutorialMode)
                        {
                            this.api.kernel.TutorialManager.onWaitingCase({code: "OBJECT_CONTAINER_SELECT", params: [Number(oEvent.target._name.substr(4))]});
                            break;
                        } // end if
                        if (Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && (oEvent.target.contentData != undefined && !oEvent.target.notInChat))
                        {
                            this.api.kernel.GameManager.insertItemInChat(oEvent.target.contentData);
                            return;
                        }
                        else
                        {
                            oEvent.target.notInChat = false;
                        } // end else if
                        var _loc7 = this.gapi.getUIComponent("Inventory");
                        if (_loc7 != undefined)
                        {
                            _loc7.showItemInfos(oEvent.target.contentData);
                        }
                        else
                        {
                            var _loc8 = oEvent.target.contentData;
                            if (_loc8 == undefined)
                            {
                                return;
                            } // end if
                            if (this.api.datacenter.Player.canUseObject)
                            {
                                if (_loc8.canTarget)
                                {
                                    this.api.kernel.GameManager.switchToItemTarget(_loc8);
                                }
                                else if (_loc8.canUse && oEvent.keyBoard)
                                {
                                    this.api.network.Items.use(_loc8.ID);
                                } // end if
                            } // end else if
                        } // end else if
                        break;
                    } 
                } // End of switch
                break;
            } 
        } // End of switch
    };
    _loc1.dblClick = function (oEvent)
    {
        if (oEvent.target == this._mcbMovableBar)
        {
            this._mcbMovableBar.size = this._mcbMovableBar.size == 0 ? (this.api.kernel.OptionsManager.getOption("MovableBarSize")) : (0);
            return;
        } // end if
    };
    _loc1.beforeFinalCountDown = function (oEvent)
    {
        this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FINAL_COUNTDOWN);
    };
    _loc1.finalCountDown = function (oEvent)
    {
        this._mcXtra._visible = false;
        this._lblFinalCountDown.text = oEvent.value;
    };
    _loc1.tictac = function (oEvent)
    {
        this.api.sounds.events.onBannerTimer();
    };
    _loc1.finish = function (oEvent)
    {
        this._mcXtra._visible = true;
        if (this._lblFinalCountDown.text != undefined)
        {
            this._lblFinalCountDown.text = "";
        } // end if
    };
    _loc1.complete = function (oEvent)
    {
        var _loc3 = this.api.kernel.OptionsManager.getOption("BannerIllustrationMode");
        if (oEvent.target.contentPath.indexOf("artworks") != -1 && _loc3 == "helper")
        {
            this.showCircleXtra("helper", true);
        }
        else
        {
            this.api.colors.addSprite(this._mcXtra.content, this._oData.data);
        } // end else if
    };
    _loc1.over = function (oEvent)
    {
        if (!this.gapi.isCursorHidden())
        {
            return;
        } // end if
        switch (oEvent.target._name)
        {
            case "_btnHelp":
            {
                this.gapi.showTooltip(this.api.lang.getText("CHAT_MENU"), oEvent.target, -20, {bXLimit: false, bYLimit: false});
                break;
            } 
            case "_btnGiveUp":
            {
                if (this.api.datacenter.Game.isSpectator)
                {
                    var _loc3 = this.api.lang.getText("GIVE_UP_SPECTATOR");
                }
                else if (this.api.datacenter.Game.fightType == dofus.managers.GameManager.FIGHT_TYPE_CHALLENGE || !this.api.datacenter.Basics.aks_current_server.isHardcore())
                {
                    _loc3 = this.api.lang.getText("GIVE_UP");
                }
                else
                {
                    _loc3 = this.api.lang.getText("SUICIDE");
                } // end else if
                this.gapi.showTooltip(_loc3, oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnPvP":
            {
                this.gapi.showTooltip(this.api.lang.getText("CONQUEST_WORD"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnMount":
            {
                this.gapi.showTooltip(this.api.lang.getText("MY_MOUNT"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnGuild":
            {
                this.gapi.showTooltip(this.api.lang.getText("YOUR_GUILD"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnStatsJob":
            {
                this.gapi.showTooltip(this.api.lang.getText("YOUR_STATS_JOB"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnSpells":
            {
                this.gapi.showTooltip(this.api.lang.getText("YOUR_SPELLS"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnQuests":
            {
                this.gapi.showTooltip(this.api.lang.getText("YOUR_QUESTS"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnInventory":
            {
                this.gapi.showTooltip(this.api.lang.getText("YOUR_INVENTORY"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnMap":
            {
                this.gapi.showTooltip(this.api.lang.getText("YOUR_BOOK"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnFriends":
            {
                this.gapi.showTooltip(this.api.lang.getText("YOUR_FRIENDS"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnFights":
            {
                if (this._nFightsCount != 0)
                {
                    this.gapi.showTooltip(ank.utils.PatternDecoder.combine(this.api.lang.getText("FIGHTS_ON_MAP", [this._nFightsCount]), "m", this._nFightsCount < 2), oEvent.target, -20, {bYLimit: false});
                } // end if
                break;
            } 
            case "_btnNextTurn":
            {
                this.gapi.showTooltip(this.api.lang.getText("NEXT_TURN"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_pvAP":
            {
                this.gapi.showTooltip(this.api.lang.getText("ACTIONPOINTS"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_pvMP":
            {
                this.gapi.showTooltip(this.api.lang.getText("MOVEPOINTS"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_mcXtra":
            {
                switch (this._sCurrentCircleXtra)
                {
                    case "compass":
                    {
                        var _loc4 = oEvent.target.targetCoords;
                        if (_loc4 == undefined)
                        {
                            this.gapi.showTooltip(this.api.lang.getText("BANNER_SET_FLAG"), oEvent.target, 0, {bXLimit: true, bYLimit: false});
                        }
                        else
                        {
                            this.gapi.showTooltip(_loc4[0] + ", " + _loc4[1], oEvent.target, 0, {bXLimit: true, bYLimit: false});
                        } // end else if
                        break;
                    } 
                    case "clock":
                    {
                        this.gapi.showTooltip(this.api.kernel.NightManager.time + "\n" + this.api.kernel.NightManager.getCurrentDateString(), oEvent.target, 0, {bXLimit: true, bYLimit: false});
                        break;
                    } 
                    case "map":
                    {
                        this.gapi.showTooltip(oEvent.target.tooltip, oEvent.target, 0, {bXLimit: true, bYLimit: false});
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "_hHeart":
            {
                this.gapi.showTooltip(this.api.lang.getText("HELP_LIFE"), oEvent.target, -20);
                break;
            } 
            default:
            {
                switch (this._msShortcuts.currentTab)
                {
                    case "Spells":
                    {
                        var _loc5 = oEvent.target.contentData;
                        if (_loc5 != undefined)
                        {
                            this.gapi.showTooltip(_loc5.name + " (" + _loc5.apCost + " " + this.api.lang.getText("AP") + (_loc5.actualCriticalHit > 0 ? (", " + this.api.lang.getText("ACTUAL_CRITICAL_CHANCE") + ": 1/" + _loc5.actualCriticalHit) : ("")) + ")", oEvent.target, -20, {bXLimit: true, bYLimit: false});
                        } // end if
                        break;
                    } 
                    case "Items":
                    {
                        var _loc6 = oEvent.target.contentData;
                        if (_loc6 != undefined)
                        {
                            var _loc7 = _loc6.name;
                            if (this.gapi.getUIComponent("Inventory") == undefined)
                            {
                                if (_loc6.canUse && _loc6.canTarget)
                                {
                                    _loc7 = _loc7 + ("\n" + this.api.lang.getText("HELP_SHORTCUT_DBLCLICK_CLICK"));
                                }
                                else
                                {
                                    if (_loc6.canUse)
                                    {
                                        _loc7 = _loc7 + ("\n" + this.api.lang.getText("HELP_SHORTCUT_DBLCLICK"));
                                    } // end if
                                    if (_loc6.canTarget)
                                    {
                                        _loc7 = _loc7 + ("\n" + this.api.lang.getText("HELP_SHORTCUT_CLICK"));
                                    } // end if
                                } // end if
                            } // end else if
                            this.gapi.showTooltip(_loc7, oEvent.target, -30, {bXLimit: true, bYLimit: false});
                        } // end if
                        break;
                    } 
                } // End of switch
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.drag = function (oEvent)
    {
        var _loc3 = oEvent.target.contentData;
        if (_loc3 == undefined)
        {
            return;
        } // end if
        switch (this._msShortcuts.currentTab)
        {
            case "Spells":
            {
                if (this.gapi.getUIComponent("Spells") == undefined && !Key.isDown(Key.SHIFT))
                {
                    return;
                } // end if
                break;
            } 
            case "Items":
            {
                if (this.gapi.getUIComponent("Inventory") == undefined && !Key.isDown(Key.SHIFT))
                {
                    return;
                } // end if
                break;
            } 
        } // End of switch
        this.gapi.removeCursor();
        this.gapi.setCursor(_loc3);
    };
    _loc1.drop = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._mcbMovableBar:
            {
                this.api.kernel.OptionsManager.setOption("MovableBarCoord", {x: this._mcbMovableBar._x, y: this._mcbMovableBar._y});
                break;
            } 
            default:
            {
                switch (this._msShortcuts.currentTab)
                {
                    case "Spells":
                    {
                        if (this.gapi.getUIComponent("Spells") == undefined && !Key.isDown(Key.SHIFT))
                        {
                            return;
                        } // end if
                        var _loc3 = this.gapi.getCursor();
                        if (_loc3 == undefined)
                        {
                            return;
                        } // end if
                        this.gapi.removeCursor();
                        var _loc4 = _loc3.position;
                        var _loc5 = oEvent.target.params.position;
                        if (_loc4 == _loc5)
                        {
                            return;
                        } // end if
                        if (_loc4 != undefined)
                        {
                            this._msShortcuts.getContainer(_loc4).contentData = undefined;
                            this._oData.SpellsUsed.removeItemAt(_loc4);
                        } // end if
                        var _loc6 = this._msShortcuts.getContainer(_loc5).contentData;
                        if (_loc6 != undefined)
                        {
                            _loc6.position = undefined;
                        } // end if
                        _loc3.position = _loc5;
                        oEvent.target.contentData = _loc3;
                        this._oData.SpellsUsed.addItemAt(_loc5, _loc3);
                        this.api.network.Spells.moveToUsed(_loc3.ID, _loc5);
                        this.addToQueue({object: this._msShortcuts, method: this._msShortcuts.setSpellStateOnAllContainers});
                        break;
                    } 
                    case "Items":
                    {
                        if (this.gapi.getUIComponent("Inventory") == undefined && !Key.isDown(Key.SHIFT))
                        {
                            return;
                        } // end if
                        var _loc7 = this.gapi.getCursor();
                        if (_loc7 == undefined)
                        {
                            return;
                        } // end if
                        if (!_loc7.canMoveToShortut)
                        {
                            this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_MOVE_ITEM_HERE"), "ERROR_BOX");
                            return;
                        } // end if
                        this.gapi.removeCursor();
                        var _loc8 = oEvent.target.params.position + dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET;
                        if (_loc7.position == _loc8)
                        {
                            return;
                        } // end if
                        if (_loc7.Quantity > 1)
                        {
                            var _loc9 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: _loc7.Quantity, max: _loc7.Quantity, useAllStage: true, params: {type: "drop", item: _loc7, position: _loc8}}, {bAlwaysOnTop: true});
                            _loc9.addEventListener("validate", this);
                        }
                        else
                        {
                            this.api.network.Items.movement(_loc7.ID, _loc8, 1);
                        } // end else if
                        break;
                    } 
                } // End of switch
                break;
            } 
        } // End of switch
    };
    _loc1.filterChanged = function (oEvent)
    {
        this.api.network.Chat.subscribeChannels(oEvent.filter, oEvent.selected);
    };
    _loc1.lpChanged = function (oEvent)
    {
        this._hHeart.value = oEvent.value;
    };
    _loc1.lpmaxChanged = function (oEvent)
    {
        this._hHeart.max = oEvent.value;
    };
    _loc1.apChanged = function (oEvent)
    {
        this._pvAP.value = oEvent.value;
        if (this.api.datacenter.Game.isFight)
        {
        } // end if
        this._msShortcuts.setSpellStateOnAllContainers();
    };
    _loc1.mpChanged = function (oEvent)
    {
        this._pvMP.value = Math.max(0, oEvent.value);
    };
    _loc1.selectSmiley = function (oEvent)
    {
        this.api.network.Chat.useSmiley(oEvent.index);
    };
    _loc1.selectEmote = function (oEvent)
    {
        this.api.network.Emotes.useEmote(oEvent.index);
    };
    _loc1.spellLaunched = function (oEvent)
    {
        this._msShortcuts.setSpellStateOnContainer(oEvent.spell.position);
    };
    _loc1.nextTurn = function (oEvent)
    {
        this._msShortcuts.setSpellStateOnAllContainers();
    };
    _loc1.href = function (oEvent)
    {
        var _loc3 = oEvent.params.split(",");
        switch (_loc3[0])
        {
            case "OpenGuildTaxCollectors":
            {
                this.addToQueue({object: this.gapi, method: this.gapi.loadUIAutoHideComponent, params: ["Guild", "Guild", {currentTab: "TaxCollectors"}, {bStayIfPresent: true}]});
                break;
            } 
            case "OpenPayZoneDetails":
            {
                this.addToQueue({object: this.gapi, method: this.gapi.loadUIComponent, params: ["PayZoneDialog2", "PayZoneDialog2", {name: "El Pemy", gfx: "9059", dialogID: dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_DETAILS}, {bForceLoad: true}]});
                break;
            } 
            case "ShowPlayerPopupMenu":
            {
                if (_loc3[2] != undefined && (String(_loc3[2]).length > 0 && _loc3[2] != ""))
                {
                    this.addToQueue({object: this.api.kernel.GameManager, method: this.api.kernel.GameManager.showPlayerPopupMenu, params: [undefined, _loc3[1], null, null, null, _loc3[2], this.api.datacenter.Player.isAuthorized]});
                }
                else
                {
                    this.addToQueue({object: this.api.kernel.GameManager, method: this.api.kernel.GameManager.showPlayerPopupMenu, params: [undefined, _loc3[1]]});
                } // end else if
                break;
            } 
            case "ShowItemViewer":
            {
                var _loc4 = this.api.kernel.ChatManager.getItemFromBuffer(Number(_loc3[1]));
                if (_loc4 == undefined)
                {
                    this.addToQueue({object: this.api.kernel, method: this.api.kernel.showMessage, params: [this.api.lang.getText("ERROR_WORD"), this.api.lang.getText("ERROR_ITEM_CANT_BE_DISPLAYED"), "ERROR_BOX"]});
                    break;
                } // end if
                this.addToQueue({object: this.api.ui, method: this.api.ui.loadUIComponent, params: ["ItemViewer", "ItemViewer", {item: _loc4}, {bAlwaysOnTop: true}]});
                break;
            } 
            case "updateCompass":
            {
                this.api.kernel.GameManager.updateCompass(Number(_loc3[1]), Number(_loc3[2]));
                break;
            } 
            case "ShowLinkWarning":
            {
                this.addToQueue({object: this.api.ui, method: this.api.ui.loadUIComponent, params: ["AskLinkWarning", "AskLinkWarning", {text: this.api.lang.getText(_loc3[1])}]});
                break;
            } 
        } // End of switch
    };
    _loc1.validate = function (oEvent)
    {
        switch (oEvent.params.type)
        {
            case "drop":
            {
                this.gapi.removeCursor();
                if (oEvent.value > 0 && !_global.isNaN(Number(oEvent.value)))
                {
                    this.api.network.Items.movement(oEvent.params.item.ID, oEvent.params.position, Math.min(oEvent.value, oEvent.params.item.Quantity));
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.drawBar = function (oEvent)
    {
        this.linkMovableContainer();
        this._msShortcuts.updateCurrentTabInformations();
        if (this._msShortcuts.currentTab == dofus.graphics.gapi.controls.MouseShortcuts.TAB_SPELLS)
        {
            this._btnFights._visible = false;
        }
        else
        {
            this._btnFights._visible = this._nFightsCount != 0 && !this.api.datacenter.Game.isFight;
        } // end else if
    };
    _loc1.onSetFocus = function ()
    {
        if (this.api.config.isLinux || this.api.config.isMac)
        {
            getURL("FSCommand:" add "trapallkeys", "false");
        }
        else
        {
            this._bIsOnFocus = true;
        } // end else if
    };
    _loc1.onKillFocus = function ()
    {
        if (this.api.config.isLinux || this.api.config.isMac)
        {
            getURL("FSCommand:" add "trapallkeys", "true");
        }
        else
        {
            this._bIsOnFocus = false;
        } // end else if
    };
    _loc1.addProperty("chatAutoFocus", _loc1.__get__chatAutoFocus, _loc1.__set__chatAutoFocus);
    _loc1.addProperty("illustrationType", _loc1.__get__illustrationType, function ()
    {
    });
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    _loc1.addProperty("chat", _loc1.__get__chat, function ()
    {
    });
    _loc1.addProperty("illustration", _loc1.__get__illustration, function ()
    {
    });
    _loc1.addProperty("fightsCount", function ()
    {
    }, _loc1.__set__fightsCount);
    _loc1.addProperty("txtConsole", function ()
    {
    }, _loc1.__set__txtConsole);
    _loc1.addProperty("shortcuts", _loc1.__get__shortcuts, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Banner = function ()
    {
        super();
    }).CLASS_NAME = "Banner";
    (_global.dofus.graphics.gapi.ui.Banner = function ()
    {
        super();
    }).NO_TRANSFORM = {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0};
    (_global.dofus.graphics.gapi.ui.Banner = function ()
    {
        super();
    }).INACTIVE_TRANSFORM = {ra: 50, rb: 0, ga: 50, gb: 0, ba: 50, bb: 0};
    _loc1._nFightsCount = 0;
    _loc1._bChatAutoFocus = true;
    _loc1._sChatPrefix = "";
} // end if
#endinitclip
