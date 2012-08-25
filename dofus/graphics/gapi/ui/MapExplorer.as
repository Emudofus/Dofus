// Action script...

// [Initial MovieClip Action of sprite 20599]
#initclip 120
if (!dofus.graphics.gapi.ui.MapExplorer)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.MapExplorer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__mapID = function (nMapID)
    {
        this._dmMap = new dofus.datacenter.DofusMap(nMapID);
        //return (this.mapID());
    };
    _loc1.__set__pointer = function (sPointer)
    {
        this._sPointer = sPointer;
        //return (this.pointer());
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
    _loc1.multipleSelect = function (aCoords)
    {
        this._mnMap.clear("highlight");
        for (var k in aCoords)
        {
            var _loc3 = aCoords[k];
            if (_loc3 != undefined)
            {
                var _loc4 = _loc3.type;
                var _loc5 = _loc3.x;
                var _loc6 = _loc3.y;
                var _loc7 = _loc3.mapID;
                var _loc8 = _loc3.label;
                var _loc9 = Number(this.api.lang.getMapText(_loc7).d);
                if (_loc9 == this.dungeonID || _global.isNaN(this.dungeonID))
                {
                    if (!_global.isNaN(this.dungeonID))
                    {
                        var _loc10 = this.dungeon.m[_loc7];
                        var _loc11 = this.dungeonCurrentMap;
                        if (_loc11.z != _loc10.z)
                        {
                            continue;
                        } // end if
                        _loc5 = _loc10.x;
                        _loc6 = _loc10.y;
                    } // end if
                    switch (_loc4)
                    {
                        case 1:
                        {
                            var _loc12 = dofus.Constants.FLAG_MAP_PHOENIX;
                            break;
                        } 
                        case 2:
                        {
                            _loc12 = dofus.Constants.FLAG_MAP_GROUP;
                            _loc8 = _loc5 + "," + _loc6 + " (" + _global.API.ui.getUIComponent("Party").getMemberById(aCoords[k].playerID).name + ")";
                            if (_loc8 == undefined)
                            {
                                delete aCoords[k];
                                continue;
                            } // end if
                            break;
                        } 
                        case 3:
                        {
                            _loc12 = dofus.Constants.FLAG_MAP_SEEK;
                            _loc8 = _loc5 + "," + _loc6 + " (" + aCoords[k].playerName + ")";
                            break;
                        } 
                        default:
                        {
                            _loc12 = dofus.Constants.FLAG_MAP_OTHERS;
                            break;
                        } 
                    } // End of switch
                    var _loc13 = this._mnMap.addXtraClip("UI_MapExplorerFlag", "highlight", _loc5, _loc6, _loc12, 100, false, true);
                    if (_loc8 != undefined)
                    {
                        _loc13.label = _loc13.label != undefined ? (_loc13.label + "\n" + _loc8) : (_loc8);
                        _loc13.gapi = this.gapi;
                        _loc13.onRollOver = function ()
                        {
                            this.gapi.showTooltip(this.label, this, 10);
                        };
                        _loc13.onRollOut = function ()
                        {
                            this.gapi.hideTooltip();
                        };
                    } // end if
                } // end if
            } // end if
        } // end of for...in
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.MapExplorer.CLASS_NAME);
        this.api.gfx._visible = false;
        ank.utils.MouseEvents.addListener(this);
        this.gapi.removeCursor(true);
    };
    _loc1.destroy = function ()
    {
        if (this.dungeon == undefined)
        {
            this.api.datacenter.Basics.mapExplorer_zoom = this._mnMap.zoom;
            this.api.datacenter.Basics.mapExplorer_coord = {x: this._mnMap.currentX, y: this._mnMap.currentY};
        } // end if
        this.gapi.hideTooltip();
        this.gapi.removeCursor(true);
        this.api.gfx._visible = true;
        this.api.network.Conquest.worldInfosLeave();
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.layoutContent});
        this._lblArea._visible = false;
    };
    _loc1.initTexts = function ()
    {
        this._winBg.title = this.api.lang.getText("WORLD_MAP");
        this._lblZoom.text = this.api.lang.getText("ZOOM");
        if (this.dungeon != undefined)
        {
            this._lblArea._visible = true;
            this._lblArea.text = this.dungeon.n;
        }
        else
        {
            this._lblArea.text = this.api.lang.getText("AREA");
        } // end else if
        this._lblHints.text = this.api.lang.getText("HINTS_FILTER");
    };
    _loc1.layoutContent = function ()
    {
        if (this.dungeon == undefined)
        {
            var _loc2 = this.api.lang.getHintsCategories();
            _loc2[-1] = {n: this.api.lang.getText("OPTION_GRID"), c: "Yellow"};
            var _loc3 = this.api.kernel.OptionsManager.getOption("MapFilters");
            var _loc4 = 0;
            var _loc5 = -1;
            
            while (++_loc5, _loc5 < _loc2.length)
            {
                if (_loc2[_loc5] != undefined)
                {
                    var _loc6 = new Object();
                    _loc6._y = this._mcFilterPlacer._y;
                    _loc6._x = this._mcFilterPlacer._x + _loc4;
                    _loc6.backgroundDown = "ButtonCheckDown";
                    _loc6.backgroundUp = "ButtonCheckUp";
                    _loc6.styleName = _loc2[_loc5].c + "MapHintCheckButton";
                    _loc6.toggle = true;
                    _loc6.selected = false;
                    _loc6.enabled = true;
                    var _loc7 = (ank.gapi.controls.Button)(this.attachMovie("Button", "_mcFilter" + _loc5, this.getNextHighestDepth(), _loc6));
                    _loc7.setSize(12, 12);
                    _loc7.addEventListener("click", this);
                    _loc7.addEventListener("over", this);
                    _loc7.addEventListener("out", this);
                    _loc4 = _loc4 + 17;
                } // end if
                if (_loc5 != -1)
                {
                    this.showHintsCategory(_loc5, _loc3[_loc5] == 1);
                } // end if
            } // end while
            this._mnMap.showGrid = this.api.datacenter.Basics.mapExplorer_grid;
            this["_mcFilter-1"].selected = this.api.datacenter.Basics.mapExplorer_grid;
        }
        else
        {
            this._lblHints._visible = false;
            this._mnMap.showGrid = false;
        } // end else if
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnZoomPlus.addEventListener("click", this);
        this._btnZoomMinous.addEventListener("click", this);
        this._btnMove.addEventListener("click", this);
        this._btnSelect.addEventListener("click", this);
        this._btnCenterOnMe.addEventListener("click", this);
        this._btnZoomPlus.addEventListener("over", this);
        this._btnZoomMinous.addEventListener("over", this);
        this._btnMove.addEventListener("over", this);
        this._btnSelect.addEventListener("over", this);
        this._btnCenterOnMe.addEventListener("over", this);
        this._btnZoomPlus.addEventListener("out", this);
        this._btnZoomMinous.addEventListener("out", this);
        this._btnMove.addEventListener("out", this);
        this._btnSelect.addEventListener("out", this);
        this._btnCenterOnMe.addEventListener("out", this);
        this._mnMap.addEventListener("overMap", this);
        this._mnMap.addEventListener("outMap", this);
        this._mnMap.addEventListener("over", this);
        this._mnMap.addEventListener("out", this);
        this._mnMap.addEventListener("zoom", this);
        this._mnMap.addEventListener("select", this);
        this._mnMap.addEventListener("xtraLayerLoad", this);
        if (this.api.datacenter.Player.isAuthorized)
        {
            this._mnMap.addEventListener("doubleClick", this);
        } // end if
        this._vsZoom.addEventListener("change", this);
        this.api.datacenter.Conquest.addEventListener("worldDataChanged", this);
    };
    _loc1.initData = function ()
    {
        if (this.dungeon != undefined)
        {
            this.initDungeonMap();
        }
        else
        {
            this.api.network.Conquest.worldInfosJoin();
            this.initWorldMap();
        } // end else if
    };
    _loc1.initWorldMap = function ()
    {
        if (this._dmMap == undefined)
        {
            this._dmMap = this.api.datacenter.Map;
            var _loc2 = this.api.datacenter.Basics.mapExplorer_coord;
        } // end if
        this.showMapSuperArea(this._dmMap.superarea);
        if (_loc2 != undefined)
        {
            this._mnMap.setMapPosition(_loc2.x, _loc2.y);
        } // end if
        this._mnMap.zoom = this.api.datacenter.Basics.mapExplorer_zoom;
    };
    _loc1.showMapSuperArea = function (nSuperAreaID)
    {
        if (nSuperAreaID == undefined)
        {
            return;
        } // end if
        this._mnMap.contentPath = dofus.Constants.LOCAL_MAPS_PATH + nSuperAreaID + ".swf";
        this._mnMap.clear();
        this._mnMap.setMapPosition(this._dmMap.x, this._dmMap.y);
        var _loc3 = this.api.datacenter.Map;
        this._mnMap.addXtraClip("UI_MapExplorerSelectRectangle", "rectangle", _loc3.x, _loc3.y, dofus.Constants.MAP_CURRENT_POSITION, 50);
        if (this._dmMap != _loc3)
        {
            this._mnMap.addXtraClip("UI_MapExplorerSelectRectangle", "rectangle", this._dmMap.x, this._dmMap.y, dofus.Constants.MAP_WAYPOINT_POSITION, 50);
        } // end if
        if (this.api.datacenter.Basics.banner_targetCoords != undefined)
        {
            this._mnMap.addXtraClip("UI_MapExplorerFlag", "flag", this.api.datacenter.Basics.banner_targetCoords[0], this.api.datacenter.Basics.banner_targetCoords[1], 255);
        } // end if
        if (this.api.datacenter.Basics.aks_infos_highlightCoords != undefined)
        {
            this.multipleSelect(this.api.datacenter.Basics.aks_infos_highlightCoords);
        } // end if
    };
    _loc1.hideArrows = function (bHide)
    {
        this._mcTriangleNW._visible = this._mcTriangleN._visible = this._mcTriangleNE._visible = this._mcTriangleW._visible = this._mcTriangleE._visible = this._mcTriangleSW._visible = this._mcTriangleS._visible = this._mcTriangleSE._visible = !bHide;
    };
    _loc1.showHintsCategory = function (categoryID, bShow)
    {
        var _loc4 = this.api.kernel.OptionsManager.getOption("MapFilters");
        _loc4[categoryID] = bShow;
        this.api.kernel.OptionsManager.setOption("MapFilters", _loc4);
        this["_mcFilter" + categoryID].selected = bShow;
        var _loc5 = "hints" + categoryID;
        if (bShow)
        {
            this._mnMap.loadXtraLayer(dofus.Constants.MAP_HINTS_FILE, _loc5);
        }
        else
        {
            this._mnMap.clear(_loc5);
        } // end else if
    };
    _loc1.drawHintsOnCategoryLayer = function (categoryID)
    {
        var _loc3 = "hints" + categoryID;
        if (dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID == categoryID)
        {
            var _loc4 = this.getConquestAreaList();
        }
        else
        {
            _loc4 = this.api.lang.getHintsByCategory(categoryID);
        } // end else if
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc4.length)
        {
            var _loc6 = new dofus.datacenter.Hint(_loc4[_loc5]);
            if ((_loc6.superAreaID == this._dmMap.superarea || dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID == categoryID && categoryID != 5) && _loc6.y != undefined)
            {
                var _loc7 = this._mnMap.addXtraClip(_loc6.gfx, _loc3, _loc6.x, _loc6.y, undefined, undefined, true);
                _loc7.oHint = _loc6;
                _loc7.gapi = this.gapi;
                _loc7.onRollOver = function ()
                {
                    this.gapi.showTooltip(this.oHint.x + "," + this.oHint.y + " (" + this.oHint.name + ")", this, -20);
                };
                _loc7.onRollOut = function ()
                {
                    this.gapi.hideTooltip();
                };
            } // end if
        } // end while
    };
    _loc1.getConquestAreaList = function ()
    {
        var _loc2 = this.api.datacenter.Conquest.worldDatas;
        if (!_loc2.areas.length)
        {
            this.addToQueue({object: this, method: this.drawHintsOnCategoryLayer, params: [dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID]});
        } // end if
        var _loc3 = new Array();
        var _loc4 = new String();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc2.areas.length)
        {
            if (_loc2.areas[_loc5].alignment == 1)
            {
                var _loc7 = this.api.lang.getText("BONTARIAN_PRISM");
                var _loc6 = 420;
            } // end if
            if (_loc2.areas[_loc5].alignment == 2)
            {
                _loc7 = this.api.lang.getText("BRAKMARIAN_PRISM");
                _loc6 = 421;
            } // end if
            _loc3.push({g: _loc6, m: _loc2.areas[_loc5].prism, n: _loc7, superAreaID: this.api.lang.getMapAreaText(_loc2.areas[_loc5].id).a});
        } // end while
        return (_loc3);
    };
    _loc1.initDungeonMap = function (nDungeon)
    {
        var _loc3 = this.api.datacenter.Map;
        this._mnMap.clear();
        this._mnMap.createXtraLayer("dungeonParchment");
        this._mnMap.createXtraLayer("dungeonMap");
        this._mnMap.createXtraLayer("highlight");
        var _loc4 = this.dungeon.m;
        var _loc5 = this.dungeonCurrentMap;
        for (var a in _loc4)
        {
            var _loc6 = _loc4[a];
            if (_loc5.z == _loc6.z)
            {
                var _loc7 = this._mnMap.addXtraClip("UI_MapExplorerRectangle", "dungeonMap", _loc6.x, _loc6.y);
                if (_loc6.n != undefined)
                {
                    _loc7.label = _loc6.n + " (" + _loc6.x + "," + _loc6.y + ")";
                    _loc7.gapi = this.gapi;
                    _loc7.onRollOver = function ()
                    {
                        this.gapi.showTooltip(this.label, this, -20);
                    };
                    _loc7.onRollOut = function ()
                    {
                        this.gapi.hideTooltip();
                    };
                } // end if
            } // end if
        } // end of for...in
        var _loc8 = this.dungeonCurrentMap;
        this._mnMap.addXtraClip("UI_MapExplorerSelectRectangle", "dungeonMap", _loc8.x, _loc8.y, dofus.Constants.MAP_CURRENT_POSITION, 50);
        this._mnMap.setMapPosition(_loc8.x, _loc8.y);
        this._mnMap.loadXtraLayer(dofus.Constants.MAP_HINTS_FILE, "dungeonHints");
        this._mnMap.loadXtraLayer(dofus.Constants.LOCAL_MAPS_PATH + "dungeon.swf", "dungeonParchment");
    };
    _loc1.initDungeonParchment = function ()
    {
        var _loc2 = this._mnMap.getXtraLayer("dungeonParchment");
        var _loc3 = this._mnMap.getXtraLayer("dungeonMap");
        var _loc4 = _loc3._width;
        var _loc5 = _loc3._height;
        var _loc6 = _loc2.view._x;
        var _loc7 = _loc2.view._y;
        var _loc8 = _loc2.view._width;
        var _loc9 = _loc2.view._height;
        var _loc10 = 100;
        if (_loc4 > _loc8 || _loc5 > _loc9)
        {
            var _loc11 = _loc8 / _loc4;
            var _loc12 = _loc9 / _loc5;
            if (_loc12 > _loc11)
            {
                _loc10 = 100 * _loc4 / _loc8;
            }
            else
            {
                _loc10 = 100 * _loc5 / _loc9;
            } // end else if
            _loc2._xscale = _loc2._yscale = _loc10;
        } // end if
        var _loc13 = _loc6 * _loc10 / 100 + (_loc8 * _loc10 / 100 - _loc4) / 2;
        var _loc14 = _loc7 * _loc10 / 100 + (_loc9 * _loc10 / 100 - _loc5) / 2;
        _loc2.parchment._x = -_loc13 * 100 / _loc10;
        _loc2.parchment._y = -_loc14 * 100 / _loc10;
        var _loc15 = _loc2._parent._xscale;
        var _loc16 = _loc2._width * _loc10 / 100 * _loc15 / 100;
        var _loc17 = _loc2._height * _loc10 / 100 * _loc15 / 100;
        var _loc18 = this._mnMap._width;
        var _loc19 = this._mnMap._height;
        if (_loc16 > _loc17)
        {
            this._mnMap.zoom = this._mnMap.zoom * _loc18 / _loc16;
        }
        else
        {
            this._mnMap.zoom = this._mnMap.zoom * _loc19 / _loc17;
        } // end else if
        this._mnMap.setMapPosition(this.dungeonCurrentMap.x, this.dungeonCurrentMap.y);
    };
    _loc1.drawHintsDungeon = function ()
    {
        var _loc2 = this.dungeon.m;
        for (var a in _loc2)
        {
            var _loc3 = _loc2[a];
            if (_loc3.i != undefined)
            {
                var _loc4 = this._mnMap.addXtraClip(_loc3.i, "dungeonHints", _loc3.x, _loc3.y, undefined, undefined, true);
                if (_loc3.n != undefined)
                {
                    _loc4.label = _loc3.n + " (" + _loc3.x + "," + _loc3.y + ")";
                    _loc4.gapi = this.gapi;
                    _loc4.onRollOver = function ()
                    {
                        this.gapi.showTooltip(this.label, this, -20);
                    };
                    _loc4.onRollOut = function ()
                    {
                        this.gapi.hideTooltip();
                    };
                } // end if
            } // end if
        } // end of for...in
    };
    _loc1.onMouseWheel = function (nIncrement, mcTarget)
    {
        if (mcTarget._target.indexOf("_mnMap", 0) != -1)
        {
            this._mnMap.zoom = this._mnMap.zoom + (nIncrement < 0 ? (-5) : (5));
        } // end if
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
            case "_btnZoomPlus":
            {
                this.api.sounds.events.onMapButtonClick();
                this._mnMap.interactionMode = "zoom+";
                this._btnZoomMinous.selected = false;
                this._btnMove.selected = false;
                this._btnSelect.selected = false;
                this._btnZoomPlus.enabled = false;
                this._btnZoomMinous.enabled = true;
                this._btnMove.enabled = true;
                this._btnSelect.enabled = true;
                this.hideArrows(true);
                break;
            } 
            case "_btnZoomMinous":
            {
                this.api.sounds.events.onMapButtonClick();
                this._mnMap.interactionMode = "zoom-";
                this._btnZoomPlus.selected = false;
                this._btnMove.selected = false;
                this._btnSelect.selected = false;
                this._btnZoomPlus.enabled = true;
                this._btnZoomMinous.enabled = false;
                this._btnMove.enabled = true;
                this._btnSelect.enabled = true;
                this.hideArrows(true);
                break;
            } 
            case "_btnMove":
            {
                this.api.sounds.events.onMapButtonClick();
                this._mnMap.interactionMode = "move";
                this._btnZoomMinous.selected = false;
                this._btnZoomPlus.selected = false;
                this._btnSelect.selected = false;
                this._btnZoomPlus.enabled = true;
                this._btnZoomMinous.enabled = true;
                this._btnMove.enabled = false;
                this._btnSelect.enabled = true;
                this.hideArrows(false);
                break;
            } 
            case "_btnSelect":
            {
                this.api.sounds.events.onMapButtonClick();
                this._mnMap.interactionMode = "select";
                this._btnZoomMinous.selected = false;
                this._btnZoomPlus.selected = false;
                this._btnMove.selected = false;
                this._btnZoomPlus.enabled = true;
                this._btnZoomMinous.enabled = true;
                this._btnMove.enabled = true;
                this._btnSelect.enabled = false;
                this.hideArrows(true);
                break;
            } 
            case "_btnCenterOnMe":
            {
                if (this.dungeon != undefined)
                {
                    var _loc3 = this.dungeonCurrentMap;
                    this._mnMap.setMapPosition(_loc3.x, _loc3.y);
                }
                else
                {
                    this._mnMap.setMapPosition(this.api.datacenter.Map.x, this.api.datacenter.Map.y);
                } // end else if
                break;
            } 
            default:
            {
                var _loc4 = oEvent.target._name;
                var _loc5 = Number(_loc4.substr(9, _loc4.length));
                if (_loc5 != -1)
                {
                    this.showHintsCategory(_loc5, !this.api.kernel.OptionsManager.getOption("MapFilters")[_loc5]);
                    this.api.ui.getUIComponent("Banner").illustration.updateHints();
                }
                else
                {
                    var _loc6 = !this.api.datacenter.Basics.mapExplorer_grid;
                    this.api.datacenter.Basics.mapExplorer_grid = _loc6;
                    this._mnMap.showGrid = _loc6;
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._mnMap:
            {
                var _loc3 = oEvent.target._name.substr(4);
                this.setMovieClipTransform(this["_mcTriangle" + _loc3], dofus.graphics.gapi.ui.MapExplorer.OVER_TRIANGLE_TRANSFORM);
                break;
            } 
            case this._btnZoomPlus:
            {
                this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_ZOOM_PLUS"), oEvent.target, -20);
                break;
            } 
            case this._btnZoomMinous:
            {
                this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_ZOOM_MINOUS"), oEvent.target, -20);
                break;
            } 
            case this._btnMove:
            {
                this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_MOVE"), oEvent.target, -20);
                break;
            } 
            case this._btnSelect:
            {
                this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_SELECT"), oEvent.target, -20);
                break;
            } 
            case this._btnCenterOnMe:
            {
                this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_CENTER"), oEvent.target, -20);
                break;
            } 
            default:
            {
                var _loc4 = oEvent.target._name;
                this.gapi.showTooltip(this.api.lang.getHintsCategory(Number(_loc4.substr(9, _loc4.length))).n, oEvent.target, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._mnMap:
            {
                var _loc3 = 0;
                
                while (++_loc3, _loc3 < dofus.graphics.gapi.ui.MapExplorer.DIRECTIONS.length)
                {
                    this.setMovieClipTransform(this["_mcTriangle" + dofus.graphics.gapi.ui.MapExplorer.DIRECTIONS[_loc3]], dofus.graphics.gapi.ui.MapExplorer.OUT_TRIANGLE_TRANSFORM);
                } // end while
                break;
            } 
            default:
            {
                this.gapi.hideTooltip();
                break;
            } 
        } // End of switch
    };
    _loc1.change = function (oEvent)
    {
        this._mnMap.zoom = oEvent.target.value;
    };
    _loc1.zoom = function (oEvent)
    {
        this._vsZoom.value = oEvent.target.zoom;
    };
    _loc1.select = function (oEvent)
    {
        this.api.sounds.events.onMapFlag();
        var _loc3 = oEvent.coordinates;
        this._mnMap.clear("flag");
        if (this.api.kernel.GameManager.updateCompass(_loc3.x, _loc3.y, false))
        {
            this._mnMap.addXtraClip("UI_MapExplorerFlag", "flag", _loc3.x, _loc3.y, 255);
        } // end if
    };
    _loc1.overMap = function (oEvent)
    {
        if (this.dungeon == undefined)
        {
            var _loc3 = this.api.kernel.AreasManager.getAreaIDFromCoordinates(oEvent.coordinates.x, oEvent.coordinates.y, this._dmMap.superarea);
            var _loc4 = this.api.kernel.AreasManager.getSubAreaIDFromCoordinates(oEvent.coordinates.x, oEvent.coordinates.y, this._dmMap.superarea);
            if (_loc4 != undefined)
            {
                var _loc5 = this.api.lang.getMapSubAreaText(_loc4).n;
                var _loc6 = (dofus.datacenter.Subarea)(this.api.datacenter.Subareas.getItemAt(_loc4));
                if (_loc6 != undefined)
                {
                    var _loc7 = _loc6.color;
                    var _loc8 = this.api.lang.getMapAreaText(_loc3).n + (_loc5.substr(0, 2) == "//" ? (" - ") : (" (" + _loc5 + ") - ")) + _loc6.alignment.name;
                }
                else
                {
                    _loc7 = dofus.Constants.AREA_NO_ALIGNMENT_COLOR;
                    _loc8 = this.api.lang.getMapAreaText(_loc3).n + (_loc5.substr(0, 2) == "//" ? ("") : (" (" + _loc5 + ")"));
                } // end else if
                if (this._vsZoom.value != 2)
                {
                    this._mnMap.addSubareaClip(_loc4, _loc7 != -1 ? (_loc7) : (dofus.Constants.AREA_NO_ALIGNMENT_COLOR), 20);
                } // end if
                this._lblAreaName.text = _loc8;
                this._lblArea._visible = true;
            }
            else
            {
                this.outMap();
            } // end if
        } // end else if
    };
    _loc1.outMap = function (oEvent)
    {
        if (this.dungeon == undefined)
        {
            this._mnMap.removeAreaClip();
            if (this._lblAreaName.text != undefined)
            {
                this._lblAreaName.text = "";
            } // end if
            this._lblArea._visible = false;
        } // end if
    };
    _loc1.doubleClick = function (oEvent)
    {
        if (!this.api.datacenter.Game.isFight && this.dungeon == undefined)
        {
            var _loc3 = oEvent.coordinates.x;
            var _loc4 = oEvent.coordinates.y;
            if (_loc3 != undefined && _loc4 != undefined)
            {
                this.api.network.Basics.autorisedMoveCommand(_loc3, _loc4);
            } // end if
        } // end if
    };
    _loc1.xtraLayerLoad = function (oEvent)
    {
        switch (oEvent.mc._name)
        {
            case "dungeonHints":
            {
                this.drawHintsDungeon();
                break;
            } 
            case "dungeonParchment":
            {
                this.initDungeonParchment();
                break;
            } 
            default:
            {
                var _loc3 = oEvent.mc._name;
                this.drawHintsOnCategoryLayer(Number(_loc3.substr(5, _loc3.length)));
                break;
            } 
        } // End of switch
    };
    _loc1.worldDataChanged = function (oEvent)
    {
        if (this["_mcFilter" + dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID].selected)
        {
            this.addToQueue({object: this, method: this.drawHintsOnCategoryLayer, params: [dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID]});
        } // end if
    };
    _loc1.addProperty("pointer", function ()
    {
    }, _loc1.__set__pointer);
    _loc1.addProperty("dungeon", _loc1.__get__dungeon, function ()
    {
    });
    _loc1.addProperty("dungeonCurrentMap", _loc1.__get__dungeonCurrentMap, function ()
    {
    });
    _loc1.addProperty("dungeonID", _loc1.__get__dungeonID, function ()
    {
    });
    _loc1.addProperty("mapID", function ()
    {
    }, _loc1.__set__mapID);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.MapExplorer = function ()
    {
        super();
    }).CLASS_NAME = "MapExplorer";
    (_global.dofus.graphics.gapi.ui.MapExplorer = function ()
    {
        super();
    }).OVER_TRIANGLE_TRANSFORM = {ra: 0, rb: 255, ga: 0, gb: 102, ba: 0, bb: 0};
    (_global.dofus.graphics.gapi.ui.MapExplorer = function ()
    {
        super();
    }).OUT_TRIANGLE_TRANSFORM = {ra: 0, rb: 184, ga: 0, gb: 177, ba: 0, bb: 143};
    (_global.dofus.graphics.gapi.ui.MapExplorer = function ()
    {
        super();
    }).DIRECTIONS = new Array("NW", "N", "NE", "W", "E", "SW", "S", "SE");
    (_global.dofus.graphics.gapi.ui.MapExplorer = function ()
    {
        super();
    }).FILTER_CONQUEST_ID = 5;
} // end if
#endinitclip
