// Action script...

// [Initial MovieClip Action of sprite 20615]
#initclip 136
if (!dofus.utils.Api)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.utils)
    {
        _global.dofus.utils = new Object();
    } // end if
    var _loc1 = (_global.dofus.utils.Api = function ()
    {
        super();
        dofus.utils.Api._oLastInstance = this;
    }).prototype;
    (_global.dofus.utils.Api = function ()
    {
        super();
        dofus.utils.Api._oLastInstance = this;
    }).getInstance = function ()
    {
        return (dofus.utils.Api._oLastInstance);
    };
    _loc1.__get__config = function ()
    {
        return (this._oConfig);
    };
    _loc1.__get__kernel = function ()
    {
        return (this._oKernel);
    };
    _loc1.__get__datacenter = function ()
    {
        return (this._oDatacenter);
    };
    _loc1.__get__network = function ()
    {
        return (this._oNetwork);
    };
    _loc1.__get__gfx = function ()
    {
        return (this._oGfx);
    };
    _loc1.__get__ui = function ()
    {
        return (this._oUI);
    };
    _loc1.__get__sounds = function ()
    {
        return (this._oSounds);
    };
    _loc1.__get__lang = function ()
    {
        return (this._oLang);
    };
    _loc1.__get__colors = function ()
    {
        return (this._oColors);
    };
    _loc1.initialize = function ()
    {
        this._oConfig = _global.CONFIG;
        this._oLang = new dofus.utils.DofusTranslator();
        this._oUI = dofus.DofusCore.getClip().GAPI;
        this._oUI.api = this;
        this._oKernel = new dofus.Kernel(this);
        this._oSounds = dofus.sounds.AudioManager.getInstance();
        _global.SOMA = this._oSounds;
        this._oDatacenter = new dofus.datacenter.Datacenter(this);
        this._oNetwork = new dofus.aks.Aks(this);
        this._oGfx = dofus.DofusCore.getClip().BATTLEFIELD;
        if (this._oConfig.isStreaming && this._oConfig.streamingMethod == "explod")
        {
            this._oGfx.initialize(this._oDatacenter, dofus.Constants.OBJECTS_LIGHT_FILE, dofus.Constants.OBJECTS_LIGHT_FILE, dofus.Constants.ACCESSORIES_PATH, this);
        }
        else
        {
            this._oGfx.initialize(this._oDatacenter, dofus.Constants.GROUND_FILE, dofus.Constants.OBJECTS_FILE, dofus.Constants.ACCESSORIES_PATH, this);
        } // end else if
        this._oColors = _global.GAC;
        this._oConfig.languages = this._oLang.getConfigText("LANGUAGES_LIST");
    };
    _loc1.checkFileSize = function (sFile, nCheckID)
    {
        var _loc3 = new Object();
        var ref = this;
        _loc3.onLoadComplete = function (mc, httpStatus)
        {
            ref.onFileCheckFinished(true, mc.getBytesTotal(), nCheckID);
            mc.removeMovieClip();
        };
        _loc3.onLoadError = function (mc, errorCode, httpStatus)
        {
            ref.onFileCheckFinished(false, mc.getBytesLoaded(), nCheckID);
            mc.removeMovieClip();
        };
        var _loc4 = dofus.DofusCore.getInstance().getTemporaryContainer();
        var _loc5 = _loc4.createEmptyMovieClip("FC" + nCheckID, _loc4.getNextHighestDepth());
        var _loc6 = new MovieClipLoader();
        _loc6.addListener(_loc3);
        _loc6.loadClip(sFile, _loc5);
    };
    _loc1.onFileCheckFinished = function (bSuccess, nFileSize, nCheckID)
    {
        this.network.Basics.fileCheckAnswer(nCheckID, bSuccess ? (nFileSize) : (-1));
    };
    _loc1.addProperty("datacenter", _loc1.__get__datacenter, function ()
    {
    });
    _loc1.addProperty("kernel", _loc1.__get__kernel, function ()
    {
    });
    _loc1.addProperty("colors", _loc1.__get__colors, function ()
    {
    });
    _loc1.addProperty("ui", _loc1.__get__ui, function ()
    {
    });
    _loc1.addProperty("sounds", _loc1.__get__sounds, function ()
    {
    });
    _loc1.addProperty("network", _loc1.__get__network, function ()
    {
    });
    _loc1.addProperty("lang", _loc1.__get__lang, function ()
    {
    });
    _loc1.addProperty("config", _loc1.__get__config, function ()
    {
    });
    _loc1.addProperty("gfx", _loc1.__get__gfx, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
