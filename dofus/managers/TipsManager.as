// Action script...

// [Initial MovieClip Action of sprite 20647]
#initclip 168
if (!dofus.managers.TipsManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.TipsManager = function (oAPI)
    {
        super();
        dofus.managers.TipsManager._sSelf = this;
        this.initialize(oAPI);
    }).prototype;
    (_global.dofus.managers.TipsManager = function (oAPI)
    {
        super();
        dofus.managers.TipsManager._sSelf = this;
        this.initialize(oAPI);
    }).getInstance = function ()
    {
        return (dofus.managers.TipsManager._sSelf);
    };
    _loc1.initialize = function (oAPI)
    {
        this.api = oAPI;
        this._aTipsList = new Array();
        this.addToQueue({object: this, method: this.loadTipsStates});
    };
    _loc1.showNewTip = function (nTip)
    {
        if (!this.getIsDisplayingFreshTips())
        {
            this.setHasBeenDisplayed(nTip);
        }
        else if (!this.getHasBeenDisplayed(nTip))
        {
            var _loc3 = dofus.graphics.gapi.controls.Helper.getCurrentHelper();
            if (_loc3 == null)
            {
                return;
            } // end if
            _loc3.onNewTip();
            this.addTipToList(nTip);
            this.setHasBeenDisplayed(nTip);
        } // end else if
    };
    _loc1.displayNextTips = function ()
    {
        if (!this.hasNewTips())
        {
            return;
        } // end if
        var _loc2 = this.getTipToDisplay();
        this.showFloatingTips(_loc2);
        var _loc3 = dofus.graphics.gapi.controls.Helper.getCurrentHelper();
        if (_loc3 == null)
        {
            return;
        } // end if
        _loc3.onRemoveTip();
    };
    _loc1.hasNewTips = function ()
    {
        return (this._aTipsList.length > 0);
    };
    _loc1.resetDisplayedTipsList = function ()
    {
        this._aTipsStates = new Array();
        this.saveTipsStates();
    };
    _loc1.pointGUI = function (sComponentInstance, aElement)
    {
        var _loc4 = this.api.ui.getUIComponent(sComponentInstance);
        var _loc5 = aElement[0];
        var _loc6 = _loc4[_loc5];
        var _loc7 = 1;
        
        while (++_loc7, _loc7 < aElement.length)
        {
            _loc5 = String(aElement[_loc7]);
            if (_loc6[_loc5] != undefined)
            {
                _loc6 = _loc6[_loc5];
                continue;
            } // end if
            break;
        } // end while
        if (_loc6 == undefined)
        {
            return;
        } // end if
        var _loc8 = _loc6.getBounds();
        var _loc9 = _loc8.xMax - _loc8.xMin;
        var _loc10 = _loc8.yMax - _loc8.yMin;
        var _loc11 = _loc9 / 2 + _loc6._x + _loc8.xMin;
        var _loc12 = _loc10 / 2 + _loc6._y + _loc8.yMin;
        var _loc13 = {x: _loc11, y: _loc12};
        _loc6._parent.localToGlobal(_loc13);
        _loc11 = _loc13.x;
        _loc12 = _loc13.y;
        var _loc14 = Math.sqrt(Math.pow(_loc9, 2) + Math.pow(_loc10, 2)) / 2;
        this.api.ui.loadUIComponent("Indicator", "Indicator" + this._nIndicatorIndex, {coordinates: [_loc11, _loc12], offset: _loc14}, {bAlwaysOnTop: true});
        this._aIndicatorTimers[this._nIndicatorIndex] = _global.setInterval(this, "onIndicatorHide", dofus.managers.TipsManager.INDICATOR_SHOWUP_TIME * 1000, this._nIndicatorIndex++);
    };
    _loc1.pointCell = function (nMapID, nCellID, nOffset)
    {
        if (this.api.datacenter.Basics.aks_current_map_id == nMapID || nMapID == -1)
        {
            var _loc5 = this.api.gfx.mapHandler.getCellData(nCellID).mc;
            if (_loc5 == undefined)
            {
                return;
            } // end if
            var _loc6 = {x: _loc5._x, y: _loc5._y};
            _loc5._parent.localToGlobal(_loc6);
            var _loc7 = _loc6.x;
            var _loc8 = _loc6.y;
            this.api.ui.loadUIComponent("Indicator", "Indicator" + this._nIndicatorIndex, {coordinates: [_loc7, _loc8], offset: nOffset, rotate: false}, {bAlwaysOnTop: true});
            this._aIndicatorTimers[this._nIndicatorIndex] = _global.setInterval(this, "onIndicatorHide", dofus.managers.TipsManager.INDICATOR_SHOWUP_TIME * 1000, this._nIndicatorIndex++);
        }
        else
        {
            return;
        } // end else if
    };
    _loc1.pointSprite = function (nMapID, nGfxID)
    {
        if (this.api.datacenter.Basics.aks_current_map_id == nMapID || nMapID == -1)
        {
            var _loc4 = this.api.gfx.spriteHandler.getSprites().getItems();
            for (var k in _loc4)
            {
                if (_loc4[k].gfxFile == dofus.Constants.CLIPS_PERSOS_PATH + nGfxID + ".swf")
                {
                    var _loc5 = {x: _loc4[k].mc._x, y: _loc4[k].mc._y};
                    _loc4[k].localToGlobal(_loc5);
                    var _loc6 = _loc5.x;
                    var _loc7 = _loc5.y;
                    var _loc8 = _loc4[k].mc._height;
                    this.api.ui.loadUIComponent("Indicator", "Indicator" + this._nIndicatorIndex, {coordinates: [_loc6, _loc7], offset: _loc8, rotate: false}, {bAlwaysOnTop: true});
                    this._aIndicatorTimers[this._nIndicatorIndex] = _global.setInterval(this, "onIndicatorHide", dofus.managers.TipsManager.INDICATOR_SHOWUP_TIME * 1000, this._nIndicatorIndex++);
                } // end if
            } // end of for...in
        }
        else
        {
            return;
        } // end else if
    };
    _loc1.pointPicto = function (nMapID, nPictoID)
    {
        if (this.api.datacenter.Basics.aks_current_map_id == nMapID || nMapID == -1)
        {
            var _loc4 = this.api.gfx.mapHandler.getCellsData();
            for (var k in _loc4)
            {
                if (_loc4[k].layerObject1Num != undefined && (!_global.isNaN(_loc4[k].layerObject1Num) && _loc4[k].layerObject1Num > 0))
                {
                    if (_loc4[k].layerObject1Num == nPictoID)
                    {
                        this.pointCell(nMapID, _loc4[k].num, _loc4[k].mcObject1._height);
                    } // end if
                } // end if
                if (_loc4[k].layerObject2Num != undefined && (!_global.isNaN(_loc4[k].layerObject2Num) && _loc4[k].layerObject2Num > 0))
                {
                    if (_loc4[k].layerObject2Num == nPictoID)
                    {
                        this.pointCell(nMapID, _loc4[k].num, _loc4[k].mcObject2._height);
                    } // end if
                } // end if
            } // end of for...in
        }
        else
        {
            return;
        } // end else if
    };
    _loc1.getTipToDisplay = function ()
    {
        var _loc2 = Number(this._aTipsList.pop());
        return (_loc2);
    };
    _loc1.showFloatingTips = function (nTip)
    {
        var _loc3 = this.api.kernel.OptionsManager.getOption("FloatingTipsCoord");
        var _loc4 = this.api.ui.loadUIComponent("FloatingTips", "FloatingTips", {tip: nTip, position: _loc3}, {bStayIfPresent: true, bAlwaysOnTop: true});
    };
    _loc1.addTipToList = function (nTip)
    {
        this._aTipsList.push(nTip);
        this.saveTipsList();
    };
    _loc1.getHasBeenDisplayed = function (nTip)
    {
        return (this._aTipsStates[nTip] == true);
    };
    _loc1.setHasBeenDisplayed = function (nTip, bDisplayed)
    {
        if (bDisplayed == undefined)
        {
            bDisplayed = true;
        } // end if
        if (this._aTipsStates[nTip] != bDisplayed)
        {
            this._aTipsStates[nTip] = bDisplayed;
            this.saveTipsStates();
        } // end if
    };
    _loc1.getIsDisplayingFreshTips = function ()
    {
        if (this.api.config.isExpo)
        {
            return (true);
        } // end if
        return (this.api.kernel.OptionsManager.getOption("DisplayingFreshTips"));
    };
    _loc1.setIsDisplayingFreshTips = function (bDisplaying)
    {
        this.api.kernel.OptionsManager.setOption("DisplayingFreshTips", bDisplaying);
    };
    _loc1.getTipsSharedObject = function ()
    {
        if (this._soTips == undefined)
        {
            this._soTips = SharedObject.getLocal(dofus.Constants.GLOBAL_SO_TIPS_NAME);
        } // end if
        return (this._soTips);
    };
    _loc1.loadTipsStates = function ()
    {
        if (this.api.config.isExpo)
        {
            this._aTipsStates = new Array();
        }
        else
        {
            this._aTipsStates = this.getTipsSharedObject().data.TIPSSTATES;
            if (this._aTipsStates == undefined)
            {
                this._aTipsStates = new Array();
            } // end if
        } // end else if
    };
    _loc1.saveTipsStates = function ()
    {
        if (!this.api.config.isExpo)
        {
            this.getTipsSharedObject().data.TIPSSTATES = this._aTipsStates;
        } // end if
    };
    _loc1.saveTipsList = function ()
    {
        this.getTipsSharedObject().data.TIPSLIST = this._aTipsList;
    };
    _loc1.getInterfaceTriggers = function ()
    {
        if (this._aInterfaceTriggers != undefined)
        {
            return (this._aInterfaceTriggers);
        }
        else
        {
            var _loc2 = this.api.lang.getKnownledgeBaseTriggers();
            if (_loc2 == undefined)
            {
                return (new Array());
            } // end if
            this._aInterfaceTriggers = new Array();
            var _loc3 = 0;
            
            while (++_loc3, _loc3 < _loc2.length)
            {
                if (_loc2[_loc3].t == dofus.managers.TipsManager.TRIGGER_TYPE_GUI)
                {
                    this._aInterfaceTriggers["GUI" + _loc2[_loc3].v] = _loc2[_loc3].d;
                } // end if
            } // end while
            return (this._aInterfaceTriggers);
        } // end else if
    };
    _loc1.getMapsTriggers = function ()
    {
        if (this._aMapsTriggers != undefined)
        {
            return (this._aMapsTriggers);
        }
        else
        {
            var _loc2 = this.api.lang.getKnownledgeBaseTriggers();
            if (_loc2 == undefined)
            {
                return (new Array());
            } // end if
            this._aMapsTriggers = new Array();
            var _loc3 = 0;
            
            while (++_loc3, _loc3 < _loc2.length)
            {
                if (_loc2[_loc3].t == dofus.managers.TipsManager.TRIGGER_TYPE_MAP)
                {
                    var _loc4 = _loc2[_loc3].v;
                    var _loc5 = 0;
                    
                    while (++_loc5, _loc5 < _loc4.length)
                    {
                        if (this._aMapsTriggers["MAP" + _loc4[_loc5]] != undefined)
                        {
                            this._aMapsTriggers["MAP" + _loc4[_loc5]] = this._aMapsTriggers["MAP" + _loc4[_loc5]] + "|" + _loc2[_loc3].d;
                            continue;
                        } // end if
                        this._aMapsTriggers["MAP" + _loc4[_loc5]] = _loc2[_loc3].d;
                    } // end while
                } // end if
            } // end while
            return (this._aMapsTriggers);
        } // end else if
    };
    _loc1.onIndicatorHide = function (nIndicatorIndex)
    {
        _global.clearInterval(this._aIndicatorTimers[nIndicatorIndex]);
        this.api.ui.unloadUIComponent("Indicator" + nIndicatorIndex);
    };
    _loc1.onNewMap = function (nMapID)
    {
        var _loc3 = String(this.getMapsTriggers()["MAP" + nMapID]);
        if (_loc3 != undefined && _loc3.length > 0)
        {
            var _loc4 = _loc3.split("|");
            var _loc5 = 0;
            
            while (++_loc5, _loc5 < _loc4.length)
            {
                if (_loc4[_loc5] != undefined && !_global.isNaN(_loc4[_loc5]))
                {
                    this.showNewTip(Number(_loc4[_loc5]));
                } // end if
            } // end while
        } // end if
    };
    _loc1.onNewInterface = function (sLinkID)
    {
        var _loc3 = this.getInterfaceTriggers()["GUI" + sLinkID];
        if (_loc3 != undefined && !_global.isNaN(_loc3))
        {
            this.showNewTip(_loc3);
        } // end if
    };
    _loc1.onLink = function (oEvent)
    {
        var _loc3 = oEvent.params.split(",");
        switch (_loc3[0])
        {
            case "CellIndicator":
            {
                var _loc4 = Number(_loc3[1]);
                var _loc5 = Number(_loc3[2]);
                var _loc6 = Number(_loc3[3]);
                this.addToQueue({object: this, method: this.pointCell, params: [_loc4, _loc5, _loc6]});
                break;
            } 
            case "UiIndicator":
            {
                var _loc7 = _loc3[1];
                var _loc8 = new Array();
                var _loc9 = 2;
                
                while (++_loc9, _loc9 < _loc3.length)
                {
                    _loc8.push(_loc3[_loc9]);
                } // end while
                this.addToQueue({object: this, method: this.pointGUI, params: [_loc7, _loc8]});
                break;
            } 
            case "SpriteIndicator":
            {
                var _loc10 = Number(_loc3[1]);
                var _loc11 = Number(_loc3[2]);
                this.addToQueue({object: this, method: this.pointSprite, params: [_loc10, _loc11]});
                break;
            } 
            case "PictoIndicator":
            {
                var _loc12 = Number(_loc3[1]);
                var _loc13 = Number(_loc3[2]);
                this.addToQueue({object: this, method: this.pointPicto, params: [_loc12, _loc13]});
                break;
            } 
            case "PointCompass":
            {
                var _loc14 = Number(_loc3[1]);
                var _loc15 = Number(_loc3[2]);
                this.addToQueue({object: this.api.kernel.GameManager, method: this.api.kernel.GameManager.updateCompass, params: [_loc14, _loc15, true]});
                break;
            } 
            case "KnownledgeBase":
            {
                var _loc16 = Number(_loc3[1]);
                this.addToQueue({object: this.api.ui, method: this.api.ui.loadUIComponent, params: ["KnownledgeBase", "KnownledgeBase", {article: _loc16}]});
                break;
            } 
        } // End of switch
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.TipsManager = function (oAPI)
    {
        super();
        dofus.managers.TipsManager._sSelf = this;
        this.initialize(oAPI);
    }).TIP_START_POPUP = 3;
    (_global.dofus.managers.TipsManager = function (oAPI)
    {
        super();
        dofus.managers.TipsManager._sSelf = this;
        this.initialize(oAPI);
    }).TIP_GAIN_LEVEL = 19;
    (_global.dofus.managers.TipsManager = function (oAPI)
    {
        super();
        dofus.managers.TipsManager._sSelf = this;
        this.initialize(oAPI);
    }).TIP_FIGHT_PLACEMENT = 5;
    (_global.dofus.managers.TipsManager = function (oAPI)
    {
        super();
        dofus.managers.TipsManager._sSelf = this;
        this.initialize(oAPI);
    }).TIP_FIGHT_START = 7;
    (_global.dofus.managers.TipsManager = function (oAPI)
    {
        super();
        dofus.managers.TipsManager._sSelf = this;
        this.initialize(oAPI);
    }).TIP_FIGHT_ENDMOVE = 8;
    (_global.dofus.managers.TipsManager = function (oAPI)
    {
        super();
        dofus.managers.TipsManager._sSelf = this;
        this.initialize(oAPI);
    }).TIP_FIGHT_ENDATTACK = 10;
    (_global.dofus.managers.TipsManager = function (oAPI)
    {
        super();
        dofus.managers.TipsManager._sSelf = this;
        this.initialize(oAPI);
    }).TIP_FIGHT_ENDFIGHT = 12;
    (_global.dofus.managers.TipsManager = function (oAPI)
    {
        super();
        dofus.managers.TipsManager._sSelf = this;
        this.initialize(oAPI);
    }).TIP_QUEST_WALKTHOUGH = 31;
    (_global.dofus.managers.TipsManager = function (oAPI)
    {
        super();
        dofus.managers.TipsManager._sSelf = this;
        this.initialize(oAPI);
    }).TIP_FINAL_COUNTDOWN = 34;
    (_global.dofus.managers.TipsManager = function (oAPI)
    {
        super();
        dofus.managers.TipsManager._sSelf = this;
        this.initialize(oAPI);
    }).INDICATOR_SHOWUP_TIME = 5;
    (_global.dofus.managers.TipsManager = function (oAPI)
    {
        super();
        dofus.managers.TipsManager._sSelf = this;
        this.initialize(oAPI);
    }).TRIGGER_TYPE_MAP = 1;
    (_global.dofus.managers.TipsManager = function (oAPI)
    {
        super();
        dofus.managers.TipsManager._sSelf = this;
        this.initialize(oAPI);
    }).TRIGGER_TYPE_GUI = 2;
    (_global.dofus.managers.TipsManager = function (oAPI)
    {
        super();
        dofus.managers.TipsManager._sSelf = this;
        this.initialize(oAPI);
    })._sSelf = null;
    _loc1._aIndicatorTimers = new Array();
    _loc1._nIndicatorIndex = 0;
} // end if
#endinitclip
