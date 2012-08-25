// Action script...

// [Initial MovieClip Action of sprite 20511]
#initclip 32
if (!ank.battlefield.MapHandler)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.MapHandler = function (b, c, d)
    {
        if (b != undefined)
        {
            this.initialize(b, c, d);
        } // end if
        this._mclLoader.addListener(this);
    }).prototype;
    _loc1.__get__LoaderRequestLeft = function ()
    {
        return (this._nLoadRequest);
    };
    _loc1.initialize = function (b, c, d)
    {
        this._mcBattlefield = b;
        this._oDatacenter = d;
        this._mcContainer = c;
    };
    _loc1.build = function (oMap, nCellNum, bBuildAll)
    {
        this._oDatacenter.Map = oMap;
        var _loc5 = ank.battlefield.Constants.CELL_WIDTH;
        var _loc6 = ank.battlefield.Constants.CELL_HALF_WIDTH;
        var _loc7 = ank.battlefield.Constants.CELL_HALF_HEIGHT;
        var _loc8 = ank.battlefield.Constants.LEVEL_HEIGHT;
        var _loc9 = -1;
        var _loc10 = 0;
        var _loc11 = 0;
        var _loc12 = oMap.data;
        var _loc13 = _loc12.length;
        var _loc14 = oMap.width - 1;
        var _loc15 = this._mcContainer.ExternalContainer;
        var _loc16 = nCellNum != undefined;
        var _loc17 = false;
        var _loc18 = this._nLastCellCount == _loc13;
        this._nLoadRequest = 0;
        if (!_loc16 && (ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod"))
        {
            this._mcContainer.applyMask(false);
        } // end if
        if (oMap.backgroundNum != 0)
        {
            if (ank.battlefield.Constants.USE_STREAMING_FILES && (ank.battlefield.Constants.STREAMING_METHOD == "explod" && !_loc16))
            {
                var _loc19 = _loc15.Ground.createEmptyMovieClip("background", -1);
                _loc19.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/BACKGROUND"];
                this._mclLoader.loadClip(ank.battlefield.Constants.STREAMING_GROUNDS_DIR + oMap.backgroundNum + ".swf", _loc19);
                ++this._nLoadRequest;
            }
            else if (ank.battlefield.Constants.STREAMING_METHOD != "")
            {
                _loc15.Ground.attachMovie(oMap.backgroundNum, "background", -1).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/BACKGROUND"];
            }
            else
            {
                _loc15.Ground.attach(oMap.backgroundNum, "background", -1).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/BACKGROUND"];
            } // end else if
        } // end else if
        var _loc20 = -1;
        while (++_loc20 < _loc13)
        {
            if (_loc9 == _loc14)
            {
                _loc9 = 0;
                _loc10 = _loc10 + 1;
                if (_loc11 == 0)
                {
                    _loc11 = _loc6;
                    _loc14 = _loc14 - 1;
                }
                else
                {
                    _loc11 = 0;
                    _loc14 = _loc14 + 1;
                } // end else if
            }
            else
            {
                ++_loc9;
            } // end else if
            if (_loc16)
            {
                if (_loc20 < nCellNum)
                {
                    continue;
                }
                else if (_loc20 > nCellNum)
                {
                    return;
                } // end if
            } // end else if
            var _loc21 = _loc12[_loc20];
            if (_loc21.active)
            {
                var _loc22 = _loc9 * _loc5 + _loc11;
                var _loc23 = _loc10 * _loc7 - _loc8 * (_loc21.groundLevel - 7);
                _loc21.x = _loc22;
                _loc21.y = _loc23;
                if (_loc21.movement || bBuildAll)
                {
                    if (!_loc18 && !_loc15.InteractionCell["cell" + _loc20])
                    {
                        if (!_loc17)
                        {
                            if (ank.battlefield.Constants.STREAMING_METHOD != "")
                            {
                                var _loc24 = _loc15.InteractionCell.attachMovie("i" + _loc21.groundSlope, "cell" + _loc20, _loc20, {_x: _loc22, _y: _loc23});
                            }
                            else
                            {
                                _loc24 = _loc15.InteractionCell.attachMovie("i" + _loc21.groundSlope, "cell" + _loc20, _loc20, {_x: _loc22, _y: _loc23});
                            } // end else if
                        }
                        else
                        {
                            _loc24 = _loc15.InteractionCell.createEmptyMovieClip("cell" + _loc20, _loc20, {_x: _loc22, _y: _loc23});
                        } // end else if
                        _loc24.__proto__ = ank.battlefield.mc.Cell.prototype;
                        _loc24.initialize(this._mcBattlefield);
                    }
                    else
                    {
                        _loc24 = _loc15.InteractionCell["cell" + _loc20];
                    } // end else if
                    _loc21.mc = _loc24;
                    _loc24.data = _loc21;
                }
                else
                {
                    _loc15.InteractionCell["cell" + _loc20].removeMovieClip();
                } // end else if
                if (_loc21.layerGroundNum != 0)
                {
                    if (ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
                    {
                        var _loc26 = true;
                        if (_loc16)
                        {
                            var _loc25 = _loc15.Ground["cell" + _loc20];
                            if (_loc25 != undefined && _loc25.lastGroundID == _loc21.layerGroundNum)
                            {
                                _loc26 = false;
                                _loc25.fullLoaded = false;
                                this._oLoadingCells[_loc25] = _loc21;
                                this.onLoadInit(_loc25);
                            } // end if
                        } // end if
                        if (_loc26)
                        {
                            _loc25 = _loc15.Ground.createEmptyMovieClip("cell" + _loc20, _loc20);
                            _loc25.fullLoaded = false;
                            this._oLoadingCells[_loc25] = _loc21;
                            this._mclLoader.loadClip(ank.battlefield.Constants.STREAMING_GROUNDS_DIR + _loc21.layerGroundNum + ".swf", _loc25);
                            ++this._nLoadRequest;
                        } // end if
                    }
                    else
                    {
                        if (!_loc17)
                        {
                            if (ank.battlefield.Constants.STREAMING_METHOD != "")
                            {
                                _loc25 = _loc15.Ground.attachMovie(_loc21.layerGroundNum, "cell" + _loc20, _loc20);
                            }
                            else
                            {
                                _loc25 = _loc15.Ground.attach(_loc21.layerGroundNum, "cell" + _loc20, _loc20);
                            } // end else if
                        }
                        else
                        {
                            _loc25 = new MovieClip();
                        } // end else if
                        _loc25.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Ground"];
                        _loc25._x = _loc22;
                        _loc25._y = _loc23;
                        if (_loc21.groundSlope != 1)
                        {
                            _loc25.gotoAndStop(_loc21.groundSlope);
                        }
                        else if (_loc21.layerGroundRot != 0)
                        {
                            _loc25._rotation = _loc21.layerGroundRot * 90;
                            if (_loc25._rotation % 180)
                            {
                                _loc25._yscale = 1.928600E+002;
                                _loc25._xscale = 5.185000E+001;
                            } // end if
                        } // end else if
                        if (_loc21.layerGroundFlip)
                        {
                            _loc25._xscale = _loc25._xscale * -1;
                        } // end if
                    } // end else if
                }
                else
                {
                    _loc15.Ground["cell" + _loc20].removeMovieClip();
                } // end else if
                if (_loc21.layerObject1Num != 0)
                {
                    if (ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
                    {
                        var _loc28 = true;
                        if (_loc16)
                        {
                            var _loc27 = _loc15.Object1["cell" + _loc20];
                            if (_loc27 != undefined && _loc27.lastObject1ID == _loc21.layerObject1Num)
                            {
                                _loc28 = false;
                                _loc27.fullLoaded = false;
                                this._oLoadingCells[_loc27] = _loc21;
                                this.onLoadInit(_loc27);
                            } // end if
                        } // end if
                        if (_loc28)
                        {
                            _loc27 = _loc15.Object1.createEmptyMovieClip("cell" + _loc20, _loc20);
                            _loc27.fullLoaded = false;
                            this._oLoadingCells[_loc27] = _loc21;
                            this._mclLoader.loadClip(ank.battlefield.Constants.STREAMING_OBJECTS_DIR + _loc21.layerObject1Num + ".swf", _loc27);
                            ++this._nLoadRequest;
                        } // end if
                    }
                    else
                    {
                        if (!_loc17)
                        {
                            _loc27 = _loc15.Object1.attachMovie(_loc21.layerObject1Num, "cell" + _loc20, _loc20);
                        }
                        else
                        {
                            _loc27 = new MovieClip();
                        } // end else if
                        _loc27.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Object1"];
                        _loc27._x = _loc22;
                        _loc27._y = _loc23;
                        if (_loc21.groundSlope == 1 && _loc21.layerObject1Rot != 0)
                        {
                            _loc27._rotation = _loc21.layerObject1Rot * 90;
                            if (_loc27._rotation % 180)
                            {
                                _loc27._yscale = 1.928600E+002;
                                _loc27._xscale = 5.185000E+001;
                            } // end if
                        } // end if
                        if (_loc21.layerObject1Flip)
                        {
                            _loc27._xscale = _loc27._xscale * -1;
                        } // end if
                    } // end else if
                    _loc21.mcObject1 = _loc27;
                }
                else
                {
                    _loc15.Object1["cell" + _loc20].removeMovieClip();
                } // end else if
                if (_loc21.layerObjectExternal != "")
                {
                    if (!_loc17)
                    {
                        var _loc29 = _loc15.Object2.attachClassMovie(ank.battlefield.mc.InteractiveObject, "cellExt" + _loc20, _loc20 * 100 + 1);
                    } // end if
                    _loc29.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/ObjectExternal"];
                    _loc29.initialize(this._mcBattlefield, _loc21, _loc21.layerObjectExternalInteractive);
                    _loc29.loadExternalClip(_loc21.layerObjectExternal, _loc21.layerObjectExternalAutoSize);
                    _loc29._x = _loc22;
                    _loc29._y = _loc23;
                    _loc21.mcObjectExternal = _loc29;
                }
                else
                {
                    _loc15.Object2["cellExt" + _loc20].removeMovieClip();
                    delete _loc21.mcObjectExternal;
                } // end else if
                if (_loc21.layerObject2Num != 0)
                {
                    if (ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
                    {
                        var _loc31 = true;
                        if (_loc16)
                        {
                            var _loc30 = _loc15.Object2["cell" + _loc20];
                            if (_loc30 != undefined && _loc30.lastObject2ID == _loc21.layerObject2Num)
                            {
                                _loc31 = false;
                                _loc30.fullLoaded = false;
                                this._oLoadingCells[_loc30] = _loc21;
                                this.onLoadInit(_loc30);
                            } // end if
                        } // end if
                        if (_loc31)
                        {
                            _loc30 = _loc15.Object2.createEmptyMovieClip("cell" + _loc20, _loc20 * 100);
                            _loc30.fullLoaded = false;
                            this._oLoadingCells[_loc30] = _loc21;
                            this._mclLoader.loadClip(ank.battlefield.Constants.STREAMING_OBJECTS_DIR + _loc21.layerObject2Num + ".swf", _loc30);
                            ++this._nLoadRequest;
                        } // end if
                    }
                    else
                    {
                        if (!_loc17)
                        {
                            _loc30 = _loc15.Object2.attachMovie(_loc21.layerObject2Num, "cell" + _loc20, _loc20 * 100);
                        }
                        else
                        {
                            _loc30 = new MovieClip();
                        } // end else if
                        _loc30.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Object2"];
                        if (_loc21.layerObject2Interactive)
                        {
                            _loc30.__proto__ = ank.battlefield.mc.InteractiveObject.prototype;
                            _loc30.initialize(this._mcBattlefield, _loc21, true);
                        } // end if
                        _loc30._x = _loc22;
                        _loc30._y = _loc23;
                        if (_loc21.layerObject2Flip)
                        {
                            _loc30._xscale = -100;
                        } // end if
                    } // end else if
                    _loc21.mcObject2 = _loc30;
                }
                else
                {
                    _loc15.Object2["cell" + _loc20].removeMovieClip();
                    delete _loc21.mcObject2;
                } // end else if
                continue;
            } // end if
            if (bBuildAll)
            {
                var _loc32 = _loc9 * _loc5 + _loc11;
                var _loc33 = _loc10 * _loc7;
                _loc21.x = _loc32;
                _loc21.y = _loc33;
                var _loc34 = _loc15.InteractionCell.attachMovie("i1", "cell" + _loc20, _loc20, {_x: _loc32, _y: _loc33});
                _loc34.__proto__ = ank.battlefield.mc.Cell.prototype;
                _loc34.initialize(this._mcBattlefield);
                _loc21.mc = _loc34;
                _loc34.data = _loc21;
            } // end if
        } // end while
        if (!_loc16)
        {
            if (ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
            {
                if (this._nAdjustTimer != undefined)
                {
                    return;
                } // end if
                this._nAdjustTimer = _global.setInterval(this, "adjustAndMaskMap", ank.battlefield.MapHandler.TIME_BEFORE_AJUSTING_MAP);
            }
            else
            {
                this.adjustAndMaskMap();
            } // end if
        } // end else if
    };
    _loc1.updateCell = function (nCellNum, oNewCell, sMaskHex, nPermanentLevel)
    {
        if (nCellNum > this.getCellCount())
        {
            ank.utils.Logger.err("[updateCell] Cellule " + nCellNum + " inexistante");
            return;
        } // end if
        if (nPermanentLevel == undefined || _global.isNaN(nPermanentLevel))
        {
            nPermanentLevel = 0;
        }
        else
        {
            nPermanentLevel = Number(nPermanentLevel);
        } // end else if
        var _loc6 = _global.parseInt(sMaskHex, 16);
        var _loc7 = (_loc6 & 65536) != 0;
        var _loc8 = (_loc6 & 32768) != 0;
        var _loc9 = (_loc6 & 16384) != 0;
        var _loc10 = (_loc6 & 8192) != 0;
        var _loc11 = (_loc6 & 4096) != 0;
        var _loc12 = (_loc6 & 2048) != 0;
        var _loc13 = (_loc6 & 1024) != 0;
        var _loc14 = (_loc6 & 512) != 0;
        var _loc15 = (_loc6 & 256) != 0;
        var _loc16 = (_loc6 & 128) != 0;
        var _loc17 = (_loc6 & 64) != 0;
        var _loc18 = (_loc6 & 32) != 0;
        var _loc19 = (_loc6 & 16) != 0;
        var _loc20 = (_loc6 & 8) != 0;
        var _loc21 = (_loc6 & 4) != 0;
        var _loc22 = (_loc6 & 2) != 0;
        var _loc23 = (_loc6 & 1) != 0;
        var _loc24 = this._oDatacenter.Map.data[nCellNum];
        if (nPermanentLevel > 0)
        {
            if (_loc24.nPermanentLevel == 0)
            {
                var _loc25 = new ank.battlefield.datacenter.Cell();
                for (var k in _loc24)
                {
                    _loc25[k] = _loc24[k];
                } // end of for...in
                this._oDatacenter.Map.originalsCellsBackup.addItemAt(nCellNum, _loc25);
                _loc24.nPermanentLevel = nPermanentLevel;
            } // end if
        } // end if
        if (_loc10)
        {
            _loc24.active = oNewCell.active;
        } // end if
        if (_loc11)
        {
            _loc24.lineOfSight = oNewCell.lineOfSight;
        } // end if
        if (_loc12)
        {
            _loc24.movement = oNewCell.movement;
        } // end if
        if (_loc13)
        {
            _loc24.groundLevel = oNewCell.groundLevel;
        } // end if
        if (_loc14)
        {
            _loc24.groundSlope = oNewCell.groundSlope;
        } // end if
        if (_loc15)
        {
            _loc24.layerGroundNum = oNewCell.layerGroundNum;
        } // end if
        if (_loc16)
        {
            _loc24.layerGroundFlip = oNewCell.layerGroundFlip;
        } // end if
        if (_loc17)
        {
            _loc24.layerGroundRot = oNewCell.layerGroundRot;
        } // end if
        if (_loc18)
        {
            _loc24.layerObject1Num = oNewCell.layerObject1Num;
        } // end if
        if (_loc20)
        {
            _loc24.layerObject1Rot = oNewCell.layerObject1Rot;
        } // end if
        if (_loc19)
        {
            _loc24.layerObject1Flip = oNewCell.layerObject1Flip;
        } // end if
        if (_loc22)
        {
            _loc24.layerObject2Flip = oNewCell.layerObject2Flip;
        } // end if
        if (_loc23)
        {
            _loc24.layerObject2Interactive = oNewCell.layerObject2Interactive;
        } // end if
        if (_loc21)
        {
            _loc24.layerObject2Num = oNewCell.layerObject2Num;
        } // end if
        if (_loc9)
        {
            _loc24.layerObjectExternal = oNewCell.layerObjectExternal;
        } // end if
        if (_loc8)
        {
            _loc24.layerObjectExternalInteractive = oNewCell.layerObjectExternalInteractive;
        } // end if
        if (_loc7)
        {
            _loc24.layerObjectExternalAutoSize = oNewCell.layerObjectExternalAutoSize;
        } // end if
        _loc24.layerObjectExternalData = oNewCell.layerObjectExternalData;
        this.build(this._oDatacenter.Map, nCellNum);
    };
    _loc1.initializeMap = function (nPermanentLevel)
    {
        if (nPermanentLevel == undefined)
        {
            nPermanentLevel = Number.POSITIVE_INFINITY;
        }
        else
        {
            nPermanentLevel = Number(nPermanentLevel);
        } // end else if
        var _loc3 = this._oDatacenter.Map;
        var _loc4 = _loc3.data;
        var _loc5 = _loc3.originalsCellsBackup.getItems();
        for (var k in _loc5)
        {
            this.initializeCell(Number(k), nPermanentLevel);
        } // end of for...in
    };
    _loc1.initializeCell = function (nCellNum, nPermanentLevel)
    {
        if (nPermanentLevel == undefined)
        {
            nPermanentLevel = Number.POSITIVE_INFINITY;
        }
        else
        {
            nPermanentLevel = Number(nPermanentLevel);
        } // end else if
        var _loc4 = this._oDatacenter.Map;
        var _loc5 = _loc4.data;
        var _loc6 = _loc4.originalsCellsBackup.getItemAt(String(nCellNum));
        if (_loc6 == undefined)
        {
            ank.utils.Logger.err("La case est déjà dans son état init");
            return;
        } // end if
        if (_loc5[nCellNum].nPermanentLevel <= nPermanentLevel)
        {
            _loc5[nCellNum] = _loc6;
            this.build(_loc4, nCellNum);
            _loc4.originalsCellsBackup.removeItemAt(String(nCellNum));
        } // end if
    };
    _loc1.setObject2Frame = function (nCellNum, frame)
    {
        if (typeof(frame) == "number" && frame < 1)
        {
            ank.utils.Logger.err("[setObject2Frame] frame " + frame + " incorecte");
            return;
        } // end if
        if (nCellNum > this.getCellCount())
        {
            ank.utils.Logger.err("[setObject2Frame] Cellule " + nCellNum + " inexistante");
            return;
        } // end if
        var _loc4 = this._oDatacenter.Map.data[nCellNum];
        var _loc5 = _loc4.mcObject2;
        if (ank.battlefield.Constants.USE_STREAMING_FILES && (ank.battlefield.Constants.STREAMING_METHOD == "explod" && !_loc5.fullLoaded))
        {
            this._oSettingFrames[nCellNum] = frame;
        }
        else if (ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
        {
            for (var s in _loc5)
            {
                if (_loc5[s] instanceof MovieClip)
                {
                    _loc5[s].gotoAndStop(frame);
                } // end if
            } // end of for...in
        }
        else
        {
            _loc5.gotoAndStop(frame);
        } // end else if
    };
    _loc1.setObjectExternalFrame = function (nCellNum, frame)
    {
        if (typeof(frame) == "number" && frame < 1)
        {
            ank.utils.Logger.err("[setObject2Frame] frame " + frame + " incorecte");
            return;
        } // end if
        if (nCellNum > this.getCellCount())
        {
            ank.utils.Logger.err("[setObject2Frame] Cellule " + nCellNum + " inexistante");
            return;
        } // end if
        var _loc4 = this._oDatacenter.Map.data[nCellNum];
        var _loc5 = _loc4.mcObjectExternal._mcExternal;
        _loc5.gotoAndStop(frame);
    };
    _loc1.setObject2Interactive = function (nCellNum, bInteractive, nPermanentLevel)
    {
        if (nCellNum > this.getCellCount())
        {
            ank.utils.Logger.err("[setObject2State] Cellule " + nCellNum + " inexistante");
            return;
        } // end if
        var _loc5 = this._oDatacenter.Map.data[nCellNum];
        _loc5.mcObject2.select(false);
        var _loc6 = new ank.battlefield.datacenter.Cell();
        _loc6.layerObject2Interactive = bInteractive;
        this.updateCell(nCellNum, _loc6, "1", nPermanentLevel);
    };
    _loc1.getCellCount = function (Void)
    {
        return (this._oDatacenter.Map.data.length);
    };
    _loc1.getCellData = function (nCellNum)
    {
        return (this._oDatacenter.Map.data[nCellNum]);
    };
    _loc1.getCellsData = function (Void)
    {
        return (this._oDatacenter.Map.data);
    };
    _loc1.getWidth = function (Void)
    {
        return (this._oDatacenter.Map.width);
    };
    _loc1.getHeight = function (Void)
    {
        return (this._oDatacenter.Map.height);
    };
    _loc1.getCaseNum = function (nX, nY)
    {
        var _loc4 = this.getWidth();
        return (nX * _loc4 + nY * (_loc4 - 1));
    };
    _loc1.getCellHeight = function (nCellNum)
    {
        var _loc3 = this.getCellData(nCellNum);
        var _loc4 = _loc3.groundSlope == undefined || _loc3.groundSlope == 1 ? (0) : (5.000000E-001);
        var _loc5 = _loc3.groundLevel == undefined ? (0) : (_loc3.groundLevel - 7);
        return (_loc5 + _loc4);
    };
    _loc1.getLayerByCellPropertyName = function (oCellPropertyName)
    {
        var _loc3 = new Array();
        for (var i in this._oDatacenter.Map.data)
        {
            _loc3.push(this._oDatacenter.Map.data[i][oCellPropertyName]);
        } // end of for...in
        return (_loc3);
    };
    _loc1.resetEmptyCells = function ()
    {
        var _loc2 = this._mcBattlefield.spriteHandler.getSprites().getItems();
        var _loc3 = new Array();
        for (var k in _loc2)
        {
            _loc3[_loc2[k].cellNum] = true;
        } // end of for...in
        var _loc4 = this.getCellCount();
        var _loc5 = 0;
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc4)
        {
            if (_loc3[_loc6] != true)
            {
                var _loc7 = this._mcBattlefield.mapHandler.getCellData(_loc6);
                _loc5 = _loc5 + _loc7.spriteOnCount;
                _loc7.removeAllSpritesOnID();
            } // end if
        } // end while
        if (_loc5 > 0)
        {
        } // end if
    };
    _loc1.adjustAndMaskMap = function ()
    {
        if (this._nAdjustTimer != undefined)
        {
            _global.clearInterval(this._nAdjustTimer);
            this._nAdjustTimer = undefined;
        } // end if
        this._mcContainer.applyMask(true);
        this._mcContainer.adjusteMap();
    };
    _loc1.onLoadInit = function (mc)
    {
        --this._nLoadRequest;
        if (this._oLoadingCells[mc] == undefined)
        {
            return;
        } // end if
        var _loc3 = String(mc).split(".");
        var _loc4 = _loc3[_loc3.length - 2];
        var _loc5 = this._oLoadingCells[mc];
        switch (_loc4)
        {
            case "Ground":
            {
                mc.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Ground"];
                mc._x = Number(_loc5.x);
                mc._y = Number(_loc5.y);
                if (_loc5.groundSlope == 1 && _loc5.layerGroundRot != 0)
                {
                    mc._rotation = _loc5.layerGroundRot * 90;
                    if (mc._rotation % 180)
                    {
                        mc._yscale = 1.928600E+002;
                        mc._xscale = 5.185000E+001;
                    }
                    else
                    {
                        mc._yscale = mc._xscale = 100;
                    } // end else if
                }
                else
                {
                    mc._rotation = 0;
                    mc._yscale = mc._xscale = 100;
                } // end else if
                if (_loc5.layerGroundFlip)
                {
                    mc._xscale = mc._xscale * -1;
                }
                else
                {
                    mc._xscale = mc._xscale * 1;
                } // end else if
                if (_loc5.groundSlope != 1)
                {
                    mc.gotoAndStop(_loc5.groundSlope);
                } // end if
                mc.lastGroundID = _loc5.layerGroundNum;
                break;
            } 
            case "Object1":
            {
                mc.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Object1"];
                mc._x = Number(_loc5.x);
                mc._y = Number(_loc5.y);
                if (_loc5.groundSlope == 1 && _loc5.layerObject1Rot != 0)
                {
                    mc._rotation = _loc5.layerObject1Rot * 90;
                    if (mc._rotation % 180)
                    {
                        mc._yscale = 1.928600E+002;
                        mc._xscale = 5.185000E+001;
                    }
                    else
                    {
                        mc._yscale = mc._xscale = 100;
                    } // end else if
                }
                else
                {
                    mc._rotation = 0;
                    mc._yscale = mc._xscale = 100;
                } // end else if
                if (_loc5.layerObject1Flip)
                {
                    mc._xscale = mc._xscale * -1;
                }
                else
                {
                    mc._xscale = mc._xscale * 1;
                } // end else if
                mc.lastObject1ID = _loc5.layerObject1Num;
                break;
            } 
            case "Object2":
            {
                mc.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Object2"];
                mc._x = Number(_loc5.x);
                mc._y = Number(_loc5.y);
                if (_loc5.layerObject2Interactive)
                {
                    mc.__proto__ = ank.battlefield.mc.InteractiveObject.prototype;
                    mc.initialize(this._mcBattlefield, _loc5, true);
                }
                else
                {
                    mc.__proto__ = MovieClip.prototype;
                } // end else if
                if (_loc5.layerObject2Flip)
                {
                    mc._xscale = -100;
                }
                else
                {
                    mc._xscale = 100;
                } // end else if
                mc.lastObject2ID = _loc5.layerObject2Num;
                break;
            } 
        } // End of switch
        if (this._oSettingFrames[_loc5.num] != undefined)
        {
            var _loc6 = this._oDatacenter.Map.data[_loc5.num].mcObject2;
            for (var s in _loc6)
            {
                if (_loc6[s] instanceof MovieClip)
                {
                    _loc6[s].gotoAndStop(this._oSettingFrames[_loc5.num]);
                } // end if
            } // end of for...in
            delete this._oSettingFrames[_loc5.num];
        } // end if
        mc.fullLoaded = true;
        delete this._oLoadingCells[mc];
    };
    _loc1.addProperty("LoaderRequestLeft", _loc1.__get__LoaderRequestLeft, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.battlefield.MapHandler = function (b, c, d)
    {
        if (b != undefined)
        {
            this.initialize(b, c, d);
        } } // end if
        this._mclLoader.addListener(this);
    }).OBJECT_TYPE_BACKGROUND = 1;
    (_global.ank.battlefield.MapHandler = function (b, c, d)
    {
        if (b != undefined)
        {
            this.initialize(b, c, d);
        } } } // end if
        this._mclLoader.addListener(this);
    }).OBJECT_TYPE_GROUND = 2;
    (_global.ank.battlefield.MapHandler = function (b, c, d)
    {
        if (b != undefined)
        {
            this.initialize(b, c, d);
        } } } } // end if
        this._mclLoader.addListener(this);
    }).OBJECT_TYPE_OBJECT1 = 3;
    (_global.ank.battlefield.MapHandler = function (b, c, d)
    {
        if (b != undefined)
        {
            this.initialize(b, c, d);
        } } } } } // end if
        this._mclLoader.addListener(this);
    }).OBJECT_TYPE_OBJECT2 = 4;
    (_global.ank.battlefield.MapHandler = function (b, c, d)
    {
        if (b != undefined)
        {
            this.initialize(b, c, d);
        } } } } } } // end if
        this._mclLoader.addListener(this);
    }).TIME_BEFORE_AJUSTING_MAP = 500;
    _loc1._oLoadingCells = new Object();
    _loc1._oSettingFrames = new Object();
    _loc1._mclLoader = new MovieClipLoader();
    _loc1._nMaxMapRender = 1;
} // end if
#endinitclip
