// Action script...

// [Initial MovieClip Action of sprite 20584]
#initclip 105
if (!ank.gapi.controls.Loader)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.gapi)
    {
        _global.ank.gapi = new Object();
    } // end if
    if (!ank.gapi.controls)
    {
        _global.ank.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.controls.Loader = function ()
    {
        super();
    }).prototype;
    _loc1.__set__enabled = function (bEnabled)
    {
        super.__set__enabled(bEnabled);
        //return (this.enabled());
    };
    _loc1.__set__scaleContent = function (bScaleContent)
    {
        this._bScaleContent = bScaleContent;
        //return (this.scaleContent());
    };
    _loc1.__get__scaleContent = function ()
    {
        return (this._bScaleContent);
    };
    _loc1.__set__autoLoad = function (bAutoLoad)
    {
        this._bAutoLoad = bAutoLoad;
        //return (this.autoLoad());
    };
    _loc1.__get__autoLoad = function ()
    {
        return (this._bAutoLoad);
    };
    _loc1.__set__centerContent = function (bCenterContent)
    {
        this._bCenterContent = bCenterContent;
        //return (this.centerContent());
    };
    _loc1.__get__centerContent = function ()
    {
        return (this._bCenterContent);
    };
    _loc1.__set__contentParams = function (oParams)
    {
        this._oParams = oParams;
        if (this._oParams.frame)
        {
            this.frame = this._oParams.frame;
        } // end if
        //return (this.contentParams());
    };
    _loc1.__get__contentParams = function ()
    {
        return (this._oParams);
    };
    _loc1.__set__contentPath = function (sURL)
    {
        this._sURL = sURL;
        if (this._bAutoLoad)
        {
            this.load();
        } // end if
        //return (this.contentPath());
    };
    _loc1.__get__contentPath = function ()
    {
        return (this._sURL);
    };
    _loc1.__set__forceReload = function (bForce)
    {
        this._bForceReload = bForce;
        //return (this.forceReload());
    };
    _loc1.__get__forceReload = function ()
    {
        return (this._bForceReload);
    };
    _loc1.__get__bytesLoaded = function ()
    {
        return (this._nBytesLoaded);
    };
    _loc1.__get__bytesTotal = function ()
    {
        return (this._nBytesTotal);
    };
    _loc1.__get__percentLoaded = function ()
    {
        var _loc2 = Math.round(this.bytesLoaded / this.bytesTotal * 100);
        _loc2 = _global.isNaN(_loc2) ? (0) : (_loc2);
        return (_loc2);
    };
    _loc1.__get__content = function ()
    {
        return (this.holder_mc.content_mc);
    };
    _loc1.__get__holder = function ()
    {
        return (this.holder_mc);
    };
    _loc1.__get__loaded = function ()
    {
        return (this._bLoaded);
    };
    _loc1.__set__frame = function (sFrame)
    {
        this._sFrame = sFrame;
        this.content.gotoAndStop(sFrame);
        this.size();
        //return (this.frame());
    };
    _loc1.forceNextLoad = function ()
    {
        delete this._sPrevURL;
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.Loader.CLASS_NAME);
        if (this._bScaleContent == undefined)
        {
            this._bScaleContent = true;
        } // end if
        this._bInited = true;
        this._nBytesLoaded = 0;
        this._nBytesTotal = 0;
        this._bLoaded = false;
        this._mvlLoader = new MovieClipLoader();
        this._mvlLoader.addListener(this);
    };
    _loc1.createChildren = function ()
    {
        this.createEmptyMovieClip("holder_mc", 10);
        if (this._bAutoLoad && this._sURL != undefined)
        {
            this.load();
        } // end if
    };
    _loc1.size = function ()
    {
        super.size();
        if (this.holder_mc.content_mc != undefined)
        {
            if (this._sFrame != undefined && this._sFrame != "")
            {
                this.frame = this._sFrame;
            } // end if
            if (this._bScaleContent)
            {
                var _loc3 = this.holder_mc.content_mc._width;
                var _loc4 = this.holder_mc.content_mc._height;
                var _loc5 = _loc3 / _loc4;
                var _loc6 = this.__width / this.__height;
                if (_loc5 == _loc6)
                {
                    this.holder_mc._width = this.__width;
                    this.holder_mc._height = this.__height;
                }
                else if (_loc5 > _loc6)
                {
                    this.holder_mc._width = this.__width;
                    this.holder_mc._height = this.__width / _loc5;
                }
                else
                {
                    this.holder_mc._width = this.__height * _loc5;
                    this.holder_mc._height = this.__height;
                } // end else if
                var _loc7 = this.holder_mc.content_mc.getBounds();
                this.holder_mc.content_mc._x = -_loc7.xMin;
                this.holder_mc.content_mc._y = -_loc7.yMin;
                this.holder_mc._x = (this.__width - this.holder_mc._width) / 2;
                this.holder_mc._y = (this.__height - this.holder_mc._height) / 2;
            } // end if
            if (this._bCenterContent)
            {
                this.holder_mc._x = this.__width / 2;
                this.holder_mc._y = this.__height / 2;
            } // end if
        } // end if
    };
    _loc1.setEnabled = function ()
    {
        if (this._bEnabled)
        {
            this.onRelease = function ()
            {
                this.dispatchEvent({type: "click"});
            };
        }
        else
        {
            delete this.onRelease;
        } // end else if
    };
    _loc1.load = function ()
    {
        if (this._sPrevURL == undefined && this._sURL == "")
        {
            return;
        } // end if
        if (!this._bForceReload && (this._sPrevURL == this._sURL || this._sURL == undefined || this.holder_mc == undefined))
        {
            return;
        } // end if
        this._visible = false;
        this._bLoaded = false;
        this._sPrevURL = this._sURL;
        this.holder_mc.content_mc.removeMovieClip();
        this.holder_mc.attachMovie(this._sURL, "content_mc", 1, this._oParams);
        if (this._sURL == "")
        {
            return;
        } // end if
        if (this.holder_mc.content_mc == undefined)
        {
            this.holder_mc.createEmptyMovieClip("content_mc", 1);
            this._mvlLoader.loadClip(this._sURL, this.holder_mc.content_mc);
        }
        else
        {
            this.onLoadComplete(this.holder_mc.content_mc);
            this.onLoadInit(this.holder_mc.content_mc);
        } // end else if
    };
    _loc1.onLoadError = function (mc)
    {
        this.dispatchEvent({type: "error", target: this, clip: mc});
    };
    _loc1.onLoadProgress = function (mc, bl, bt)
    {
        this._nBytesLoaded = bl;
        this._nBytesTotal = bt;
        this.dispatchEvent({type: "progress", target: this, clip: mc});
    };
    _loc1.onLoadComplete = function (mc)
    {
        this._bLoaded = true;
        this.dispatchEvent({type: "complete", clip: mc});
    };
    _loc1.onLoadInit = function (mc)
    {
        this.size();
        this._visible = true;
        this.dispatchEvent({type: "initialization", clip: mc});
    };
    _loc1.addProperty("frame", function ()
    {
    }, _loc1.__set__frame);
    _loc1.addProperty("scaleContent", _loc1.__get__scaleContent, _loc1.__set__scaleContent);
    _loc1.addProperty("bytesTotal", _loc1.__get__bytesTotal, function ()
    {
    });
    _loc1.addProperty("contentParams", _loc1.__get__contentParams, _loc1.__set__contentParams);
    _loc1.addProperty("contentPath", _loc1.__get__contentPath, _loc1.__set__contentPath);
    _loc1.addProperty("autoLoad", _loc1.__get__autoLoad, _loc1.__set__autoLoad);
    _loc1.addProperty("holder", _loc1.__get__holder, function ()
    {
    });
    _loc1.addProperty("content", _loc1.__get__content, function ()
    {
    });
    _loc1.addProperty("forceReload", _loc1.__get__forceReload, _loc1.__set__forceReload);
    _loc1.addProperty("bytesLoaded", _loc1.__get__bytesLoaded, function ()
    {
    });
    _loc1.addProperty("loaded", _loc1.__get__loaded, function ()
    {
    });
    _loc1.addProperty("enabled", function ()
    {
    }, _loc1.__set__enabled);
    _loc1.addProperty("percentLoaded", _loc1.__get__percentLoaded, function ()
    {
    });
    _loc1.addProperty("centerContent", _loc1.__get__centerContent, _loc1.__set__centerContent);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.Loader = function ()
    {
        super();
    }).CLASS_NAME = "Loader";
    _loc1._bEnabled = false;
    _loc1._bAutoLoad = true;
    _loc1._bScaleContent = false;
    _loc1._bCenterContent = false;
    _loc1._sURL = "";
    _loc1._bForceReload = false;
} // end if
#endinitclip
