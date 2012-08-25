// Action script...

// [Initial MovieClip Action of sprite 20596]
#initclip 117
if (!ank.battlefield.LoadManager)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.LoadManager = function (mc)
    {
        super();
        this.initialize(mc);
    }).prototype;
    _loc1.processLoad = function ()
    {
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < ank.battlefield.LoadManager._aMovieClipLoader.length)
        {
            if (this.waitingRequest > ank.battlefield.LoadManager.MAX_PARALLELE_LOAD)
            {
                return;
            } // end if
            if (ank.battlefield.LoadManager._aMovieClipLoader[_loc2].state == ank.battlefield.LoadManager.STATE_WAITING)
            {
                ank.battlefield.LoadManager._aMovieClipLoader[_loc2].state = ank.battlefield.LoadManager.STATE_LOADING;
                ank.battlefield.LoadManager._aMovieClipLoader[_loc2].loader.loadClip(ank.battlefield.LoadManager._aMovieClipLoader[_loc2].file, ank.battlefield.LoadManager._aMovieClipLoader[_loc2].container);
            } // end if
        } // end while
    };
    _loc1.getFileByMc = function (mc)
    {
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < ank.battlefield.LoadManager._aMovieClipLoader.length)
        {
            if (ank.battlefield.LoadManager._aMovieClipLoader[_loc3].container === mc)
            {
                return (ank.battlefield.LoadManager._aMovieClipLoader[_loc3]);
            } // end if
        } // end while
        return;
    };
    _loc1.getFileByName = function (sFile)
    {
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < ank.battlefield.LoadManager._aMovieClipLoader.length)
        {
            if (ank.battlefield.LoadManager._aMovieClipLoader[_loc3].file == sFile)
            {
                return (ank.battlefield.LoadManager._aMovieClipLoader[_loc3]);
            } // end if
        } // end while
        return;
    };
    _loc1.initialize = function (mc)
    {
        mx.events.EventDispatcher.initialize(this);
        ank.battlefield.LoadManager._aMovieClipLoader = new Array();
        this._mcMainContainer = mc;
    };
    _loc1.loadFile = function (sFile)
    {
        if (this.isRegister(sFile))
        {
            if (this.isLoaded(sFile))
            {
                this.onFileLoaded(sFile);
            }
            else
            {
                return;
            } // end else if
        }
        else
        {
            var _loc3 = new Object();
            _loc3.file = sFile;
            _loc3.bitLoaded = 0;
            _loc3.bitTotal = 1;
            _loc3.state = ank.battlefield.LoadManager.STATE_WAITING;
            _loc3.loader = new MovieClipLoader();
            var _loc4 = this;
            _loc3.loader.addListener(_loc4);
            _loc3.container = this._mcMainContainer.createEmptyMovieClip(sFile.split("/").join("_").split(".").join("_"), this._mcMainContainer.getNextHighestDepth());
            ank.battlefield.LoadManager._aMovieClipLoader.push(_loc3);
            if (this.waitingRequest > ank.battlefield.LoadManager.MAX_PARALLELE_LOAD)
            {
                return;
            } // end if
            _loc3.state = ank.battlefield.LoadManager.STATE_LOADING;
            _loc3.loader.loadClip(sFile, _loc3.container);
        } // end else if
    };
    _loc1.loadFiles = function (aFiles)
    {
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < aFiles.length)
        {
            this.loadFile(aFiles[_loc3]);
        } // end while
    };
    _loc1.__get__waitingRequest = function ()
    {
        var _loc2 = 0;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < ank.battlefield.LoadManager._aMovieClipLoader.length)
        {
            if (ank.battlefield.LoadManager._aMovieClipLoader[_loc3].state == ank.battlefield.LoadManager.STATE_LOADING)
            {
                ++_loc2;
            } // end if
        } // end while
        return (_loc2);
    };
    _loc1.isRegister = function (sFile)
    {
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < ank.battlefield.LoadManager._aMovieClipLoader.length)
        {
            if (sFile == ank.battlefield.LoadManager._aMovieClipLoader[_loc3].file)
            {
                return (true);
            } // end if
        } // end while
        return (false);
    };
    _loc1.isLoaded = function (sFile)
    {
        if (!this.isRegister(sFile))
        {
            return (false);
        } // end if
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < ank.battlefield.LoadManager._aMovieClipLoader.length)
        {
            if (sFile == ank.battlefield.LoadManager._aMovieClipLoader[_loc3].file)
            {
                return (ank.battlefield.LoadManager._aMovieClipLoader[_loc3].state == ank.battlefield.LoadManager.STATE_LOADED);
            } // end if
        } // end while
    };
    _loc1.areRegister = function (aFiles)
    {
        var _loc3 = true && aFiles.length > 0;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < aFiles.length && _loc3)
        {
            _loc3 = _loc3 && this.isRegister(aFiles[_loc4]);
        } // end while
        return (_loc3);
    };
    _loc1.areLoaded = function (aFiles)
    {
        if (!this.areRegister(aFiles))
        {
            return (false);
        } // end if
        var _loc3 = true && aFiles.length > 0;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < aFiles.length && _loc3)
        {
            _loc3 = _loc3 && this.isLoaded(aFiles[_loc4]);
        } // end while
        return (_loc3);
    };
    _loc1.getFileState = function (sFile)
    {
        var _loc3 = this.getFileByName(sFile);
        if (_loc3)
        {
            return (_loc3.state);
        } // end if
        return (ank.battlefield.LoadManager.STATE_UNKNOWN);
    };
    _loc1.getProgression = function (sFile)
    {
        var _loc3 = this.getFileByName(sFile);
        if (!_loc3)
        {
            return;
        } // end if
        if (_loc3.state == ank.battlefield.LoadManager.STATE_LOADED)
        {
            return (100);
        } // end if
        return (Math.floor(_loc3.bitLoaded / _loc3.bitTotal * 100));
    };
    _loc1.getProgressions = function (aFiles)
    {
        var _loc3 = 0;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < aFiles.length)
        {
            var _loc5 = this.getProgression(aFiles[_loc4]);
            if (_loc5 == undefined)
            {
                return;
            } // end if
            _loc3 = _loc3 + _loc5;
        } // end while
        return (Math.floor(_loc3 / aFiles.length));
    };
    _loc1.onFileLoaded = function (sFile)
    {
        this.dispatchEvent({type: "onFileLoaded", value: sFile});
    };
    _loc1.onLoadError = function (mc)
    {
        var _loc3 = this.getFileByMc(mc);
        _loc3.state = ank.battlefield.LoadManager.STATE_ERROR;
        delete _loc3.loader;
        this.processLoad();
    };
    _loc1.onLoadInit = function (mc)
    {
        var _loc3 = this.getFileByMc(mc);
        _loc3.state = ank.battlefield.LoadManager.STATE_LOADED;
        delete _loc3.loader;
        this.onFileLoaded(_loc3.file);
        this.processLoad();
    };
    _loc1.onLoadProgress = function (mc, nBL, nBT)
    {
        var _loc5 = this.getFileByMc(mc);
        if (!_loc5)
        {
            return;
        } // end if
        _loc5.bitLoaded = nBL;
        _loc5.bitTotal = nBT;
    };
    _loc1.addProperty("waitingRequest", _loc1.__get__waitingRequest, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.battlefield.LoadManager = function (mc)
    {
        super();
        this.initialize(mc);
    }).MAX_PARALLELE_LOAD = 3;
    (_global.ank.battlefield.LoadManager = function (mc)
    {
        super();
        this.initialize(mc);
    }).STATE_WAITING = 0;
    (_global.ank.battlefield.LoadManager = function (mc)
    {
        super();
        this.initialize(mc);
    }).STATE_LOADING = 1;
    (_global.ank.battlefield.LoadManager = function (mc)
    {
        super();
        this.initialize(mc);
    }).STATE_LOADED = 2;
    (_global.ank.battlefield.LoadManager = function (mc)
    {
        super();
        this.initialize(mc);
    }).STATE_ERROR = -1;
    (_global.ank.battlefield.LoadManager = function (mc)
    {
        super();
        this.initialize(mc);
    }).STATE_UNKNOWN = -1;
} // end if
#endinitclip
