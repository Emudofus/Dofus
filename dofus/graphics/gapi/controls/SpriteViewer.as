// Action script...

// [Initial MovieClip Action of sprite 20643]
#initclip 164
if (!dofus.graphics.gapi.controls.SpriteViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.SpriteViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__get__spriteData = function ()
    {
        return (this._oSpriteData);
    };
    _loc1.__set__spriteData = function (oData)
    {
        this._oSpriteData = oData;
        if (this.initialized)
        {
            this.addSpriteListeners();
            this.refreshDisplay();
        } // end if
        //return (this.spriteData());
    };
    _loc1.__get__enableBlur = function ()
    {
        return (this._bEnableBlur);
    };
    _loc1.__set__enableBlur = function (bState)
    {
        this._bEnableBlur = bState;
        this._mcSpriteA.onEnterFrame = this._mcSpriteB.onEnterFrame = undefined;
        (this._bCurrentSprite ? (this._mcSpriteA) : (this._mcSpriteB))._alpha = 100;
        (!this._bCurrentSprite ? (this._mcSpriteA) : (this._mcSpriteB))._alpha = 0;
        //return (this.enableBlur());
    };
    _loc1.__get__zoom = function ()
    {
        return (this._nZoom);
    };
    _loc1.__set__zoom = function (nValue)
    {
        this._nZoom = nValue;
        if (this.initialized)
        {
            this.refreshDisplay();
        } // end if
        //return (this.zoom());
    };
    _loc1.__get__allowAnimations = function ()
    {
        return (this._bAllowAnimations);
    };
    _loc1.__set__allowAnimations = function (bState)
    {
        this._bAllowAnimations = bState;
        this._mcInteraction._visible = bState;
        //return (this.allowAnimations());
    };
    _loc1.__get__noDelay = function ()
    {
        return (this._bNoDelay);
    };
    _loc1.__set__noDelay = function (bState)
    {
        this._bNoDelay = bState;
        //return (this.noDelay());
    };
    _loc1.__get__spriteAnims = function ()
    {
        return (this.SPRITE_ANIMS);
    };
    _loc1.__set__spriteAnims = function (a)
    {
        this.SPRITE_ANIMS = a;
        //return (this.spriteAnims());
    };
    _loc1.__get__refreshDelay = function ()
    {
        return (this.REFRESH_DELAY);
    };
    _loc1.__set__refreshDelay = function (n)
    {
        this.REFRESH_DELAY = n;
        //return (this.refreshDelay());
    };
    _loc1.__get__useSingleLoader = function ()
    {
        return (this._bUseSingleLoader);
    };
    _loc1.__set__useSingleLoader = function (b)
    {
        this._bUseSingleLoader = b;
        //return (this.useSingleLoader());
    };
    _loc1.refreshDisplay = function ()
    {
        if (this._nInterval > 0)
        {
            _global.clearInterval(this._nInterval);
        } // end if
        if (this._bNoDelay)
        {
            this.beginDisplay();
        }
        else
        {
            this._nInterval = _global.setInterval(this, "beginDisplay", this.REFRESH_DELAY);
        } // end else if
    };
    _loc1.getColor = function (nIndex)
    {
        return (this._oSpriteData["color" + nIndex] == undefined ? (-1) : (this._oSpriteData["color" + nIndex]));
    };
    _loc1.setColor = function (nIndex, nValue)
    {
        this._oSpriteData["color" + nIndex] = nValue;
        this.updateSprite();
    };
    _loc1.setColors = function (oColors)
    {
        this._oSpriteData.color1 = oColors.color1;
        this._oSpriteData.color2 = oColors.color2;
        this._oSpriteData.color3 = oColors.color3;
        this.updateSprite();
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.SpriteViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.refreshDisplay});
    };
    _loc1.addListeners = function ()
    {
        this._ldrSpriteA.addEventListener("initialization", this);
        this._ldrSpriteB.addEventListener("initialization", this);
        this.addSpriteListeners();
        this._mcInteraction.onRelease = function ()
        {
            this._parent.click({target: this});
        };
    };
    _loc1.addSpriteListeners = function ()
    {
        this._oSpriteData.addEventListener("gfxFileChanged", this);
        this._oSpriteData.addEventListener("accessoriesChanged", this);
    };
    _loc1.beginDisplay = function ()
    {
        _global.clearInterval(this._nInterval);
        this._nInterval = 0;
        if (this._oSpriteData == undefined)
        {
            return;
        } // end if
        if (this._bEnableBlur && !this._bUseSingleLoader)
        {
            var _loc2 = this._bCurrentSprite ? (this._ldrSpriteA) : (this._ldrSpriteB);
            this._bCurrentSprite = !this._bCurrentSprite;
            var _loc3 = this._bCurrentSprite ? (this._mcSpriteA) : (this._mcSpriteB);
        }
        else if (this._bUseSingleLoader)
        {
            _loc2 = this._ldrSpriteA;
            this._bCurrentSprite = false;
        }
        else
        {
            _loc2 = this._bCurrentSprite ? (this._ldrSpriteA) : (this._ldrSpriteB);
        } // end else if
        _loc2.forceReload = true;
        _loc2.contentPath = this._oSpriteData.gfxFile;
    };
    _loc1.attachAnimation = function (nIndex)
    {
        var _loc3 = this._mcSpriteA == undefined ? (true) : (this._mcSpriteA.attachMovie(this.SPRITE_ANIMS[nIndex], "mcAnim", 10));
        var _loc4 = this._mcSpriteB == undefined ? (true) : (this._mcSpriteB.attachMovie(this.SPRITE_ANIMS[nIndex], "mcAnim", 10));
        return (_loc3 && _loc4);
    };
    _loc1.applyZoom = function ()
    {
        if (this._mcSpriteA != undefined)
        {
            this._mcSpriteA._xscale = this._mcSpriteA._yscale = this._nZoom;
        } // end if
        if (this._mcSpriteB != undefined)
        {
            this._mcSpriteB._xscale = this._mcSpriteB._yscale = this._nZoom;
        } // end if
    };
    _loc1.playNextAnim = function (nStartingIndex)
    {
        if (nStartingIndex == undefined || _global.isNaN(nStartingIndex))
        {
            nStartingIndex = this._nSpriteAnimIndex;
        } // end if
        this._nSpriteAnimIndex = nStartingIndex;
        this._mcSpriteA.mcAnim.removeMovieClip();
        this._mcSpriteB.mcAnim.removeMovieClip();
        var _loc3 = this.attachAnimation(this._nSpriteAnimIndex);
        if (!_loc3 && --this._nAttempts)
        {
            this.addToQueue({object: this, method: this.playNextAnim, params: [this._nSpriteAnimIndex]});
            return;
        } // end if
        ++this._nSpriteAnimIndex;
        if (this._nSpriteAnimIndex > this.SPRITE_ANIMS.length)
        {
            this._nSpriteAnimIndex = 0;
        } // end if
        this._nAttempts = 10;
        if (!_loc3)
        {
            this.playNextAnim(this._nSpriteAnimIndex);
            return;
        } // end if
        this.applyZoom();
    };
    _loc1.updateSprite = function ()
    {
        this._mcSpriteA.mcAnim.removeMovieClip();
        this._mcSpriteB.mcAnim.removeMovieClip();
        this.attachAnimation(this._nSpriteAnimIndex - 1);
        this.applyZoom();
    };
    _loc1.destroy = function ()
    {
        _global.clearInterval(this._nInterval);
        this._nInterval = 0;
    };
    _loc1.initialization = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_ldrSpriteA":
            {
                this._mcCurrentSprite = this._mcSpriteA = oEvent.clip;
                this._mcOtherSprite = this._mcSpriteB;
                break;
            } 
            case "_ldrSpriteB":
            {
                this._mcCurrentSprite = this._mcSpriteB = oEvent.clip;
                this._mcOtherSprite = this._mcSpriteA;
                break;
            } 
        } // End of switch
        this.api.colors.addSprite(oEvent.target, this._oSpriteData);
        this.applyZoom();
        if (this._bEnableBlur)
        {
            this._mcOtherSprite._alpha = 100;
            this._mcCurrentSprite._alpha = 0;
            this._mcCurrentSprite.mcOther = this._mcOtherSprite;
            this._mcCurrentSprite.onEnterFrame = function ()
            {
                this._alpha = this._alpha + 10;
                this.mcOther._alpha = this.mcOther._alpha - 30;
                if (this._alpha >= 100 && this.mcOther._alpha <= 0)
                {
                    this._alpha = 100;
                    this.mcOther._alpha = 0;
                    this.onEnterFrame = undefined;
                } // end if
            };
        }
        else
        {
            this._mcCurrentSprite._alpha = 100;
            if (this._mcOtherSprite != undefined)
            {
                this._mcOtherSprite._alpha = 0;
            } // end if
        } // end else if
        this.addToQueue({object: this, method: this.playNextAnim, params: [this._nSpriteAnimIndex - 1]});
    };
    _loc1.click = function (oEvent)
    {
        this.playNextAnim();
    };
    _loc1.gfxFileChanged = function (oEvent)
    {
        this.refreshDisplay();
    };
    _loc1.accessoriesChanged = function (oEvent)
    {
        this.refreshDisplay();
    };
    _loc1.addProperty("allowAnimations", _loc1.__get__allowAnimations, _loc1.__set__allowAnimations);
    _loc1.addProperty("spriteData", _loc1.__get__spriteData, _loc1.__set__spriteData);
    _loc1.addProperty("spriteAnims", _loc1.__get__spriteAnims, _loc1.__set__spriteAnims);
    _loc1.addProperty("refreshDelay", _loc1.__get__refreshDelay, _loc1.__set__refreshDelay);
    _loc1.addProperty("enableBlur", _loc1.__get__enableBlur, _loc1.__set__enableBlur);
    _loc1.addProperty("useSingleLoader", _loc1.__get__useSingleLoader, _loc1.__set__useSingleLoader);
    _loc1.addProperty("noDelay", _loc1.__get__noDelay, _loc1.__set__noDelay);
    _loc1.addProperty("zoom", _loc1.__get__zoom, _loc1.__set__zoom);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.SpriteViewer = function ()
    {
        super();
    }).CLASS_NAME = "SpriteViewer";
    _loc1.REFRESH_DELAY = 500;
    _loc1.SPRITE_ANIMS = ["StaticF", "StaticR", "StaticL", "WalkF", "RunF", "Anim2R", "Anim2L"];
    _loc1._bEnableBlur = true;
    _loc1._nZoom = 200;
    _loc1._bAllowAnimations = true;
    _loc1._bUseSingleLoader = false;
    _loc1._bNoDelay = false;
    _loc1._nSpriteAnimIndex = 0;
    _loc1._bCurrentSprite = false;
    _loc1._nAttempts = 10;
} // end if
#endinitclip
