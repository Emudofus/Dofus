// Action script...

// [Initial MovieClip Action of sprite 842]
#initclip 54
class ank.battlefield.mc.Sprite extends MovieClip
{
    var _oData, _mcGfx, _mcBattlefield, _oSprites, _mvlLoader, _ACTION, createEmptyMovieClip, _mcXtraBack, _mcXtraTop, _x, _y, swapDepths, _visible, _alpha, _nDistance, _nLastTimer, _xscale, __get__animationClip, __get__data;
    function Sprite(b, sd, d)
    {
        super();
        this.initialize(b, sd, d);
    } // End of the function
    function get data()
    {
        return (_oData);
    } // End of the function
    function get animationClip()
    {
        return (_mcGfx.mcAnim);
    } // End of the function
    function initialize(b, sd, d)
    {
        _global.GAC.addSprite(this, d);
        _mcBattlefield = b;
        _oSprites = sd;
        _oData = d;
        _mvlLoader = new MovieClipLoader();
        _mvlLoader.addListener(this);
        this.setPosition(_oData.__get__cellNum());
        this.draw();
        _ACTION = d;
    } // End of the function
    function draw()
    {
        _mcGfx.removeMovieClip();
        this.createEmptyMovieClip("_mcGfx", 20);
        _bGfxLoaded = false;
        _mvlLoader.loadClip(_oData.__get__gfxFile(), _mcGfx);
    } // End of the function
    function clear(Void)
    {
        _mcBattlefield.mapHandler.getCellData(_oData.__get__cellNum()).removeSpriteOnID(_oData.id);
        _mcGfx.removeMovieClip();
        _oData.__set__direction(1);
        this.removeExtraClip();
        _oData.__set__isClear(true);
    } // End of the function
    function select(bool)
    {
        var _loc2 = new Object();
        if (bool)
        {
            _loc2 = {ra: 60, rb: 102, ga: 60, gb: 102, ba: 60, bb: 102};
        }
        else
        {
            _loc2 = {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0};
        } // end else if
        this.setColorTransform(_loc2);
    } // End of the function
    function addExtraClip(sFile, nColor, bTop)
    {
        if (sFile == undefined)
        {
            return;
        } // end if
        if (bTop == undefined)
        {
            bTop = false;
        } // end if
        this.removeExtraClip(bTop);
        if (bTop)
        {
            var _loc3 = new Object();
            _loc3.file = sFile;
            _loc3.color = nColor;
            _oData.xtraClipTopParams = _loc3;
            if (!_bGfxLoaded)
            {
                return;
            } // end if
        } // end if
        var _loc4 = bTop ? (_mcXtraTop) : (_mcXtraBack);
        _loc4.loadMovie(sFile);
        if (nColor != undefined)
        {
            var _loc5 = new Color(_loc4);
            _loc5.setRGB(nColor);
        } // end if
    } // End of the function
    function removeExtraClip(bTop)
    {
        switch (bTop)
        {
            case true:
            {
                _mcXtraTop.removeMovieClip();
                this.createEmptyMovieClip("_mcXtraTop", 30);
                break;
            } 
            case false:
            {
                _mcXtraBack.removeMovieClip();
                this.createEmptyMovieClip("_mcXtraBack", 10);
                break;
            } 
            default:
            {
                _mcXtraTop.removeMovieClip();
                _mcXtraBack.removeMovieClip();
                this.createEmptyMovieClip("_mcXtraTop", 30);
                this.createEmptyMovieClip("_mcXtraBack", 10);
                break;
            } 
        } // End of switch
    } // End of the function
    function setColorTransform(t)
    {
        var _loc2 = new Color(this);
        _loc2.setTransform(t);
    } // End of the function
    function setNewCellNum(nCellNum)
    {
        _oData.__set__cellNum(Number(nCellNum));
    } // End of the function
    function setDirection(nDir)
    {
        if (nDir == undefined)
        {
            nDir = _oData.direction;
        } // end if
        _oData.__set__direction(nDir);
        this.setAnim();
    } // End of the function
    function setPosition(nCellNum)
    {
        this.updateMap(nCellNum, _oData.__get__isVisible());
        this.setDepth(nCellNum);
        if (nCellNum == undefined)
        {
            nCellNum = _oData.cellNum;
        }
        else
        {
            this.setNewCellNum(nCellNum);
        } // end else if
        var _loc4 = _mcBattlefield.mapHandler.getCellData(nCellNum);
        var _loc3 = _mcBattlefield.mapHandler.getCellHeight(nCellNum);
        var _loc5 = _loc3 - Math.floor(_loc3);
        _x = _loc4.x;
        _y = _loc4.y - _loc5 * ank.battlefield.Constants.LEVEL_HEIGHT;
    } // End of the function
    function setDepth(nCellNum)
    {
        if (nCellNum == undefined)
        {
            nCellNum = _oData.cellNum;
        } // end if
        var _loc2 = ank.battlefield.utils.SpriteDepthFinder.getFreeDepthOnCell(_mcBattlefield.mapHandler, _oSprites, nCellNum, _mcBattlefield.bGhostView);
        this.swapDepths(_loc2);
    } // End of the function
    function setVisible(bool)
    {
        _oData.__set__isVisible(bool);
        _visible = bool;
        this.updateMap(_oData.__get__cellNum(), bool);
    } // End of the function
    function setAlpha(value)
    {
        _alpha = value;
    } // End of the function
    function setGhostView(bool)
    {
        this.setDepth();
        if (bool)
        {
            _nLastAlphaValue = _alpha;
            this.setAlpha(ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
        }
        else
        {
            this.setAlpha(_nLastAlphaValue);
        } // end else if
    } // End of the function
    function moveToCell(seq, cellNum, bStop, sSpeedType, sAnimation)
    {
        if (cellNum != _oData.__get__cellNum())
        {
            var _loc4 = _mcBattlefield.mapHandler.getCellData(_oData.__get__cellNum());
            var _loc3 = _mcBattlefield.mapHandler.getCellData(cellNum);
            var _loc7 = _loc3.x;
            var _loc6 = _loc3.y;
            var _loc9 = 1.000000E-002;
            if (_loc3.groundSlope != 1)
            {
                _loc6 = _loc6 - ank.battlefield.Constants.HALF_LEVEL_HEIGHT;
            } // end if
            if (sAnimation.toLowerCase() != "static")
            {
                _oData.__set__direction(ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(_loc4.x, _loc4.__get__rootY(), _loc7, _loc3.__get__rootY(), true));
            } // end if
            var _loc2;
            switch (sSpeedType)
            {
                case "slide":
                {
                    _loc2 = 2.500000E-001;
                    this.setAnim(sAnimation);
                    break;
                } 
                case "walk":
                case "run":
                {
                    _loc2 = ank.battlefield.mc.Sprite.WALK_SPEEDS[_oData.direction];
                    this.setAnim(sAnimation == undefined ? ("walk") : (sAnimation));
                    break;
                } 
                default:
                {
                    _loc2 = ank.battlefield.mc.Sprite.RUN_SPEEDS[_oData.direction];
                    this.setAnim(sAnimation == undefined ? ("run") : (sAnimation));
                    break;
                } 
            } // End of switch
            _loc2 = _loc2 * _oData.speedModerator;
            if (_loc3.groundLevel < _loc4.groundLevel)
            {
                _loc2 = _loc2 + _loc9;
            }
            else if (_loc3.groundLevel > _loc4.groundLevel)
            {
                _loc2 = _loc2 - _loc9;
            }
            else if (_loc4.groundSlope != _loc3.groundSlope)
            {
                if (_loc3.groundSlope == 1)
                {
                    _loc2 = _loc2 + _loc9;
                }
                else if (_loc4.groundSlope == 1)
                {
                    _loc2 = _loc2 - _loc9;
                } // end else if
            } // end else if
            _nDistance = Math.sqrt(Math.pow(_x - _loc7, 2) + Math.pow(_y - _loc6, 2));
            var _loc11 = Math.atan2(_loc6 - _y, _loc7 - _x);
            var _loc13 = Math.cos(_loc11);
            var _loc12 = Math.sin(_loc11);
            var _loc10 = Number(cellNum) > _oData.__get__cellNum();
            if (_loc10)
            {
                this.setDepth(cellNum);
            } // end if
            _nLastTimer = getTimer();
            this.updateMap(cellNum, _oData.__get__isVisible());
            this.setNewCellNum(cellNum);
            _oData.__set__isInMove(true);
            ank.utils.CyclicTimer.addFunction(this, this, basicMove, [_loc2, _loc13, _loc12], this, basicMoveEnd, [seq, _loc7, _loc6, cellNum, bStop, sSpeedType == "slide", !_loc10]);
        }
        else
        {
            seq.onActionEnd();
        } // end else if
    } // End of the function
    function basicMove(speed, cosRot, sinRot)
    {
        var _loc3 = getTimer() - _nLastTimer;
        var _loc2 = speed * (_loc3 > 50 ? (50) : (_loc3));
        _x = _x + _loc2 * cosRot;
        _y = _y + _loc2 * sinRot;
        _nDistance = _nDistance - _loc2;
        _nLastTimer = getTimer();
        if (_nDistance <= _loc2)
        {
            return (false);
        }
        else
        {
            return (true);
        } // end else if
    } // End of the function
    function basicMoveEnd(seq, xDest, yDest, cellNum, bStop, bSlide, bSetDepth)
    {
        if (bStop)
        {
            _x = xDest;
            _y = yDest;
            this.setAnim(_oData.__get__defaultAnimation());
            _oData.__set__isInMove(false);
        } // end if
        if (bSetDepth)
        {
            this.setDepth(cellNum);
        } // end if
        seq.onActionEnd();
    } // End of the function
    function setAnimTimer(anim, bLoop, bForced, nTimer)
    {
        this.setAnim(anim, bLoop, bForced);
        if (isNaN(Number(nTimer)))
        {
            return;
        } // end if
        if (nTimer < 1)
        {
            return;
        } // end if
        ank.utils.Timer.setTimer(this, "battlefield", this, setAnim, nTimer, [_oData.__get__defaultAnimation()]);
    } // End of the function
    function setAnim(anim, bLoop, bForced)
    {
        if (anim == undefined)
        {
            anim = _oData.defaultAnimation;
        } // end if
        anim = String(anim).toLowerCase();
        if (bLoop == undefined)
        {
            bLoop = false;
        } // end if
        if (bForced == undefined)
        {
            bForced = false;
        } // end if
        _oData.bAnimLoop = bLoop;
        var _loc5 = _mcGfx;
        var _loc2;
        var _loc4;
        switch (_oData.__get__direction())
        {
            case 0:
            {
                _loc2 = anim + "S";
                _loc4 = "staticR";
                _xscale = 100;
                break;
            } 
            case 1:
            {
                _loc2 = anim + "R";
                _loc4 = "staticR";
                _xscale = 100;
                break;
            } 
            case 2:
            {
                _loc2 = anim + "F";
                _loc4 = "staticR";
                _xscale = 100;
                break;
            } 
            case 3:
            {
                _loc2 = anim + "R";
                _loc4 = "staticR";
                _xscale = -100;
                break;
            } 
            case 4:
            {
                _loc2 = anim + "S";
                _loc4 = "staticL";
                _xscale = -100;
                break;
            } 
            case 5:
            {
                _loc2 = anim + "L";
                _loc4 = "staticL";
                _xscale = 100;
                break;
            } 
            case 6:
            {
                _loc2 = anim + "B";
                _loc4 = "staticL";
                _xscale = 100;
                break;
            } 
            case 7:
            {
                _loc2 = anim + "L";
                _loc4 = "staticL";
                _xscale = -100;
                break;
            } 
        } // End of switch
        var _loc9 = _oData.fullAnimation;
        var _loc6 = _oData.animation;
        _oData.animation = anim;
        _oData.fullAnimation = _loc2;
        if (_oData.xtraClipTopAnimations != undefined)
        {
            if (_oData.xtraClipTopAnimations[_loc2])
            {
                this.addExtraClip(_oData.xtraClipTopParams.file, _oData.xtraClipTopParams.color, true);
            }
            else if (_mcXtraTop != undefined)
            {
                this.removeExtraClip(true);
            } // end if
        } // end else if
        if (bForced || _loc2 != _loc9)
        {
            _loc5.mcAnim.removeMovieClip();
            if (_loc5.attachMovie(_loc2, "mcAnim", 10, {lastAnimation: _loc6}) == undefined)
            {
                _loc5.attachMovie(_loc4, "mcAnim", 10, {lastAnimation: _loc6});
                ank.utils.Logger.err("L\'anim (" + _loc2 + ") n\'existe pas !");
            } // end if
        } // end if
    } // End of the function
    function updateMap(nCellNum, bVisible)
    {
        var _loc2 = _mcBattlefield.mapHandler.getCellData(nCellNum);
        if (_loc2 == undefined)
        {
            if (bVisible)
            {
                _mcBattlefield.mapHandler.getCellData(_oData.__get__cellNum()).addSpriteOnID(_oData.id);
            }
            else
            {
                _mcBattlefield.mapHandler.getCellData(_oData.__get__cellNum()).removeSpriteOnID(_oData.id);
            } // end else if
            return;
        } // end if
        _mcBattlefield.mapHandler.getCellData(_oData.__get__cellNum()).removeSpriteOnID(_oData.id);
        if (bVisible)
        {
            _loc2.addSpriteOnID(_oData.id);
        } // end if
    } // End of the function
    function onLoadInit(mc)
    {
        function onEnterFrame()
        {
            _bGfxLoaded = true;
            if (isNaN(Number(_oData.startAnimationTimer)))
            {
                this.setAnim(_oData.startAnimation, undefined, true);
            }
            else
            {
                this.setAnimTimer(_oData.startAnimation, false, false, _oData.startAnimationTimer);
            } // end else if
            delete this.onEnterFrame;
        } // End of the function
    } // End of the function
    function _release(Void)
    {
        _mcBattlefield.onSpriteRelease(this);
    } // End of the function
    function _rollOver(Void)
    {
        _mcBattlefield.onSpriteRollOver(this);
    } // End of the function
    function _rollOut(Void)
    {
        _mcBattlefield.onSpriteRollOut(this);
    } // End of the function
    var _nLastAlphaValue = 100;
    var _bGfxLoaded = false;
    static var WALK_SPEEDS = [7.000000E-002, 6.000000E-002, 6.000000E-002, 6.000000E-002, 7.000000E-002, 6.000000E-002, 6.000000E-002, 6.000000E-002];
    static var RUN_SPEEDS = [1.700000E-001, 1.500000E-001, 1.500000E-001, 1.500000E-001, 1.700000E-001, 1.500000E-001, 1.500000E-001, 1.500000E-001];
} // End of Class
#endinitclip
