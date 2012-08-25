// Action script...

// [Initial MovieClip Action of sprite 20727]
#initclip 248
if (!ank.battlefield.SpriteHandler)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.SpriteHandler = function (b, c, d)
    {
        this.initialize(b, c, d);
    }).prototype;
    _loc1.initialize = function (b, c, d)
    {
        this._mcBattlefield = b;
        this._oSprites = d;
        this._mcContainer = c;
    };
    _loc1.clear = function (bKeepData)
    {
        var _loc3 = this._oSprites.getItems();
        for (var k in _loc3)
        {
            this.removeSprite(k, bKeepData);
        } // end of for...in
    };
    _loc1.getSprites = function ()
    {
        return (this._oSprites);
    };
    _loc1.getSprite = function (sID)
    {
        return (this._oSprites.getItemAt(sID));
    };
    _loc1.addSprite = function (sID, oSprite)
    {
        var _loc4 = true;
        if (oSprite == undefined)
        {
            _loc4 = false;
            oSprite = this._oSprites.getItemAt(sID);
        } // end if
        if (oSprite == undefined)
        {
            ank.utils.Logger.err("[addSprite] pas de spriteData");
            return;
        } // end if
        if (_loc4)
        {
            this._oSprites.addItemAt(sID, oSprite);
        } // end if
        this._mcContainer["sprite" + sID].removeMovieClip();
        var _loc5 = ank.battlefield.utils.SpriteDepthFinder.getFreeDepthOnCell(this._mcBattlefield.mapHandler, this._oSprites, oSprite.cellNum, oSprite.allowGhostMode && this._mcBattlefield.bGhostView);
        var _loc6 = this._mcContainer.getInstanceAtDepth(_loc5);
        oSprite.mc = this._mcContainer.attachClassMovie(oSprite.clipClass, "sprite" + sID, _loc5, [this._mcBattlefield, this._oSprites, oSprite]);
        oSprite.isHidden = this._bAllSpritesMasked;
        if (oSprite.allowGhostMode && this._mcBattlefield.bGhostView)
        {
            oSprite.mc.setAlpha(ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
        } // end if
    };
    _loc1.addLinkedSprite = function (sID, sParentID, nChildIndex, oSprite)
    {
        var _loc6 = true;
        var _loc7 = this._oSprites.getItemAt(sParentID);
        if (_loc7 == undefined)
        {
            ank.utils.Logger.err("[addLinkedSprite] pas de spriteData parent");
            return;
        } // end if
        if (oSprite == undefined)
        {
            _loc6 = false;
            oSprite = this._oSprites.getItemAt(sID);
        } // end if
        if (oSprite == undefined)
        {
            ank.utils.Logger.err("[addLinkedSprite] pas de spriteData");
            return;
        } // end if
        if (_loc6)
        {
            this._oSprites.addItemAt(sID, oSprite);
        } // end if
        var _loc8 = ank.battlefield.utils.Pathfinding.getArroundCellNum(this._mcBattlefield.mapHandler, _loc7.cellNum, _loc7.direction, nChildIndex);
        var _loc9 = this._mcBattlefield.mapHandler.getCellData(_loc8);
        if (_loc9.movement > 0 && _loc9.active)
        {
            oSprite.cellNum = _loc8;
        }
        else
        {
            oSprite.cellNum = _loc7.cellNum;
        } // end else if
        oSprite.linkedParent = _loc7;
        oSprite.childIndex = nChildIndex;
        _loc7.linkedChilds.addItemAt(sID, oSprite);
        this.addSprite(sID);
    };
    _loc1.carriedSprite = function (sID, sParentID)
    {
        var _loc4 = this._oSprites.getItemAt(sID);
        if (_loc4 == undefined)
        {
            ank.utils.Logger.err("[carriedSprite] pas de spriteData");
            return;
        } // end if
        var _loc5 = this._oSprites.getItemAt(sParentID);
        if (_loc5 == undefined)
        {
            ank.utils.Logger.err("[carriedSprite] pas de spriteData parent");
            return;
        } // end if
        if (!_loc5.hasCarriedChild())
        {
            this.autoCalculateSpriteDirection(sParentID, _loc4.cellNum);
            _loc4.direction = _loc5.direction;
            _loc4.carriedParent = _loc5;
            _loc5.carriedChild = _loc4;
            var _loc6 = _loc5.mc;
            _loc6.setAnim("carring", false, false);
            _loc6.onEnterFrame = function ()
            {
                this.updateCarriedPosition();
                delete this.onEnterFrame;
            };
            _loc4.mc.updateMap(_loc5.cellNum, _loc4.isVisible);
            _loc4.mc.setNewCellNum(_loc5.cellNum);
        } // end if
    };
    _loc1.uncarriedSprite = function (sID, nCellNum, bWithAnimation, oSeq)
    {
        var oSprite = this._oSprites.getItemAt(sID);
        if (oSprite == undefined)
        {
            ank.utils.Logger.err("[addLinkedSprite] pas de spriteData parent");
            return;
        } // end if
        if (oSprite.hasCarriedParent())
        {
            var _loc6 = oSprite.carriedParent;
            var _loc7 = _loc6.mc;
            var _loc8 = _loc6.sequencer;
            if (oSeq == undefined)
            {
                oSeq = _loc8;
            }
            else if (bWithAnimation)
            {
                oSeq.addAction(false, this, function (oParent, oSequencer)
                {
                    oParent.sequencer = oSequencer;
                }, [_loc6, oSeq]);
            } // end else if
            if (bWithAnimation)
            {
                oSeq.addAction(false, this, this.autoCalculateSpriteDirection, [_loc6.id, nCellNum]);
                oSeq.addAction(true, _loc7, _loc7.setAnim, ["carringEnd", false, false]);
                _loc7.onEnterFrame = function ()
                {
                    this.updateCarriedPosition();
                    delete this.onEnterFrame;
                };
            } // end if
            oSeq.addAction(false, this, function (oChild, oParent)
            {
                oSprite.carriedParent = undefined;
                oParent.carriedChild = undefined;
            }, [oSprite, _loc6]);
            oSeq.addAction(false, this, this.setSpritePosition, [oSprite.id, nCellNum]);
            if (bWithAnimation)
            {
                oSeq.addAction(false, _loc7, _loc7.setAnim, ["static", false, false]);
                oSeq.addAction(false, this, function (oParent, oSequencer)
                {
                    oParent.sequencer = oSequencer;
                }, [_loc6, _loc8]);
            } // end if
            oSeq.execute();
        } // end if
    };
    _loc1.mountSprite = function (sID, oMount)
    {
        var _loc4 = this._oSprites.getItemAt(sID);
        if (_loc4 == undefined)
        {
            ank.utils.Logger.err("[mountSprite] Sprite " + sID + " inexistant");
            return;
        } // end if
        if (oMount != _loc4.mount)
        {
            _loc4.mount = oMount;
            _loc4.mc.draw();
        } // end if
    };
    _loc1.unmountSprite = function (sID)
    {
        var _loc3 = this._oSprites.getItemAt(sID);
        if (_loc3 == undefined)
        {
            ank.utils.Logger.err("[unmountSprite] Sprite " + sID + " inexistant");
            return;
        } // end if
        if (_loc3.mount != undefined)
        {
            _loc3.mount = undefined;
            _loc3.mc.draw();
        } // end if
    };
    _loc1.removeSprite = function (sID, bKeepData)
    {
        this._mcBattlefield.removeSpriteBubble(sID);
        this._mcBattlefield.hideSpriteOverHead(sID);
        if (bKeepData == undefined)
        {
            bKeepData = false;
        } // end if
        var _loc4 = this._oSprites.getItemAt(sID);
        if (_loc4.hasChilds)
        {
            var _loc5 = _loc4.linkedChilds.getItems();
            for (var k in _loc5)
            {
                this.removeSprite(_loc5[k].id, bKeepData);
            } // end of for...in
        } // end if
        if (_loc4.hasParent && !bKeepData)
        {
            _loc4.linkedParent.linkedChilds.removeItemAt(sID);
        } // end if
        if (_loc4.hasCarriedChild())
        {
            _loc4.carriedChild.carriedParent = undefined;
            _loc4.carriedChild.mc.setPosition();
        } // end if
        if (_loc4.hasCarriedParent())
        {
            var _loc6 = _loc4.carriedParent;
            _loc4.carriedParent.carriedChild = undefined;
            _loc6.mc.setAnim("static", false, false);
        } // end if
        this._mcContainer["sprite" + sID].__proto__ = MovieClip.prototype;
        this._mcContainer["sprite" + sID].removeMovieClip();
        this._mcBattlefield.mapHandler.getCellData(_loc4.cellNum).removeSpriteOnID(_loc4.id);
        if (!bKeepData)
        {
            this._oSprites.removeItemAt(sID);
        } // end if
    };
    _loc1.hideSprite = function (sID, bHide)
    {
        var _loc4 = this._oSprites.getItemAt(sID);
        if (_loc4.hasChilds)
        {
            var _loc5 = _loc4.linkedChilds.getItems();
            for (var k in _loc5)
            {
                this.hideSprite(_loc5[k].id, bHide);
            } // end of for...in
        } // end if
        _loc4.mc.setVisible(!bHide);
    };
    _loc1.unmaskAllSprites = function ()
    {
        this._bAllSpritesMasked = false;
        var _loc2 = this._oSprites.getItems();
        for (var k in _loc2)
        {
            _loc2[k].isHidden = false;
        } // end of for...in
    };
    _loc1.maskAllSprites = function ()
    {
        this._bAllSpritesMasked = true;
        var _loc2 = this._oSprites.getItems();
        for (var k in _loc2)
        {
            _loc2[k].isHidden = true;
        } // end of for...in
    };
    _loc1.setSpriteDirection = function (sID, nDir)
    {
        if (nDir == undefined)
        {
            return;
        } // end if
        var _loc4 = this._oSprites.getItemAt(sID);
        if (_loc4 == undefined)
        {
            ank.utils.Logger.err("[setSpriteDirection] Sprite " + sID + " inexistant");
            return;
        } // end if
        if (_loc4.hasChilds)
        {
            var _loc5 = _loc4.linkedChilds.getItems();
            for (var k in _loc5)
            {
                this.setSpriteDirection(_loc5[k].id, nDir);
            } // end of for...in
        } // end if
        if (_loc4.hasCarriedChild())
        {
            _loc4.carriedChild.mc.setDirection(nDir);
        } // end if
        var _loc6 = _loc4.mc;
        _loc6.setDirection(nDir);
    };
    _loc1.setSpritePosition = function (sID, nCellNum, nDir)
    {
        var _loc5 = this._oSprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            ank.utils.Logger.err("[setSpritePosition] Sprite " + sID + " inexistant");
            return;
        } // end if
        if (_global.isNaN(Number(nCellNum)))
        {
            ank.utils.Logger.err("[setSpritePosition] cellNum n\'est pas un nombre");
            return;
        } // end if
        if (Number(nCellNum) < 0 || Number(nCellNum) > this._mcBattlefield.mapHandler.getCellCount())
        {
            ank.utils.Logger.err("[setSpritePosition] cellNum invalide");
            return;
        } // end if
        if (_loc5.hasChilds)
        {
            var _loc6 = _loc5.linkedChilds.getItems();
            for (var k in _loc6)
            {
                var _loc7 = ank.battlefield.utils.Pathfinding.getArroundCellNum(this._mcBattlefield.mapHandler, nCellNum, nDir, _loc6[k].childIndex);
                this.setSpriteDirection(_loc6[k].id, _loc7, nDir);
            } // end of for...in
        } // end if
        this._mcBattlefield.removeSpriteBubble(sID);
        this._mcBattlefield.hideSpriteOverHead(sID);
        if (nDir != undefined)
        {
            _loc5.direction = nDir;
        } // end if
        var _loc8 = _loc5.mc;
        _loc8.setPosition(nCellNum);
    };
    _loc1.stopSpriteMove = function (sID, oSeq, nCellNum)
    {
        oSeq.clearAllNextActions();
        var _loc5 = this._oSprites.getItemAt(sID);
        var _loc6 = _loc5.mc;
        _loc5.isInMove = false;
        oSeq.addAction(false, _loc6, _loc6.setPosition, [nCellNum]);
        oSeq.addAction(false, _loc6, _loc6.setAnim, ["static"]);
    };
    _loc1.slideSprite = function (sID, cellNum, seq, sAnimation)
    {
        if (sAnimation == undefined)
        {
            sAnimation = "static";
        } // end if
        var _loc6 = this._oSprites.getItemAt(sID);
        var _loc7 = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(this._mcBattlefield.mapHandler.getCellData(_loc6.cellNum).x, this._mcBattlefield.mapHandler.getCellData(_loc6.cellNum).rootY, this._mcBattlefield.mapHandler.getCellData(cellNum).x, this._mcBattlefield.mapHandler.getCellData(cellNum).rootY, false);
        var _loc8 = ank.battlefield.utils.Compressor.makeFullPath(this._mcBattlefield.mapHandler, [{num: _loc6.cellNum}, {num: cellNum, dir: _loc7}]);
        if (_loc8 != undefined)
        {
            this.moveSprite(sID, _loc8, seq, false, sAnimation);
        } // end if
    };
    _loc1.moveSprite = function (sID, path, seq, bClearSequencer, sAnimation, bForcedRun, bForcedWalk, runLimit)
    {
        this._mcBattlefield.removeSpriteBubble(sID);
        this._mcBattlefield.hideSpriteOverHead(sID);
        var _loc10 = sAnimation != undefined;
        if (runLimit == undefined)
        {
            runLimit = ank.battlefield.SpriteHandler.DEFAULT_RUNLINIT;
        } // end if
        if (bForcedRun == undefined)
        {
            bForcedRun = false;
        } // end if
        if (bForcedWalk == undefined)
        {
            bForcedWalk = false;
        } // end if
        var _loc11 = _loc10 ? ("slide") : ("walk");
        if (bForcedWalk)
        {
            _loc11 = "walk";
        }
        else if (bForcedRun)
        {
            _loc11 = "run";
        }
        else if (!bForcedRun && (!bForcedWalk && !_loc10))
        {
            if (path.length > runLimit)
            {
                _loc11 = "run";
            } // end else if
        } // end else if
        var _loc12 = this._oSprites.getItemAt(sID);
        if (_loc12 == undefined)
        {
            ank.utils.Logger.err("[moveSprite] Sprite " + sID + " inexistant");
            return;
        } // end if
        if (seq == undefined)
        {
            seq = _loc12.sequencer;
        } // end if
        if (_loc12.hasChilds)
        {
            var _loc13 = Number(path[path.length - 1]);
            if (path.length > 1)
            {
                var _loc14 = ank.battlefield.utils.Pathfinding.getDirection(this._mcBattlefield.mapHandler, Number(path[path.length - 2]), _loc13);
            }
            else
            {
                _loc14 = _loc12.direction;
            } // end else if
            var _loc15 = _loc12.linkedChilds.getItems();
            for (var k in _loc15)
            {
                var _loc16 = _loc15[k];
                var _loc17 = ank.battlefield.utils.Pathfinding.getArroundCellNum(this._mcBattlefield.mapHandler, _loc13, _loc14, _loc16.childIndex);
                var _loc18 = ank.battlefield.utils.Pathfinding.pathFind(this._mcBattlefield.mapHandler, _loc16.cellNum, _loc17, {bAllDirections: _loc16.allDirections, bIgnoreSprites: true, bCellNumOnly: true, bWithBeginCellNum: true});
                if (_loc18 != null)
                {
                    ank.utils.Timer.setTimer(_loc16, "battlefield", this, this.moveSprite, 200 + (_loc12.cellNum == _loc16.cellNum ? (200) : (0)), [_loc16.id, _loc18, _loc16.sequencer, bClearSequencer, sAnimation, _loc16.forceRun || bForcedRun, _loc16.forceWalk || bForcedWalk, runLimit]);
                } // end if
            } // end of for...in
        } // end if
        var _loc19 = _loc12.mc;
        if (bClearSequencer)
        {
            if (!_loc10)
            {
                seq.clearAllNextActions();
            } // end if
        } // end if
        seq.addAction(false, _loc19, _loc19.setPosition, [path[0]]);
        var _loc20 = path.length;
        var _loc21 = _loc20 - 1;
        for (var _loc22 = 0; _loc22 < _loc20; ++_loc22)
        {
            var _loc23 = sAnimation;
            var _loc24 = _loc11;
            var _loc25 = false;
            if (_loc22 != 0)
            {
                var _loc26 = this._mcBattlefield.mapHandler.getCellHeight(path[_loc22 - 1]);
                var _loc27 = this._mcBattlefield.mapHandler.getCellHeight(path[_loc22]);
                if (Math.abs(_loc26 - _loc27) > 5.000000E-001 && this._mcBattlefield.isJumpActivate)
                {
                    _loc23 = "jump";
                    _loc24 = "run";
                    _loc25 = true;
                } // end if
            } // end if
            seq.addAction(true, _loc19, _loc19.moveToCell, [seq, path[_loc22], _loc22 == _loc21, _loc24, _loc23, _loc25]);
        } // end of for
        seq.execute();
    };
    _loc1.launchVisualEffect = function (sID, oEffectData, nCellNum, nDisplayType, mSpriteAnimation, sTargetID, oSpriteToHideDuringAnimation, bForceVisible)
    {
        var _loc10 = this._oSprites.getItemAt(sID);
        if (_loc10 == undefined)
        {
            ank.utils.Logger.err("[launchVisualEffect] Sprite " + sID + " inexistant");
            return;
        } // end if
        var _loc11 = this._oSprites.getItemAt(sTargetID);
        var _loc12 = _loc10.mc;
        var _loc13 = _loc10.sequencer;
        var _loc14 = true;
        switch (nDisplayType)
        {
            case 0:
            {
                var _loc15 = false;
                _loc14 = false;
                break;
            } 
            case 10:
            case 11:
            {
                _loc15 = false;
                break;
            } 
            case 12:
            {
                _loc15 = true;
                break;
            } 
            case 20:
            case 21:
            {
                _loc15 = false;
                break;
            } 
            case 30:
            case 31:
            {
                _loc15 = true;
                break;
            } 
            case 40:
            case 41:
            {
                _loc15 = true;
                break;
            } 
            case 50:
            {
                _loc15 = false;
                break;
            } 
            case 51:
            {
                _loc15 = true;
                break;
            } 
            default:
            {
                _loc15 = false;
                _loc14 = false;
                break;
            } 
        } // End of switch
        _loc12._ACTION = _loc10;
        _loc12._OBJECT = _loc12;
        _loc13.addAction(false, this, this.autoCalculateSpriteDirection, [sID, nCellNum]);
        if (mSpriteAnimation != undefined)
        {
            var _loc16 = typeof(mSpriteAnimation);
            if (_loc16 == "object")
            {
                if (mSpriteAnimation.length < 3)
                {
                    ank.utils.Logger.err("[launchVisualEffect] l\'anim " + mSpriteAnimation + " est invalide");
                    return;
                } // end if
                var _loc17 = _loc10.cellNum;
                var _loc18 = this._mcBattlefield.mapHandler.getCellData(_loc17);
                var _loc19 = this._mcBattlefield.mapHandler.getCellData(nCellNum);
                var _loc20 = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(_loc18.x, _loc18.y, _loc19.x, _loc19.y, false);
                var _loc21 = ank.battlefield.utils.Compressor.makeFullPath(this._mcBattlefield.mapHandler, ank.battlefield.utils.Pathfinding.pathFind(this._mcBattlefield.mapHandler, _loc17, nCellNum, {bIgnoreSprites: true, bWithBeginCellNum: true}));
                _loc21.pop();
                var _loc22 = _loc21[_loc21.length - 1];
                this.moveSprite(sID, _loc21, _loc13, false, mSpriteAnimation[0], false, true);
                _loc13.addAction(false, _loc12, _loc12.setDirection, [ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(_loc20)]);
                _loc13.addAction(true, _loc12, _loc12.setAnim, [mSpriteAnimation[1]]);
                if (_loc14)
                {
                    _loc13.addAction(_loc15, this._mcBattlefield.visualEffectHandler, this._mcBattlefield.visualEffectHandler.addEffect, [_loc10, oEffectData, nCellNum, nDisplayType, _loc11, bForceVisible ? (true) : (_loc10.isVisible)]);
                } // end if
                var _loc23 = ank.battlefield.utils.Compressor.makeFullPath(this._mcBattlefield.mapHandler, ank.battlefield.utils.Pathfinding.pathFind(this._mcBattlefield.mapHandler, _loc22, _loc17, {bIgnoreSprites: true, bWithBeginCellNum: true}));
                this.moveSprite(sID, _loc23, _loc13, false, mSpriteAnimation[2], false, true);
                _loc13.addAction(false, _loc12, _loc12.setDirection, [_loc20]);
                if (mSpriteAnimation[3] != undefined)
                {
                    _loc13.addAction(false, _loc12, _loc12.setAnim, [mSpriteAnimation[3]]);
                } // end if
                _loc13.execute();
                return;
            }
            else if (_loc16 == "string")
            {
                _loc13.addAction(true, _loc12, _loc12.setAnim, [mSpriteAnimation, false, true]);
            } // end if
        } // end else if
        if (oSpriteToHideDuringAnimation != undefined)
        {
            _loc13.addAction(false, this, this.hideSprite, [oSpriteToHideDuringAnimation.id, true]);
        } // end if
        if (_loc14)
        {
            _loc13.addAction(_loc15, this._mcBattlefield.visualEffectHandler, this._mcBattlefield.visualEffectHandler.addEffect, [_loc10, oEffectData, nCellNum, nDisplayType, _loc11, bForceVisible ? (true) : (_loc10.isVisible)]);
        } // end if
        if (oSpriteToHideDuringAnimation != undefined)
        {
            _loc13.addAction(false, this, this.hideSprite, [oSpriteToHideDuringAnimation.id, false]);
        } // end if
        _loc13.execute();
    };
    _loc1.launchCarriedSprite = function (sID, oEffectData, nCellNum, nDisplayType)
    {
        var _loc6 = this._oSprites.getItemAt(sID);
        var _loc7 = _loc6.sequencer;
        if (_loc6 == undefined)
        {
            ank.utils.Logger.err("[launchCarriedSprite] Sprite " + sID + " inexistant");
            return;
        } // end if
        var _loc8 = _loc6.carriedChild;
        this.launchVisualEffect(sID, oEffectData, nCellNum, nDisplayType, "carringThrow", undefined, _loc8);
        _loc7.addAction(false, this, this.setSpritePosition, [_loc8.id, nCellNum]);
        this.uncarriedSprite(_loc8.id, nCellNum, false, _loc7);
        _loc7.addAction(false, this, this.setSpriteAnim, [sID, "static"]);
        _loc7.execute();
    };
    _loc1.autoCalculateSpriteDirection = function (sID, nCellNum)
    {
        var _loc4 = this._oSprites.getItemAt(sID);
        if (_loc4 == undefined)
        {
            ank.utils.Logger.err("[launchVisualEffect] Sprite " + sID + " inexistant");
            return;
        } // end if
        if (_loc4.cellNum != nCellNum)
        {
            var _loc5 = _loc4.mc;
            var _loc6 = this._mcBattlefield.mapHandler.getCellData(_loc4.cellNum);
            var _loc7 = this._mcBattlefield.mapHandler.getCellData(nCellNum);
            var _loc8 = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(_loc6.x, _loc6.rootY, _loc7.x, _loc7.rootY, false);
            _loc5.setDirection(_loc8);
        } // end if
    };
    _loc1.convertHeightToFourSpriteDirection = function (sID)
    {
        var _loc3 = this._oSprites.getItemAt(sID);
        if (_loc3 == undefined)
        {
            ank.utils.Logger.err("[convertHeightToFourSpriteDirection] Sprite " + sID + " inexistant");
            return;
        } // end if
        this.setSpriteDirection(sID, ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(_loc3.direction));
    };
    _loc1.setSpriteAnim = function (sID, anim, bForced)
    {
        var _loc5 = this._oSprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            ank.utils.Logger.err("[setSpriteAnim(" + anim + ")] Sprite " + sID + " inexistant");
            return;
        } // end if
        ank.utils.Timer.removeTimer(_loc5.mc, "battlefield");
        _loc5.mc.setAnim(anim, false, bForced);
    };
    _loc1.setSpriteLoopAnim = function (sID, anim, nTimer)
    {
        var _loc5 = this._oSprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            ank.utils.Logger.err("[setSpriteLoopAnim] Sprite " + sID + " inexistant");
            return;
        } // end if
        ank.utils.Timer.removeTimer(_loc5.mc, "battlefield");
        _loc5.mc.setAnim(anim, true);
        ank.utils.Timer.setTimer(_loc5.mc, "battlefield", _loc5.mc, _loc5.mc.setAnim, nTimer, ["static"]);
    };
    _loc1.setSpriteTimerAnim = function (sID, anim, bForced, nTimer)
    {
        var _loc6 = this._oSprites.getItemAt(sID);
        if (_loc6 == undefined)
        {
            ank.utils.Logger.err("[setSpriteTimerAnim] Sprite " + sID + " inexistant");
            return;
        } // end if
        ank.utils.Timer.removeTimer(_loc6.mc, "battlefield");
        _loc6.mc.setAnimTimer(anim, false, bForced, nTimer);
    };
    _loc1.setSpriteGfx = function (sID, sFile)
    {
        var _loc4 = this._oSprites.getItemAt(sID);
        if (_loc4 == undefined)
        {
            ank.utils.Logger.err("[setSpriteGfx] Sprite " + sID + " inexistant");
            return;
        } // end if
        if (sFile != _loc4.gfxFile)
        {
            _loc4.gfxFile = sFile;
            _loc4.mc.draw();
        } // end if
    };
    _loc1.setSpriteColorTransform = function (sID, t)
    {
        var _loc4 = this._oSprites.getItemAt(sID);
        if (_loc4 == undefined)
        {
            ank.utils.Logger.err("[setSpriteColorTransform] Sprite " + sID + " inexistant");
            return;
        } // end if
        _loc4.mc.setColorTransform(t);
    };
    _loc1.setSpriteAlpha = function (sID, nAlpha)
    {
        var _loc4 = this._oSprites.getItemAt(sID);
        if (_loc4 == undefined)
        {
            ank.utils.Logger.err("[setSpriteAlpha] Sprite " + sID + " inexistant");
            return;
        } // end if
        _loc4.mc.setAlpha(nAlpha);
    };
    _loc1.addSpriteExtraClip = function (sID, clipFile, col, bTop)
    {
        var _loc6 = this._oSprites.getItemAt(sID);
        if (_loc6 == undefined)
        {
            ank.utils.Logger.err("[addSpriteExtraClip] Sprite " + sID + " inexistant");
            return;
        } // end if
        _loc6.mc.addExtraClip(clipFile, col, bTop);
    };
    _loc1.removeSpriteExtraClip = function (sID, bTop)
    {
        var _loc4 = this._oSprites.getItemAt(sID);
        if (_loc4 == undefined)
        {
            ank.utils.Logger.err("[removeSpriteExtraClip] Sprite " + sID + " inexistant");
            return;
        } // end if
        _loc4.mc.removeExtraClip(bTop);
    };
    _loc1.showSpritePoints = function (sID, value, col)
    {
        var _loc5 = this._oSprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            ank.utils.Logger.err("[showSpritePoints] Sprite " + sID + " inexistant");
            return;
        } // end if
        _loc5.mc.showPoints(value, col);
    };
    _loc1.setSpriteGhostView = function (bool)
    {
        var _loc3 = this._oSprites.getItems();
        for (var k in _loc3)
        {
            var _loc4 = this._oSprites.getItemAt(k);
            _loc4.mc.setGhostView(_loc4.allowGhostMode && bool);
        } // end of for...in
    };
    _loc1.selectSprite = function (sID, bSelect)
    {
        var _loc4 = this._oSprites.getItemAt(sID);
        if (_loc4 == undefined)
        {
            ank.utils.Logger.err("[selectSprite] Sprite " + sID + " inexistant");
            return;
        } // end if
        if (_loc4.hasChilds)
        {
            var _loc5 = _loc4.linkedChilds.getItems();
            for (var k in _loc5)
            {
                this.selectSprite(_loc5[k].id, bSelect);
            } // end of for...in
        } // end if
        _loc4.mc.select(bSelect);
    };
    _loc1.setSpriteScale = function (sID, nScaleX, nScaleY)
    {
        var _loc5 = this._oSprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            ank.utils.Logger.err("[selectSprite] Sprite " + sID + " inexistant");
            return;
        } // end if
        _loc5.mc.setScale(nScaleX, nScaleY);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.battlefield.SpriteHandler = function (b, c, d)
    {
        this.initialize(b, c, d);
    }).DEFAULT_RUNLINIT = 6;
} // end if
#endinitclip
