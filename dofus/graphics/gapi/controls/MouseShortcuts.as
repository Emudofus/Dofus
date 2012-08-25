// Action script...

// [Initial MovieClip Action of sprite 20957]
#initclip 222
if (!dofus.graphics.gapi.controls.MouseShortcuts)
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
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.MouseShortcuts = function ()
    {
        super();
    }).prototype;
    _loc1.__get__currentTab = function ()
    {
        return (this._sCurrentTab);
    };
    _loc1.__set__meleeVisible = function (b)
    {
        this._ctrCC._visible = b;
        //return (this.meleeVisible());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.MouseShortcuts.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.getContainer = function (nID)
    {
        return (this["_ctr" + nID]);
    };
    _loc1.setContainer = function (nID, cContainer)
    {
        this["_ctr" + nID] = cContainer;
    };
    _loc1.initData = function ()
    {
        this._ctrCC.contentPath = dofus.Constants.SPELLS_ICONS_PATH + "0.swf";
    };
    _loc1.initTexts = function ()
    {
        this._btnTabSpells.label = this.api.lang.getText("BANNER_TAB_SPELLS");
        this._btnTabItems.label = this.api.lang.getText("BANNER_TAB_ITEMS");
    };
    _loc1.addListeners = function ()
    {
        this._btnTabSpells.addEventListener("click", this);
        this._btnTabItems.addEventListener("click", this);
        this._btnTabSpells.addEventListener("over", this);
        this._btnTabItems.addEventListener("over", this);
        this._btnTabSpells.addEventListener("out", this);
        this._btnTabItems.addEventListener("out", this);
        var _loc2 = 1;
        
        while (++_loc2, _loc2 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
        {
            var _loc3 = this["_ctr" + _loc2];
            _loc3.addEventListener("click", this);
            _loc3.addEventListener("dblClick", this);
            _loc3.addEventListener("over", this);
            _loc3.addEventListener("out", this);
            _loc3.addEventListener("drag", this);
            _loc3.addEventListener("drop", this);
            _loc3.params = {position: _loc2};
        } // end while
        this._ctrCC.addEventListener("click", this);
        this._ctrCC.addEventListener("over", this);
        this._ctrCC.addEventListener("out", this);
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
        this.api.datacenter.Player.Spells.addEventListener("modelChanged", this);
        this.api.datacenter.Player.Inventory.addEventListener("modelChanged", this);
    };
    _loc1.clearSpellStateOnAllContainers = function ()
    {
        var _loc2 = this.api.datacenter.Player.Spells;
        for (var k in _loc2)
        {
            if (_global.isNaN(_loc2[k].position))
            {
                continue;
            } // end if
            var _loc3 = this["_ctr" + _loc2[k].position];
            _loc3.showLabel = false;
            this.setMovieClipTransform(_loc3.content, dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
        } // end of for...in
        this.setMovieClipTransform(this._ctrCC.content, dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
    };
    _loc1.setSpellStateOnAllContainers = function ()
    {
        if (this._sCurrentTab != "Spells")
        {
            return;
        } // end if
        var _loc2 = this.api.datacenter.Player.Spells;
        for (var k in _loc2)
        {
            if (_global.isNaN(_loc2[k].position))
            {
                continue;
            } // end if
            this.setSpellStateOnContainer(_loc2[k].position);
        } // end of for...in
        this.setSpellStateOnContainer(0);
    };
    _loc1.setItemStateOnAllContainers = function ()
    {
        if (this._sCurrentTab != "Items")
        {
            return;
        } // end if
        var _loc2 = this.api.datacenter.Player.Inventory;
        for (var k in _loc2)
        {
            var _loc3 = _loc2[k].position - dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET;
            if (_global.isNaN(_loc3) && _loc3 < 1)
            {
                continue;
            } // end if
            this.setItemStateOnContainer(_loc3);
        } // end of for...in
        this.setSpellStateOnContainer(0);
    };
    _loc1.updateSpells = function ()
    {
        var _loc2 = new Array();
        var _loc3 = 1;
        
        while (++_loc3, _loc3 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
        {
            _loc2[_loc3] = true;
        } // end while
        var _loc4 = this.api.datacenter.Player.Spells;
        for (var k in _loc4)
        {
            var _loc5 = _loc4[k];
            var _loc6 = _loc5.position;
            if (!_global.isNaN(_loc6))
            {
                this["_ctr" + _loc6].contentData = _loc5;
                _loc2[_loc6] = false;
            } // end if
        } // end of for...in
        var _loc7 = 1;
        
        while (++_loc7, _loc7 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
        {
            if (_loc2[_loc7])
            {
                this["_ctr" + _loc7].contentData = undefined;
            } // end if
        } // end while
        this.addToQueue({object: this, method: this.setSpellStateOnAllContainers});
    };
    _loc1.updateItems = function ()
    {
        var _loc2 = new Array();
        var _loc3 = 1;
        
        while (++_loc3, _loc3 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
        {
            _loc2[_loc3] = true;
        } // end while
        var _loc4 = this.api.datacenter.Player.Inventory;
        for (var k in _loc4)
        {
            var _loc5 = _loc4[k];
            if (!_global.isNaN(_loc5.position))
            {
                if (_loc5.position < dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET + 1)
                {
                    continue;
                } // end if
                var _loc6 = _loc5.position - dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET;
                var _loc7 = this["_ctr" + _loc6];
                _loc7.contentData = _loc5;
                if (_loc5.Quantity > 1)
                {
                    _loc7.label = String(_loc5.Quantity);
                } // end if
                _loc2[_loc6] = false;
            } // end if
        } // end of for...in
        var _loc8 = 1;
        
        while (++_loc8, _loc8 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
        {
            if (_loc2[_loc8])
            {
                this["_ctr" + _loc8].contentData = undefined;
            } // end if
        } // end while
        this.addToQueue({object: this, method: this.setItemStateOnAllContainers});
    };
    _loc1.setSpellStateOnContainer = function (nIndex)
    {
        var _loc3 = nIndex == 0 ? (this._ctrCC) : (this["_ctr" + nIndex]);
        var _loc4 = nIndex == 0 ? (this.api.datacenter.Player.Spells[0]) : (_loc3.contentData);
        if (_loc4 == undefined)
        {
            return;
        } // end if
        if (this.api.kernel.TutorialManager.isTutorialMode)
        {
            .can = true;
        }
        else
        {
            var _loc5 = this.api.datacenter.Player.SpellsManager.checkCanLaunchSpellReturnObject(_loc4.ID);
        } // end else if
        if (_loc5.can == false)
        {
            switch (_loc5.type)
            {
                case "NOT_IN_REQUIRED_STATE":
                case "IN_FORBIDDEN_STATE":
                {
                    this.setMovieClipTransform(_loc3.content, dofus.graphics.gapi.controls.MouseShortcuts.WRONG_STATE_TRANSFORM);
                    if (_loc5.params[1])
                    {
                        _loc3.showLabel = true;
                        _loc3.label = _loc5.params[1];
                    }
                    else
                    {
                        _loc3.showLabel = false;
                    } // end else if
                    break;
                } 
                case "NOT_ENOUGH_AP":
                case "CANT_SUMMON_MORE_CREATURE":
                case "CANT_LAUNCH_MORE":
                case "CANT_RELAUNCH":
                case "NOT_IN_FIGHT":
                {
                    _loc3.showLabel = false;
                    this.setMovieClipTransform(_loc3.content, dofus.graphics.gapi.controls.MouseShortcuts.INACTIVE_TRANSFORM);
                    break;
                } 
                case "CANT_LAUNCH_BEFORE":
                {
                    this.setMovieClipTransform(_loc3.content, dofus.graphics.gapi.controls.MouseShortcuts.INACTIVE_TRANSFORM);
                    _loc3.showLabel = true;
                    _loc3.label = _loc5.params[0];
                    break;
                } 
            } // End of switch
        }
        else
        {
            _loc3.showLabel = false;
            this.setMovieClipTransform(_loc3.content, dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
        } // end else if
    };
    _loc1.setItemStateOnContainer = function (nIndex)
    {
        var _loc3 = this["_ctr" + nIndex];
        var _loc4 = _loc3.contentData;
        if (_loc4 == undefined)
        {
            return;
        } // end if
        _loc3.showLabel = _loc4.Quantity > 1;
        if (this.api.datacenter.Game.isRunning)
        {
            this.setMovieClipTransform(_loc3.content, dofus.graphics.gapi.controls.MouseShortcuts.INACTIVE_TRANSFORM);
        }
        else
        {
            this.setMovieClipTransform(_loc3.content, dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
        } // end else if
    };
    _loc1.updateCurrentTabInformations = function ()
    {
        switch (this._sCurrentTab)
        {
            case "Spells":
            {
                this.updateSpells();
                this._ctrCC._visible = !this.api.datacenter.Player.isMutant;
                break;
            } 
            case "Items":
            {
                this.updateItems();
                this._ctrCC._visible = false;
                this.api.ui.getUIComponent("Banner").updateEye();
                break;
            } 
        } // End of switch
    };
    _loc1.setCurrentTab = function (sNewTab)
    {
        if (sNewTab != this._sCurrentTab)
        {
            var _loc3 = this["_btnTab" + this._sCurrentTab];
            var _loc4 = this["_btnTab" + sNewTab];
            _loc3.selected = true;
            _loc3.enabled = true;
            _loc4.selected = false;
            _loc4.enabled = false;
            this._sCurrentTab = sNewTab;
            this.updateCurrentTabInformations();
        } // end if
    };
    _loc1.onShortcut = function (sShortcut)
    {
        var _loc3 = true;
        switch (sShortcut)
        {
            case "SWAP":
            {
                this.setCurrentTab(this._sCurrentTab == "Spells" ? ("Items") : ("Spells"));
                _loc3 = false;
                break;
            } 
            case "SH0":
            {
                this.click({target: this._ctrCC});
                _loc3 = false;
                break;
            } 
            case "SH1":
            {
                this.click({target: this._ctr1, keyBoard: true});
                _loc3 = false;
                break;
            } 
            case "SH2":
            {
                this.click({target: this._ctr2, keyBoard: true});
                _loc3 = false;
                break;
            } 
            case "SH3":
            {
                this.click({target: this._ctr3, keyBoard: true});
                _loc3 = false;
                break;
            } 
            case "SH4":
            {
                this.click({target: this._ctr4, keyBoard: true});
                _loc3 = false;
                break;
            } 
            case "SH5":
            {
                this.click({target: this._ctr5, keyBoard: true});
                _loc3 = false;
                break;
            } 
            case "SH6":
            {
                this.click({target: this._ctr6, keyBoard: true});
                _loc3 = false;
                break;
            } 
            case "SH7":
            {
                this.click({target: this._ctr7, keyBoard: true});
                _loc3 = false;
                break;
            } 
            case "SH8":
            {
                this.click({target: this._ctr8, keyBoard: true});
                _loc3 = false;
                break;
            } 
            case "SH9":
            {
                this.click({target: this._ctr9, keyBoard: true});
                _loc3 = false;
                break;
            } 
            case "SH10":
            {
                this.click({target: this._ctr10, keyBoard: true});
                _loc3 = false;
                break;
            } 
            case "SH11":
            {
                this.click({target: this._ctr11, keyBoard: true});
                _loc3 = false;
                break;
            } 
            case "SH12":
            {
                this.click({target: this._ctr12, keyBoard: true});
                _loc3 = false;
                break;
            } 
            case "SH13":
            {
                this.click({target: this._ctr13, keyBoard: true});
                _loc3 = false;
                break;
            } 
            case "SH14":
            {
                this.click({target: this._ctr14, keyBoard: true});
                _loc3 = false;
                break;
            } 
        } // End of switch
        return (_loc3);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnTabSpells":
            {
                this.api.sounds.events.onBannerSpellItemButtonClick();
                this.setCurrentTab("Spells");
                break;
            } 
            case "_btnTabItems":
            {
                this.api.sounds.events.onBannerSpellItemButtonClick();
                this.setCurrentTab("Items");
                break;
            } 
            case "_ctrCC":
            {
                if (this._ctrCC._visible)
                {
                    if (this.api.kernel.TutorialManager.isTutorialMode)
                    {
                        this.api.kernel.TutorialManager.onWaitingCase({code: "CC_CONTAINER_SELECT"});
                        break;
                    } // end if
                    this.api.kernel.GameManager.switchToSpellLaunch(this.api.datacenter.Player.Spells[0], false);
                } // end if
                break;
            } 
            default:
            {
                switch (this._sCurrentTab)
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
                        var _loc3 = oEvent.target.contentData;
                        if (_loc3 == undefined)
                        {
                            return;
                        } // end if
                        this.api.kernel.GameManager.switchToSpellLaunch(_loc3, true);
                        break;
                    } 
                    case "Items":
                    {
                        if (this.api.kernel.TutorialManager.isTutorialMode)
                        {
                            this.api.kernel.TutorialManager.onWaitingCase({code: "OBJECT_CONTAINER_SELECT", params: [Number(oEvent.target._name.substr(4))]});
                            break;
                        } // end if
                        if (Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && oEvent.target.contentData != undefined)
                        {
                            this.api.kernel.GameManager.insertItemInChat(oEvent.target.contentData);
                            return;
                        } // end if
                        var _loc4 = this.gapi.getUIComponent("Inventory");
                        if (_loc4 != undefined)
                        {
                            _loc4.showItemInfos(oEvent.target.contentData);
                        }
                        else
                        {
                            var _loc5 = oEvent.target.contentData;
                            if (_loc5 == undefined)
                            {
                                return;
                            } // end if
                            if (this.api.datacenter.Player.canUseObject)
                            {
                                if (_loc5.canTarget)
                                {
                                    this.api.kernel.GameManager.switchToItemTarget(_loc5);
                                }
                                else if (_loc5.canUse && oEvent.keyBoard)
                                {
                                    this.api.network.Items.use(_loc5.ID);
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
        switch (this._sCurrentTab)
        {
            case "Spells":
            {
                switch (oEvent.target._name)
                {
                    case "_ctrCC":
                    {
                        var _loc3 = this.api.datacenter.Player.Spells[0];
                        break;
                    } 
                    default:
                    {
                        _loc3 = oEvent.target.contentData;
                        break;
                    } 
                } // End of switch
                if (_loc3 == undefined)
                {
                    return;
                } // end if
                this.gapi.loadUIAutoHideComponent("SpellInfos", "SpellInfos", {spell: _loc3}, {bStayIfPresent: true});
                break;
            } 
            case "Items":
            {
                var _loc4 = oEvent.target.contentData;
                if (_loc4 != undefined)
                {
                    if (!_loc4.canUse || !this.api.datacenter.Player.canUseObject)
                    {
                        return;
                    } // end if
                    this.api.network.Items.use(_loc4.ID);
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        if (!this.gapi.isCursorHidden())
        {
            return;
        } // end if
        switch (oEvent.target._name)
        {
            case "_ctrCC":
            {
                var _loc3 = this.api.datacenter.Player.Spells[0];
                var _loc4 = this.api.kernel.GameManager.getCriticalHitChance(this.api.datacenter.Player.weaponItem.criticalHit);
                this.gapi.showTooltip(_loc3.name + "\n" + _loc3.descriptionVisibleEffects + " (" + _loc3.apCost + " " + this.api.lang.getText("AP") + (!_global.isNaN(_loc4) ? (", " + this.api.lang.getText("ACTUAL_CRITICAL_CHANCE") + ": 1/" + _loc4) : ("")) + ")", oEvent.target, -30, {bXLimit: true, bYLimit: false});
                break;
            } 
            default:
            {
                switch (this._sCurrentTab)
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
        switch (this._sCurrentTab)
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
        
        switch (this._sCurrentTab)
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
                    this["_ctr" + _loc4].contentData = undefined;
                } // end if
                var _loc6 = this["_ctr" + _loc5].contentData;
                if (_loc6 != undefined)
                {
                    _loc6.position = undefined;
                } // end if
                _loc3.position = _loc5;
                oEvent.target.contentData = _loc3;
                this.api.network.Spells.moveToUsed(_loc3.ID, _loc5);
                this.addToQueue({object: this, method: this.setSpellStateOnAllContainers});
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
        
        oEvent.target;
    };
    _loc1.modelChanged = function (oEvent)
    {
        switch (oEvent.eventName)
        {
            case "updateOne":
            case "updateAll":
        } // End of switch
        if (oEvent.target == this.api.datacenter.Player.Spells)
        {
            if (this._sCurrentTab == "Spells")
            {
                this.updateSpells();
            } // end if
        }
        else if (this._sCurrentTab == "Items")
        {
            this.updateItems();
        } // end else if
        
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
    _loc1.addProperty("meleeVisible", function ()
    {
    }, _loc1.__set__meleeVisible);
    _loc1.addProperty("currentTab", _loc1.__get__currentTab, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.MouseShortcuts = function ()
    {
        super();
    }).TAB_SPELLS = "Spells";
    (_global.dofus.graphics.gapi.controls.MouseShortcuts = function ()
    {
        super();
    }).TAB_ITEMS = "Items";
    (_global.dofus.graphics.gapi.controls.MouseShortcuts = function ()
    {
        super();
    }).CLASS_NAME = "MouseShortcuts";
    (_global.dofus.graphics.gapi.controls.MouseShortcuts = function ()
    {
        super();
    }).MAX_CONTAINER = 24;
    (_global.dofus.graphics.gapi.controls.MouseShortcuts = function ()
    {
        super();
    }).ITEM_OFFSET = 34;
    (_global.dofus.graphics.gapi.controls.MouseShortcuts = function ()
    {
        super();
    }).NO_TRANSFORM = {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0};
    (_global.dofus.graphics.gapi.controls.MouseShortcuts = function ()
    {
        super();
    }).INACTIVE_TRANSFORM = {ra: 50, rb: 0, ga: 50, gb: 0, ba: 50, bb: 0};
    (_global.dofus.graphics.gapi.controls.MouseShortcuts = function ()
    {
        super();
    }).WRONG_STATE_TRANSFORM = {ra: 50, rb: 0, ga: 50, gb: 0, ba: 70, bb: 0};
    _loc1._sCurrentTab = "Items";
} // end if
#endinitclip
