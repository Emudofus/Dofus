// Action script...

// [Initial MovieClip Action of sprite 20597]
#initclip 118
if (!ank.external.ExternalConnector)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.external)
    {
        _global.ank.external = new Object();
    } // end if
    var _loc1 = (_global.ank.external.ExternalConnector = function ()
    {
        super();
        mx.events.EventDispatcher.initialize(this);
        this._sConnectionName = ank.external.ExternalConnector.CONNECTION_NAME + new Date().getTime() + random(100000);
        this.connect(this._sConnectionName);
        ank.utils.Timer.setTimer(this, "externalconnector", this, this.initialize, 100);
    }).prototype;
    (_global.ank.external.ExternalConnector = function ()
    {
        super();
        mx.events.EventDispatcher.initialize(this);
        this._sConnectionName = ank.external.ExternalConnector.CONNECTION_NAME + new Date().getTime() + random(100000);
        this.connect(this._sConnectionName);
        ank.utils.Timer.setTimer(this, "externalconnector", this, this.initialize, 100);
    }).getInstance = function ()
    {
        if (ank.external.ExternalConnector._oInstance == undefined)
        {
            ank.external.ExternalConnector._oInstance = new ank.external.ExternalConnector();
        } // end if
        return (ank.external.ExternalConnector._oInstance);
    };
    _loc1.pushCall = function (sMethodName)
    {
        this._aCallQueue.push({args: arguments});
        if (!this._bInitializing)
        {
            if (!this._bCalling)
            {
                this.processQueue();
            }
            else if (!this._bInitialized)
            {
                this.onUnknownMethod();
            } // end if
        } // end else if
    };
    _loc1.call = function (sMethodName)
    {
        this._bCalling = true;
        var _loc3 = new Array();
        _loc3.push(ank.external.ExternalConnector.CONNECTION_NAME);
        _loc3.push(sMethodName);
        _loc3.push(this._sConnectionName);
        var _loc4 = 1;
        
        while (++_loc4, _loc4 < arguments.length)
        {
            _loc3.push(arguments[_loc4]);
        } // end while
        this.send.apply(this, _loc3);
    };
    _loc1.onStatus = function (oInfos)
    {
        this._bCalling = false;
        switch (oInfos.level)
        {
            case "status":
            {
                break;
            } 
            case "error":
            {
                this.dispatchEvent({type: "onExternalConnectionFaild"});
                break;
            } 
        } // End of switch
        if (this._bInitialized)
        {
            this.processQueue();
        } // end if
    };
    _loc1.toString = function ()
    {
        return ("ExternalConnector" + " initialized:" + this._bInitialized + " calling:" + this._bCalling);
    };
    _loc1.initialize = function ()
    {
        this._bInitializing = true;
        this.call("Initialize");
        ank.utils.Timer.setTimer(this, ank.external.ExternalConnector.TIME_OUT_LAYER, this, this.onInitializeFaild, ank.external.ExternalConnector.TIME_OUT);
    };
    _loc1.processQueue = function ()
    {
        if (this._aCallQueue.length != 0)
        {
            var _loc2 = this._aCallQueue.shift();
            if (!this._bInitialized)
            {
                this.dispatchEvent({type: "onExternalConnectionFaild"});
            }
            else
            {
                this.call.apply(this, _loc2.args);
            } // end if
        } // end else if
    };
    _loc1.onInitialize = function ()
    {
        ank.utils.Timer.removeTimer(this, ank.external.ExternalConnector.TIME_OUT_LAYER);
        this._bInitializing = false;
        this._bInitialized = true;
        this.processQueue();
    };
    _loc1.onInitializeFaild = function ()
    {
        ank.utils.Timer.removeTimer(this, ank.external.ExternalConnector.TIME_OUT_LAYER);
        this._bInitializing = false;
        this._bInitialized = false;
        this.dispatchEvent({type: "onExternalConnectionFaild"});
    };
    _loc1.onUnknownMethod = function ()
    {
        this.dispatchEvent({type: "onExternalConnectionFaild"});
    };
    _loc1.onApplicationArgs = function (sArgs)
    {
        this.dispatchEvent({type: "onApplicationArgs", args: sArgs.split(" ")});
    };
    _loc1.onBrowseFileCancel = function ()
    {
        this.dispatchEvent({type: "onBrowseFileCancel"});
    };
    _loc1.onBrowseFileSelect = function (aFiles)
    {
        this.dispatchEvent({type: "onBrowseFileSelect", files: aFiles});
    };
    _loc1.onBrowseFileToSaveCancel = function ()
    {
        this.dispatchEvent({type: "onBrowseFileToSaveCancel"});
    };
    _loc1.onBrowseFileToSaveSelect = function (sFile)
    {
        this.dispatchEvent({type: "onBrowseFileToSaveSelect", file: sFile});
    };
    _loc1.onHttpDownloadError = function (sMsg, mParams)
    {
        this.dispatchEvent({type: "onHttpDownloadError", msg: sMsg, params: mParams});
    };
    _loc1.onHttpDownloadProgress = function (nBytesLoaded, nBytesTotal)
    {
        this.dispatchEvent({type: "onHttpDownloadProgress", bl: nBytesLoaded, bt: nBytesTotal});
    };
    _loc1.onHttpDownloadComplete = function ()
    {
        this.dispatchEvent({type: "onHttpDownloadComplete"});
    };
    _loc1.onScreenResolutionError = function (oEvent)
    {
        this.dispatchEvent({type: "onScreenResolutionError"});
    };
    _loc1.onScreenResolutionSuccess = function (oEvent)
    {
        this.dispatchEvent({type: "onScreenResolutionSuccess"});
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.external.ExternalConnector = function ()
    {
        super();
        mx.events.EventDispatcher.initialize(this);
        this._sConnectionName = ank.external.ExternalConnector.CONNECTION_NAME + new Date().getTime() + random(100000);
        this.connect(this._sConnectionName);
        ank.utils.Timer.setTimer(this, "externalconnector", this, this.initialize, 100);
    }).CONNECTION_NAME = "__ank.external.connector__";
    (_global.ank.external.ExternalConnector = function ()
    {
        super();
        mx.events.EventDispatcher.initialize(this);
        this._sConnectionName = ank.external.ExternalConnector.CONNECTION_NAME + new Date().getTime() + random(100000);
        this.connect(this._sConnectionName);
        ank.utils.Timer.setTimer(this, "externalconnector", this, this.initialize, 100);
    }).TIME_OUT = 1500;
    (_global.ank.external.ExternalConnector = function ()
    {
        super();
        mx.events.EventDispatcher.initialize(this);
        this._sConnectionName = ank.external.ExternalConnector.CONNECTION_NAME + new Date().getTime() + random(100000);
        this.connect(this._sConnectionName);
        ank.utils.Timer.setTimer(this, "externalconnector", this, this.initialize, 100);
    }).TIME_OUT_LAYER = "externalconnectortimeout";
    _loc1._bInitializing = false;
    _loc1._bInitialized = false;
    _loc1._aCallQueue = new Array();
    _loc1._bCalling = false;
} // end if
#endinitclip
