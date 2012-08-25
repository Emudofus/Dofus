// Action script...

// [Initial MovieClip Action of sprite 20509]
#initclip 30
if (!dofus.managers.ServersManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.ServersManager = function ()
    {
        super();
    }).prototype;
    _loc1.initialize = function (oAPI, sObjectName, sFolder)
    {
        super.initialize(oAPI);
        this._sObjectName = sObjectName;
        this._sFolder = sFolder;
        this._oFailedURL = new Object();
    };
    _loc1.loadData = function (sFile)
    {
        if (this._sFile == sFile)
        {
            return;
        } // end if
        this._sFile = sFile;
        this.clearTimer();
        this._mcl.unloadClip(this._mc);
        this.api.ui.loadUIComponent("Waiting", "Waiting");
        this._aServers = _level0._loader.copyAndOrganizeDataServerList();
        this._urlIndex = -1;
        this.loadWithNextURL();
    };
    _loc1.loadWithNextURL = function ()
    {
        ++this._urlIndex;
        if (this._urlIndex < this._aServers.length && this._aServers.length > 0)
        {
            this._oCurrentServer = this._aServers[this._urlIndex];
            this._sCurrentFileURL = this._oCurrentServer.url + this._sFolder + this._sFile;
            System.security.allowDomain(this._oCurrentServer.url);
            this._mcl = new MovieClipLoader();
            this._mcl.addListener(this);
            this._timerID = _global.setInterval(this.onEventNotCall, 3000);
            this._mc = _root.createEmptyMovieClip("__ANKSWFDATA__", _root.getNextHighestDepth());
            this._mcl.loadClip(this._sCurrentFileURL, this._mc);
        }
        else
        {
            this.onAllLoadFailed(this._mc);
        } // end else if
    };
    _loc1.clear = function ()
    {
        this.clearTimer();
    };
    _loc1.getCurrentServer = function ()
    {
        return (this._oCurrentServer.url + this._sFolder);
    };
    _loc1.clearTimer = function ()
    {
        _global.clearInterval(this._timerID);
    };
    _loc1.clearUI = function ()
    {
        this.api.ui.unloadUIComponent("Waiting");
        this.api.ui.unloadUIComponent("CenterText");
    };
    _loc1.onEventNotCall = function ()
    {
        this.clearTimer();
        this.onLoadError();
    };
    _loc1.onLoadStart = function ()
    {
        this.clearTimer();
    };
    _loc1.onLoadError = function (mc)
    {
        this.api.kernel.showMessage(undefined, "Erreur au chargement du fichier \'" + this._sCurrentFileURL + "\'", "DEBUG_LOG");
        this.clearTimer();
        this.onError(mc);
        this.loadWithNextURL();
    };
    _loc1.onLoadProgress = function ()
    {
        this.clearTimer();
    };
    _loc1.onLoadComplete = function ()
    {
        this.clearTimer();
    };
    _loc1.onLoadInit = function (mc)
    {
        this.clearTimer();
        this._sFile = undefined;
        this.clearUI();
        this.onComplete(mc);
    };
    _loc1.onAllLoadFailed = function (mc)
    {
        this.api.kernel.showMessage(undefined, "Chargement du fichier \'" + this._sFile + "\' impossible ", "DEBUG_LOG");
        this.clearTimer();
        this._sFile = undefined;
        this.clearUI();
        this.onFailed(mc);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
