// Action script...

// [Initial MovieClip Action of sprite 20609]
#initclip 130
if (!ank.battlefield.Battlefield)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.Battlefield = function ()
    {
        super();
    }).prototype;
    _loc1.__get__isMapBuild = function ()
    {
        if (this._bMapBuild)
        {
            return (true);
        } // end if
        ank.utils.Logger.err("[isMapBuild] Carte non chargée");
        return (false);
    };
    _loc1.__set__screenWidth = function (nScreenWidth)
    {
        this._nScreenWidth = nScreenWidth;
        //return (this.screenWidth());
    };
    _loc1.__get__screenWidth = function ()
    {
        return (this._nScreenWidth == undefined ? (ank.battlefield.Constants.DISPLAY_WIDTH) : (this._nScreenWidth));
    };
    _loc1.__set__screenHeight = function (nScreenHeight)
    {
        this._nScreenHeight = nScreenHeight;
        //return (this.screenHeight());
    };
    _loc1.__get__screenHeight = function ()
    {
        return (this._nScreenHeight == undefined ? (ank.battlefield.Constants.DISPLAY_HEIGHT) : (this._nScreenHeight));
    };
    _loc1.__set__isJumpActivate = function (bJumpActivate)
    {
        this._bJumpActivate = bJumpActivate;
        //return (this.isJumpActivate());
    };
    _loc1.__get__isJumpActivate = function ()
    {
        return (this._bJumpActivate);
    };
    _loc1.__get__container = function ()
    {
        return (this._mcMainContainer);
    };
    _loc1.__get__datacenter = function ()
    {
        return (this._oDatacenter);
    };
    _loc1.initialize = function (oDatacenter, sGroundFile, sObjectFile, sAccessoriesPath)
    {
        this._oDatacenter = oDatacenter;
        this._sGroundFile = sGroundFile;
        if (!this.initializeDatacenter())
        {
            ank.utils.Logger.err("BattleField -> Init datacenter impossible");
            this.onInitError();
        } // end if
        ank.utils.Extensions.addExtensions();
        if (_global.GAC == undefined)
        {
            _global.GAC = new ank.battlefield.GlobalSpriteHandler();
            _global.GAC.setAccessoriesRoot(sAccessoriesPath);
        } // end if
        this.attachClassMovie(ank.battlefield.mc.Container, "_mcMainContainer", 10, [this, this._oDatacenter, sObjectFile]);
        this._bMapBuild = false;
        this.loadManager = new ank.battlefield.LoadManager(this.createEmptyMovieClip("LoadManager", this.getNextHighestDepth()));
    };
    _loc1.setStreaming = function (status, objectsDir, groundsDir)
    {
        ank.battlefield.Constants.USE_STREAMING_FILES = status;
        ank.battlefield.Constants.STREAMING_OBJECTS_DIR = objectsDir;
        ank.battlefield.Constants.STREAMING_GROUNDS_DIR = groundsDir;
    };
    _loc1.setStreamingMethod = function (sName)
    {
        ank.battlefield.Constants.STREAMING_METHOD = sName;
    };
    _loc1.setCustomGfxFile = function (sPathGfxGround, sPathGfxObject)
    {
        if (sPathGfxGround && (sPathGfxGround != "" && this._sGroundFile != sPathGfxGround))
        {
            this._sGroundFile = sPathGfxGround;
            this._bUseCustomGroundGfxFile = true;
            this.bCustomFileLoaded = false;
        } // end if
        if (sPathGfxObject && (sPathGfxObject != "" && this._sObjectFile != sPathGfxObject))
        {
            this._mcMainContainer.initialize(this._mcMainContainer, this._oDatacenter, sPathGfxObject);
            this.bCustomFileLoaded = false;
            this._sObjectFile = sPathGfxObject;
        } // end if
    };
    _loc1.clear = function ()
    {
        this._mcMainContainer.clear();
        this._sGroundFile = "";
        this._sObjectFile = "";
        ank.utils.Timer.clear("battlefield");
        ank.utils.CyclicTimer.clear();
        this.initializeDatacenter();
        this.createHandlers();
        this._bMapBuild = false;
    };
    _loc1.setColor = function (t)
    {
        this._mcMainContainer.setColor(t);
    };
    _loc1.cleanMap = function (nPermanentLevel, bKeepData)
    {
        if (!this.isMapBuild)
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
        this.mapHandler.initializeMap(nPermanentLevel);
        this.unSelect(true);
        this.clearAllZones();
        this.clearPointer();
        this.removeGrid();
        this.clearAllSprites(bKeepData);
        this.overHeadHandler.clear();
        this.textHandler.clear();
        this.pointsHandler.clear();
        ank.utils.Timer.clean();
        ank.utils.CyclicTimer.clear();
    };
    _loc1.getZoom = function ()
    {
        return (this._mcMainContainer.getZoom());
    };
    _loc1.showContainer = function (bool)
    {
        this._mcMainContainer._visible = bool;
    };
    _loc1.zoom = function (nFactor)
    {
        this._mcMainContainer.zoom(nFactor);
    };
    _loc1.buildMapFromObject = function (oMap, bBuildAll)
    {
        this.clear();
        if (oMap == undefined)
        {
            return;
        } // end if
        this.onMapBuilding();
        this.mapHandler.build(oMap, undefined, bBuildAll);
        if (this.mapHandler.LoaderRequestLeft == 0)
        {
            this.DispatchMapLoaded();
        }
        else
        {
            this._nFrameLoadTimeOut = ank.battlefield.Battlefield.FRAMELOADTIMOUT;
            var ref = this;
            this.onEnterFrame = function ()
            {
                --ref._nFrameLoadTimeOut;
                if (ref._nFrameLoadTimeOut <= 0 || ref.mapHandler.LoaderRequestLeft <= 0)
                {
                    delete ref.onEnterFrame;
                    ref.DispatchMapLoaded();
                } // end if
            };
        } // end else if
    };
    _loc1.DispatchMapLoaded = function ()
    {
        this._bMapBuild = true;
        this.onMapLoaded();
    };
    _loc1.buildMap = function (nID, sName, nWidth, nHeight, nBackID, sCompressedData, oMap, bBuildAll)
    {
        if (oMap == undefined)
        {
            oMap = new ank.battlefield.datacenter.Map();
        } // end if
        ank.battlefield.utils.Compressor.uncompressMap(nID, sName, nWidth, nHeight, nBackID, sCompressedData, oMap, bBuildAll);
        this.buildMapFromObject(oMap, bBuildAll);
    };
    _loc1.updateCell = function (nCellNum, sCompressData, sMaskHexStr, nPermanentLevel)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        if (sCompressData == undefined)
        {
            this.mapHandler.initializeCell(nCellNum, Number.POSITIVE_INFINITY);
        }
        else
        {
            var _loc6 = ank.battlefield.utils.Compressor.uncompressCell(sCompressData, true);
            this.mapHandler.updateCell(nCellNum, _loc6, sMaskHexStr, nPermanentLevel);
        } // end else if
    };
    _loc1.setObject2Frame = function (nCellNum, frame)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.mapHandler.setObject2Frame(nCellNum, frame);
    };
    _loc1.setObject2Interactive = function (nCellNum, bInteractive, nPermanentLevel)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.mapHandler.setObject2Interactive(nCellNum, bInteractive, nPermanentLevel);
    };
    _loc1.updateCellObjectExternalWithExternalClip = function (nCellNum, sFile, nPermanentLevel, bInteractive, bAutoSize, oExternalData)
    {
        var _loc8 = new ank.battlefield.datacenter.Cell();
        _loc8.layerObjectExternal = sFile;
        _loc8.layerObjectExternalInteractive = bInteractive == undefined ? (true) : (bInteractive);
        _loc8.layerObjectExternalAutoSize = bAutoSize;
        _loc8.layerObjectExternalData = oExternalData;
        this.mapHandler.updateCell(nCellNum, _loc8, "1C000", nPermanentLevel);
    };
    _loc1.setObjectExternalFrame = function (nCellNum, frame)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.mapHandler.setObjectExternalFrame(nCellNum, frame);
    };
    _loc1.initializeCell = function (nCellNum, nPermanentLevel)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.mapHandler.initializeCell(nCellNum, nPermanentLevel);
    };
    _loc1.select = function (cellList, nColor, sLayer, nAlpha)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        if (typeof(cellList) == "object")
        {
            this.selectionHandler.selectMultiple(true, cellList, nColor, sLayer, nAlpha);
        }
        else if (typeof(cellList) == "number")
        {
            this.selectionHandler.select(true, cellList, nColor, sLayer, nAlpha);
        } // end else if
    };
    _loc1.unSelect = function (bAll, cellList, sLayer)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        if (bAll)
        {
            this.selectionHandler.clear();
        }
        else if (typeof(cellList) == "object")
        {
            this.selectionHandler.selectMultiple(false, cellList, undefined, sLayer);
        }
        else if (typeof(cellList) == "number")
        {
            this.selectionHandler.select(false, cellList, undefined, sLayer);
        }
        else if (sLayer != undefined)
        {
            this.selectionHandler.clearLayer(sLayer);
        } // end else if
    };
    _loc1.unSelectAllButOne = function (sLayer)
    {
        var _loc3 = this.selectionHandler.getLayers();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            if (_loc3[_loc4] != sLayer)
            {
                this.selectionHandler.clearLayer(_loc3[_loc4]);
            } // end if
        } // end while
    };
    _loc1.setInteraction = function (nState)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.interactionHandler.setEnabled(nState);
    };
    _loc1.setInteractionOnCell = function (nCellNum, nState)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.interactionHandler.setEnabledCell(nCellNum, nState);
    };
    _loc1.setInteractionOnCells = function (aCells, nState)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        for (var k in aCells)
        {
            this.interactionHandler.setEnabledCell(aCells[k], nState);
        } // end of for...in
    };
    _loc1.drawZone = function (nCellNum, nRadiusIn, nRadiusOut, sLayer, nColor, sShape)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.zoneHandler.drawZone(nCellNum, nRadiusIn, nRadiusOut, sLayer, nColor, sShape);
    };
    _loc1.clearZone = function (nCellNum, nRadius, sLayer)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.zoneHandler.clearZone(nCellNum, nRadius, sLayer);
    };
    _loc1.clearZoneLayer = function (sLayer)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.zoneHandler.clearZoneLayer(sLayer);
    };
    _loc1.clearAllZones = function (Void)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.zoneHandler.clear();
    };
    _loc1.clearPointer = function (Void)
    {
        this.pointerHandler.clear();
    };
    _loc1.hidePointer = function (Void)
    {
        this.pointerHandler.hide();
    };
    _loc1.addPointerShape = function (sShape, mSize, nColor, nCellNumRef)
    {
        this.pointerHandler.addShape(sShape, mSize, nColor, nCellNumRef);
    };
    _loc1.drawPointer = function (nCellNum)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.pointerHandler.draw(nCellNum);
    };
    _loc1.getSprite = function (sID)
    {
        return (this.spriteHandler.getSprite(sID));
    };
    _loc1.getSprites = function ()
    {
        return (this.spriteHandler.getSprites());
    };
    _loc1.addSprite = function (sID, spriteData)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.addSprite(sID, spriteData);
    };
    _loc1.addLinkedSprite = function (sID, sParentID, nChildIndex, oSprite)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.addLinkedSprite(sID, sParentID, nChildIndex, oSprite);
    };
    _loc1.carriedSprite = function (sID, sParentID)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.carriedSprite(sID, sParentID);
    };
    _loc1.uncarriedSprite = function (sID, nCellNum, bWithAnimation, oSeq)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.uncarriedSprite(sID, nCellNum, bWithAnimation, oSeq);
    };
    _loc1.mountSprite = function (sID, oMount)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.mountSprite(sID, oMount);
    };
    _loc1.unmountSprite = function (sID)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.unmountSprite(sID);
    };
    _loc1.clearAllSprites = function (bKeepData)
    {
        this.spriteHandler.clear(bKeepData);
    };
    _loc1.removeSprite = function (sID, bKeepData)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.removeSprite(sID, bKeepData);
    };
    _loc1.hideSprite = function (sID, bool)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.hideSprite(sID, bool);
    };
    _loc1.setSpritePosition = function (sID, nCellNum, dir)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.setSpritePosition(sID, nCellNum, dir);
    };
    _loc1.setSpriteDirection = function (sID, nDir)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.setSpriteDirection(sID, nDir);
    };
    _loc1.stopSpriteMove = function (sID, oSeq, nCellNum)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.stopSpriteMove(sID, oSeq, nCellNum);
    };
    _loc1.moveSprite = function (sID, compressedPath, oSeq, bClearSequencer, bForcedRun, bForcedWalk, nRunLimit)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        var _loc9 = ank.battlefield.utils.Compressor.extractFullPath(this.mapHandler, compressedPath);
        this.moveSpriteWithUncompressedPath(sID, _loc9, oSeq, bClearSequencer, bForcedRun, bForcedWalk, nRunLimit);
    };
    _loc1.moveSpriteWithUncompressedPath = function (sID, aPath, oSeq, bClearSequencer, bForcedRun, bForcedWalk, nRunLimit, sAnimation)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        if (aPath != undefined)
        {
            this.spriteHandler.moveSprite(sID, aPath, oSeq, bClearSequencer, sAnimation, bForcedRun, bForcedWalk, nRunLimit);
        } // end if
    };
    _loc1.slideSprite = function (sID, nCellNum, oSeq, sAnimation)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.slideSprite(sID, nCellNum, oSeq, sAnimation);
    };
    _loc1.autoCalculateSpriteDirection = function (sID, nCellNum)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.autoCalculateSpriteDirection(sID, nCellNum);
    };
    _loc1.convertHeightToFourSpriteDirection = function (sID)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.convertHeightToFourSpriteDirection(sID);
    };
    _loc1.setForcedSpriteAnim = function (sID, sAnim)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.setSpriteAnim(sID, sAnim, true);
    };
    _loc1.setSpriteAnim = function (sID, sAnim)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.setSpriteAnim(sID, sAnim);
    };
    _loc1.setSpriteLoopAnim = function (sID, sAnim, nTimer)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.setSpriteLoopAnim(sID, sAnim, nTimer);
    };
    _loc1.setSpriteTimerAnim = function (sID, sAnim, bForced, nTimer)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.setSpriteTimerAnim(sID, sAnim, bForced, nTimer);
    };
    _loc1.setSpriteGfx = function (sID, sFile)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.setSpriteGfx(sID, sFile);
    };
    _loc1.setSpriteColorTransform = function (sID, oTransform)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.setSpriteColorTransform(sID, oTransform);
    };
    _loc1.setSpriteAlpha = function (sID, nAlpha)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.setSpriteAlpha(sID, nAlpha);
    };
    _loc1.spriteLaunchVisualEffect = function (sID, oEffectData, nCellNum, nDisplayType, mSpriteAnimation, sTargetID, oSpriteToHideDuringAnimation, bForceVisible)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.launchVisualEffect(sID, oEffectData, nCellNum, nDisplayType, mSpriteAnimation, sTargetID, oSpriteToHideDuringAnimation, bForceVisible);
    };
    _loc1.spriteLaunchCarriedSprite = function (sID, oEffectData, nCellNum, nDisplayType)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.launchCarriedSprite(sID, oEffectData, nCellNum, nDisplayType);
    };
    _loc1.selectSprite = function (sID, bSelect)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.spriteHandler.selectSprite(sID, bSelect);
    };
    _loc1.addSpriteBubble = function (sID, sText, nType)
    {
        var _loc5 = this._oDatacenter.Sprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            ank.utils.Logger.err("[addSpriteBubble] Sprite inexistant (sprite Id : " + sID + ")");
            return;
        } // end if
        if (_loc5.isInMove)
        {
            return;
        } // end if
        if (!_loc5.isVisible)
        {
            return;
        } // end if
        var _loc6 = _loc5.mc;
        var _loc7 = _loc6._x;
        var _loc8 = _loc6._y;
        if (nType == undefined)
        {
            nType = ank.battlefield.TextHandler.BUBBLE_TYPE_CHAT;
        } // end if
        if (_loc7 == 0 || _loc8 == 0)
        {
            ank.utils.Logger.err("[addSpriteBubble] le sprite n\'est pas encore placé ");
            return;
        } // end if
        this.textHandler.addBubble(sID, _loc7, _loc8, sText, nType);
    };
    _loc1.removeSpriteBubble = function (sID)
    {
        var _loc3 = this._oDatacenter.Sprites.getItemAt(sID);
        if (_loc3 == undefined)
        {
            return;
        } // end if
        this.textHandler.removeBubble(sID);
    };
    _loc1.addSpritePoints = function (sID, sValue, nColor)
    {
        var _loc5 = this._oDatacenter.Sprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            ank.utils.Logger.err("[addSpritePoints] Sprite inexistant");
            return;
        } // end if
        if (!_loc5.isVisible)
        {
            return;
        } // end if
        var _loc6 = _loc5.mc;
        var _loc7 = _loc6._x;
        var _loc8 = _loc6._y - ank.battlefield.Constants.DEFAULT_SPRITE_HEIGHT;
        if (_loc7 == 0 || _loc8 == 0)
        {
            ank.utils.Logger.err("[addSpritePoints] le sprite n\'est pas encore placé ");
            return;
        } // end if
        this.pointsHandler.addPoints(sID, _loc7, _loc8, sValue, nColor);
    };
    _loc1.addSpriteOverHeadItem = function (sID, sLayerName, className, aArgs, nDelay, bEvenInMove)
    {
        var _loc8 = this._oDatacenter.Sprites.getItemAt(sID);
        if (_loc8 == undefined)
        {
            ank.utils.Logger.err("[addSpriteOverHeadItem] Sprite inexistant");
            return;
        } // end if
        if (_loc8.isInMove && !bEvenInMove)
        {
            return;
        } // end if
        if (!_loc8.isVisible)
        {
            return;
        } // end if
        var _loc9 = _loc8.mc;
        this.overHeadHandler.addOverHeadItem(sID, _loc9._x, _loc9._y, _loc9, sLayerName, className, aArgs, nDelay);
    };
    _loc1.removeSpriteOverHeadLayer = function (sID, sLayerName)
    {
        this.overHeadHandler.removeOverHeadLayer(sID, sLayerName);
    };
    _loc1.hideSpriteOverHead = function (sID)
    {
        this.overHeadHandler.removeOverHead(sID);
    };
    _loc1.addSpriteExtraClipOnTimer = function (sID, sFile, nColor, bTop, nDuration)
    {
        this.addSpriteExtraClip(sID, sFile, nColor, bTop);
        var _loc7 = new Object();
        _loc7.timerId = _global.setInterval(this, "removeSpriteExtraClipOnTimer", nDuration, _loc7, sID, bTop);
    };
    _loc1.removeSpriteExtraClipOnTimer = function (oTimer, sID, bTop)
    {
        _global.clearInterval(oTimer.timerId);
        this.removeSpriteExtraClip(sID, bTop);
    };
    _loc1.addSpriteExtraClip = function (sID, sFile, nColor, bTop)
    {
        this.spriteHandler.addSpriteExtraClip(sID, sFile, nColor, bTop);
    };
    _loc1.removeSpriteExtraClip = function (sID, bTop)
    {
        this.spriteHandler.removeSpriteExtraClip(sID, bTop);
    };
    _loc1.showSpritePoints = function (sID, nValue, nColor)
    {
        this.spriteHandler.showSpritePoints(sID, nValue, nColor);
    };
    _loc1.setSpriteGhostView = function (bool)
    {
        this.bGhostView = bool;
        this.spriteHandler.setSpriteGhostView(bool);
    };
    _loc1.setSpriteScale = function (sID, nScaleX, nScaleY)
    {
        this.spriteHandler.setSpriteScale(sID, nScaleX, nScaleY);
    };
    _loc1.drawGrid = function (bAll)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        if (this.gridHandler.bGridVisible)
        {
            this.removeGrid();
        }
        else
        {
            this.gridHandler.draw(bAll);
        } // end else if
    };
    _loc1.removeGrid = function (Void)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        this.gridHandler.clear();
    };
    _loc1.addVisualEffectOnSprite = function (sID, oEffectData, nCellNum, nDisplayType, sTargetID)
    {
        if (!this.isMapBuild)
        {
            return;
        } // end if
        var _loc7 = this._oDatacenter.Sprites.getItemAt(sID);
        var _loc8 = this._oDatacenter.Sprites.getItemAt(sTargetID);
        this.visualEffectHandler.addEffect(_loc7, oEffectData, nCellNum, nDisplayType, _loc8);
    };
    _loc1.initializeDatacenter = function (Void)
    {
        if (this._oDatacenter == undefined)
        {
            return (false);
        } // end if
        this._oDatacenter.Map.cleanSpritesOn();
        this._oDatacenter.Map = new ank.battlefield.datacenter.Map();
        this._oDatacenter.Sprites = new ank.utils.ExtendedObject();
        return (true);
    };
    _loc1.createHandlers = function (Void)
    {
        this.mapHandler = new ank.battlefield.MapHandler(this, this._mcMainContainer, this._oDatacenter);
        this.spriteHandler = new ank.battlefield.SpriteHandler(this, this._mcMainContainer.ExternalContainer.Object2, this._oDatacenter.Sprites);
        this.interactionHandler = new ank.battlefield.InteractionHandler(this._mcMainContainer.ExternalContainer.InteractionCell, this._oDatacenter);
        this.zoneHandler = new ank.battlefield.ZoneHandler(this, this._mcMainContainer.ExternalContainer.Zone);
        this.pointerHandler = new ank.battlefield.PointerHandler(this, this._mcMainContainer.ExternalContainer.Pointer);
        this.selectionHandler = new ank.battlefield.SelectionHandler(this, this._mcMainContainer.ExternalContainer, this._oDatacenter);
        this.gridHandler = new ank.battlefield.GridHandler(this._mcMainContainer.ExternalContainer.Grid, this._oDatacenter);
        this.visualEffectHandler = new ank.battlefield.VisualEffectHandler(this, this._mcMainContainer.ExternalContainer.Object2);
        this.textHandler = new ank.battlefield.TextHandler(this, this._mcMainContainer.Text, this._oDatacenter);
        this.pointsHandler = new ank.battlefield.PointsHandler(this, this._mcMainContainer.Points, this._oDatacenter);
        this.overHeadHandler = new ank.battlefield.OverHeadHandler(this, this._mcMainContainer.OverHead);
    };
    _loc1.onLoadInit = function (mc)
    {
        switch (mc._name)
        {
            case "Ground":
            {
                mc._parent.useCustomGroundGfxFile(this._bUseCustomGroundGfxFile);
                this.bCustomFileLoaded = true;
                this.onInitComplete();
                break;
            } 
            default:
            {
                mc.__proto__ = ank.battlefield.mc.ExternalContainer.prototype;
                mc.initialize(this._sGroundFile);
                this.createHandlers();
                break;
            } 
        } // End of switch
    };
    _loc1.onLoadError = function (mc)
    {
        this.onInitError();
    };
    _loc1.onLoadProgress = function (mc, nBL, nBT)
    {
        this.onInitProgress(nBL, nBT);
    };
    _loc1.addProperty("datacenter", _loc1.__get__datacenter, function ()
    {
    });
    _loc1.addProperty("isJumpActivate", _loc1.__get__isJumpActivate, _loc1.__set__isJumpActivate);
    _loc1.addProperty("screenHeight", _loc1.__get__screenHeight, _loc1.__set__screenHeight);
    _loc1.addProperty("screenWidth", _loc1.__get__screenWidth, _loc1.__set__screenWidth);
    _loc1.addProperty("isMapBuild", _loc1.__get__isMapBuild, function ()
    {
    });
    _loc1.addProperty("container", _loc1.__get__container, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    _loc1._bJumpActivate = false;
    (_global.ank.battlefield.Battlefield = function ()
    {
        super();
    }).FRAMELOADTIMOUT = 500;
    _loc1._bUseCustomGroundGfxFile = false;
    _loc1.bGhostView = false;
    _loc1.bCustomFileLoaded = false;
} // end if
#endinitclip
