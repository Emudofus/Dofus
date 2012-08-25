// Action script...

// [Initial MovieClip Action of sprite 20941]
#initclip 206
if (!ank.utils.SharedObjectFix)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.SharedObjectFix = function (params)
    {
        super();
        this._so = params.persistence ? (SharedObject.getRemote(params.name, params.remotePath, params.persistence, params.secure)) : (SharedObject.getLocal(params.name, params.localPath, params.secure));
        if (this._so.data._Data == undefined)
        {
            this._so.data._Data = new Object();
        } // end if
        this.data = this._so.data._Data;
        this._so.onStatus = function (infoObject)
        {
            if (this.onStatus)
            {
                this.onStatus(infoObject);
            } // end if
        };
        this._so.onSync = function (objArray)
        {
            if (this.onSync)
            {
                this.onSync(objArray);
            } // end if
        };
    }).prototype;
    _loc1.clear = function ()
    {
        this.data = new Object();
        this._so.clear();
    };
    _loc1.close = function ()
    {
        this._so.data._Data = this.data;
        this._so.close();
    };
    _loc1.flush = function (minDiskSpace)
    {
        this._so.data._Data = this.data;
        return (this._so.flush(minDiskSpace));
    };
    _loc1.getSize = function ()
    {
        this._so.data._Data = this.data;
        return (this._so.getSize());
    };
    _loc1.connect = function (myConnection)
    {
        this._so.data._Data = this.data;
        return (this._so.connect(myConnection));
    };
    _loc1.send = function (handlerName)
    {
        this._so.data._Data = this.data;
        this._so.send(handlerName);
    };
    _loc1.setFps = function (updatesPerSecond)
    {
        this._so.data._Data = this.data;
        return (this._so.setFps(updatesPerSecond));
    };
    (_global.ank.utils.SharedObjectFix = function (params)
    {
        super();
        this._so = params.persistence ? (SharedObject.getRemote(params.name, params.remotePath, params.persistence, params.secure)) : (SharedObject.getLocal(params.name, params.localPath, params.secure));
        if (this._so.data._Data == undefined)
        {
            this._so.data._Data = new Object();
        } } // end if
        this.data = this._so.data._Data;
        this._so.onStatus = function (infoObject)
        {
            if (this.onStatus)
            {
                this.onStatus(infoObject);
            } } // end if
        };
        this._so.onSync = function (objArray)
        {
            if (this.onSync)
            {
                this.onSync(objArray);
            } } // end if
        };
    }).getLocal = function (name, localPath, secure)
    {
        if (!ank.utils.SharedObjectFix._oLocalCache[name])
        {
            ank.utils.SharedObjectFix._oLocalCache[name] = new ank.utils.SharedObjectFix({name: name, localPath: localPath, secure: secure});
        } // end if
        return (ank.utils.SharedObjectFix._oLocalCache[name]);
    };
    (_global.ank.utils.SharedObjectFix = function (params)
    {
        super();
        this._so = params.persistence ? (SharedObject.getRemote(params.name, params.remotePath, params.persistence, params.secure)) : (SharedObject.getLocal(params.name, params.localPath, params.secure));
        if (this._so.data._Data == undefined)
        {
            this._so.data._Data = new Object();
        } } } // end if
        this.data = this._so.data._Data;
        this._so.onStatus = function (infoObject)
        {
            if (this.onStatus)
            {
                this.onStatus(infoObject);
            } } } // end if
        };
        this._so.onSync = function (objArray)
        {
            if (this.onSync)
            {
                this.onSync(objArray);
            } } } // end if
        };
    }).getRemote = function (name, remotePath, persistence, secure)
    {
        if (!ank.utils.SharedObjectFix._oRemoteCache[name])
        {
            ank.utils.SharedObjectFix._oRemoteCache[name] = new ank.utils.SharedObjectFix({name: name, remotePath: remotePath, persistence: persistence, secure: secure});
        } // end if
        return (ank.utils.SharedObjectFix._oRemoteCache[name]);
    };
    (_global.ank.utils.SharedObjectFix = function (params)
    {
        super();
        this._so = params.persistence ? (SharedObject.getRemote(params.name, params.remotePath, params.persistence, params.secure)) : (SharedObject.getLocal(params.name, params.localPath, params.secure));
        if (this._so.data._Data == undefined)
        {
            this._so.data._Data = new Object();
        } } } } // end if
        this.data = this._so.data._Data;
        this._so.onStatus = function (infoObject)
        {
            if (this.onStatus)
            {
                this.onStatus(infoObject);
            } } } } // end if
        };
        this._so.onSync = function (objArray)
        {
            if (this.onSync)
            {
                this.onSync(objArray);
            } } } } // end if
        };
    }).deleteAll = function (url)
    {
        SharedObject.deleteAll();
    };
    (_global.ank.utils.SharedObjectFix = function (params)
    {
        super();
        this._so = params.persistence ? (SharedObject.getRemote(params.name, params.remotePath, params.persistence, params.secure)) : (SharedObject.getLocal(params.name, params.localPath, params.secure));
        if (this._so.data._Data == undefined)
        {
            this._so.data._Data = new Object();
        } } } } } // end if
        this.data = this._so.data._Data;
        this._so.onStatus = function (infoObject)
        {
            if (this.onStatus)
            {
                this.onStatus(infoObject);
            } } } } } // end if
        };
        this._so.onSync = function (objArray)
        {
            if (this.onSync)
            {
                this.onSync(objArray);
            } } } } } // end if
        };
    }).getDiskUsage = function (url)
    {
        return (SharedObject.getDiskUsage(url));
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.utils.SharedObjectFix = function (params)
    {
        super();
        this._so = params.persistence ? (SharedObject.getRemote(params.name, params.remotePath, params.persistence, params.secure)) : (SharedObject.getLocal(params.name, params.localPath, params.secure));
        if (this._so.data._Data == undefined)
        {
            this._so.data._Data = new Object();
        } } } } } } // end if
        this.data = this._so.data._Data;
        this._so.onStatus = function (infoObject)
        {
            if (this.onStatus)
            {
                this.onStatus(infoObject);
            } } } } } } // end if
        };
        this._so.onSync = function (objArray)
        {
            if (this.onSync)
            {
                this.onSync(objArray);
            } } } } } } // end if
        };
    })._oLocalCache = new Object(, _global.ank.utils.SharedObjectFix = function (params)
    {
        super();
        this._so = params.persistence ? (SharedObject.getRemote(params.name, params.remotePath, params.persistence, params.secure)) : (SharedObject.getLocal(params.name, params.localPath, params.secure));
        if (this._so.data._Data == undefined)
        {
            this._so.data._Data = new Object();
        } } } } } } } // end if
        this.data = this._so.data._Data;
        this._so.onStatus = function (infoObject)
        {
            if (this.onStatus)
            {
                this.onStatus(infoObject);
            } } } } } } } // end if
        };
        this._so.onSync = function (objArray)
        {
            if (this.onSync)
            {
                this.onSync(objArray);
            } } } } } } } // end if
        };
    })._oRemoteCache = new Object();
} // end if
#endinitclip
