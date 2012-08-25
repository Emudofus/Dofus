// Action script...

// [Initial MovieClip Action of sprite 20863]
#initclip 128
if (!dofus.graphics.gapi.controls.MiniMap)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.MiniMap = function ()
    {
        super();
    }).prototype;
    _loc1.updateFlags = function ()
    {
        this.updateDataMap();
        if (this._oMap.x == undefined || this._oMap.y == undefined)
        {
            this.addToQueue({object: this, method: this.updateFlags});
            return;
        } // end if
        this.clearFlag();
        if (this.api.datacenter.Basics.banner_targetCoords)
        {
            this.addFlag(this.api.datacenter.Basics.banner_targetCoords[0], this.api.datacenter.Basics.banner_targetCoords[1], 255);
        } // end if
        if (this.api.datacenter.Basics.aks_infos_highlightCoords.length)
        {
            var _loc2 = this.api.datacenter.Basics.aks_infos_highlightCoords;
            for (var i in _loc2)
            {
                if (!_loc2[i])
                {
                    continue;
                } // end if
                if (_loc2[i].miniMapTagId == undefined)
                {
                    _loc2[i].miniMapTagId = this._nRandomTag;
                } // end if
                if (_loc2[i].miniMapTagId != this._nRandomTag)
                {
                    delete _loc2[i];
                    continue;
                } // end if
                switch (_loc2[i].type)
                {
                    case 1:
                    {
                        if (!)
                        {
                            var _loc3 = _loc2[i];
                        }
                        else
                        {
                            var _loc4 = Math.sqrt(Math.pow(_loc3.x - this._oMap.x, 2) + Math.pow(_loc3.y - this._oMap.y, 2));
                            var _loc5 = Math.sqrt(Math.pow(_loc2[i].x - this._oMap.x, 2) + Math.pow(_loc2[i].y - this._oMap.y, 2));
                            if (_loc5 < _loc4)
                            {
                                _loc3 = _loc2[i];
                            } // end if
                        } // end else if
                        break;
                    } 
                    case 2:
                    {
                        var _loc6 = _global.API.ui.getUIComponent("Party").getMemberById(_loc2[i].playerID).name;
                        if (_loc6 == undefined)
                        {
                            delete _loc2[i];
                            continue;
                        } // end if
                        this.addFlag(_loc2[i].x, _loc2[i].y, dofus.Constants.FLAG_MAP_GROUP, _loc6);
                        break;
                    } 
                    case 3:
                    {
                        this.addFlag(_loc2[i].x, _loc2[i].y, dofus.Constants.FLAG_MAP_SEEK, _loc2[i].playerName);
                        break;
                    } 
                } // End of switch
            } // end of for...in
            if (_loc3)
            {
                this.addFlag(_loc3.x, _loc3.y, dofus.Constants.FLAG_MAP_PHOENIX, this.api.lang.getText("BANNER_MAP_PHOENIX"));
            } // end if
        } // end if
    };
    _loc1.clearFlag = function ()
    {
        for (var i in this._mcFlagsDirection)
        {
            this._mcFlagsDirection[i].removeMovieClip();
        } // end of for...in
        for (var i in this._mcFlagsContainer)
        {
            this._mcFlagsContainer[i].removeMovieClip();
        } // end of for...in
        this._aFlags = new Array();
    };
    _loc1.addFlag = function (nX, nY, nColor, sLabel)
    {
        if (_global.isNaN(nX) || _global.isNaN(nY))
        {
            return;
        } // end if
        var _loc6 = this._mcFlagsDirection.getNextHighestDepth();
        var _loc7 = this._mcFlagsDirection.attachMovie("FlagDirection", "dir" + _loc6, _loc6);
        _loc7.stop();
        var _loc8 = (nColor & 16711680) >> 16;
        var _loc9 = (nColor & 65280) >> 8;
        var _loc10 = nColor & 255;
        var _loc11 = new Color(_loc7._mcCursor._mc._mcColor);
        var _loc12 = new Object();
        _loc12 = {ra: 0, ga: 0, ba: 0, rb: _loc8, gb: _loc9, bb: _loc10};
        _loc11.setTransform(_loc12);
        if (!this._mcFlagsContainer)
        {
            this._mcFlagsContainer = this._mcFlags.createEmptyMovieClip("_mcFlagsContainer", 1);
        } // end if
        var _loc13 = this._nMapScale / 100 * this._nTileWidth;
        var _loc14 = this._nMapScale / 100 * this._nTileHeight;
        _loc6 = this._mcFlagsContainer.getNextHighestDepth();
        var _loc15 = this._mcFlagsContainer.attachMovie("UI_MapExplorerFlag", "flag" + _loc6, _loc6);
        _loc15._x = _loc13 * nX + _loc13 / 2;
        _loc15._y = _loc14 * nY + _loc14 / 2;
        _loc15._xscale = this._nMapScale;
        _loc15._yscale = this._nMapScale;
        _loc11 = new Color(_loc15._mcColor);
        _loc12 = new Object();
        _loc12 = {ra: 0, ga: 0, ba: 0, rb: _loc8, gb: _loc9, bb: _loc10};
        _loc11.setTransform(_loc12);
        this._aFlags.push({x: nX, y: nY, color: nColor, mcDirection: _loc7});
        _loc7.tooltipText = nX + "," + nY + (sLabel.length ? (" (" + sLabel + ")") : (""));
        _loc15.tooltipText = _loc7.tooltipText;
        _loc15.gapi = this.gapi;
        _loc7.gapi = this.gapi;
        _loc7.mcTarget = _loc7._mcCursor;
        _loc15.mcTarget = _loc15;
        _loc7.onRollOver = _loc15.onRollOver = function ()
        {
            this.gapi.showTooltip(this.tooltipText, this, -20, {bXLimit: false, bYLimit: false});
        };
        _loc7.onRollOut = _loc15.onRollOut = function ()
        {
            this.gapi.hideTooltip();
        };
        this.updateMap();
    };
    _loc1.updateHints = function ()
    {
        if (_global.isNaN(this.dungeonID))
        {
            var _loc2 = this.api.lang.getHintsCategories();
            _loc2[-1] = {n: this.api.lang.getText("OPTION_GRID"), c: "Yellow"};
            var _loc3 = this.api.kernel.OptionsManager.getOption("MapFilters");
            this._mcHintsContainer = this._ldrHints.content;
            var _loc4 = -1;
            
            while (++_loc4, _loc4 < _loc2.length)
            {
                if (_loc4 != -1)
                {
                    this.showHintsCategory(_loc4, _loc3[_loc4] == 1);
                } // end if
            } // end while
        } // end if
    };
    _loc1.__get__dungeonID = function ()
    {
        return (Number(this.api.lang.getMapText(this.api.datacenter.Map.id).d));
    };
    _loc1.__get__dungeonCurrentMap = function ()
    {
        return (this.dungeon.m[this.api.datacenter.Map.id]);
    };
    _loc1.__get__dungeon = function ()
    {
        return (this.api.lang.getDungeonText(this.dungeonID));
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.MiniMap.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.loadMap});
        this.addToQueue({object: this, method: this.updateFlags});
        this._nRandomTag = Math.random();
    };
    _loc1.addListeners = function ()
    {
        this.api.gfx.addEventListener("mapLoaded", this);
        this._ldrBitmapMap.addEventListener("initialization", this);
    };
    _loc1.initMap = function ()
    {
        this._mcBitmapContainer.removeMovieClip();
        this._mcBitmapContainer = this._ldrBitmapMap.content.createEmptyMovieClip("_mcBitmapContainer", 1);
        this._mcBitmapContainer._visible = false;
        if (this.api.datacenter.Player.isAuthorized)
        {
            this._mcBitmapContainer.onMouseUp = this.onMouseUp;
            this._mcBitmapContainer.onRelease = function ()
            {
            };
        }
        else
        {
            this._mcBitmapContainer.onRelease = this.click;
        } // end else if
        this._mcCursor._xscale = this._nMapScale;
        this._mcCursor._yscale = this._nMapScale;
        this._mcCursor.oMap = this._oMap;
        this._mcCursor.gapi = this.gapi;
        this._mcCursor.onRollOver = function ()
        {
            this.gapi.showTooltip(this.oMap.x + "," + this.oMap.y, this, -20, {bXLimit: false, bYLimit: false});
        };
        this._mcCursor.onRollOut = function ()
        {
            this.gapi.hideTooltip();
        };
        this.updateMap();
        this.updateHints();
    };
    _loc1.drawMap = function ()
    {
        var _loc2 = -10;
        
        while (++_loc2, _loc2 < 10)
        {
            var _loc3 = -10;
            
            while (++_loc3, _loc3 < 10)
            {
                var _loc4 = Math.floor(this._oMap.x / dofus.graphics.gapi.controls.MiniMap.MAP_IMG_WIDTH);
                var _loc5 = Math.floor(this._oMap.y / dofus.graphics.gapi.controls.MiniMap.MAP_IMG_HEIGHT);
                if (_loc4 < _loc2 - 2 || (_loc4 > _loc2 + 2 || (_loc5 < _loc3 - 2 || _loc5 > _loc3 + 2)))
                {
                    if (this._mcBitmapContainer[_loc2 + "_" + _loc3] != undefined)
                    {
                        this._mcBitmapContainer[_loc2 + "_" + _loc3].removeMovieClip();
                    } // end if
                    continue;
                } // end if
                if (this._mcBitmapContainer[_loc2 + "_" + _loc3] != undefined)
                {
                    continue;
                } // end if
                var _loc6 = this._mcBitmapContainer.attachMovie(_loc2 + "_" + _loc3, _loc2 + "_" + _loc3, this._mcBitmapContainer.getNextHighestDepth());
                _loc6._xscale = this._nMapScale;
                _loc6._yscale = this._nMapScale;
                _loc6._x = _loc6._width * _loc2;
                _loc6._y = _loc6._height * _loc3;
            } // end while
        } // end while
    };
    _loc1.initDungeon = function ()
    {
        this._mcBitmapContainer.removeMovieClip();
        this._mcBitmapContainer = this._ldrBitmapMap.createEmptyMovieClip("_mcDongeonContainer", 1);
        this._mcBg.onRelease = this.click;
        this._mcCursor._xscale = this._nMapScale;
        this._mcCursor._yscale = this._nMapScale;
        var _loc2 = this.dungeon.m;
        var _loc3 = this.dungeonCurrentMap;
        var _loc4 = 0;
        for (var a in _loc2)
        {
            var _loc5 = _loc2[a];
            if (_loc3.z == _loc5.z)
            {
                var _loc6 = this._mcBitmapContainer.attachMovie("UI_MapExplorerRectangle", "dungeonMap" + _loc4, _loc4++);
                _loc6._xscale = this._nMapScale;
                _loc6._yscale = this._nMapScale;
                _loc6._x = _loc6._width * _loc5.x + _loc6._width / 2 + 1;
                _loc6._y = _loc6._height * _loc5.y + _loc6._height / 2 + 1;
                if (_loc5.n != undefined)
                {
                    _loc6.label = _loc5.n + " (" + _loc5.x + "," + _loc5.y + ")";
                    _loc6.gapi = this.gapi;
                    _loc6.onRollOver = function ()
                    {
                        this.gapi.showTooltip(this.label, this, -20, {bXLimit: false, bYLimit: false});
                    };
                    _loc6.onRollOut = function ()
                    {
                        this.gapi.hideTooltip();
                    };
                } // end if
            } // end if
        } // end of for...in
    };
    _loc1.loadMap = function (bForceReload)
    {
        if (this._oMap.superarea == undefined)
        {
            this.addToQueue({object: this, method: this.loadMap, params: [bForceReload]});
            return (false);
        } // end if
        if (_global.isNaN(this.dungeonID))
        {
            if (this._oMap.superarea !== this._nCurrentArea || bForceReload)
            {
                this._nCurrentArea = this._oMap.superarea;
                this._ldrBitmapMap.contentPath = dofus.Constants.LOCAL_MAPS_PATH + this._nCurrentArea + ".swf";
                return (true);
            } // end if
            return (false);
        }
        else
        {
            this.initDungeon();
            this._nCurrentArea = -1;
        } // end else if
    };
    _loc1.showHintsCategory = function (categoryID, bShow)
    {
        var _loc4 = this.api.kernel.OptionsManager.getOption("MapFilters");
        _loc4[categoryID] = bShow;
        this.api.kernel.OptionsManager.setOption("MapFilters", _loc4);
        var _loc5 = "hints" + categoryID;
        if (!this._mcHintsContainer[_loc5])
        {
            this._mcHintsContainer.createEmptyMovieClip(_loc5, categoryID);
        } // end if
        if (bShow)
        {
            var _loc6 = this.api.lang.getHintsByCategory(categoryID);
            var _loc7 = this._nMapScale / 100 * this._nTileWidth;
            var _loc8 = this._nMapScale / 100 * this._nTileHeight;
            var _loc9 = 0;
            
            while (++_loc9, _loc9 < _loc6.length)
            {
                var _loc10 = new dofus.datacenter.Hint(_loc6[_loc9]);
                if (_loc10.superAreaID === this._oMap.superarea)
                {
                    var _loc11 = Math.sqrt(Math.pow(_loc10.x - this._oMap.x, 2) + Math.pow(_loc10.y - this._oMap.y, 2));
                    if (_loc11 > 6)
                    {
                        this._mcHintsContainer[_loc5]["hint" + _loc9].removeMovieClip();
                        continue;
                    } // end if
                    if (this._mcHintsContainer[_loc5]["hint" + _loc9] != undefined)
                    {
                        continue;
                    } // end if
                    var _loc12 = this._mcHintsContainer[_loc5].attachMovie(_loc10.gfx, "hint" + _loc9, _loc9, {_xscale: this._nMapScale, _yscale: this._nMapScale});
                    _loc12._x = _loc7 * _loc10.x + _loc7 / 2;
                    _loc12._y = _loc8 * _loc10.y + _loc8 / 2;
                    _loc12.oHint = _loc10;
                    _loc12.gapi = this.gapi;
                    _loc12.onRollOver = function ()
                    {
                        this.gapi.showTooltip(this.oHint.x + "," + this.oHint.y + " (" + this.oHint.name + ")", this, -20, {bXLimit: false, bYLimit: false});
                    };
                    _loc12.onRollOut = function ()
                    {
                        this.gapi.hideTooltip();
                    };
                    continue;
                } // end if
                this._mcHintsContainer[_loc5]["hint" + _loc9].removeMovieClip();
            } // end while
        }
        else
        {
            this._ldrHints.content[_loc5].removeMovieClip();
        } // end else if
    };
    _loc1.getConquestAreaList = function ()
    {
        var _loc2 = this.api.datacenter.Conquest.worldDatas;
        var _loc3 = new Array();
        var _loc4 = new String();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc2.areas.length)
        {
            if (_loc2.areas[_loc5].alignment == 1)
            {
                var _loc7 = this.api.lang.getText("BONTARIAN_PRISM");
                var _loc6 = 420;
            }
            else
            {
                _loc7 = this.api.lang.getText("BRAKMARIAN_PRISM");
                _loc6 = 421;
            } // end else if
            _loc3.push({g: _loc6, m: _loc2.areas[_loc5].prism, n: _loc7, superAreaID: this.api.lang.getMapAreaText(_loc2.areas[_loc5].id).a});
        } // end while
        return (_loc3);
    };
    _loc1.updateDataMap = function ()
    {
        if (_global.isNaN(this.dungeonID))
        {
            this._oMap = this.api.datacenter.Map;
            this._mcHintsContainer._visible = true;
            this._mcFlagsContainer._visible = true;
        }
        else
        {
            this._oMap = this.dungeonCurrentMap;
            this._mcHintsContainer._visible = false;
            this._mcFlagsContainer._visible = false;
        } // end else if
        this._mcCursor.oMap = this._oMap;
    };
    _loc1.updateMap = function ()
    {
        this.updateDataMap();
        this.updateHints();
        var _loc2 = this._nMapScale / 100 * this._nTileWidth;
        var _loc3 = this._nMapScale / 100 * this._nTileHeight;
        this._mcBitmapContainer._x = -_loc2 * this._oMap.x - _loc2 / 2;
        this._mcBitmapContainer._y = -_loc3 * this._oMap.y - _loc3 / 2;
        this._mcHintsContainer._x = this._mcBitmapContainer._x;
        this._mcHintsContainer._y = this._mcBitmapContainer._y;
        this._mcFlagsContainer._x = this._mcBitmapContainer._x;
        this._mcFlagsContainer._y = this._mcBitmapContainer._y;
        this.drawMap();
        for (var i in this._aFlags)
        {
            var _loc4 = this._aFlags[i].x - this._oMap.x;
            var _loc5 = this._aFlags[i].y - this._oMap.y;
            if (_global.isNaN(_loc5) || _global.isNaN(_loc4))
            {
                continue;
            } // end if
            if (dofus.graphics.gapi.controls.MiniMap.HIDE_FLAG_ZONE[_loc5 + 6][_loc4 + 3] == undefined || dofus.graphics.gapi.controls.MiniMap.HIDE_FLAG_ZONE[_loc5 + 6][_loc4 + 3] == 1)
            {
                this._aFlags[i].mcDirection._visible = true;
                var _loc6 = Math.floor(Math.atan2(_loc5, _loc4) / Math.PI * 180);
                if (_loc6 < 0)
                {
                    _loc6 = _loc6 + 360;
                } // end if
                if (_loc6 > 360)
                {
                    _loc6 = _loc6 - 360;
                } // end if
                this._aFlags[i].mcDirection.gotoAndStop(_loc6 + 1);
                this._aFlags[i].mcDirection._mcCursor.gotoAndStop(_loc6 + 1);
                continue;
            } // end if
            this._aFlags[i].mcDirection._visible = false;
        } // end of for...in
        this._mcBitmapContainer._visible = true;
    };
    _loc1.onClickTimer = function (bIsClick)
    {
        ank.utils.Timer.removeTimer(this, "minimap");
        this._bTimerEnable = false;
        if (bIsClick)
        {
            this.click();
        } // end if
    };
    _loc1.getCoordinatesFromReal = function (nRealX, nRealY)
    {
        var _loc4 = this._nMapScale / 100 * this._nTileWidth;
        var _loc5 = this._nMapScale / 100 * this._nTileHeight;
        var _loc6 = Math.floor(nRealX / _loc4);
        var _loc7 = Math.floor(nRealY / _loc5);
        return ({x: _loc6, y: _loc7});
    };
    _loc1.mapLoaded = function (oEvent)
    {
        this.updateDataMap();
        if (!this.loadMap())
        {
            this.updateMap();
        } // end if
    };
    _loc1.initialization = function (oEvent)
    {
        this.initMap();
    };
    _loc1.click = function ()
    {
        var _loc2 = new Object();
        _loc2.target = _global.API.ui.getUIComponent("Banner").illustration;
        _global.API.ui.getUIComponent("Banner").click(_loc2);
    };
    _loc1.doubleClick = function (oEvent)
    {
        if (!this.api.datacenter.Game.isFight && _global.isNaN(this.dungeonID))
        {
            var _loc3 = oEvent.coordinates.x;
            var _loc4 = oEvent.coordinates.y;
            if (_loc3 != undefined && _loc4 != undefined)
            {
                this.api.network.Basics.autorisedMoveCommand(_loc3, _loc4);
            } // end if
        } // end if
    };
    _loc1.onMouseUp = function ()
    {
        if (this._mcBg.hitTest(_root._xmouse, _root._ymouse, true))
        {
            if (this._bTimerEnable != true)
            {
                this._bTimerEnable = true;
                ank.utils.Timer.setTimer(this, "minimap", this, this.onClickTimer, ank.gapi.Gapi.DBLCLICK_DELAY, [true]);
            }
            else
            {
                this.onClickTimer(false);
                var _loc2 = this._mcBitmapContainer._xmouse;
                var _loc3 = this._mcBitmapContainer._ymouse;
                var _loc4 = this.getCoordinatesFromReal(_loc2, _loc3);
                this.doubleClick({coordinates: _loc4});
            } // end if
        } // end else if
    };
    _loc1.addProperty("dungeon", _loc1.__get__dungeon, function ()
    {
    });
    _loc1.addProperty("dungeonCurrentMap", _loc1.__get__dungeonCurrentMap, function ()
    {
    });
    _loc1.addProperty("dungeonID", _loc1.__get__dungeonID, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.MiniMap = function ()
    {
        super();
    }).CLASS_NAME = "MiniMap";
    (_global.dofus.graphics.gapi.controls.MiniMap = function ()
    {
        super();
    }).HIDE_FLAG_ZONE = [[1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1], [1, 0, 0, 1, 0, 0, 1], [1, 0, 0, 0, 0, 0, 1], [0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1], [1, 0, 0, 0, 0, 0, 1], [1, 1, 0, 0, 0, 1, 1]];
    (_global.dofus.graphics.gapi.controls.MiniMap = function ()
    {
        super();
    }).MAP_IMG_WIDTH = 15;
    (_global.dofus.graphics.gapi.controls.MiniMap = function ()
    {
        super();
    }).MAP_IMG_HEIGHT = 15;
    _loc1._aFlags = new Array();
    _loc1._nMapScale = 40;
    _loc1._nTileWidth = 40;
    _loc1._nTileHeight = 23;
} // end if
#endinitclip
