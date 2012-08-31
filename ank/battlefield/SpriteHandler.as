// Action script...

// [Initial MovieClip Action of sprite 857]
#initclip 69
class ank.battlefield.SpriteHandler
{
    var _mcBattlefield, _oSprites, _mcContainer;
    function SpriteHandler(b, c, d)
    {
        this.initialize(b, c, d);
    } // End of the function
    function initialize(b, c, d)
    {
        _mcBattlefield = b;
        _oSprites = d;
        _mcContainer = c;
    } // End of the function
    function clear(bKeepData)
    {
        var _loc2 = _oSprites.getItems();
        for (var _loc4 in _loc2)
        {
            this.removeSprite(_loc4, bKeepData);
        } // end of for...in
    } // End of the function
    function addSprite(sID, oSprite)
    {
        var _loc3 = true;
        if (oSprite == undefined)
        {
            _loc3 = false;
            oSprite = _oSprites.getItemAt(sID);
        } // end if
        if (oSprite == undefined)
        {
            ank.utils.Logger.err("[addSprite] pas de spriteData");
            return;
        } // end if
        if (_loc3)
        {
            _oSprites.addItemAt(sID, oSprite);
        } // end if
        _mcContainer["sprite" + sID].removeMovieClip();
        var _loc5 = ank.battlefield.utils.SpriteDepthFinder.getFreeDepthOnCell(_mcBattlefield.mapHandler, _oSprites, oSprite.__get__cellNum(), _mcBattlefield.bGhostView);
        oSprite.mc = _mcContainer.attachClassMovie(oSprite.clipClass, "sprite" + sID, _loc5, [_mcBattlefield, _oSprites, oSprite]);
        if (_mcBattlefield.bGhostView)
        {
            oSprite.mc.setAlpha(ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
        } // end if
    } // End of the function
    function addLinkedSprite(sID, sParentID, nChildIndex, oSprite)
    {
        var _loc4 = true;
        var _loc3 = _oSprites.getItemAt(sParentID);
        if (_loc3 == undefined)
        {
            ank.utils.Logger.err("[addLinkedSprite] pas de spriteData parent");
            return;
        } // end if
        if (oSprite == undefined)
        {
            _loc4 = false;
            oSprite = _oSprites.getItemAt(sID);
        } // end if
        if (oSprite == undefined)
        {
            ank.utils.Logger.err("[addLinkedSprite] pas de spriteData");
            return;
        } // end if
        if (_loc4)
        {
            _oSprites.addItemAt(sID, oSprite);
        } // end if
        var _loc6 = ank.battlefield.utils.Pathfinding.getArroundCellNum(_mcBattlefield.mapHandler, _loc3.__get__cellNum(), _loc3.__get__direction(), nChildIndex);
        var _loc7 = _mcBattlefield.mapHandler.getCellData(_loc6);
        if (_loc7.movement > 0 && _loc7.active)
        {
            oSprite.__set__cellNum(_loc6);
        }
        else
        {
            oSprite.__set__cellNum(_loc3.cellNum);
        } // end else if
        oSprite.__set__linkedParent(_loc3);
        oSprite.__set__childIndex(nChildIndex);
        _loc3.linkedChilds.addItemAt(sID, oSprite);
        this.addSprite(sID);
    } // End of the function
    function removeSprite(sID, bKeepData)
    {
        _mcBattlefield.removeSpriteBubble(sID);
        _mcBattlefield.hideSpriteOverHead(sID);
        if (bKeepData == undefined)
        {
            bKeepData = false;
        } // end if
        var _loc4 = _oSprites.getItemAt(sID);
        if (_loc4.__get__hasChilds())
        {
            var _loc2 = _loc4.linkedChilds.getItems();
            for (var _loc6 in _loc2)
            {
                this.removeSprite(_loc2[_loc6].id, bKeepData);
            } // end of for...in
        } // end if
        if (_loc4.__get__hasParent() && !bKeepData)
        {
            _loc4.linkedParent.linkedChilds.removeItemAt(sID);
        } // end if
        _mcContainer["sprite" + sID].__proto__ = MovieClip.prototype;
        _mcContainer["sprite" + sID].removeMovieClip();
        _mcBattlefield.mapHandler.getCellData(_loc4.__get__cellNum()).removeSpriteOnID(_loc4.id);
        if (!bKeepData)
        {
            _oSprites.removeItemAt(sID);
        } // end if
    } // End of the function
    function hideSprite(sID, bHide)
    {
        var _loc5 = _oSprites.getItemAt(sID);
        if (_loc5.__get__hasChilds())
        {
            var _loc2 = _loc5.linkedChilds.getItems();
            for (var _loc4 in _loc2)
            {
                this.hideSprite(_loc2[_loc4].id, bHide);
            } // end of for...in
        } // end if
        _loc5.mc.setVisible(!bHide);
    } // End of the function
    function setSpriteDirection(sID, nDir)
    {
        if (nDir == undefined)
        {
            return;
        } // end if
        var _loc4 = _oSprites.getItemAt(sID);
        if (_loc4 == undefined)
        {
            ank.utils.Logger.err("[setSpriteDirection] Sprite inexistant");
            return;
        } // end if
        if (_loc4.__get__hasChilds())
        {
            var _loc2 = _loc4.linkedChilds.getItems();
            for (var _loc5 in _loc2)
            {
                this.setSpriteDirection(_loc2[_loc5].id, nDir);
            } // end of for...in
        } // end if
        var _loc6 = _loc4.mc;
        _loc6.setDirection(nDir);
    } // End of the function
    function setSpritePosition(sID, nCellNum, nDir)
    {
        var _loc6 = _oSprites.getItemAt(sID);
        if (_loc6 == undefined)
        {
            ank.utils.Logger.err("[setSpritePosition] Sprite inexistant");
            return;
        } // end if
        if (isNaN(Number(nCellNum)))
        {
            ank.utils.Logger.err("[setSpritePosition] cellNum n\'est pas un nombre");
            return;
        } // end if
        if (Number(nCellNum) < 0 || Number(nCellNum) > _mcBattlefield.mapHandler.getCellCount())
        {
            ank.utils.Logger.err("[setSpritePosition] cellNum invalide");
            return;
        } // end if
        if (_loc6.__get__hasChilds())
        {
            var _loc2 = _loc6.linkedChilds.getItems();
            for (var _loc7 in _loc2)
            {
                var _loc3 = ank.battlefield.utils.Pathfinding.getArroundCellNum(_mcBattlefield.mapHandler, nCellNum, nDir, _loc2[_loc7].childIndex);
                this.setSpriteDirection(_loc2[_loc7].id, _loc3, nDir);
            } // end of for...in
        } // end if
        _mcBattlefield.removeSpriteBubble(sID);
        _mcBattlefield.hideSpriteOverHead(sID);
        if (nDir != undefined)
        {
            _loc6.__set__direction(nDir);
        } // end if
        var _loc8 = _loc6.mc;
        _loc8.setPosition(nCellNum);
    } // End of the function
    function slideSprite(sID, cellNum, seq, sAnimation)
    {
        if (sAnimation == undefined)
        {
            sAnimation = "static";
        } // end if
        var _loc2 = _oSprites.getItemAt(sID);
        var _loc8 = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(_mcBattlefield.mapHandler.getCellData(_loc2.__get__cellNum()).x, _mcBattlefield.mapHandler.getCellData(_loc2.__get__cellNum()).y, _mcBattlefield.mapHandler.getCellData(cellNum).x, _mcBattlefield.mapHandler.getCellData(cellNum).y, false);
        var _loc3 = ank.battlefield.utils.Compressor.makeFullPath(_mcBattlefield.mapHandler, [{num: _loc2.__get__cellNum()}, {num: cellNum, dir: _loc8}]);
        if (_loc3 != undefined)
        {
            this.moveSprite(sID, _loc3, seq, false, sAnimation);
        } // end if
    } // End of the function
    function moveSprite(sID, path, seq, bClearSequencer, sAnimation, bForcedRun, bForcedWalk, runLimit)
    {
        _mcBattlefield.removeSpriteBubble(sID);
        _mcBattlefield.hideSpriteOverHead(sID);
        var _loc24 = sAnimation != undefined;
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
        var _loc16 = _loc24 ? ("slide") : ("walk");
        if (bForcedWalk)
        {
            _loc16 = "walk";
        }
        else if (bForcedRun)
        {
            _loc16 = "run";
        }
        else if (!bForcedRun && !bForcedWalk && !_loc24)
        {
            if (path.length > runLimit)
            {
                _loc16 = "run";
            } // end else if
        } // end else if
        var _loc9 = _oSprites.getItemAt(sID);
        if (_loc9 == undefined)
        {
            ank.utils.Logger.err("[moveSprite] Sprite inexistant");
            return;
        } // end if
        if (seq == undefined)
        {
            seq = _loc9.sequencer;
        } // end if
        if (_loc9.__get__hasChilds())
        {
            var _loc19 = Number(path[path.length - 1]);
            var _loc20;
            if (path.length > 1)
            {
                _loc20 = ank.battlefield.utils.Pathfinding.getDirection(_mcBattlefield.mapHandler, Number(path[path.length - 2]), _loc19);
            }
            else
            {
                _loc20 = _loc9.direction;
            } // end else if
            var _loc10 = _loc9.linkedChilds.getItems();
            for (var _loc23 in _loc10)
            {
                var _loc2 = _loc10[_loc23];
                var _loc5 = ank.battlefield.utils.Pathfinding.getArroundCellNum(_mcBattlefield.mapHandler, _loc19, _loc20, _loc2.__get__childIndex());
                var _loc4 = ank.battlefield.utils.Pathfinding.pathFind(_mcBattlefield.mapHandler, _loc2.__get__cellNum(), _loc5, {bAllDirections: _loc2.__get__allDirections(), bIgnoreSprites: true, bCellNumOnly: true, bWithBeginCellNum: true});
                if (_loc4 != null)
                {
                    ank.utils.Timer.setTimer(_loc2, "battlefield", this, moveSprite, 200 + (_loc9.__get__cellNum() == _loc2.__get__cellNum() ? (200) : (0)), [_loc2.id, _loc4, _loc2.__get__sequencer(), bClearSequencer, sAnimation, _loc2.__get__forceRun() || bForcedRun, _loc2.__get__forceWalk() || bForcedWalk, runLimit]);
                } // end if
            } // end of for...in
        } // end if
        var _loc7 = _loc9.mc;
        if (bClearSequencer)
        {
            if (!_loc24)
            {
                seq.clearAllNextActions();
            } // end if
        } // end if
        seq.addAction(false, _loc7, _loc7.setPosition, [path[0]]);
        path.reverse();
        for (var _loc3 = path.length - 1; _loc3 >= 0; --_loc3)
        {
            seq.addAction(true, _loc7, _loc7.moveToCell, [seq, path[_loc3], _loc3 == 0, _loc16, sAnimation]);
        } // end of for
        seq.execute();
    } // End of the function
    function launchVisualEffect(sID, oEffectData, nCellNum, nDisplayType, mSpriteAnimation)
    {
        var _loc6 = _oSprites.getItemAt(sID);
        if (_loc6 == undefined)
        {
            ank.utils.Logger.err("[launchVisualEffect] Sprite inexistant");
            return;
        } // end if
        var _loc2 = _loc6.mc;
        var _loc3 = _loc6.__get__sequencer();
        var _loc8 = true;
        var _loc4;
        switch (nDisplayType)
        {
            case 0:
            {
                _loc4 = false;
                _loc8 = false;
                break;
            } 
            case 10:
            case 11:
            {
                _loc4 = false;
                break;
            } 
            case 12:
            {
                _loc4 = true;
                break;
            } 
            case 20:
            case 21:
            {
                _loc4 = false;
                break;
            } 
            case 30:
            case 31:
            {
                _loc4 = true;
                break;
            } 
            case 40:
            case 41:
            {
                _loc4 = true;
                break;
            } 
            case 50:
            {
                _loc4 = false;
                break;
            } 
            case 51:
            {
                _loc4 = true;
                break;
            } 
            default:
            {
                _loc4 = false;
                _loc8 = false;
                break;
            } 
        } // End of switch
        _loc2._ACTION = _loc6;
        _loc2._OBJECT = _loc2;
        _loc3.addAction(false, this, autoCalculateSpriteDirection, [sID, nCellNum]);
        if (mSpriteAnimation != undefined)
        {
            var _loc15 = typeof(mSpriteAnimation);
            if (_loc15 == "object")
            {
                if (mSpriteAnimation.length < 3)
                {
                    ank.utils.Logger.err("[launchVisualEffect] l\'anim " + mSpriteAnimation + " est invalide");
                    return;
                } // end if
                var _loc10 = _loc6.__get__cellNum();
                var _loc14 = _mcBattlefield.mapHandler.getCellData(_loc10);
                var _loc12 = _mcBattlefield.mapHandler.getCellData(nCellNum);
                var _loc11 = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(_loc14.x, _loc14.y, _loc12.x, _loc12.y, false);
                var _loc7 = ank.battlefield.utils.Compressor.makeFullPath(_mcBattlefield.mapHandler, ank.battlefield.utils.Pathfinding.pathFind(_mcBattlefield.mapHandler, _loc10, nCellNum, {bIgnoreSprites: true, bWithBeginCellNum: true}));
                _loc7.pop();
                var _loc18 = _loc7[_loc7.length - 1];
                this.moveSprite(sID, _loc7, _loc3, false, mSpriteAnimation[0], false, true);
                _loc3.addAction(false, _loc2, _loc2.setDirection, [ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(_loc11)]);
                _loc3.addAction(true, _loc2, _loc2.setAnim, [mSpriteAnimation[1]]);
                if (_loc8)
                {
                    _loc3.addAction(_loc4, _mcBattlefield.visualEffectHandler, _mcBattlefield.visualEffectHandler.addEffect, [_loc6, oEffectData, nCellNum, nDisplayType]);
                } // end if
                var _loc17 = ank.battlefield.utils.Compressor.makeFullPath(_mcBattlefield.mapHandler, ank.battlefield.utils.Pathfinding.pathFind(_mcBattlefield.mapHandler, _loc18, _loc10, {bIgnoreSprites: true, bWithBeginCellNum: true}));
                this.moveSprite(sID, _loc17, _loc3, false, mSpriteAnimation[2], false, true);
                _loc3.addAction(false, _loc2, _loc2.setDirection, [_loc11]);
                if (mSpriteAnimation[3] != undefined)
                {
                    _loc3.addAction(false, _loc2, _loc2.setAnim, [mSpriteAnimation[3]]);
                } // end if
                _loc3.execute();
                return;
            }
            else if (_loc15 == "string")
            {
                _loc3.addAction(true, _loc2, _loc2.setAnim, [mSpriteAnimation]);
            } // end if
        } // end else if
        if (_loc8)
        {
            _loc3.addAction(_loc4, _mcBattlefield.visualEffectHandler, _mcBattlefield.visualEffectHandler.addEffect, [_loc6, oEffectData, nCellNum, nDisplayType]);
        } // end if
        _loc3.execute();
    } // End of the function
    function autoCalculateSpriteDirection(sID, cellNum)
    {
        var _loc3 = _oSprites.getItemAt(sID);
        if (_loc3 == undefined)
        {
            ank.utils.Logger.err("[launchVisualEffect] Sprite inexistant");
            return;
        } // end if
        var _loc2 = _loc3.mc;
        var _loc4 = _mcBattlefield.mapHandler.getCellData(cellNum);
        var _loc5 = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(_loc2._x, _loc2._y, _loc4.x, _loc4.y, false);
        _loc2.setDirection(_loc5);
    } // End of the function
    function convertHeightToFourSpriteDirection(sID)
    {
        var _loc2 = _oSprites.getItemAt(sID);
        if (_loc2 == undefined)
        {
            ank.utils.Logger.err("[convertHeightToFourSpriteDirection] Sprite inexistant");
            return;
        } // end if
        this.setSpriteDirection(sID, ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(_loc2.__get__direction()));
    } // End of the function
    function setSpriteAnim(sID, anim, bForced)
    {
        var _loc2 = _oSprites.getItemAt(sID);
        if (_loc2 == undefined)
        {
            ank.utils.Logger.err("[setSpriteAnim] Sprite inexistant");
            return;
        } // end if
        ank.utils.Timer.removeTimer(_loc2.mc, "battlefield");
        _loc2.mc.setAnim(anim, false, bForced);
    } // End of the function
    function setSpriteLoopAnim(sID, anim, nTimer)
    {
        var _loc2 = _oSprites.getItemAt(sID);
        if (_loc2 == undefined)
        {
            ank.utils.Logger.err("[setSpriteLoopAnim] Sprite inexistant");
            return;
        } // end if
        ank.utils.Timer.removeTimer(_loc2.mc, "battlefield");
        _loc2.mc.setAnim(anim, true);
        ank.utils.Timer.setTimer(_loc2.mc, "battlefield", _loc2.mc, _loc2.mc.setAnim, nTimer, ["static"]);
    } // End of the function
    function setSpriteTimerAnim(sID, anim, bForced, nTimer)
    {
        var _loc2 = _oSprites.getItemAt(sID);
        if (_loc2 == undefined)
        {
            ank.utils.Logger.err("[setSpriteTimerAnim] Sprite inexistant");
            return;
        } // end if
        ank.utils.Timer.removeTimer(_loc2.mc, "battlefield");
        _loc2.mc.setAnimTimer(anim, false, bForced, nTimer);
    } // End of the function
    function setSpriteGfx(sID, sFile)
    {
        var _loc2 = _oSprites.getItemAt(sID);
        if (_loc2 == undefined)
        {
            ank.utils.Logger.err("[setSpriteGfx] Sprite inexistant");
            return;
        } // end if
        if (sFile != _loc2.__get__gfxFile())
        {
            _loc2.__set__gfxFile(sFile);
            _loc2.mc.draw();
        } // end if
    } // End of the function
    function setSpriteColorTransform(sID, t)
    {
        var _loc2 = _oSprites.getItemAt(sID);
        if (_loc2 == undefined)
        {
            ank.utils.Logger.err("[setSpriteColorTransform] Sprite inexistant");
            return;
        } // end if
        _loc2.mc.setColorTransform(t);
    } // End of the function
    function addSpriteExtraClip(sID, clipFile, col, bTop)
    {
        var _loc2 = _oSprites.getItemAt(sID);
        if (_loc2 == undefined)
        {
            ank.utils.Logger.err("[addSpriteExtraClip] Sprite inexistant");
            return;
        } // end if
        _loc2.mc.addExtraClip(clipFile, col, bTop);
    } // End of the function
    function removeSpriteExtraClip(sID, bTop)
    {
        var _loc2 = _oSprites.getItemAt(sID);
        if (_loc2 == undefined)
        {
            ank.utils.Logger.err("[removeSpriteExtraClip] Sprite inexistant");
            return;
        } // end if
        _loc2.mc.removeExtraClip(bTop);
    } // End of the function
    function showSpritePoints(sID, value, col)
    {
        var _loc2 = _oSprites.getItemAt(sID);
        if (_loc2 == undefined)
        {
            ank.utils.Logger.err("[showSpritePoints] Sprite inexistant");
            return;
        } // end if
        _loc2.mc.showPoints(value, col);
    } // End of the function
    function setSpriteGhostView(bool)
    {
        var _loc3 = _oSprites.getItems();
        for (var _loc5 in _loc3)
        {
            var _loc2 = _oSprites.getItemAt(_loc5);
            _loc2.mc.setGhostView(bool);
        } // end of for...in
    } // End of the function
    function selectSprite(sID, bSelect)
    {
        var _loc4 = _oSprites.getItemAt(sID);
        if (_loc4 == undefined)
        {
            ank.utils.Logger.err("[selectSprite] Sprite inexistant");
            return;
        } // end if
        if (_loc4.__get__hasChilds())
        {
            var _loc2 = _loc4.linkedChilds.getItems();
            for (var _loc5 in _loc2)
            {
                this.selectSprite(_loc2[_loc5].id, bSelect);
            } // end of for...in
        } // end if
        _loc4.mc.select(bSelect);
    } // End of the function
    static var DEFAULT_RUNLINIT = 6;
} // End of Class
#endinitclip
