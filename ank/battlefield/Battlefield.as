// Action script...

// [Initial MovieClip Action of sprite 843]
#initclip 55
class ank.battlefield.Battlefield extends MovieClip
{
    var _bMapBuild, _nScreenWidth, __get__screenWidth, _nScreenHeight, __get__screenHeight, _oDatacenter, _sGroundFile, onInitError, attachClassMovie, _mcMainContainer, __get__isMapBuild, mapHandler, overHeadHandler, textHandler, pointsHandler, onMapLoaded, selectionHandler, interactionHandler, zoneHandler, pointerHandler, spriteHandler, gridHandler, visualEffectHandler, onInitComplete, onInitProgress, __set__screenHeight, __set__screenWidth;
    function Battlefield()
    {
        super();
    } // End of the function
    function get isMapBuild()
    {
        if (_bMapBuild)
        {
            return (true);
        } // end if
        ank.utils.Logger.err("[isMapBuild] Carte non chargée");
        return (false);
    } // End of the function
    function set screenWidth(nScreenWidth)
    {
        _nScreenWidth = nScreenWidth;
        //return (this.screenWidth());
        null;
    } // End of the function
    function get screenWidth()
    {
        return (_nScreenWidth == undefined ? (ank.battlefield.Constants.DISPLAY_WIDTH) : (_nScreenWidth));
    } // End of the function
    function set screenHeight(nScreenHeight)
    {
        _nScreenHeight = nScreenHeight;
        //return (this.screenHeight());
        null;
    } // End of the function
    function get screenHeight()
    {
        return (_nScreenHeight == undefined ? (ank.battlefield.Constants.DISPLAY_HEIGHT) : (_nScreenHeight));
    } // End of the function
    function initialize(oDatacenter, sGroundFile, sObjectFile)
    {
        _oDatacenter = oDatacenter;
        _sGroundFile = sGroundFile;
        if (!this.initializeDatacenter())
        {
            ank.utils.Logger.err("BattleField -> Init datacenter impossible");
            this.onInitError();
        } // end if
        ank.utils.Extensions.addExtensions();
        if (_global.GAC == undefined)
        {
            _global.GAC = new ank.battlefield.GlobalSpriteHandler();
        } // end if
        this.attachClassMovie(ank.battlefield.mc.Container, "_mcMainContainer", 10, [this, _oDatacenter, sObjectFile]);
        _bMapBuild = false;
    } // End of the function
    function clear()
    {
        _mcMainContainer.clear();
        ank.utils.Timer.clear("battlefield");
        ank.utils.CyclicTimer.clear();
        this.initializeDatacenter();
        this.createHandlers();
        _bMapBuild = false;
    } // End of the function
    function setColor(t)
    {
        _mcMainContainer.setColor(t);
    } // End of the function
    function cleanMap(nPermanentLevel, bKeepData)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        if (nPermanentLevel == undefined)
        {
            nPermanentLevel = Number.POSITIVE_INFINITY;
        }
        else
        {
            nPermanentLevel = Number(nPermanentLevel);
        } // end else if
        mapHandler.initializeMap(nPermanentLevel);
        this.unSelect(true);
        this.clearAllZones();
        this.clearPointer();
        this.removeGrid();
        this.clearAllSprites(bKeepData);
        overHeadHandler.clear();
        textHandler.clear();
        pointsHandler.clear();
        ank.utils.Timer.clean();
        ank.utils.CyclicTimer.clear();
    } // End of the function
    function getZoom()
    {
        return (_mcMainContainer.getZoom());
    } // End of the function
    function showContainer(bool)
    {
        _mcMainContainer._visible = bool;
    } // End of the function
    function zoom(nFactor)
    {
        _mcMainContainer.zoom(nFactor);
    } // End of the function
    function buildMapFromObject(oMap, bBuildAll)
    {
        this.clear();
        if (oMap == undefined)
        {
            return;
        } // end if
        mapHandler.build(oMap, undefined, bBuildAll);
        _bMapBuild = true;
        this.onMapLoaded();
    } // End of the function
    function buildMap(nID, sName, nWidth, nHeight, nBackID, sCompressedData, oMap, bBuildAll)
    {
        if (oMap == undefined)
        {
            oMap = new ank.battlefield.datacenter.Map();
        } // end if
        ank.battlefield.utils.Compressor.uncompressMap(nID, sName, nWidth, nHeight, nBackID, sCompressedData, oMap, bBuildAll);
        this.buildMapFromObject(oMap, bBuildAll);
    } // End of the function
    function buildMultiMap(nW, nH, nBgID, sData, nCoordX, nCoordY, oMap)
    {
        if (oMap == undefined)
        {
            oMap = new ank.battlefield.datacenter.Map();
        } // end if
        ank.battlefield.utils.Compressor.uncompressMap(null, null, nW, nH, nBgID, sData, oMap);
        mapHandler.buildMulti(oMap, nCoordX, nCoordY);
        _bMapBuild = true;
        this.onMapLoaded();
    } // End of the function
    function updateCell(nCellNum, sCompressData, sMaskHexStr, nPermanentLevel)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        if (sCompressData == undefined)
        {
            mapHandler.initializeCell(nCellNum, Number.POSITIVE_INFINITY);
        }
        else
        {
            var _loc2 = ank.battlefield.utils.Compressor.uncompressCell(sCompressData, true);
            mapHandler.updateCell(nCellNum, _loc2, sMaskHexStr, nPermanentLevel);
        } // end else if
    } // End of the function
    function setObject2Frame(nCellNum, frame)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        mapHandler.setObject2Frame(nCellNum, frame);
    } // End of the function
    function setObject2Interactive(nCellNum, bInteractive, nPermanentLevel)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        mapHandler.setObject2Interactive(nCellNum, bInteractive, nPermanentLevel);
    } // End of the function
    function updateCellObjectExternalWithExternalClip(nCellNum, sFile, nPermanentLevel)
    {
        var _loc2 = new ank.battlefield.datacenter.Cell();
        _loc2.layerObjectExternal = sFile;
        _loc2.layerObjectExternalInteractive = true;
        mapHandler.updateCell(nCellNum, _loc2, "C000", nPermanentLevel);
    } // End of the function
    function initializeCell(nCellNum, nPermanentLevel)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        mapHandler.initializeCell(nCellNum, nPermanentLevel);
    } // End of the function
    function select(cellList, nColor)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        if (typeof(cellList) == "object")
        {
            selectionHandler.selectMultiple(true, cellList, nColor);
        }
        else if (typeof(cellList) == "number")
        {
            selectionHandler.select(true, cellList, nColor);
        } // end else if
    } // End of the function
    function unSelect(bAll, cellList)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        if (bAll)
        {
            selectionHandler.clear();
        }
        else if (typeof(cellList) == "object")
        {
            selectionHandler.selectMultiple(false, cellList);
        }
        else if (typeof(cellList) == "number")
        {
            selectionHandler.select(false, cellList);
        } // end else if
    } // End of the function
    function setInteraction(nState)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        interactionHandler.setEnabled(nState);
    } // End of the function
    function setInteractionOnCell(nCellNum, nState)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        interactionHandler.setEnabledCell(nCellNum, nState);
    } // End of the function
    function setInteractionOnCells(aCells, nState)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        for (var _loc4 in aCells)
        {
            interactionHandler.setEnabledCell(aCells[_loc4], nState);
        } // end of for...in
    } // End of the function
    function drawZone(nCellNum, nRadiusIn, nRadiusOut, sLayer, nColor, sShape)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        zoneHandler.drawZone(nCellNum, nRadiusIn, nRadiusOut, sLayer, nColor, sShape);
    } // End of the function
    function clearZone(nCellNum, nRadius, sLayer)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        zoneHandler.clearZone(nCellNum, nRadius, sLayer);
    } // End of the function
    function clearZoneLayer(sLayer)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        zoneHandler.clearZoneLayer(sLayer);
    } // End of the function
    function clearAllZones(Void)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        zoneHandler.clear();
    } // End of the function
    function clearPointer(Void)
    {
        pointerHandler.clear();
    } // End of the function
    function hidePointer(Void)
    {
        pointerHandler.hide();
    } // End of the function
    function addPointerShape(sShape, mSize, nColor, nCellNumRef)
    {
        pointerHandler.addShape(sShape, mSize, nColor, nCellNumRef);
    } // End of the function
    function drawPointer(nCellNum)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        pointerHandler.draw(nCellNum);
    } // End of the function
    function addSprite(sID, spriteData)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.addSprite(sID, spriteData);
    } // End of the function
    function addLinkedSprite(sID, sParentID, nChildIndex, oSprite)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.addLinkedSprite(sID, sParentID, nChildIndex, oSprite);
    } // End of the function
    function clearAllSprites(bKeepData)
    {
        spriteHandler.clear(bKeepData);
    } // End of the function
    function removeSprite(sID, bKeepData)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.removeSprite(sID, bKeepData);
    } // End of the function
    function hideSprite(sID, bool)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.hideSprite(sID, bool);
    } // End of the function
    function setSpritePosition(sID, nCellNum, dir)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.setSpritePosition(sID, nCellNum, dir);
    } // End of the function
    function setSpriteDirection(sID, nDir)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.setSpriteDirection(sID, nDir);
    } // End of the function
    function moveSprite(sID, compressedPath, oSeq, bClearSequencer, bForcedRun, bForcedWalk, nRunLimit)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        var _loc2 = ank.battlefield.utils.Compressor.extractFullPath(mapHandler, compressedPath);
        this.moveSpriteWithUncompressedPath(sID, _loc2, oSeq, bClearSequencer, bForcedRun, bForcedWalk, nRunLimit);
    } // End of the function
    function moveSpriteWithUncompressedPath(sID, aPath, oSeq, bClearSequencer, bForcedRun, bForcedWalk, nRunLimit)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        if (aPath != undefined)
        {
            spriteHandler.moveSprite(sID, aPath, oSeq, bClearSequencer, undefined, bForcedRun, bForcedWalk, nRunLimit);
        } // end if
    } // End of the function
    function slideSprite(sID, nCellNum, oSeq, sAnimation)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.slideSprite(sID, nCellNum, oSeq, sAnimation);
    } // End of the function
    function autoCalculateSpriteDirection(sID, nCellNum)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.autoCalculateSpriteDirection(sID, nCellNum);
    } // End of the function
    function convertHeightToFourSpriteDirection(sID)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.convertHeightToFourSpriteDirection(sID);
    } // End of the function
    function setForcedSpriteAnim(sID, sAnim)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.setSpriteAnim(sID, sAnim, true);
    } // End of the function
    function setSpriteAnim(sID, sAnim)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.setSpriteAnim(sID, sAnim);
    } // End of the function
    function setSpriteLoopAnim(sID, sAnim, nTimer)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.setSpriteLoopAnim(sID, sAnim, nTimer);
    } // End of the function
    function setSpriteTimerAnim(sID, sAnim, bForced, nTimer)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.setSpriteTimerAnim(sID, sAnim, bForced, nTimer);
    } // End of the function
    function setSpriteGfx(sID, sFile)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.setSpriteGfx(sID, sFile);
    } // End of the function
    function setSpriteColorTransform(sID, oTransform)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.setSpriteColorTransform(sID, oTransform);
    } // End of the function
    function spriteLaunchVisualEffect(sID, oEffectData, nCellNum, nDisplayType, mSpriteAnimation)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.launchVisualEffect(sID, oEffectData, nCellNum, nDisplayType, mSpriteAnimation);
    } // End of the function
    function selectSprite(sID, bSelect)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        spriteHandler.selectSprite(sID, bSelect);
    } // End of the function
    function addSpriteBubble(sID, sText)
    {
        var _loc2 = _oDatacenter.Sprites.getItemAt(sID);
        if (_loc2 == undefined)
        {
            ank.utils.Logger.err("[addSpriteBubble] Sprite inexistant");
            return;
        } // end if
        if (_loc2.__get__isInMove())
        {
            return;
        } // end if
        if (!_loc2.__get__isVisible())
        {
            return;
        } // end if
        var _loc3 = _loc2.mc;
        var _loc5 = _loc3._x;
        var _loc4 = _loc3._y;
        if (_loc5 == 0 || _loc4 == 0)
        {
            ank.utils.Logger.err("[addSpriteBubble] le sprite n\'est pas encore placé");
            return;
        } // end if
        textHandler.addBubble(sID, _loc5, _loc4, sText);
    } // End of the function
    function removeSpriteBubble(sID)
    {
        var _loc2 = _oDatacenter.Sprites.getItemAt(sID);
        if (_loc2 == undefined)
        {
            ank.utils.Logger.err("[hideSpriteBubble] Sprite inexistant");
            return;
        } // end if
        textHandler.removeBubble(sID);
    } // End of the function
    function addSpritePoints(sID, sValue, nColor)
    {
        var _loc2 = _oDatacenter.Sprites.getItemAt(sID);
        if (_loc2 == undefined)
        {
            ank.utils.Logger.err("[addSpritePoints] Sprite inexistant");
            return;
        } // end if
        if (!_loc2.__get__isVisible())
        {
            return;
        } // end if
        var _loc3 = _loc2.mc;
        var _loc5 = _loc3._x;
        var _loc4 = _loc3._y - ank.battlefield.Constants.DEFAULT_SPRITE_HEIGHT;
        if (_loc5 == 0 || _loc4 == 0)
        {
            ank.utils.Logger.err("[addSpritePoints] le sprite n\'est pas encore placé");
            return;
        } // end if
        pointsHandler.addPoints(sID, _loc5, _loc4, sValue, nColor);
    } // End of the function
    function addSpriteOverHeadItem(sID, sLayerName, className, aArgs, nDelay)
    {
        var _loc2 = _oDatacenter.Sprites.getItemAt(sID);
        if (_loc2 == undefined)
        {
            ank.utils.Logger.err("[addSpriteOverHeadItem] Sprite inexistant");
            return;
        } // end if
        if (_loc2.__get__isInMove())
        {
            return;
        } // end if
        if (!_loc2.__get__isVisible())
        {
            return;
        } // end if
        var _loc3 = _loc2.mc;
        var _loc5 = _loc3._x;
        var _loc4 = _loc3._y;
        overHeadHandler.addOverHeadItem(sID, _loc5, _loc4, _loc3, sLayerName, className, aArgs, nDelay);
    } // End of the function
    function removeSpriteOverHeadLayer(sID, sLayerName)
    {
        overHeadHandler.removeOverHeadLayer(sID, sLayerName);
    } // End of the function
    function hideSpriteOverHead(sID)
    {
        overHeadHandler.removeOverHead(sID);
    } // End of the function
    function addSpriteExtraClip(sID, sFile, nColor, bTop)
    {
        spriteHandler.addSpriteExtraClip(sID, sFile, nColor, bTop);
    } // End of the function
    function removeSpriteExtraClip(sID, bTop)
    {
        spriteHandler.removeSpriteExtraClip(sID, bTop);
    } // End of the function
    function showSpritePoints(sID, nValue, nColor)
    {
        spriteHandler.showSpritePoints(sID, nValue, nColor);
    } // End of the function
    function setSpriteGhostView(bool)
    {
        bGhostView = bool;
        spriteHandler.setSpriteGhostView(bool);
    } // End of the function
    function drawGrid(bAll)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        if (gridHandler.bGridVisible)
        {
            this.removeGrid();
        }
        else
        {
            gridHandler.draw(bAll);
        } // end else if
    } // End of the function
    function removeGrid(Void)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        gridHandler.clear();
    } // End of the function
    function addVisualEffectOnSprite(sID, oEffectData, nCellNum, nDisplayType)
    {
        if (!this.__get__isMapBuild())
        {
            return;
        } // end if
        var _loc2 = _oDatacenter.Sprites.getItemAt(sID);
        if (_loc2 == undefined)
        {
            ank.utils.Logger.err("[addVisualEffectOnSprite] Sprite inexistant");
            return;
        } // end if
        visualEffectHandler.addEffect(_loc2, oEffectData, nCellNum, nDisplayType);
    } // End of the function
    function initializeDatacenter(Void)
    {
        if (_oDatacenter == undefined)
        {
            return (false);
        } // end if
        _oDatacenter.Map.cleanSpritesOn();
        _oDatacenter.Map = new ank.battlefield.datacenter.Map();
        _oDatacenter.Sprites = new ank.utils.ExtendedObject();
        return (true);
    } // End of the function
    function createHandlers(Void)
    {
        mapHandler = new ank.battlefield.MapHandler(this, _mcMainContainer, _oDatacenter);
        spriteHandler = new ank.battlefield.SpriteHandler(this, _mcMainContainer.ExternalContainer.Object2, _oDatacenter.Sprites);
        interactionHandler = new ank.battlefield.InteractionHandler(_mcMainContainer.ExternalContainer.InteractionCell);
        zoneHandler = new ank.battlefield.ZoneHandler(this, _mcMainContainer.ExternalContainer.Zone);
        pointerHandler = new ank.battlefield.PointerHandler(this, _mcMainContainer.ExternalContainer.Pointer);
        selectionHandler = new ank.battlefield.SelectionHandler(this, _mcMainContainer.ExternalContainer.Select, _oDatacenter);
        gridHandler = new ank.battlefield.GridHandler(_mcMainContainer.ExternalContainer.Grid, _oDatacenter);
        visualEffectHandler = new ank.battlefield.VisualEffectHandler(this, _mcMainContainer.ExternalContainer.Object2);
        textHandler = new ank.battlefield.TextHandler(this, _mcMainContainer.Text, _oDatacenter);
        pointsHandler = new ank.battlefield.PointsHandler(this, _mcMainContainer.Points, _oDatacenter);
        overHeadHandler = new ank.battlefield.OverHeadHandler(this, _mcMainContainer.OverHead);
    } // End of the function
    function onLoadInit(mc)
    {
        if (mc._name != "Ground")
        {
            mc.__proto__ = ank.battlefield.mc.ExternalContainer.prototype;
            mc.initialize(_sGroundFile);
            this.createHandlers();
        }
        else
        {
            this.onInitComplete();
        } // end else if
    } // End of the function
    function onLoadError(mc)
    {
        this.onInitError();
    } // End of the function
    function onLoadProgress(mc, nBL, nBT)
    {
        this.onInitProgress(nBL, nBT);
    } // End of the function
    var bGhostView = false;
} // End of Class
#endinitclip
