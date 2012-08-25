// Action script...

// [Initial MovieClip Action of sprite 20967]
#initclip 232
if (!ank.battlefield.mc.Sprite)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    if (!ank.battlefield.mc)
    {
        _global.ank.battlefield.mc = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.mc.Sprite = function (b, sd, d)
    {
        super();
        this.initialize(b, sd, d);
    }).prototype;
    _loc1.__get__data = function ()
    {
        return (this._oData);
    };
    _loc1.__set__mcCarried = function (mc)
    {
        this._mcCarried = mc;
        //return (this.mcCarried());
    };
    _loc1.__set__mcChevauchorPos = function (mc)
    {
        this._mcChevauchorPos = mc;
        //return (this.mcChevauchorPos());
    };
    _loc1.__set__isHidden = function (b)
    {
        this.setHidden(b);
        //return (this.isHidden());
    };
    _loc1.__get__isHidden = function ()
    {
        return (this._bHidden);
    };
    _loc1.initialize = function (b, sd, d)
    {
        _global.GAC.addSprite(this, d);
        this._mcBattlefield = b;
        this._oSprites = sd;
        this._oData = d;
        this._mvlLoader = new MovieClipLoader();
        this._mvlLoader.addListener(this);
        this.setPosition(this._oData.cellNum);
        this.draw();
        this._ACTION = d;
    };
    _loc1.draw = function ()
    {
        this._mcGfx.removeMovieClip();
        this.createEmptyMovieClip("_mcGfx", 20);
        this.setHidden(this._bHidden);
        this._bGfxLoaded = false;
        this._bChevauchorGfxLoaded = false;
        this._mvlLoader.loadClip(!this._oData.isMounting ? (this._oData.gfxFile) : (this._oData.mount.gfxFile), this._mcGfx);
    };
    _loc1.clear = function (Void)
    {
        this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum).removeSpriteOnID(this._oData.id);
        this._mcGfx.removeMovieClip();
        this._oData.direction = 1;
        this.removeExtraClip();
        this._oData.isClear = true;
    };
    _loc1.select = function (bool)
    {
        var _loc3 = new Object();
        if (bool)
        {
            _loc3 = {ra: 60, rb: 102, ga: 60, gb: 102, ba: 60, bb: 102};
        }
        else
        {
            _loc3 = {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0};
        } // end else if
        this.setColorTransform(_loc3);
    };
    _loc1.addExtraClip = function (sFile, nColor, bTop)
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
            var _loc5 = new Object();
            _loc5.file = sFile;
            _loc5.color = nColor;
            this._oData.xtraClipTopParams = _loc5;
            if (!this._bGfxLoaded)
            {
                return;
            } // end if
        } // end if
        var _loc6 = bTop ? (this._mcXtraTop) : (this._mcXtraBack);
        _loc6.loadMovie(sFile);
        if (nColor != undefined)
        {
            var _loc7 = new Color(_loc6);
            _loc7.setRGB(nColor);
        } // end if
    };
    _loc1.removeExtraClip = function (bTop)
    {
        switch (bTop)
        {
            case true:
            {
                this._mcXtraTop.removeMovieClip();
                this.createEmptyMovieClip("_mcXtraTop", 30);
                break;
            } 
            case false:
            {
                this._mcXtraBack.removeMovieClip();
                this.createEmptyMovieClip("_mcXtraBack", 10);
                break;
            } 
            default:
            {
                this._mcXtraTop.removeMovieClip();
                this._mcXtraBack.removeMovieClip();
                this.createEmptyMovieClip("_mcXtraTop", 30);
                this.createEmptyMovieClip("_mcXtraBack", 10);
                break;
            } 
        } // End of switch
    };
    _loc1.setColorTransform = function (t)
    {
        var _loc3 = new Color(this);
        _loc3.setTransform(t);
    };
    _loc1.setNewCellNum = function (nCellNum)
    {
        this._oData.cellNum = Number(nCellNum);
    };
    _loc1.setDirection = function (nDir)
    {
        if (nDir == undefined)
        {
            nDir = this._oData.direction;
        } // end if
        this._oData.direction = nDir;
        this.setAnim(this._oData.animation);
    };
    _loc1.setPosition = function (nCellNum)
    {
        this.updateMap(nCellNum, this._oData.isVisible);
        this.setDepth(nCellNum);
        if (nCellNum == undefined)
        {
            nCellNum = this._oData.cellNum;
        }
        else
        {
            this.setNewCellNum(nCellNum);
        } // end else if
        var _loc3 = this._mcBattlefield.mapHandler.getCellData(nCellNum);
        var _loc4 = this._mcBattlefield.mapHandler.getCellHeight(nCellNum);
        var _loc5 = _loc4 - Math.floor(_loc4);
        this._x = _loc3.x;
        this._y = _loc3.y - _loc5 * ank.battlefield.Constants.LEVEL_HEIGHT;
    };
    _loc1.setDepth = function (nCellNum)
    {
        if (nCellNum == undefined)
        {
            nCellNum = this._oData.cellNum;
        } // end if
        var _loc3 = ank.battlefield.utils.SpriteDepthFinder.getFreeDepthOnCell(this._mcBattlefield.mapHandler, this._oSprites, nCellNum, this._mcBattlefield.bGhostView && this._oData.allowGhostMode);
        this.swapDepths(_loc3);
        if (this._oData.hasCarriedChild())
        {
            this._oData.carriedChild.mc.setDepth(nCellNum);
        } // end if
    };
    _loc1.setVisible = function (bool)
    {
        this._oData.isVisible = bool;
        this._visible = bool;
        this.updateMap(this._oData.cellNum, bool);
    };
    _loc1.setAlpha = function (value)
    {
        this._mcGfx._alpha = value;
    };
    _loc1.setHidden = function (b)
    {
        this._bHidden = b;
        if (this._bHidden)
        {
            this._mcGfx._x = this._mcGfx._y = -5000;
            this._mcGfx._visible = false;
        }
        else
        {
            this._mcGfx._x = this._mcGfx._y = 0;
            this._mcGfx._visible = true;
        } // end else if
    };
    _loc1.setGhostView = function (bool)
    {
        this.setDepth();
        if (bool)
        {
            this._nLastAlphaValue = this._mcGfx._alpha;
            this.setAlpha(ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
        }
        else
        {
            this.setAlpha(this._nLastAlphaValue);
        } // end else if
    };
    _loc1.moveToCell = function (seq, cellNum, bStop, sSpeedType, sAnimation, bForceAnimation)
    {
        if (cellNum != this._oData.cellNum)
        {
            var _loc8 = this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum);
            var _loc9 = this._mcBattlefield.mapHandler.getCellData(cellNum);
            var _loc10 = _loc9.x;
            var _loc11 = _loc9.y;
            var _loc12 = 1.000000E-002;
            if (_loc9.groundSlope != 1)
            {
                _loc11 = _loc11 - ank.battlefield.Constants.HALF_LEVEL_HEIGHT;
            } // end if
            if (sAnimation.toLowerCase() != "static")
            {
                this._oData.direction = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(_loc8.x, _loc8.rootY, _loc10, _loc9.rootY, true);
            } // end if
            switch (sSpeedType)
            {
                case "slide":
                {
                    var _loc13 = 2.500000E-001;
                    this.setAnim(sAnimation);
                    break;
                } 
                case "walk":
                case "run":
                {
                    _loc13 = ank.battlefield.mc.Sprite.WALK_SPEEDS[this._oData.direction];
                    this.setAnim(sAnimation == undefined ? ("walk") : (sAnimation), undefined, bForceAnimation);
                    break;
                } 
                default:
                {
                    _loc13 = !this._oData.isMounting ? (ank.battlefield.mc.Sprite.RUN_SPEEDS[this._oData.direction]) : (ank.battlefield.mc.Sprite.MOUNT_SPEEDS[this._oData.direction]);
                    this.setAnim(sAnimation == undefined ? ("run") : (sAnimation), undefined, bForceAnimation);
                    break;
                } 
            } // End of switch
            _loc13 = _loc13 * this._oData.speedModerator;
            if (_loc9.groundLevel < _loc8.groundLevel)
            {
                _loc13 = _loc13 + _loc12;
            }
            else if (_loc9.groundLevel > _loc8.groundLevel)
            {
                _loc13 = _loc13 - _loc12;
            }
            else if (_loc8.groundSlope != _loc9.groundSlope)
            {
                if (_loc9.groundSlope == 1)
                {
                    _loc13 = _loc13 + _loc12;
                }
                else if (_loc8.groundSlope == 1)
                {
                    _loc13 = _loc13 - _loc12;
                } // end else if
            } // end else if
            this._nDistance = Math.sqrt(Math.pow(this._x - _loc10, 2) + Math.pow(this._y - _loc11, 2));
            var _loc14 = Math.atan2(_loc11 - this._y, _loc10 - this._x);
            var _loc15 = Math.cos(_loc14);
            var _loc16 = Math.sin(_loc14);
            this._nLastTimer = getTimer();
            var _loc17 = Number(cellNum) > this._oData.cellNum;
            this.updateMap(cellNum, this._oData.isVisible, true);
            this.setNewCellNum(cellNum);
            this._oData.isInMove = true;
            if (this._oData.hasCarriedChild())
            {
                var _loc18 = this._oData.carriedChild;
                var _loc19 = _loc18.mc;
                _loc19.setDirection(this._oData.direction);
                _loc19.updateMap(cellNum, _loc18.isVisible);
                _loc19.setNewCellNum(cellNum);
            } // end if
            if (_loc17)
            {
                this.setDepth(cellNum);
            } // end if
            ank.utils.CyclicTimer.addFunction(this, this, this.basicMove, [_loc13, _loc15, _loc16], this, this.basicMoveEnd, [seq, _loc10, _loc11, cellNum, bStop, sSpeedType == "slide", !_loc17]);
        }
        else
        {
            seq.onActionEnd();
        } // end else if
    };
    _loc1.basicMove = function (speed, cosRot, sinRot)
    {
        var _loc5 = getTimer() - this._nLastTimer;
        var _loc6 = speed * (_loc5 > 50 ? (50) : (_loc5));
        this._x = this._x + _loc6 * cosRot;
        this._y = this._y + _loc6 * sinRot;
        this._nDistance = this._nDistance - _loc6;
        this._nLastTimer = getTimer();
        if (this._nDistance <= _loc6)
        {
            return (false);
        }
        else
        {
            return (true);
        } // end else if
    };
    _loc1.basicMoveEnd = function (seq, xDest, yDest, cellNum, bStop, bSlide, bSetDepth)
    {
        if (this._nOldCellNum != undefined)
        {
            this._mcBattlefield.mapHandler.getCellData(this._nOldCellNum).removeSpriteOnID(this._oData.id);
            this._nOldCellNum = undefined;
        } // end if
        if (bStop)
        {
            this._x = xDest;
            this._y = yDest;
            this.setAnim(this._oData.defaultAnimation);
            this._oData.isInMove = false;
        } // end if
        if (bSetDepth)
        {
            this.setDepth(cellNum);
        } // end if
        seq.onActionEnd();
    };
    _loc1.saveLastAnimation = function (sAnim)
    {
        if (!this._oData.isMounting)
        {
            this._mcGfx.mcAnim.lastAnimation = sAnim;
        }
        else
        {
            this._mcChevauchor.mcAnim.lastAnimation = sAnim;
            this._mcGfx.mcAnimFront.lastAnimation = sAnim;
            this._mcGfx.mcAnimBack.lastAnimation = sAnim;
        } // end else if
    };
    _loc1.setAnimTimer = function (anim, bLoop, bForced, nTimer)
    {
        this.setAnim(anim, bLoop, bForced);
        if (_global.isNaN(Number(nTimer)))
        {
            return;
        } // end if
        if (nTimer < 1)
        {
            return;
        } // end if
        ank.utils.Timer.setTimer(this, "battlefield", this, this.setAnim, nTimer, [this._oData.defaultAnimation]);
    };
    _loc1.setAnim = function (anim, bLoop, bForced)
    {
        if (anim == undefined)
        {
            anim = this._oData.defaultAnimation;
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
        var _loc5 = this._oData.noFlip;
        this._oData.bAnimLoop = bLoop;
        var _loc6 = this._mcGfx;
        var _loc7 = "";
        if (this._oData.hasCarriedChild())
        {
            _loc7 = _loc7 + "_C";
        } // end if
        switch (this._oData.direction)
        {
            case 0:
            {
                var _loc10 = "S";
                var _loc8 = anim + _loc7 + _loc10;
                var _loc9 = "staticR";
                this._xscale = 100;
                break;
            } 
            case 1:
            {
                _loc10 = "R";
                _loc8 = anim + _loc7 + _loc10;
                _loc9 = "staticR";
                this._xscale = 100;
                break;
            } 
            case 2:
            {
                _loc10 = "F";
                _loc8 = anim + _loc7 + _loc10;
                _loc9 = "staticR";
                this._xscale = 100;
                break;
            } 
            case 3:
            {
                _loc10 = "R";
                _loc8 = anim + _loc7 + _loc10;
                _loc9 = "staticR";
                if (!_loc5)
                {
                    this._xscale = -100;
                } // end if
                break;
            } 
            case 4:
            {
                _loc10 = "S";
                _loc8 = anim + _loc7 + _loc10;
                _loc9 = "staticL";
                if (!_loc5)
                {
                    this._xscale = -100;
                } // end if
                break;
            } 
            case 5:
            {
                _loc10 = "L";
                _loc8 = anim + _loc7 + _loc10;
                _loc9 = "staticL";
                this._xscale = 100;
                break;
            } 
            case 6:
            {
                _loc10 = "B";
                _loc8 = anim + _loc7 + _loc10;
                _loc9 = "staticL";
                this._xscale = 100;
                break;
            } 
            case 7:
            {
                _loc10 = "L";
                _loc8 = anim + _loc7 + _loc10;
                _loc9 = "staticL";
                if (!_loc5)
                {
                    this._xscale = -100;
                } // end if
                break;
            } 
        } // End of switch
        var _loc11 = this._oData.fullAnimation;
        var _loc12 = this._oData.animation;
        this._oData.animation = anim;
        this._oData.fullAnimation = _loc8;
        if (this._oData.xtraClipTopAnimations != undefined)
        {
            if (this._oData.xtraClipTopAnimations[_loc8])
            {
                this.addExtraClip(this._oData.xtraClipTopParams.file, this._oData.xtraClipTopParams.color, true);
            }
            else if (this._mcXtraTop != undefined)
            {
                this.removeExtraClip(true);
            } // end if
        } // end else if
        if (bForced || _loc8 != _loc11)
        {
            if (!this._oData.isMounting)
            {
                _loc6.mcAnim.removeMovieClip();
                if (_loc6.attachMovie(_loc8, "mcAnim", 10, {lastAnimation: _loc12}) == undefined)
                {
                    _loc6.attachMovie("static" + _loc10, "mcAnim", 10, {lastAnimation: _loc12});
                    ank.utils.Logger.err("L\'anim (" + _loc8 + ") n\'existe pas !");
                } // end if
                if (ank.battlefield.Battlefield.useCacheAsBitmapOnStaticAnim)
                {
                    (MovieClip)(_loc6.mcAnim).cacheAsBitmap = (MovieClip)(_loc6.mcAnim)._totalframes == 1;
                } // end if
            }
            else
            {
                this._mcChevauchor.mcAnim.removeMovieClip();
                _loc6.mcAnimFront.removeMovieClip();
                _loc6.mcAnimBack.removeMovieClip();
                if (this._mcChevauchor.attachMovie(_loc8, "mcAnim", 1, {lastAnimation: _loc12}) == undefined)
                {
                    this._mcChevauchor.attachMovie("static" + _loc10, "mcAnim", 1, {lastAnimation: _loc12});
                } // end if
                if (_loc6.attachMovie(_loc8 + "_Front", "mcAnimFront", 30, {lastAnimation: _loc12}) == undefined)
                {
                    _loc6.attachMovie("static" + _loc10 + "_Front", "mcAnimFront", 30, {lastAnimation: _loc12});
                } // end if
                if (_loc6.attachMovie(_loc8 + "_Back", "mcAnimBack", 10, {lastAnimation: _loc12}) == undefined)
                {
                    _loc6.attachMovie("static" + _loc10 + "_Back", "mcAnimBack", 10, {lastAnimation: _loc12});
                } // end if
            } // end if
        } // end else if
        if (this._oData.hasCarriedChild())
        {
            ank.utils.CyclicTimer.addFunction(this, this, this.updateCarriedPosition);
        } // end if
        if (this._oData.isMounting)
        {
            this.chevauchorUpdater = this.createEmptyMovieClip("chevauchorUpdater", 1000);
            this.chevauchorUpdater.sprite = this;
            this.chevauchorUpdater.onEnterFrame = function ()
            {
                this.sprite.updateChevauchorPosition();
            };
        } // end if
    };
    _loc1.updateCarriedPosition = function ()
    {
        if (this._oData.hasCarriedChild())
        {
            if (this._mcCarried != undefined)
            {
                var _loc2 = {x: this._mcCarried._x, y: this._mcCarried._y};
                this._mcCarried._parent.localToGlobal(_loc2);
                this._mcBattlefield.container.globalToLocal(_loc2);
                this._oData.carriedChild.mc._x = _loc2.x;
                this._oData.carriedChild.mc._y = _loc2.y;
            } // end if
        } // end if
        return (this._oData.animation != "static" ? (true) : (false));
    };
    _loc1.updateChevauchorPosition = function ()
    {
        if (this._oData.isMounting)
        {
            if (this._mcChevauchorPos != undefined)
            {
                var _loc2 = {x: this._mcChevauchorPos._x, y: this._mcChevauchorPos._y};
                this._mcChevauchorPos._parent.localToGlobal(_loc2);
                this._mcGfx.globalToLocal(_loc2);
                this._mcChevauchor._x = _loc2.x;
                this._mcChevauchor._y = _loc2.y;
                this._mcChevauchor._rotation = this._mcChevauchorPos._rotation;
                this._mcChevauchor._xscale = this._mcChevauchorPos._xscale;
                this._mcChevauchor._yscale = this._mcChevauchorPos._yscale;
            } // end if
        } // end if
        if (this._oData.animation == "static")
        {
            this.chevauchorUpdater.removeMovieClip();
        } // end if
        return (true);
    };
    _loc1.updateMap = function (nCellNum, bVisible, bDontRemoveAllSpriteOn)
    {
        var _loc5 = this._mcBattlefield.mapHandler.getCellData(nCellNum);
        if (_loc5 == undefined)
        {
            if (bVisible)
            {
                this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum).addSpriteOnID(this._oData.id);
            }
            else
            {
                this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum).removeSpriteOnID(this._oData.id);
            } // end else if
            return;
        } // end if
        if (bDontRemoveAllSpriteOn != true)
        {
            this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum).removeSpriteOnID(this._oData.id);
        }
        else
        {
            this._nOldCellNum = this._oData.cellNum;
        } // end else if
        if (bVisible)
        {
            _loc5.addSpriteOnID(this._oData.id);
        } // end if
    };
    _loc1.setScale = function (nScaleX, nScaleY)
    {
        this._mcGfx._xscale = nScaleX;
        this._mcGfx._yscale = nScaleY != undefined ? (nScaleY) : (nScaleX);
    };
    _loc1.onLoadInit = function (mc)
    {
        this.onEnterFrame = function ()
        {
            if (!this._bGfxLoaded)
            {
                this._bGfxLoaded = true;
                if (this._oData.isMounting)
                {
                    this._mcChevauchor = this._mcGfx.createEmptyMovieClip("chevauchor", 20);
                    this._mvlLoader.loadClip(this._oData.mount.chevauchorGfxFile, this._mcChevauchor);
                } // end if
            }
            else
            {
                this._bChevauchorGfxLoaded = true;
            } // end else if
            if (this._bGfxLoaded && (!this._oData.isMounting || this._bChevauchorGfxLoaded))
            {
                if (_global.isNaN(Number(this._oData.startAnimationTimer)))
                {
                    this.setAnim(this._oData.startAnimation, undefined, true);
                }
                else
                {
                    this.setAnimTimer(this._oData.startAnimation, false, false, this._oData.startAnimationTimer);
                } // end else if
                delete this.onEnterFrame;
            } // end if
        };
    };
    _loc1._release = function (Void)
    {
        this._mcBattlefield.onSpriteRelease(this);
    };
    _loc1._rollOver = function (Void)
    {
        this._mcBattlefield.onSpriteRollOver(this);
    };
    _loc1._rollOut = function (Void)
    {
        this._mcBattlefield.onSpriteRollOut(this);
    };
    _loc1.addProperty("data", _loc1.__get__data, function ()
    {
    });
    _loc1.addProperty("mcChevauchorPos", function ()
    {
    }, _loc1.__set__mcChevauchorPos);
    _loc1.addProperty("mcCarried", function ()
    {
    }, _loc1.__set__mcCarried);
    _loc1.addProperty("isHidden", _loc1.__get__isHidden, _loc1.__set__isHidden);
    ASSetPropFlags(_loc1, null, 1);
    _loc1._nLastAlphaValue = 100;
    _loc1._bGfxLoaded = false;
    _loc1._bChevauchorGfxLoaded = false;
    (_global.ank.battlefield.mc.Sprite = function (b, sd, d)
    {
        super();
        this.initialize(b, sd, d);
    }).WALK_SPEEDS = [7.000000E-002, 6.000000E-002, 6.000000E-002, 6.000000E-002, 7.000000E-002, 6.000000E-002, 6.000000E-002, 6.000000E-002];
    (_global.ank.battlefield.mc.Sprite = function (b, sd, d)
    {
        super();
        this.initialize(b, sd, d);
    }).MOUNT_SPEEDS = [2.300000E-001, 2.000000E-001, 2.000000E-001, 2.000000E-001, 2.300000E-001, 2.000000E-001, 2.000000E-001, 2.000000E-001];
    (_global.ank.battlefield.mc.Sprite = function (b, sd, d)
    {
        super();
        this.initialize(b, sd, d);
    }).RUN_SPEEDS = [1.700000E-001, 1.500000E-001, 1.500000E-001, 1.500000E-001, 1.700000E-001, 1.500000E-001, 1.500000E-001, 1.500000E-001];
} // end if
#endinitclip
