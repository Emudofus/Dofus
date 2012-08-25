// Action script...

// [Initial MovieClip Action of sprite 20775]
#initclip 40
if (!dofus.graphics.gapi.controls.ClassSelector)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.ClassSelector = function ()
    {
        super();
    }).prototype;
    _loc1.__get__xRay = function ()
    {
        return (this._xRay);
    };
    _loc1.__set__xRay = function (n)
    {
        this._xRay = n;
        //return (this.xRay());
    };
    _loc1.__get__yRay = function ()
    {
        return (this._yRay);
    };
    _loc1.__set__yRay = function (n)
    {
        this._yRay = n;
        //return (this.yRay());
    };
    _loc1.__get__minScale = function ()
    {
        return (this._minScale);
    };
    _loc1.__set__minScale = function (n)
    {
        this._minScale = n;
        //return (this.minScale());
    };
    _loc1.__get__maxScale = function ()
    {
        return (this._maxScale);
    };
    _loc1.__set__maxScale = function (n)
    {
        this._maxScale = n;
        //return (this.maxScale());
    };
    _loc1.__get__minAlpha = function ()
    {
        return (this._minAlpha);
    };
    _loc1.__set__minAlpha = function (n)
    {
        this._minAlpha = n;
        //return (this.minAlpha());
    };
    _loc1.__get__maxAlpha = function ()
    {
        return (this._maxAlpha);
    };
    _loc1.__set__maxAlpha = function (n)
    {
        this._maxAlpha = n;
        //return (this.maxAlpha());
    };
    _loc1.__get__clipsList = function ()
    {
        return (this._aClipList);
    };
    _loc1.__set__clipsList = function (a)
    {
        if (this._aClipList.length == a.length)
        {
            this._nLoaded = 0;
            var _loc3 = 0;
            
            while (++_loc3, _loc3 < a.length)
            {
                this._aLoaders[_loc3] = new MovieClipLoader();
                this._aLoaders[_loc3].addListener(this);
                this._aLoaders[_loc3].loadClip(a[_loc3 == 0 ? (0) : (a.length - _loc3)], this._aClips[_loc3]);
                this._aClips[_loc3]._visible = false;
            } // end while
        } // end if
        this._aClipList = a;
        //return (this.clipsList());
    };
    _loc1.__get__animation = function ()
    {
        return (this._bAnimation);
    };
    _loc1.__set__animation = function (b)
    {
        this._bAnimation = b;
        //return (this.animation());
    };
    _loc1.__get__animationSpeed = function ()
    {
        return (this._nAnimationSpeed);
    };
    _loc1.__set__animationSpeed = function (n)
    {
        this._nAnimationSpeed = n;
        //return (this.animationSpeed());
    };
    _loc1.__get__currentIndex = function ()
    {
        return (this._nCurrentIndex == this._aClipList.length ? (0) : (this._nCurrentIndex));
    };
    _loc1.__set__currentIndex = function (n)
    {
        this.swapTo(n, true);
        //return (this.currentIndex());
    };
    _loc1.__get__clips = function ()
    {
        return (this._aClips);
    };
    _loc1.initialize = function (newList)
    {
        this._aClipList = newList;
        this.drawComponent();
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.ClassSelector.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
    };
    _loc1.drawComponent = function ()
    {
        var _loc2 = Math.PI / 180 * 90;
        this._nLoaded = 0;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._aClipList.length)
        {
            this._aClips[_loc3] = this.createEmptyMovieClip("node" + (this._aClipList.length - _loc3), this._aClipList.length - _loc3);
            this._aLoaders[_loc3] = new MovieClipLoader();
            this._aLoaders[_loc3].addListener(this);
            this._aLoaders[_loc3].loadClip(this._aClipList[_loc3 == 0 ? (0) : (this._aClipList.length - _loc3)], this._aClips[_loc3]);
            this._aClips[_loc3]._visible = false;
        } // end while
    };
    _loc1.update = function ()
    {
        var _loc2 = Math.PI / 180 * 90;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._aClips.length)
        {
            this._aClips[_loc3]._x = Math.cos(_loc2 + this._nCurrentPosition) * this._xRay;
            this._aClips[_loc3]._y = Math.sin(_loc2 + this._nCurrentPosition) * this._yRay;
            var _loc4 = (this._aClips[_loc3]._y + this._yRay) / (this._yRay * 2) * (this._maxScale - this._minScale) + this._minScale;
            this._aClips[_loc3]._xscale = this._aClips[_loc3]._yscale = _loc4 <= 0 ? (1) : (_loc4);
            this._aClips[_loc3]._alpha = (this._aClips[_loc3]._y + this._yRay) / (this._yRay * 2) * (this._maxAlpha - this._minAlpha) + this._minAlpha;
            this._aClips[_loc3]._visible = this._aClips[_loc3]._y > 0;
            if (this._aClips[_loc3]._visible)
            {
                var _loc5 = Math.floor((_loc2 + this._nCurrentPosition) * 180 / Math.PI % 360);
                var _loc6 = Math.floor(360 / this._aClips.length);
                this._aClips[_loc3].slideIter = -Math.ceil((_loc5 - 90) / _loc6);
                var ref = this;
                this._aClips[_loc3].onRelease = function ()
                {
                    ref.slide(this.slideIter);
                };
            } // end if
            _loc2 = _loc2 + Math.PI / 180 * (360 / this._aClips.length);
        } // end while
    };
    _loc1.garbageCollector = function ()
    {
        var _loc2 = new Array();
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._aRegisteredColors.length)
        {
            if (this._aRegisteredColors[_loc3].mc != undefined)
            {
                _loc2.push(this._aRegisteredColors[_loc3]);
            } // end if
        } // end while
        this._aRegisteredColors = _loc2;
    };
    _loc1.registerColor = function (mc, c)
    {
        this._aRegisteredColors.push({mc: mc, z: c});
        this.garbageCollector();
    };
    _loc1.updateColor = function (zone, color)
    {
        if (this._nLoaded < this._aClipList.length)
        {
            this._aUpdateOnLoaded[zone] = color;
        }
        else
        {
            var _loc4 = 0;
            
            while (++_loc4, _loc4 < this._aRegisteredColors.length)
            {
                if (this._aRegisteredColors[_loc4].z == zone)
                {
                    this.applyColor(this._aRegisteredColors[_loc4].mc, this._aRegisteredColors[_loc4].z, color);
                } // end if
            } // end while
        } // end else if
    };
    _loc1.applyColor = function (mc, zone, color)
    {
        if (color == -1 || color == undefined)
        {
            var _loc5 = new Color(mc);
            _loc5.setTransform({ra: 100, ga: 100, ba: 100, rb: 0, gb: 0, bb: 0});
            return;
        } // end if
        var _loc6 = (color & 16711680) >> 16;
        var _loc7 = (color & 65280) >> 8;
        var _loc8 = color & 255;
        var _loc9 = new Color(mc);
        var _loc10 = new Object();
        _loc10 = {ra: 0, ga: 0, ba: 0, rb: _loc6, gb: _loc7, bb: _loc8};
        _loc9.setTransform(_loc10);
    };
    _loc1.swapTo = function (nIndex, bNoEvent)
    {
        if (nIndex > this._aClipList.length)
        {
            return;
        } // end if
        this._bMoving = false;
        delete this.onEnterFrame;
        var _loc4 = Math.PI / 180 * 360 / this._aClipList.length;
        this._nCurrentIndex = nIndex;
        this.setPosition(_loc4 * nIndex);
        this.onMoveEnd(bNoEvent);
    };
    _loc1.slide = function (nIndex)
    {
        if (this._bMoving)
        {
            return;
        } // end if
        if (this._nCurrentIndex + nIndex > this._aClipList.length)
        {
            this._nCurrentIndex = this._nCurrentIndex + nIndex - this._aClipList.length;
        }
        else if (this._nCurrentIndex + nIndex < 0)
        {
            this._nCurrentIndex = this._nCurrentIndex + nIndex + this._aClipList.length;
        }
        else
        {
            this._nCurrentIndex = this._nCurrentIndex + nIndex;
        } // end else if
        if (!this._bAnimation)
        {
            this.swapTo(this._nCurrentIndex);
            return;
        } // end if
        this._bMoving = true;
        var _loc3 = Math.PI / 180 * 360 / this._aClipList.length;
        var t = 0;
        var b = this._nCurrentPosition;
        var c = this._nCurrentPosition + _loc3 * nIndex - this._nCurrentPosition;
        var d = Math.abs(nIndex) * this._nAnimationSpeed;
        var r = this;
        this.onEnterFrame = function ()
        {
            r.setPosition(r.ease(t++, b, c, d));
            if (t > d)
            {
                delete this.onEnterFrame;
                r.onMoveEnd();
            } // end if
        };
    };
    _loc1.setPosition = function (n)
    {
        this._nCurrentPosition = n;
        this.update();
    };
    _loc1.ease = function (t, b, c, d)
    {
        return (c * t / d + b);
    };
    _loc1.onMoveEnd = function (bNoEvent)
    {
        this._bMoving = false;
        if (!bNoEvent)
        {
            this.dispatchEvent({type: "change", value: this.currentIndex});
        } // end if
    };
    _loc1.onLoadComplete = function (mc)
    {
        this.onSubclipLoaded(mc);
    };
    _loc1.onLoadError = function (mc)
    {
        this.onSubclipLoaded(mc);
    };
    _loc1.onSubclipLoaded = function (mc)
    {
        ++this._nLoaded;
        delete this._aLoaders[Number(mc._name.substr(4))];
        var ref = this;
        mc.registerColor = function (tmp, n)
        {
            ref.registerColor(tmp, n);
        };
        if (this._nLoaded == this._aClipList.length)
        {
            var _loc3 = 1;
            
            while (++_loc3, _loc3 <= dofus.graphics.gapi.controls.ClassSelector.MAXIMUM_ZONES)
            {
                this.addToQueue({object: this, method: this.updateColor, params: [_loc3, this._aUpdateOnLoaded[_loc3]]});
            } // end while
            this.update();
        } // end if
    };
    _loc1.addProperty("maxScale", _loc1.__get__maxScale, _loc1.__set__maxScale);
    _loc1.addProperty("clips", _loc1.__get__clips, function ()
    {
    });
    _loc1.addProperty("currentIndex", _loc1.__get__currentIndex, _loc1.__set__currentIndex);
    _loc1.addProperty("clipsList", _loc1.__get__clipsList, _loc1.__set__clipsList);
    _loc1.addProperty("xRay", _loc1.__get__xRay, _loc1.__set__xRay);
    _loc1.addProperty("minAlpha", _loc1.__get__minAlpha, _loc1.__set__minAlpha);
    _loc1.addProperty("animation", _loc1.__get__animation, _loc1.__set__animation);
    _loc1.addProperty("minScale", _loc1.__get__minScale, _loc1.__set__minScale);
    _loc1.addProperty("yRay", _loc1.__get__yRay, _loc1.__set__yRay);
    _loc1.addProperty("animationSpeed", _loc1.__get__animationSpeed, _loc1.__set__animationSpeed);
    _loc1.addProperty("maxAlpha", _loc1.__get__maxAlpha, _loc1.__set__maxAlpha);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.ClassSelector = function ()
    {
        super();
    }).CLASS_NAME = "ClassSelector";
    (_global.dofus.graphics.gapi.controls.ClassSelector = function ()
    {
        super();
    }).MAXIMUM_ZONES = 3;
    _loc1._xRay = 330;
    _loc1._yRay = 95;
    _loc1._minScale = -120;
    _loc1._maxScale = 100;
    _loc1._minAlpha = -100;
    _loc1._maxAlpha = 100;
    _loc1._bAnimation = true;
    _loc1._nAnimationSpeed = 10;
    _loc1._aClipList = new Array();
    _loc1._bMoving = false;
    _loc1._nCurrentPosition = 0;
    _loc1._nCurrentIndex = 0;
    _loc1._aClips = new Array();
    _loc1._aLoaders = new Array();
    _loc1._nLoaded = 0;
    _loc1._aRegisteredColors = new Array();
    _loc1._aUpdateOnLoaded = new Array();
} // end if
#endinitclip
