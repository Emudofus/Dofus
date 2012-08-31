// Action script...

// [Initial MovieClip Action of sprite 846]
#initclip 58
class ank.battlefield.MapHandler
{
    var _mcBattlefield, _oDatacenter, _mcContainer;
    function MapHandler(b, c, d)
    {
        this.initialize(b, c, d);
    } // End of the function
    function initialize(b, c, d)
    {
        _mcBattlefield = b;
        _oDatacenter = d;
        _mcContainer = c;
    } // End of the function
    function buildMulti(oMap, nCoordX, nCoordY)
    {
        var _loc20 = ank.battlefield.Constants.CELL_WIDTH;
        var _loc19 = ank.battlefield.Constants.CELL_HALF_WIDTH;
        var _loc21 = ank.battlefield.Constants.CELL_HALF_HEIGHT;
        var _loc22 = ank.battlefield.Constants.LEVEL_HEIGHT;
        var _loc16 = _mcContainer.maxDepth;
        var _loc25 = _mcContainer.minDepth + 1;
        var _loc17 = ank.battlefield.Constants.CELL_WIDTH * (oMap.width - 1) * nCoordX;
        var _loc15 = ank.battlefield.Constants.CELL_HEIGHT * (oMap.height - 1) * nCoordY;
        var _loc8 = -1;
        var _loc14 = 0;
        var _loc7 = 0;
        var _loc18 = oMap.data;
        var _loc23 = _loc18.length;
        var _loc11 = _mcContainer.ExternalContainer;
        var _loc13 = oMap.width - 1;
        if (oMap.backgroundNum != 0)
        {
            var _loc4 = _loc11.Ground.attach(oMap.backgroundNum, "bg" + _loc25, _loc25);
            _loc4._x = _loc17;
            _loc4._y = _loc15;
        } // end if
        var _loc12 = -1;
        while (++_loc12 < _loc23)
        {
            var _loc3 = _loc16 + _loc12;
            if (_loc8 == _loc13)
            {
                _loc8 = 0;
                _loc14 = _loc14 + 1;
                if (_loc7 == 0)
                {
                    _loc7 = _loc19;
                    _loc13 = _loc13 - 1;
                }
                else
                {
                    _loc7 = 0;
                    _loc13 = _loc13 + 1;
                } // end else if
            }
            else
            {
                ++_loc8;
            } // end else if
            var _loc2 = _loc18[_loc12];
            if (_loc2.active)
            {
                var _loc6 = _loc17 + _loc8 * _loc20 + _loc7;
                var _loc5 = _loc15 + _loc14 * _loc21 - _loc22 * (_loc2.groundLevel - 7);
                if (_loc2.layerGroundNum != 0)
                {
                    _loc4 = _loc11.Ground.attach(_loc2.layerGroundNum, "cell" + _loc3, _loc3);
                    _loc4._x = _loc6;
                    _loc4._y = _loc5;
                    var _loc9 = _loc2.layerGroundRot;
                    if (_loc2.groundSlope != 1)
                    {
                        _loc4.gotoAndStop(_loc2.groundSlope);
                    }
                    else if (_loc9 != 0)
                    {
                        var _loc10 = _loc9 * 90;
                        if (_loc10 % 180)
                        {
                            _loc4._yscale = 1.928600E+002;
                            _loc4._xscale = 5.185000E+001;
                        } // end if
                        _loc4._rotation = _loc10;
                    } // end else if
                    if (_loc2.layerGroundFlip)
                    {
                        _loc4._xscale = _loc4._xscale * -1;
                    } // end if
                } // end if
                if (_loc2.layerObject1Num != 0)
                {
                    _loc4 = _loc11.Object1.attachMovie(_loc2.layerObject1Num, "cell" + _loc3, _loc3);
                    _loc4._x = _loc6;
                    _loc4._y = _loc5;
                    _loc9 = _loc2.layerObject1Rot;
                    if (_loc2.groundSlope == 1 && _loc9 != 0)
                    {
                        _loc4._rotation = _loc9 * 90;
                        if (_loc4._rotation % 180)
                        {
                            _loc4._yscale = 1.928600E+002;
                            _loc4._xscale = 5.185000E+001;
                        } // end if
                    } // end if
                    if (_loc2.layerObject1Flip)
                    {
                        _loc4._xscale = _loc4._xscale * -1;
                    } // end if
                } // end if
                if (_loc2.layerObject2Num != 0)
                {
                    _loc4 = _loc11.Object2.attachMovie(_loc2.layerObject2Num, "cell" + _loc3, _loc3);
                    _loc4._x = _loc6;
                    _loc4._y = _loc5;
                    if (_loc2.layerObject2Flip)
                    {
                        _loc4._xscale = _loc4._xscale * -1;
                    } // end if
                } // end if
            } // end if
        } // end while
        _mcContainer.maxDepth = _loc16 + _loc12;
        _mcContainer.nMinDepth = _loc25;
    } // End of the function
    function build(oMap, nCellNum, bBuildAll)
    {
        _oDatacenter.Map = oMap;
        var _loc12 = ank.battlefield.Constants.CELL_WIDTH;
        var _loc20 = ank.battlefield.Constants.CELL_HALF_WIDTH;
        var _loc13 = ank.battlefield.Constants.CELL_HALF_HEIGHT;
        var _loc21 = ank.battlefield.Constants.LEVEL_HEIGHT;
        var _loc7 = -1;
        var _loc11 = 0;
        var _loc6 = 0;
        var _loc19 = oMap.data;
        var _loc22 = _loc19.length;
        var _loc10 = oMap.width - 1;
        var _loc4 = _mcContainer.ExternalContainer;
        var _loc18 = nCellNum != undefined;
        if (oMap.backgroundNum != 0)
        {
            _loc4.Ground.attach(oMap.backgroundNum, "background", -1);
        } // end if
        var _loc3 = -1;
        while (++_loc3 < _loc22)
        {
            if (_loc7 == _loc10)
            {
                _loc7 = 0;
                _loc11 = _loc11 + 1;
                if (_loc6 == 0)
                {
                    _loc6 = _loc20;
                    _loc10 = _loc10 - 1;
                }
                else
                {
                    _loc6 = 0;
                    _loc10 = _loc10 + 1;
                } // end else if
            }
            else
            {
                ++_loc7;
            } // end else if
            if (_loc18)
            {
                if (_loc3 < nCellNum)
                {
                    continue;
                }
                else if (_loc3 > nCellNum)
                {
                    return;
                } // end if
            } // end else if
            var _loc2 = _loc19[_loc3];
            if (_loc2.active)
            {
                var _loc9 = _loc7 * _loc12 + _loc6;
                var _loc8 = _loc11 * _loc13 - _loc21 * (_loc2.groundLevel - 7);
                _loc2.x = _loc9;
                _loc2.y = _loc8;
                if (_loc2.movement || bBuildAll)
                {
                    var _loc5 = _loc4.InteractionCell.attachMovie("i" + _loc2.groundSlope, "cell" + _loc3, _loc3, {_x: _loc9, _y: _loc8});
                    _loc5.__proto__ = ank.battlefield.mc.Cell.prototype;
                    _loc5.initialize(_mcBattlefield);
                    _loc2.mc = _loc5;
                    _loc5.data = _loc2;
                }
                else
                {
                    _loc4.InteractionCell["cell" + _loc3].removeMovieClip();
                } // end else if
                if (_loc2.layerGroundNum != 0)
                {
                    _loc5 = _loc4.Ground.attach(_loc2.layerGroundNum, "cell" + _loc3, _loc3);
                    _loc5._x = _loc9;
                    _loc5._y = _loc8;
                    if (_loc2.groundSlope != 1)
                    {
                        _loc5.gotoAndStop(_loc2.groundSlope);
                    }
                    else if (_loc2.layerGroundRot != 0)
                    {
                        _loc5._rotation = _loc2.layerGroundRot * 90;
                        if (_loc5._rotation % 180)
                        {
                            _loc5._yscale = 1.928600E+002;
                            _loc5._xscale = 5.185000E+001;
                        } // end if
                    } // end else if
                    if (_loc2.layerGroundFlip)
                    {
                        _loc5._xscale = _loc5._xscale * -1;
                    } // end if
                    _loc5.cacheAsBitmap = true;
                }
                else
                {
                    _loc4.Ground.clips["cell" + _loc3].removeMovieClip();
                } // end else if
                if (_loc2.layerObject1Num != 0)
                {
                    _loc5 = _loc4.Object1.attachMovie(_loc2.layerObject1Num, "cell" + _loc3, _loc3);
                    _loc5._x = _loc9;
                    _loc5._y = _loc8;
                    if (_loc2.groundSlope == 1 && _loc2.layerObject1Rot != 0)
                    {
                        _loc5._rotation = _loc2.layerObject1Rot * 90;
                        if (_loc5._rotation % 180)
                        {
                            _loc5._yscale = 1.928600E+002;
                            _loc5._xscale = 5.185000E+001;
                        } // end if
                    } // end if
                    if (_loc2.layerObject1Flip)
                    {
                        _loc5._xscale = _loc5._xscale * -1;
                    } // end if
                    _loc5.cacheAsBitmap = true;
                }
                else
                {
                    _loc4.Object1["cell" + _loc3].removeMovieClip();
                } // end else if
                if (_loc2.layerObjectExternal != "")
                {
                    _loc5 = _loc4.Object2.attachClassMovie(ank.battlefield.mc.InteractiveObject, "cellExt" + _loc3, _loc3 * 100 + 1);
                    _loc5.initialize(_mcBattlefield, _loc2, _loc2.layerObjectExternalInteractive);
                    _loc5.loadExternalClip(_loc2.layerObjectExternal);
                    _loc5._x = _loc9;
                    _loc5._y = _loc8;
                    _loc5.cacheAsBitmap = true;
                }
                else
                {
                    _loc4.Object2["cellExt" + _loc3].removeMovieClip();
                } // end else if
                if (_loc2.layerObject2Num != 0)
                {
                    _loc5 = _loc4.Object2.attachMovie(_loc2.layerObject2Num, "cell" + _loc3, _loc3 * 100);
                    if (_loc2.layerObject2Interactive)
                    {
                        _loc5.__proto__ = ank.battlefield.mc.InteractiveObject.prototype;
                        _loc5.initialize(_mcBattlefield, _loc2, true);
                    } // end if
                    _loc5._x = _loc9;
                    _loc5._y = _loc8;
                    if (_loc2.layerObject2Flip)
                    {
                        _loc5._xscale = -100;
                    } // end if
                    _loc2.mcObject2 = _loc5;
                    _loc5.cacheAsBitmap = true;
                }
                else
                {
                    _loc4.Object2["cell" + _loc3].removeMovieClip();
                    delete _loc2.mcObject2;
                } // end else if
                continue;
            } // end if
            if (bBuildAll)
            {
                _loc9 = _loc7 * _loc12 + _loc6;
                _loc8 = _loc11 * _loc13;
                _loc2.x = _loc9;
                _loc2.y = _loc8;
                _loc5 = _loc4.InteractionCell.attachMovie("i1", "cell" + _loc3, _loc3, {_x: _loc9, _y: _loc8});
                _loc5.__proto__ = ank.battlefield.mc.Cell.prototype;
                _loc5.initialize(_mcBattlefield);
                _loc2.mc = _loc5;
                _loc5.data = _loc2;
            } // end if
        } // end while
        if (!_loc18)
        {
            _mcContainer.applyMask();
            _mcContainer.adjusteMap();
        } // end if
    } // End of the function
    function updateCell(nCellNum, oNewCell, sMaskHex, nPermanentLevel)
    {
        if (nCellNum > this.getCellCount())
        {
            ank.utils.Logger.err("[updateCell] Cellule " + nCellNum + " inexistante");
            return;
        } // end if
        if (nPermanentLevel == undefined || isNaN(nPermanentLevel))
        {
            nPermanentLevel = 0;
        }
        else
        {
            nPermanentLevel = Number(nPermanentLevel);
        } // end else if
        var _loc3 = parseInt(sMaskHex, 16);
        var _loc23 = (_loc3 & 32768) != 0;
        var _loc20 = (_loc3 & 16384) != 0;
        var _loc10 = (_loc3 & 8192) != 0;
        var _loc18 = (_loc3 & 4096) != 0;
        var _loc12 = (_loc3 & 2048) != 0;
        var _loc24 = (_loc3 & 1024) != 0;
        var _loc11 = (_loc3 & 512) != 0;
        var _loc21 = (_loc3 & 256) != 0;
        var _loc13 = (_loc3 & 128) != 0;
        var _loc19 = (_loc3 & 64) != 0;
        var _loc15 = (_loc3 & 32) != 0;
        var _loc22 = (_loc3 & 16) != 0;
        var _loc14 = (_loc3 & 8) != 0;
        var _loc17 = (_loc3 & 4) != 0;
        var _loc9 = (_loc3 & 2) != 0;
        var _loc16 = (_loc3 & 1) != 0;
        var _loc2 = _oDatacenter.Map.data[nCellNum];
        if (nPermanentLevel > 0)
        {
            if (_loc2.nPermanentLevel == 0)
            {
                var _loc5 = new ank.battlefield.datacenter.Cell();
                for (var _loc7 in _loc2)
                {
                    _loc5[_loc7] = _loc2[_loc7];
                } // end of for...in
                _oDatacenter.Map.originalsCellsBackup.addItemAt(nCellNum, _loc5);
                _loc2.nPermanentLevel = nPermanentLevel;
            } // end if
        } // end if
        if (_loc10)
        {
            _loc2.active = oNewCell.active;
        } // end if
        if (_loc18)
        {
            _loc2.lineOfSight = oNewCell.lineOfSight;
        } // end if
        if (_loc12)
        {
            _loc2.movement = oNewCell.movement;
        } // end if
        if (_loc24)
        {
            _loc2.groundLevel = oNewCell.groundLevel;
        } // end if
        if (_loc11)
        {
            _loc2.groundSlope = oNewCell.groundSlope;
        } // end if
        if (_loc21)
        {
            _loc2.layerGroundNum = oNewCell.layerGroundNum;
        } // end if
        if (_loc13)
        {
            _loc2.layerGroundFlip = oNewCell.layerGroundFlip;
        } // end if
        if (_loc19)
        {
            _loc2.layerGroundRot = oNewCell.layerGroundRot;
        } // end if
        if (_loc15)
        {
            _loc2.layerObject1Num = oNewCell.layerObject1Num;
        } // end if
        if (_loc14)
        {
            _loc2.layerObject1Rot = oNewCell.layerObject1Rot;
        } // end if
        if (_loc22)
        {
            _loc2.layerObject1Flip = oNewCell.layerObject1Flip;
        } // end if
        if (_loc9)
        {
            _loc2.layerObject2Flip = oNewCell.layerObject2Flip;
        } // end if
        if (_loc16)
        {
            _loc2.layerObject2Interactive = oNewCell.layerObject2Interactive;
        } // end if
        if (_loc17)
        {
            _loc2.layerObject2Num = oNewCell.layerObject2Num;
        } // end if
        if (_loc20)
        {
            _loc2.layerObjectExternal = oNewCell.layerObjectExternal;
        } // end if
        if (_loc23)
        {
            _loc2.layerObjectExternalInteractive = oNewCell.layerObjectExternalInteractive;
        } // end if
        this.build(_oDatacenter.Map, nCellNum);
    } // End of the function
    function initializeMap(nPermanentLevel)
    {
        if (nPermanentLevel == undefined)
        {
            nPermanentLevel = Number.POSITIVE_INFINITY;
        }
        else
        {
            nPermanentLevel = Number(nPermanentLevel);
        } // end else if
        var _loc5 = _oDatacenter.Map;
        var _loc6 = _loc5.data;
        var _loc3 = _loc5.originalsCellsBackup.getItems();
        for (var _loc4 in _loc3)
        {
            this.initializeCell(Number(_loc4), nPermanentLevel);
        } // end of for...in
    } // End of the function
    function initializeCell(nCellNum, nPermanentLevel)
    {
        if (nPermanentLevel == undefined)
        {
            nPermanentLevel = Number.POSITIVE_INFINITY;
        }
        else
        {
            nPermanentLevel = Number(nPermanentLevel);
        } // end else if
        var _loc2 = _oDatacenter.Map;
        var _loc6 = _loc2.data;
        var _loc5 = _loc2.originalsCellsBackup.getItemAt(String(nCellNum));
        if (_loc5 == undefined)
        {
            ank.utils.Logger.err("La case est déjà dans son état init");
            return;
        } // end if
        if (_loc6[nCellNum].nPermanentLevel <= nPermanentLevel)
        {
            _loc6[nCellNum] = _loc5;
            this.build(_loc2, nCellNum);
            _loc2.originalsCellsBackup.removeItemAt(String(nCellNum));
        } // end if
    } // End of the function
    function setObject2Frame(nCellNum, frame)
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
        var _loc5 = _oDatacenter.Map.data[nCellNum];
        var _loc3 = _loc5.mcObject2;
        _loc3.gotoAndStop(frame);
    } // End of the function
    function setObject2Interactive(nCellNum, bInteractive, nPermanentLevel)
    {
        if (nCellNum > this.getCellCount())
        {
            ank.utils.Logger.err("[setObject2State] Cellule " + nCellNum + " inexistante");
            return;
        } // end if
        var _loc4 = _oDatacenter.Map.data[nCellNum];
        _loc4.mcObject2.select(false);
        var _loc2 = new ank.battlefield.datacenter.Cell();
        _loc2.layerObject2Interactive = bInteractive;
        this.updateCell(nCellNum, _loc2, "1", nPermanentLevel);
    } // End of the function
    function getCellCount(Void)
    {
        return (_oDatacenter.Map.data.length);
    } // End of the function
    function getCellData(nCellNum)
    {
        return (_oDatacenter.Map.data[nCellNum]);
    } // End of the function
    function getCellsData(Void)
    {
        return (_oDatacenter.Map.data);
    } // End of the function
    function getWidth(Void)
    {
        return (_oDatacenter.Map.width);
    } // End of the function
    function getHeight(Void)
    {
        return (_oDatacenter.Map.height);
    } // End of the function
    function getCaseNum(nX, nY)
    {
        var _loc2 = this.getWidth();
        return (nX * _loc2 + nY * (_loc2 - 1));
    } // End of the function
    function getCellHeight(nCellNum)
    {
        var _loc2 = this.getCellData(nCellNum);
        var _loc3 = _loc2.groundSlope == undefined || _loc2.groundSlope == 1 ? (0) : (5.000000E-001);
        var _loc4 = _loc2.groundLevel == undefined ? (0) : (_loc2.groundLevel - 7);
        return (_loc4 + _loc3);
    } // End of the function
    function getLayerByCellPropertyName(oCellPropertyName)
    {
        var _loc2 = new Array();
        for (var _loc4 in _oDatacenter.Map.data)
        {
            _loc2.push(_oDatacenter.Map.data[_loc4][oCellPropertyName]);
        } // end of for...in
        return (_loc2);
    } // End of the function
} // End of Class
#endinitclip
