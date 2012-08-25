// Action script...

// [Initial MovieClip Action of sprite 20946]
#initclip 211
if (!dofus.utils.LangFileLoader)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.utils)
    {
        _global.dofus.utils = new Object();
    } // end if
    var _loc1 = (_global.dofus.utils.LangFileLoader = function ()
    {
        super();
        AsBroadcaster.initialize(this);
    }).prototype;
    _loc1.load = function (aServers, sFile, mc, sSharedObjectName, sFileName, sLang, bUseMultiSO)
    {
        this._aServers = aServers;
        this._sFile = sFile;
        this._mc = mc;
        this._urlIndex = -1;
        this._sSharedObjectName = sSharedObjectName;
        this._sFileName = sFileName;
        this._sLang = sLang;
        this._bUseMultiSO = bUseMultiSO;
        this.loadWithNextURL();
    };
    _loc1.loadWithNextURL = function ()
    {
        ++this._urlIndex;
        if (this._urlIndex < this._aServers.length && this._aServers.length > 0)
        {
            var _loc2 = this._aServers[this._urlIndex].url;
            var _loc3 = _loc2 + this._sFile;
            System.security.allowDomain(_loc2);
            this._mcl = new MovieClipLoader();
            this._mcl.addListener(this);
            this._progressTimer = _global.setInterval(this.onTimedProgress, 1000);
            this._timerID = _global.setInterval(this.onEventNotCall, 5000);
            this._mcl.loadClip(_loc3, this._mc);
        }
        else
        {
            this.broadcastMessage("onAllLoadFailed", this._mc);
        } // end else if
    };
    _loc1.getCurrentServer = function ()
    {
        return (this._aServers[this._urlIndex]);
    };
    _loc1.onEventNotCall = function (mc)
    {
        _global.clearInterval(this._timerID);
        this.onLoadError(mc, "unknown", -1);
    };
    _loc1.onLoadStart = function (mc)
    {
        _global.clearInterval(this._timerID);
        this.broadcastMessage("onLoadStart", mc, this.getCurrentServer());
    };
    _loc1.onLoadError = function (mc, errorCode, httpStatus)
    {
        _global.clearInterval(this._timerID);
        _global.clearInterval(this._progressTimer);
        this.broadcastMessage("onLoadError", mc, errorCode, httpStatus, this.getCurrentServer());
        this.loadWithNextURL();
    };
    _loc1.onTimedProgress = function ()
    {
        var _loc2 = this._mcl.getProgress(this._mc);
        this.broadcastMessage("onLoadProgress", this._mc, _loc2.bytesLoaded, _loc2.bytesTotal, this.getCurrentServer());
    };
    _loc1.onLoadComplete = function (mc, httpStatus)
    {
        _global.clearInterval(this._timerID);
        _global.clearInterval(this._progressTimer);
        this.broadcastMessage("onLoadComplete", mc, httpStatus, this.getCurrentServer());
    };
    _loc1.onLoadInit = function (mc)
    {
        _global.clearInterval(this._timerID);
        _global.clearInterval(this._progressTimer);
        this._so = ank.utils.SharedObjectFix.getLocal(this._sSharedObjectName);
        if (mc.FILE_BEGIN != true && mc.FILE_END != true)
        {
            this.broadcastMessage("onCorruptFile", mc, mc.getBytesTotal(), this.getCurrentServer());
            this.loadWithNextURL();
            return;
        } // end if
        if (this._so.data.VERSIONS == undefined)
        {
            this._so.data.VERSIONS = new Object();
        } // end if
        this._so.data.VERSIONS[this._sFileName] = mc.VERSION;
        if (this._so.data.WEIGHTS == undefined)
        {
            this._so.data.WEIGHTS = new Object();
        } // end if
        this._so.data.WEIGHTS[this._sFileName.toUpperCase()] = mc.getBytesTotal();
        this._aData = new Array();
        for (var k in mc)
        {
            if (k == "VERSION" || (k == "FILE_BEGIN" || k == "FILE_END"))
            {
                continue;
            } // end if
            this._aData.push({key: k, value: mc[k]});
            delete mc[k];
        } // end of for...in
        this._so.data.LANGUAGE = this._sLang;
        if (this._so.flush(1000000000) == false)
        {
            this.broadcastMessage("onCantWrite", mc);
            return;
        } // end if
        this._nStart = 0;
        if (this._bUseMultiSO)
        {
            this._nStep = 1;
        }
        else
        {
            this._nStep = 10000000;
        } // end else if
        this.addToQueue({object: this, method: this.processFile});
    };
    _loc1.processFile = function ()
    {
        var _loc2 = this._nStart;
        
        while (++_loc2, _loc2 < this._nStart + this._nStep)
        {
            if (!this._aData[_loc2])
            {
                break;
            } // end if
            if (this._bUseMultiSO)
            {
                this._so = ank.utils.SharedObjectFix.getLocal(this._sSharedObjectName + "_" + this._aData[_loc2].key);
            } // end if
            this._so.data[this._aData[_loc2].key] = this._aData[_loc2].value;
            delete this._aData[_loc2];
        } // end while
        this._nStart = this._nStart + this._nStep;
        if (this._so.flush(1000000000) == false)
        {
            this.broadcastMessage("onCantWrite", this._mc);
            return;
        } // end if
        if (this._nStart >= this._aData.length)
        {
            this.processFileEnd();
        }
        else
        {
            this.addToQueue({object: this, method: this.processFile});
        } // end else if
    };
    _loc1.processFileEnd = function ()
    {
        delete this._so;
        this.broadcastMessage("onLoadInit", this._mc, this.getCurrentServer());
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
