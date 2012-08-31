// Action script...

// [Initial MovieClip Action of sprite 885]
#initclip 97
class dofus.managers.ServersManager extends dofus.utils.ApiElement
{
    var _mvlLoader, _nCurrentServerIndex, _bLongRetry, _nServersCheckedCount, _sCurrentFile, api, _nIntervalID, _aServersList, _nLongRetryIntervalID, _nIndexMax, _nLongRetryTimer, onComplete, onError, addToQueue;
    function ServersManager()
    {
        super();
        _mvlLoader = new MovieClipLoader();
        _mvlLoader.addListener(this);
    } // End of the function
    function initialize(oAPI)
    {
        super.initialize(oAPI);
        _nCurrentServerIndex = 0;
    } // End of the function
    function loadData(sFile, bDontInitServerCount, bLongRetry)
    {
        this.clearLongRetry();
        _bLongRetry = bLongRetry == undefined ? (false) : (bLongRetry);
        if (bDontInitServerCount != true)
        {
            _nServersCheckedCount = 0;
        } // end if
        if (sFile == _sCurrentFile)
        {
            return;
        } // end if
        _sCurrentFile = sFile;
        _root.__ANKSWFDATA__.removeMovieClip();
        var _loc3 = _root.createEmptyMovieClip("__ANKSWFDATA__", _root.getNextHighestDepth());
        api.ui.loadUIComponent("Waiting", "Waiting");
        var _loc4 = this.getCurrentServer();
        _mvlLoader.loadClip(_loc4 + sFile, _loc3);
        _nIntervalID = setInterval(this, "onTimeOut", dofus.managers.ServersManager.TIMEOUT, _loc3);
    } // End of the function
    function getCurrentServer()
    {
        return (_aServersList[_nCurrentServerIndex]);
    } // End of the function
    function clearLongRetry()
    {
        api.ui.unloadUIComponent("ServersManagerRetry");
        clearInterval(_nLongRetryIntervalID);
    } // End of the function
    function tryNextServer()
    {
        if (_nServersCheckedCount < _nIndexMax)
        {
            ++_nCurrentServerIndex;
            if (_nCurrentServerIndex > _nIndexMax)
            {
                _nCurrentServerIndex = 0;
            } // end if
        } // end if
        ++_nServersCheckedCount;
        return (_nServersCheckedCount <= _nIndexMax);
    } // End of the function
    function startLongRetry(sFile)
    {
        this.clearLongRetry();
        _nLongRetryTimer = dofus.managers.ServersManager.LONG_RETRY_TIME;
        api.kernel.OptionsManager.setOption("MapInfos", false);
        api.ui.loadUIComponent("ServersManagerRetry", "ServersManagerRetry", {timer: _nLongRetryTimer});
        _nLongRetryIntervalID = setInterval(this, "onLongRetryTimer", 1000, sFile);
    } // End of the function
    function onTimeOut(mc)
    {
        this.onLoadError(mc);
        _mvlLoader.unloadClip(mc);
    } // End of the function
    function onLoadInit(mc)
    {
        clearInterval(_nIntervalID);
        delete this._sCurrentFile;
        api.ui.unloadUIComponent("Waiting");
        this.onComplete(mc);
    } // End of the function
    function onLoadError(mc)
    {
        clearInterval(_nIntervalID);
        if (!this.tryNextServer())
        {
            api.ui.unloadUIComponent("Waiting");
            api.ui.unloadUIComponent("CenterText");
            if (_bLongRetry)
            {
                this.startLongRetry(_sCurrentFile);
            } // end if
            this.onError();
        }
        else
        {
            this.addToQueue({object: this, method: loadData, params: [_sCurrentFile, true]});
        } // end else if
        delete this._sCurrentFile;
    } // End of the function
    function onLongRetryTimer(sFile)
    {
        --_nLongRetryTimer;
        if (_nLongRetryTimer < 1)
        {
            this.clearLongRetry();
            this.loadData(sFile, true, _bLongRetry);
        }
        else
        {
            api.ui.getUIComponent("ServersManagerRetry").timer = _nLongRetryTimer;
        } // end else if
    } // End of the function
    static var TIMEOUT = 20000;
    static var LONG_RETRY_TIME = 30;
} // End of Class
#endinitclip
