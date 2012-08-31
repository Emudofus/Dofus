// Action script...

// [Initial MovieClip Action of sprite 1009]
#initclip 228
class dofus.graphics.gapi.ui.Banner extends ank.gapi.core.UIAdvancedComponent
{
    var _oData, __get__data, _btnFights, api, __get__fightsCount, __get__chatAutoFocus, _btnNextTurn, _btnGiveUp, _pvAP, _pvMP, _sCurrentCircleXtra, _mcCircleXtraMask, _mcCircleXtraPlacer, getNextHighestDepth, attachMovie, _mcXtra, _ccChrono, _cChat, addToQueue, setMovieClipTransform, _ctrCC, _mcRightPanel, _mcRightPanelPlacer, gapi, _btnTabSpells, _btnTabItems, _btnGuild, _btnStatsJob, _btnSpells, _btnInventory, _btnMap, _btnFriends, _btnHelp, _txtConsole, _ctr1, _ctr2, _ctr3, _ctr4, _ctr5, _ctr6, _ctr7, _lblFinalCountDown, _hHeart, __get__gapi, __set__chatAutoFocus, __set__data, __set__fightsCount;
    function Banner()
    {
        super();
    } // End of the function
    function set data(oData)
    {
        _oData = oData;
        //return (this.data());
        null;
    } // End of the function
    function set fightsCount(nFightsCount)
    {
        _nFightsCount = nFightsCount;
        _btnFights._visible = nFightsCount != 0 && !api.datacenter.Game.isFight && _sCurrentTab == "Items";
        if (_btnFights.__get__icon() == "")
        {
            _btnFights.__set__icon("Eye2");
        } // end if
        //return (this.fightsCount());
        null;
    } // End of the function
    function get chatAutoFocus()
    {
        return (_bChatAutoFocus);
    } // End of the function
    function set chatAutoFocus(bChatAutoFocus)
    {
        _bChatAutoFocus = bChatAutoFocus;
        //return (this.chatAutoFocus());
        null;
    } // End of the function
    function showNextTurnButton(bShow)
    {
        _btnNextTurn._visible = bShow;
    } // End of the function
    function showGiveUpButton(bShow)
    {
        _btnGiveUp._visible = bShow;
    } // End of the function
    function showPoints(bShow)
    {
        _pvAP._visible = bShow;
        _pvMP._visible = bShow;
        if (bShow)
        {
            _oData.data.addEventListener("lpChanged", this);
            _oData.data.addEventListener("apChanged", this);
            _oData.data.addEventListener("mpChanged", this);
            this.apChanged({value: Math.max(0, _oData.data.AP)});
            this.mpChanged({value: Math.max(0, _oData.data.MP)});
        } // end if
    } // End of the function
    function showCircleXtra(sXtraName, bShow, oParams, oComponentParams)
    {
        if (sXtraName == undefined)
        {
            return (false);
        } // end if
        if (sXtraName == _sCurrentCircleXtra && bShow)
        {
            return (false);
        } // end if
        if (sXtraName != _sCurrentCircleXtra && !bShow)
        {
            return (false);
        } // end if
        if (_sCurrentCircleXtra != undefined && bShow)
        {
            this.showCircleXtra(_sCurrentCircleXtra, false);
        } // end if
        var _loc5;
        var _loc3 = new Object();
        var _loc2 = new Array();
        if (oComponentParams == undefined)
        {
            oComponentParams = new Object();
        } // end if
        switch (sXtraName)
        {
            case "artwork":
            {
                _loc5 = "Loader";
                _loc3 = {_x: _mcCircleXtraMask._x, _y: _mcCircleXtraMask._y, contentPath: dofus.Constants.GUILDS_FACES_PATH + _oData.data.gfxID + ".swf", enabled: true};
                _loc2 = ["complete", "click"];
                break;
            } 
            case "compass":
            {
                var _loc9 = api.datacenter.Map;
                _loc5 = "Compass";
                _loc3 = {_x: _mcCircleXtraPlacer._x, _y: _mcCircleXtraPlacer._y, _width: _mcCircleXtraPlacer._width, _height: _mcCircleXtraPlacer._height, arrow: "UI_BannerCompassArrow", noArrow: "UI_BannerCompassNoArrow", background: "UI_BannerCompassBack", targetCoords: api.datacenter.Basics.banner_targetCoords, currentCoords: [_loc9.x, _loc9.y]};
                _loc2 = ["click", "over", "out"];
                break;
            } 
            case "clock":
            {
                _loc5 = "Clock";
                _loc3 = {_x: _mcCircleXtraPlacer._x, _y: _mcCircleXtraPlacer._y, _width: _mcCircleXtraPlacer._width, _height: _mcCircleXtraPlacer._height, arrowHours: "UI_BannerClockArrowHours", arrowMinutes: "UI_BannerClockArrowMinutes", background: "UI_BannerClockBack", updateFunction: {object: api.kernel.NightManager, method: api.kernel.NightManager.getCurrentTime}};
                _loc2 = ["click", "over", "out"];
                break;
            } 
            default:
            {
                _loc5 = "Loader";
                _loc3 = {_x: _mcCircleXtraPlacer._x, _y: _mcCircleXtraPlacer._y, _width: _mcCircleXtraPlacer._width, _height: _mcCircleXtraPlacer._height};
                break;
            } 
        } // End of switch
        if (bShow)
        {
            for (var _loc6 in _loc3)
            {
                oComponentParams[_loc6] = _loc3[_loc6];
            } // end of for...in
            this.attachMovie(_loc5, "_mcXtra", this.getNextHighestDepth(), oComponentParams);
            if (oParams.bMask)
            {
                _mcXtra.setMask(_mcCircleXtraMask);
            } // end if
            for (var _loc6 in _loc2)
            {
                _mcXtra.addEventListener(_loc2[_loc6], this);
            } // end of for...in
            _mcXtra.swapDepths(_mcCircleXtraPlacer);
            _sCurrentCircleXtra = sXtraName;
        }
        else if (_mcXtra != undefined)
        {
            for (var _loc6 in _loc2)
            {
                _mcXtra.removeEventListener(_loc2[_loc6], this);
            } // end of for...in
            _mcCircleXtraPlacer.swapDepths(_mcXtra);
            _mcXtra.removeMovieClip();
            delete this._sCurrentCircleXtra;
        } // end else if
        return (true);
    } // End of the function
    function setCircleXtraParams(oParams)
    {
        for (var _loc3 in oParams)
        {
            _mcXtra[_loc3] = oParams[_loc3];
        } // end of for...in
    } // End of the function
    function startTimer(nDuration)
    {
        _ccChrono.startTimer(nDuration);
    } // End of the function
    function stopTimer()
    {
        _ccChrono.stopTimer();
    } // End of the function
    function setChatText(sText)
    {
        _cChat.setText(sText);
    } // End of the function
    function updateSpells()
    {
        var _loc5 = new Array();
        for (var _loc2 = 1; _loc2 <= 14; ++_loc2)
        {
            _loc5[_loc2] = true;
        } // end of for
        var _loc6 = _oData.Spells;
        for (var _loc7 in _loc6)
        {
            var _loc4 = _loc6[_loc7];
            var _loc3 = _loc4.position;
            if (!isNaN(_loc3))
            {
                this["_ctr" + _loc3].contentData = _loc4;
                _loc5[_loc3] = false;
            } // end if
        } // end of for...in
        for (var _loc2 = 1; _loc2 <= 14; ++_loc2)
        {
            if (_loc5[_loc2])
            {
                this["_ctr" + _loc2].contentData = undefined;
            } // end if
        } // end of for
        this.addToQueue({object: this, method: setSpellStateOnAllContainers});
    } // End of the function
    function updateItems()
    {
        var _loc6 = new Array();
        for (var _loc3 = 1; _loc3 <= 14; ++_loc3)
        {
            _loc6[_loc3] = true;
        } // end of for
        var _loc7 = _oData.Inventory;
        for (var _loc8 in _loc7)
        {
            var _loc2 = _loc7[_loc8];
            if (!isNaN(_loc2.position))
            {
                if (_loc2.position < 40)
                {
                    continue;
                } // end if
                var _loc4 = _loc2.position - 39;
                var _loc5 = this["_ctr" + _loc4];
                _loc5.contentData = _loc2;
                if (_loc2.Quantity > 1)
                {
                    _loc5.label = String(_loc2.Quantity);
                } // end if
                _loc6[_loc4] = false;
            } // end if
        } // end of for...in
        for (var _loc3 = 1; _loc3 <= 14; ++_loc3)
        {
            if (_loc6[_loc3])
            {
                this["_ctr" + _loc3].contentData = undefined;
            } // end if
        } // end of for
        this.addToQueue({object: this, method: setItemStateOnAllContainers});
    } // End of the function
    function clearSpellStateOnAllContainers()
    {
        var _loc3 = _oData.Spells;
        for (var _loc4 in _loc3)
        {
            if (isNaN(_loc3[_loc4].position))
            {
                continue;
            } // end if
            var _loc2 = this["_ctr" + _loc3[_loc4].position];
            _loc2.__set__showLabel(false);
            this.setMovieClipTransform(_loc2.__get__content(), dofus.graphics.gapi.ui.Banner.NO_TRANSFORM);
        } // end of for...in
        this.setMovieClipTransform(_ctrCC.__get__content(), dofus.graphics.gapi.ui.Banner.NO_TRANSFORM);
    } // End of the function
    function setSpellStateOnAllContainers()
    {
        if (_sCurrentTab != "Spells")
        {
            return;
        } // end if
        var _loc2 = _oData.Spells;
        for (var _loc3 in _loc2)
        {
            if (isNaN(_loc2[_loc3].position))
            {
                continue;
            } // end if
            this.setSpellStateOnContainer(_loc2[_loc3].position);
        } // end of for...in
        this.setSpellStateOnContainer(0);
    } // End of the function
    function setItemStateOnAllContainers()
    {
        if (_sCurrentTab != "Items")
        {
            return;
        } // end if
        var _loc3 = _oData.Inventory;
        for (var _loc4 in _loc3)
        {
            var _loc2 = _loc3[_loc4].position - 39;
            if (isNaN(_loc2) && _loc2 < 1)
            {
                continue;
            } // end if
            this.setItemStateOnContainer(_loc2);
        } // end of for...in
        this.setSpellStateOnContainer(0);
    } // End of the function
    function showRightPanel(sPanelName, oParams)
    {
        if (_mcRightPanel.className == sPanelName)
        {
            return;
        } // end if
        if (_mcRightPanel != undefined)
        {
            this.hideRightPanel();
        } // end if
        oParams._x = _mcRightPanelPlacer._x;
        oParams._y = _mcRightPanelPlacer._y;
        var _loc2 = this.attachMovie(sPanelName, "_mcRightPanel", this.getNextHighestDepth(), oParams);
        _loc2.swapDepths(_mcRightPanelPlacer);
    } // End of the function
    function hideRightPanel()
    {
        if (_mcRightPanel != undefined)
        {
            _mcRightPanel.swapDepths(_mcRightPanelPlacer);
            _mcRightPanel.removeMovieClip();
        } // end if
    } // End of the function
    function updateSmileysEmotes()
    {
        _cChat.updateSmileysEmotes();
    } // End of the function
    function showSmileysEmotesPanel(bShow)
    {
        if (bShow == undefined)
        {
            bShow = true;
        } // end if
        _cChat.hideSmileys(!bShow);
    } // End of the function
    function updateLocalPlayer()
    {
        _mcXtra.contentPath = dofus.Constants.GUILDS_FACES_PATH + _oData.data.gfxID + ".swf";
        _ctrCC._visible = !_oData.isMutant && _sCurrentTab == "Spells";
    } // End of the function
    function setCurrentTab(sNewTab)
    {
        if (sNewTab != _sCurrentTab)
        {
            var _loc2 = this["_btnTab" + _sCurrentTab];
            var _loc3 = this["_btnTab" + sNewTab];
            _loc2.__set__selected(true);
            _loc2.__set__enabled(true);
            _loc3.__set__selected(false);
            _loc3.__set__enabled(false);
            _sCurrentTab = sNewTab;
            this.updateCurrentTabInformations();
        } // end if
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Banner.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        _btnFights._visible = false;
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.showPoints(false);
        this.showNextTurnButton(false);
        this.showGiveUpButton(false);
        _mcRightPanelPlacer._visible = false;
        _mcCircleXtraPlacer._visible = false;
        if (api.kernel.OptionsManager.getOption("TipsOnStart"))
        {
            gapi.loadUIComponent("Tips", "Tips");
        } // end if
    } // End of the function
    function initTexts()
    {
        _btnTabSpells.__set__label(api.lang.getText("BANNER_TAB_SPELLS"));
        _btnTabItems.__set__label(api.lang.getText("BANNER_TAB_ITEMS"));
    } // End of the function
    function addListeners()
    {
        _btnGuild.addEventListener("click", this);
        _btnStatsJob.addEventListener("click", this);
        _btnSpells.addEventListener("click", this);
        _btnInventory.addEventListener("click", this);
        _btnMap.addEventListener("click", this);
        _btnFriends.addEventListener("click", this);
        _btnTabSpells.addEventListener("click", this);
        _btnTabItems.addEventListener("click", this);
        _btnFights.addEventListener("click", this);
        _btnHelp.addEventListener("click", this);
        _btnGuild.addEventListener("over", this);
        _btnStatsJob.addEventListener("over", this);
        _btnSpells.addEventListener("over", this);
        _btnInventory.addEventListener("over", this);
        _btnMap.addEventListener("over", this);
        _btnFriends.addEventListener("over", this);
        _btnTabSpells.addEventListener("over", this);
        _btnTabItems.addEventListener("over", this);
        _btnFights.addEventListener("over", this);
        _btnGuild.addEventListener("out", this);
        _btnStatsJob.addEventListener("out", this);
        _btnSpells.addEventListener("out", this);
        _btnInventory.addEventListener("out", this);
        _btnMap.addEventListener("out", this);
        _btnFriends.addEventListener("out", this);
        _btnTabSpells.addEventListener("out", this);
        _btnTabItems.addEventListener("out", this);
        _btnFights.addEventListener("out", this);
        _btnStatsJob.tabIndex = 0;
        _btnSpells.tabIndex = 1;
        _btnInventory.tabIndex = 2;
        _btnMap.tabIndex = 3;
        _btnFriends.tabIndex = 4;
        _btnGuild.tabIndex = 5;
        _ccChrono.addEventListener("finalCountDown", this);
        _ccChrono.addEventListener("finish", this);
        for (var _loc3 = 1; _loc3 <= 14; ++_loc3)
        {
            var _loc2 = this["_ctr" + _loc3];
            _loc2.addEventListener("click", this);
            _loc2.addEventListener("dblClick", this);
            _loc2.addEventListener("over", this);
            _loc2.addEventListener("out", this);
            _loc2.addEventListener("drag", this);
            _loc2.addEventListener("drop", this);
            _loc2.params = {position: _loc3};
        } // end of for
        _ctrCC.addEventListener("click", this);
        _ctrCC.addEventListener("dblClick", this);
        _ctrCC.addEventListener("over", this);
        _ctrCC.addEventListener("out", this);
        _cChat.addEventListener("filterChanged", this);
        _cChat.addEventListener("selectSmiley", this);
        _cChat.addEventListener("selectEmote", this);
        _cChat.addEventListener("href", this);
        _oData.addEventListener("lpChanged", this);
        _oData.addEventListener("lpmaxChanged", this);
        _btnNextTurn.addEventListener("click", this);
        _btnNextTurn.addEventListener("over", this);
        _btnNextTurn.addEventListener("out", this);
        _btnGiveUp.addEventListener("click", this);
        _btnGiveUp.addEventListener("over", this);
        _btnGiveUp.addEventListener("out", this);
        Key.addListener(this);
        _oData.SpellsManager.addEventListener("spellLaunched", this);
        _oData.SpellsManager.addEventListener("nextTurn", this);
        _pvAP.addEventListener("over", this);
        _pvAP.addEventListener("out", this);
        _pvMP.addEventListener("over", this);
        _pvMP.addEventListener("out", this);
        _oData.Spells.addEventListener("modelChanged", this);
        _oData.Inventory.addEventListener("modelChanged", this);
    } // End of the function
    function initData()
    {
        _ctrCC.__set__contentPath(dofus.Constants.SPELLS_ICONS_PATH + "0.swf");
        this.showCircleXtra("artwork", true, {bMask: true});
        this.updateCurrentTabInformations();
        this.lpmaxChanged({value: _oData.LPmax});
        this.lpChanged({value: _oData.LP});
        api.kernel.ChatManager.refresh();
    } // End of the function
    function setChatFocus()
    {
        Selection.setFocus(_txtConsole);
    } // End of the function
    function isChatFocus()
    {
        return (Selection.getFocus()._name == "_txtConsole");
    } // End of the function
    function placeCursorAtTheEnd()
    {
        Selection.setFocus(_txtConsole);
        Selection.setSelection(_txtConsole.text.length, 1000);
    } // End of the function
    function setChatFocusWithLastKey(sChar)
    {
        if (!_bChatAutoFocus)
        {
            return;
        } // end if
        if (Selection.getFocus() != undefined)
        {
            return;
        } // end if
        if (Key.getCode() == 9)
        {
            return;
        } // end if
        if (Key.getCode() == 27)
        {
            return;
        } // end if
        if (Key.getCode() == 8)
        {
            return;
        } // end if
        if (Key.getCode() == 46)
        {
            return;
        } // end if
        _txtConsole.text = sChar;
        this.setChatFocus();
        this.placeCursorAtTheEnd();
    } // End of the function
    function setSpellStateOnContainer(nIndex)
    {
        var _loc2 = nIndex == 0 ? (_ctrCC) : (this["_ctr" + nIndex]);
        var _loc4 = nIndex == 0 ? (_oData.Spells[0]) : (_loc2.__get__contentData());
        if (_loc4 == undefined)
        {
            return;
        } // end if
        var _loc3;
        if (api.kernel.TutorialManager.isTutorialMode)
        {
            _loc3.can = true;
        }
        else
        {
            _loc3 = _oData.SpellsManager.checkCanLaunchSpellReturnObject(_loc4.ID);
        } // end else if
        if (_loc3.can == false)
        {
            switch (_loc3.type)
            {
                case "NOT_ENOUGH_AP":
                case "CANT_SUMMON_MORE_CREATURE":
                case "CANT_LAUNCH_MORE":
                case "CANT_RELAUNCH":
                case "NOT_IN_FIGHT":
                {
                    _loc2.__set__showLabel(false);
                    this.setMovieClipTransform(_loc2.__get__content(), dofus.graphics.gapi.ui.Banner.INACTIVE_TRANSFORM);
                    break;
                } 
                case "CANT_LAUNCH_BEFORE":
                {
                    this.setMovieClipTransform(_loc2.__get__content(), dofus.graphics.gapi.ui.Banner.INACTIVE_TRANSFORM);
                    _loc2.__set__showLabel(true);
                    _loc2.__set__label(_loc3.params[0]);
                    break;
                } 
            } // End of switch
        }
        else
        {
            _loc2.__set__showLabel(false);
            this.setMovieClipTransform(_loc2.__get__content(), dofus.graphics.gapi.ui.Banner.NO_TRANSFORM);
        } // end else if
    } // End of the function
    function setItemStateOnContainer(nIndex)
    {
        var _loc2 = this["_ctr" + nIndex];
        var _loc3 = _loc2.__get__contentData();
        if (_loc3 == undefined)
        {
            return;
        } // end if
        _loc2.__set__showLabel(_loc3.Quantity > 1);
        if (api.datacenter.Game.isRunning)
        {
            this.setMovieClipTransform(_loc2.__get__content(), dofus.graphics.gapi.ui.Banner.INACTIVE_TRANSFORM);
        }
        else
        {
            this.setMovieClipTransform(_loc2.__get__content(), dofus.graphics.gapi.ui.Banner.NO_TRANSFORM);
        } // end else if
    } // End of the function
    function updateCurrentTabInformations()
    {
        switch (_sCurrentTab)
        {
            case "Spells":
            {
                this.updateSpells();
                _ctrCC._visible = !_oData.isMutant;
                _btnFights._visible = false;
                break;
            } 
            case "Items":
            {
                this.updateItems();
                _ctrCC._visible = false;
                _btnFights._visible = _nFightsCount != 0 && !api.datacenter.Game.isFight;
                break;
            } 
        } // End of switch
    } // End of the function
    function onKeyUp()
    {
        switch (Key.getCode())
        {
            case 191:
            {
                if (!Key.isDown(16))
                {
                    break;
                } // end if
            } 
            case 111:
            {
                this.setChatFocusWithLastKey("/");
                break;
            } 
            case 13:
            {
                if (this.isChatFocus())
                {
                    if (_txtConsole.text.length != 0)
                    {
                        if (Key.isDown(16))
                        {
                            api.kernel.Console.process("/t " + _txtConsole.text);
                        }
                        else if (Key.isDown(17))
                        {
                            api.kernel.Console.process("/g " + _txtConsole.text);
                        }
                        else
                        {
                            api.kernel.Console.process(_txtConsole.text);
                        } // end else if
                        _txtConsole.text = "";
                    } // end if
                }
                else if (Selection.getFocus() == undefined && _bChatAutoFocus)
                {
                    this.setChatFocus();
                } // end else if
                break;
            } 
            case 33:
            {
                if (this.isChatFocus())
                {
                    _txtConsole.text = api.kernel.Console.getWhisperHistoryUp();
                    this.placeCursorAtTheEnd();
                } // end if
                break;
            } 
            case 34:
            {
                if (this.isChatFocus())
                {
                    _txtConsole.text = api.kernel.Console.getWhisperHistoryDown();
                    this.placeCursorAtTheEnd();
                } // end if
                break;
            } 
            case 38:
            {
                if (this.isChatFocus())
                {
                    if (Key.isDown(16))
                    {
                        _txtConsole.text = api.kernel.Console.getWhisperHistoryUp();
                    }
                    else
                    {
                        _txtConsole.text = api.kernel.Console.getHistoryUp();
                    } // end else if
                    this.placeCursorAtTheEnd();
                } // end if
                break;
            } 
            case 40:
            {
                if (this.isChatFocus())
                {
                    if (Key.isDown(16))
                    {
                        _txtConsole.text = api.kernel.Console.getWhisperHistoryDown();
                    }
                    else
                    {
                        _txtConsole.text = api.kernel.Console.getHistoryDown();
                    } // end else if
                    this.placeCursorAtTheEnd();
                } // end if
                break;
            } 
            case 39:
            {
                if (this.isChatFocus())
                {
                    if (Key.isDown(17))
                    {
                        var _loc3 = new Array();
                        var _loc2 = api.datacenter.Sprites.getItems();
                        for (var _loc5 in _loc2)
                        {
                            if (_loc2[_loc5] instanceof dofus.datacenter.Character)
                            {
                                _loc3.push(_loc2[_loc5].name);
                            } // end if
                        } // end of for...in
                        false;
                        var _loc4 = api.kernel.Console.autoCompletion(_loc3, _txtConsole.text);
                        if (!_loc4.isFull)
                        {
                            if (_loc4.list == undefined || _loc4.list.length == 0)
                            {
                                api.sounds.onError();
                            }
                            else
                            {
                                api.ui.showTooltip(_loc4.list.sort().join(", "), 0, 520);
                            } // end if
                        } // end else if
                        _txtConsole.text = _loc4.result + (_loc4.isFull ? (" ") : (""));
                        this.placeCursorAtTheEnd();
                    } // end if
                } // end if
                break;
            } 
            case 35:
            {
                if (Key.isDown(17))
                {
                    if (api.datacenter.Game.isFight)
                    {
                        api.network.Game.turnEnd();
                    } // end if
                } // end if
                break;
            } 
            case 107:
            {
                if (Selection.getFocus() == null)
                {
                    _cChat.open(false);
                } // end if
                break;
            } 
            case 109:
            {
                if (Selection.getFocus() == null)
                {
                    _cChat.open(true);
                } // end if
                break;
            } 
            case 226:
            {
                if (Selection.getFocus() == null)
                {
                    this.setCurrentTab(_sCurrentTab == "Spells" ? ("Items") : ("Spells"));
                } // end if
                break;
            } 
            case 222:
            case 48:
            {
                if (Selection.getFocus() == null)
                {
                    this.click({target: _ctrCC});
                } // end if
                break;
            } 
            case 49:
            {
                if (Selection.getFocus() == null && !Key.isDown(16))
                {
                    this.click({target: _ctr1, keyBoard: true});
                } // end if
                break;
            } 
            case 50:
            {
                if (Selection.getFocus() == null && !Key.isDown(16))
                {
                    this.click({target: _ctr2, keyBoard: true});
                } // end if
                break;
            } 
            case 51:
            {
                if (Selection.getFocus() == null && !Key.isDown(16))
                {
                    this.click({target: _ctr3, keyBoard: true});
                } // end if
                break;
            } 
            case 52:
            {
                if (Selection.getFocus() == null && !Key.isDown(16))
                {
                    this.click({target: _ctr4, keyBoard: true});
                } // end if
                break;
            } 
            case 53:
            {
                if (Selection.getFocus() == null && !Key.isDown(16))
                {
                    this.click({target: _ctr5, keyBoard: true});
                } // end if
                break;
            } 
            case 54:
            {
                if (Selection.getFocus() == null)
                {
                    this.click({target: _ctr6, keyBoard: true});
                } // end if
                break;
            } 
            case 55:
            {
                if (Selection.getFocus() == null)
                {
                    this.click({target: _ctr7, keyBoard: true});
                } // end if
                break;
            } 
            case 73:
            {
                if (Selection.getFocus() == null && api.kernel.OptionsManager.getOption("BannerShortcuts"))
                {
                    this.click({target: _btnInventory});
                }
                else
                {
                    this.setChatFocusWithLastKey(String.fromCharCode(Key.getAscii()));
                } // end else if
                break;
            } 
            case 83:
            {
                if (Selection.getFocus() == null && api.kernel.OptionsManager.getOption("BannerShortcuts"))
                {
                    this.click({target: _btnSpells});
                }
                else
                {
                    this.setChatFocusWithLastKey(String.fromCharCode(Key.getAscii()));
                } // end else if
                break;
            } 
            case 77:
            {
                if (Selection.getFocus() == null && api.kernel.OptionsManager.getOption("BannerShortcuts"))
                {
                    this.click({target: _btnMap});
                }
                else
                {
                    this.setChatFocusWithLastKey(String.fromCharCode(Key.getAscii()));
                } // end else if
                break;
            } 
            case 70:
            {
                if (Selection.getFocus() == null && !Key.isDown(17) && api.kernel.OptionsManager.getOption("BannerShortcuts"))
                {
                    this.click({target: _btnFriends});
                }
                else
                {
                    this.setChatFocusWithLastKey(String.fromCharCode(Key.getAscii()));
                } // end else if
                break;
            } 
            case 65:
            case 67:
            {
                if (Selection.getFocus() == null && api.kernel.OptionsManager.getOption("BannerShortcuts"))
                {
                    this.click({target: _btnStatsJob});
                }
                else
                {
                    this.setChatFocusWithLastKey(String.fromCharCode(Key.getAscii()));
                } // end else if
                break;
            } 
            case 71:
            {
                if (Selection.getFocus() == null && api.kernel.OptionsManager.getOption("BannerShortcuts"))
                {
                    this.click({target: _btnGuild});
                }
                else
                {
                    this.setChatFocusWithLastKey(String.fromCharCode(Key.getAscii()));
                } // end else if
                break;
            } 
            default:
            {
                this.setChatFocusWithLastKey(String.fromCharCode(Key.getAscii()));
                break;
            } 
        } // End of switch
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnGuild":
            {
                if (_oData.isMutant)
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CANT_U_ARE_MUTANT"), "ERROR_CHAT");
                    return;
                } // end if
                if (_oData.guildInfos != undefined)
                {
                    this.showSmileysEmotesPanel(false);
                    gapi.loadUIAutoHideComponent("Guild", "Guild", {currentTab: "Members"});
                }
                else
                {
                    api.kernel.showMessage(undefined, api.lang.getText("UI_ONLY_FOR_GUILD"), "ERROR_CHAT");
                } // end else if
                break;
            } 
            case "_btnStatsJob":
            {
                if (_oData.isMutant)
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CANT_U_ARE_MUTANT"), "ERROR_CHAT");
                    return;
                } // end if
                this.showSmileysEmotesPanel(false);
                gapi.loadUIAutoHideComponent("StatsJob", "StatsJob");
                break;
            } 
            case "_btnSpells":
            {
                if (_oData.isMutant)
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CANT_U_ARE_MUTANT"), "ERROR_CHAT");
                    return;
                } // end if
                this.showSmileysEmotesPanel(false);
                gapi.loadUIAutoHideComponent("Spells", "Spells");
                break;
            } 
            case "_btnInventory":
            {
                this.showSmileysEmotesPanel(false);
                gapi.loadUIAutoHideComponent("Inventory", "Inventory");
                break;
            } 
            case "_btnMap":
            {
                this.showSmileysEmotesPanel(false);
                gapi.loadUIAutoHideComponent("MapExplorer", "MapExplorer");
                break;
            } 
            case "_btnFriends":
            {
                this.showSmileysEmotesPanel(false);
                gapi.loadUIAutoHideComponent("Friends", "Friends");
                break;
            } 
            case "_btnTabSpells":
            {
                this.setCurrentTab("Spells");
                break;
            } 
            case "_btnTabItems":
            {
                this.setCurrentTab("Items");
                break;
            } 
            case "_btnFights":
            {
                if (!api.datacenter.Game.isFight)
                {
                    gapi.loadUIComponent("FightsInfos", "FightsInfos");
                } // end if
                break;
            } 
            case "_btnHelp":
            {
                api.kernel.Console.process("/help");
                _cChat.open(false);
                break;
            } 
            case "_btnNextTurn":
            {
                if (api.datacenter.Game.isFight)
                {
                    api.network.Game.turnEnd();
                } // end if
                break;
            } 
            case "_btnGiveUp":
            {
                if (api.datacenter.Game.isFight)
                {
                    if (api.datacenter.Game.isSpectator)
                    {
                        api.network.Game.leave();
                    }
                    else
                    {
                        api.kernel.GameManager.giveUpGame();
                    } // end if
                } // end else if
                break;
            } 
            case "_ctrCC":
            {
                if (_ctrCC._visible)
                {
                    if (api.kernel.TutorialManager.isTutorialMode)
                    {
                        api.kernel.TutorialManager.onWaitingCase({code: "CC_CONTAINER_SELECT"});
                        break;
                    } // end if
                    api.kernel.GameManager.switchToSpellLaunch(_oData.Spells[0], false);
                } // end if
                break;
            } 
            case "_mcXtra":
            {
                var _loc5 = api.ui.createPopupMenu();
                _loc5.addItem(api.lang.getText("BANNER_ARTWORK"), this, showCircleXtra, ["artwork", true, {bMask: true}], _sCurrentCircleXtra != "artwork");
                _loc5.addItem(api.lang.getText("BANNER_CLOCK"), this, showCircleXtra, ["clock", true, {bMask: true}], _sCurrentCircleXtra != "clock");
                _loc5.addItem(api.lang.getText("BANNER_COMPASS"), this, showCircleXtra, ["compass", true], _sCurrentCircleXtra != "compass");
                _loc5.show(_root._xmouse, _root._ymouse, true);
                break;
            } 
            default:
            {
                switch (_sCurrentTab)
                {
                    case "Spells":
                    {
                        if (api.kernel.TutorialManager.isTutorialMode)
                        {
                            api.kernel.TutorialManager.onWaitingCase({code: "SPELL_CONTAINER_SELECT", params: [Number(oEvent.target._name.substr(4))]});
                            break;
                        } // end if
                        if (gapi.getUIComponent("Spells") != undefined)
                        {
                            return;
                        } // end if
                        var _loc6 = oEvent.target.contentData;
                        if (_loc6 == undefined)
                        {
                            return;
                        } // end if
                        api.kernel.GameManager.switchToSpellLaunch(_loc6, true);
                        break;
                    } 
                    case "Items":
                    {
                        if (api.kernel.TutorialManager.isTutorialMode)
                        {
                            api.kernel.TutorialManager.onWaitingCase({code: "OBJECT_CONTAINER_SELECT", params: [Number(oEvent.target._name.substr(4))]});
                            break;
                        } // end if
                        var _loc7 = gapi.getUIComponent("Inventory");
                        if (_loc7 != undefined)
                        {
                            _loc7.showItemInfos(oEvent.target.contentData);
                        }
                        else
                        {
                            var _loc4 = oEvent.target.contentData;
                            if (_loc4 == undefined)
                            {
                                return;
                            } // end if
                            if (api.datacenter.Player.canUseObject)
                            {
                                if (_loc4.canTarget)
                                {
                                    api.kernel.GameManager.switchToItemTarget(_loc4);
                                }
                                else if (_loc4.canUse && oEvent.keyBoard)
                                {
                                    api.network.Items.use(_loc4.ID);
                                } // end if
                            } // end else if
                        } // end else if
                        break;
                    } 
                } // End of switch
                break;
            } 
        } // End of switch
    } // End of the function
    function dblClick(oEvent)
    {
        switch (_sCurrentTab)
        {
            case "Spells":
            {
                var _loc2;
                switch (oEvent.target._name)
                {
                    case "_ctrCC":
                    {
                        _loc2 = _oData.Spells[0];
                        break;
                    } 
                    default:
                    {
                        _loc2 = oEvent.target.contentData;
                        break;
                    } 
                } // End of switch
                if (_loc2 == undefined)
                {
                    return;
                } // end if
                this.showSmileysEmotesPanel(false);
                gapi.loadUIAutoHideComponent("SpellInfos", "SpellInfos", {spell: _loc2}, {bStayIfPresent: true});
                break;
            } 
            case "Items":
            {
                var _loc3 = oEvent.target.contentData;
                if (_loc3 != undefined)
                {
                    if (!_loc3.canUse || !api.datacenter.Player.canUseObject)
                    {
                        return;
                    } // end if
                    api.network.Items.use(_loc3.ID);
                } // end if
                break;
            } 
        } // End of switch
    } // End of the function
    function finalCountDown(oEvent)
    {
        _mcXtra._visible = false;
        _lblFinalCountDown.__set__text(oEvent.value);
    } // End of the function
    function finish(oEvent)
    {
        _mcXtra._visible = true;
        _lblFinalCountDown.__set__text("");
    } // End of the function
    function complete(oEvent)
    {
        api.colors.addSprite(_mcXtra.content, _oData.data);
    } // End of the function
    function over(oEvent)
    {
        if (!gapi.isCursorHidden())
        {
            return;
        } // end if
        switch (oEvent.target._name)
        {
            case "_ctrCC":
            {
                var _loc7 = _oData.Spells[0];
                gapi.showTooltip(_loc7.name + "\n" + _loc7.descriptionVisibleEffects + " (" + _loc7.apCost + " " + api.lang.getText("AP") + ")", oEvent.target, -30, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnGiveUp":
            {
                var _loc4;
                if (api.datacenter.Game.isSpectator)
                {
                    _loc4 = api.lang.getText("GIVE_UP_SPECTATOR");
                }
                else
                {
                    _loc4 = api.lang.getText("GIVE_UP");
                } // end else if
                gapi.showTooltip(_loc4, oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnGuild":
            {
                gapi.showTooltip(api.lang.getText("YOUR_GUILD"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnStatsJob":
            {
                gapi.showTooltip(api.lang.getText("YOUR_STATS_JOB"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnSpells":
            {
                gapi.showTooltip(api.lang.getText("YOUR_SPELLS"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnInventory":
            {
                gapi.showTooltip(api.lang.getText("YOUR_INVENTORY"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnMap":
            {
                gapi.showTooltip(api.lang.getText("YOUR_BOOK"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnFriends":
            {
                gapi.showTooltip(api.lang.getText("YOUR_FRIENDS"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnFights":
            {
                if (_nFightsCount != 0)
                {
                    gapi.showTooltip(ank.utils.PatternDecoder.combine(api.lang.getText("FIGHTS_ON_MAP", [_nFightsCount]), "m", _nFightsCount < 2), oEvent.target, -20, {bYLimit: false});
                } // end if
                break;
            } 
            case "_btnNextTurn":
            {
                gapi.showTooltip(api.lang.getText("NEXT_TURN"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_pvAP":
            {
                gapi.showTooltip(api.lang.getText("ACTIONPOINTS"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_pvMP":
            {
                gapi.showTooltip(api.lang.getText("MOVEPOINTS"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_mcXtra":
            {
                switch (_sCurrentCircleXtra)
                {
                    case "compass":
                    {
                        var _loc5 = oEvent.target.targetCoords;
                        if (_loc5 == undefined)
                        {
                            gapi.showTooltip(api.lang.getText("BANNER_SET_FLAG"), oEvent.target, 0, {bXLimit: true, bYLimit: false});
                        }
                        else
                        {
                            gapi.showTooltip(_loc5[0] + ", " + _loc5[1], oEvent.target, 0, {bXLimit: true, bYLimit: false});
                        } // end else if
                        break;
                    } 
                    case "clock":
                    {
                        gapi.showTooltip(api.kernel.NightManager.time + "\n" + api.kernel.NightManager.getCurrentDateString(), oEvent.target, 0, {bXLimit: true, bYLimit: false});
                        break;
                    } 
                } // End of switch
                break;
            } 
            default:
            {
                switch (_sCurrentTab)
                {
                    case "Spells":
                    {
                        var _loc6 = oEvent.target.contentData;
                        if (_loc6 != undefined)
                        {
                            gapi.showTooltip(_loc6.name + " (" + _loc6.apCost + " " + api.lang.getText("AP") + ")", oEvent.target, -20, {bXLimit: true, bYLimit: false});
                        } // end if
                        break;
                    } 
                    case "Items":
                    {
                        var _loc3 = oEvent.target.contentData;
                        if (_loc3 != undefined)
                        {
                            _loc4 = _loc3.name;
                            if (gapi.getUIComponent("Inventory") == undefined)
                            {
                                if (_loc3.canUse && _loc3.canTarget)
                                {
                                    _loc4 = _loc4 + ("\n" + api.lang.getText("HELP_SHORTCUT_DBLCLICK_CLICK"));
                                }
                                else
                                {
                                    if (_loc3.canUse)
                                    {
                                        _loc4 = _loc4 + ("\n" + api.lang.getText("HELP_SHORTCUT_DBLCLICK"));
                                    } // end if
                                    if (_loc3.canTarget)
                                    {
                                        _loc4 = _loc4 + ("\n" + api.lang.getText("HELP_SHORTCUT_CLICK"));
                                    } // end if
                                } // end if
                            } // end else if
                            gapi.showTooltip(_loc4, oEvent.target, -30, {bXLimit: true, bYLimit: false});
                        } // end if
                        break;
                    } 
                } // End of switch
                break;
            } 
        } // End of switch
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    function drag(oEvent)
    {
        var _loc2 = oEvent.target.contentData;
        if (_loc2 == undefined)
        {
            return;
        } // end if
        switch (_sCurrentTab)
        {
            case "Spells":
            {
                if (gapi.getUIComponent("Spells") == undefined)
                {
                    return;
                } // end if
                break;
            } 
            case "Items":
            {
                if (gapi.getUIComponent("Inventory") == undefined)
                {
                    return;
                } // end if
                break;
            } 
        } // End of switch
        gapi.removeCursor();
        gapi.setCursor(_loc2);
    } // End of the function
    function drop(oEvent)
    {
        switch (_sCurrentTab)
        {
            case "Spells":
            {
                if (gapi.getUIComponent("Spells") == undefined)
                {
                    return;
                } // end if
                var _loc3 = gapi.getCursor();
                if (_loc3 == undefined)
                {
                    return;
                } // end if
                gapi.removeCursor();
                var _loc4 = _loc3.position;
                var _loc5 = oEvent.target.params.position;
                if (_loc4 == _loc5)
                {
                    return;
                } // end if
                if (_loc4 != undefined)
                {
                    this["_ctr" + _loc4].contentData = undefined;
                    _oData.SpellsUsed.removeItemAt(_loc4);
                } // end if
                var _loc6 = this["_ctr" + _loc5].contentData;
                if (_loc6 != undefined)
                {
                    _loc6.position = undefined;
                } // end if
                _loc3.position = _loc5;
                oEvent.target.contentData = _loc3;
                _oData.SpellsUsed.addItemAt(_loc5, _loc3);
                api.network.Spells.moveToUsed(_loc3.ID, _loc5);
                this.addToQueue({object: this, method: setSpellStateOnAllContainers});
                break;
            } 
            case "Items":
            {
                if (gapi.getUIComponent("Inventory") == undefined)
                {
                    return;
                } // end if
                var _loc2 = gapi.getCursor();
                if (_loc2 == undefined)
                {
                    return;
                } // end if
                if (!_loc2.canMoveToShortut)
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CANT_MOVE_ITEM_HERE"), "ERROR_BOX");
                    return;
                } // end if
                gapi.removeCursor();
                _loc5 = oEvent.target.params.position + 39;
                if (_loc2.position == _loc5)
                {
                    return;
                } // end if
                if (_loc2.Quantity > 1)
                {
                    var _loc8 = gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: _loc2.Quantity, useAllStage: true, params: {type: "drop", item: _loc2, position: _loc5}}, {bAlwaysOnTop: true});
                    _loc8.addEventListener("validate", this);
                }
                else
                {
                    api.network.Items.movement(_loc2.ID, _loc5, 1);
                } // end else if
                break;
            } 
        } // End of switch
    } // End of the function
    function filterChanged(oEvent)
    {
        api.kernel.ChatManager.setTypes(_cChat.__get__filters());
    } // End of the function
    function lpChanged(oEvent)
    {
        _hHeart.__set__value(oEvent.value);
    } // End of the function
    function lpmaxChanged(oEvent)
    {
        _hHeart.__set__max(oEvent.value);
    } // End of the function
    function apChanged(oEvent)
    {
        _pvAP.__set__value(oEvent.value);
        if (api.datacenter.Game.isFight)
        {
            this.setSpellStateOnAllContainers();
        } // end if
    } // End of the function
    function mpChanged(oEvent)
    {
        _pvMP.__set__value(Math.max(0, oEvent.value));
    } // End of the function
    function selectSmiley(oEvent)
    {
        api.network.Chat.useSmiley(oEvent.index);
    } // End of the function
    function selectEmote(oEvent)
    {
        api.network.Emotes.useEmote(oEvent.index);
    } // End of the function
    function spellLaunched(oEvent)
    {
        this.setSpellStateOnContainer(oEvent.spell.position);
    } // End of the function
    function nextTurn(oEvent)
    {
        this.setSpellStateOnAllContainers();
    } // End of the function
    function href(oEvent)
    {
        switch (oEvent.params)
        {
            case "OpenGuildTaxCollectors":
            {
                this.addToQueue({object: this.__get__gapi(), method: gapi.loadUIAutoHideComponent, params: ["Guild", "Guild", {currentTab: "TaxCollectors"}, {bStayIfPresent: true}]});
                break;
            } 
        } // End of switch
    } // End of the function
    function modelChanged(oEvent)
    {
        switch (oEvent.eventName)
        {
            case "updateOne":
            case "updateAll":
        } // End of switch
        if (oEvent.target == _oData.Spells)
        {
            if (_sCurrentTab == "Spells")
            {
                this.updateSpells();
            } // end if
        }
        else if (_sCurrentTab == "Items")
        {
            this.updateItems();
        } // end else if
        
    } // End of the function
    function validate(oEvent)
    {
        switch (oEvent.params.type)
        {
            case "drop":
            {
                gapi.removeCursor();
                if (oEvent.value > 0 && !isNaN(Number(oEvent.value)))
                {
                    api.network.Items.movement(oEvent.params.item.ID, oEvent.params.position, Math.min(oEvent.value, oEvent.params.item.Quantity));
                } // end if
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "Banner";
    static var NO_TRANSFORM = {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0};
    static var INACTIVE_TRANSFORM = {ra: 50, rb: 0, ga: 50, gb: 0, ba: 50, bb: 0};
    var _sCurrentTab = "Items";
    var _nFightsCount = 0;
    var _bChatAutoFocus = true;
} // End of Class
#endinitclip
