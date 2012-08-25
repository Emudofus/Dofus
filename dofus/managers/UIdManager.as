// Action script...

// [Initial MovieClip Action of sprite 20917]
#initclip 182
if (!dofus.managers.UIdManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.UIdManager = function ()
    {
        this.receiving_lc = new LocalConnection();
        this.sending_lc = new LocalConnection();
        this._status = dofus.managers.UIdManager.NONE;
        this._connId = "_dofus" + Math.floor(Math.random() * 100000000);
    }).prototype;
    _loc1.__get__api = function ()
    {
        return (_global.API);
    };
    (_global.dofus.managers.UIdManager = function ()
    {
        this.receiving_lc = new LocalConnection();
        this.sending_lc = new LocalConnection();
        this._status = dofus.managers.UIdManager.NONE;
        this._connId = "_dofus" + Math.floor(Math.random() * 100000000);
    }).getInstance = function ()
    {
        if (!dofus.managers.UIdManager._self)
        {
            dofus.managers.UIdManager._self = new dofus.managers.UIdManager();
        } // end if
        return (dofus.managers.UIdManager._self);
    };
    _loc1.update = function ()
    {
        var _loc2 = this.receiving_lc.connect("_dofus");
        if (this._status != dofus.managers.UIdManager.SERVER && _loc2)
        {
            this.makeServer();
        }
        else if (this._status != dofus.managers.UIdManager.SERVER)
        {
            if (this._status != dofus.managers.UIdManager.CLIENT)
            {
                this.makeClient();
            } // end if
            this.receiving_lc.connect(this._connId);
            this.sending_lc.send("_dofus", "getUId", this._connId);
        } // end else if
    };
    _loc1.makeServer = function ()
    {
        this._status = dofus.managers.UIdManager.SERVER;
        this.receiving_lc.getUId = function (connId)
        {
            var _loc3 = SharedObject.getLocal(dofus.Constants.GLOBAL_SO_IDENTITY_NAME);
            if (_loc3.data.identity)
            {
                dofus.managers.UIdManager.getInstance().sending_lc.send(connId, "setUId", _loc3.data.identity);
            } // end if
            _loc3.close();
        };
    };
    _loc1.makeClient = function ()
    {
        this._status = dofus.managers.UIdManager.CLIENT;
        this.receiving_lc.setUId = function (uid)
        {
            var _loc3 = SharedObject.getLocal(dofus.Constants.GLOBAL_SO_IDENTITY_NAME);
            _loc3.data.identity = uid;
            _loc3.flush();
            _loc3.close();
            dofus.managers.UIdManager.getInstance().receiving_lc.close();
        };
    };
    _loc1.addProperty("api", _loc1.__get__api, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.UIdManager = function ()
    {
        this.receiving_lc = new LocalConnection();
        this.sending_lc = new LocalConnection();
        this._status = dofus.managers.UIdManager.NONE;
        this._connId = "_dofus" + Math.floor(Math.random() * 100000000);
    }).SERVER = 1;
    (_global.dofus.managers.UIdManager = function ()
    {
        this.receiving_lc = new LocalConnection();
        this.sending_lc = new LocalConnection();
        this._status = dofus.managers.UIdManager.NONE;
        this._connId = "_dofus" + Math.floor(Math.random() * 100000000);
    }).CLIENT = 2;
    (_global.dofus.managers.UIdManager = function ()
    {
        this.receiving_lc = new LocalConnection();
        this.sending_lc = new LocalConnection();
        this._status = dofus.managers.UIdManager.NONE;
        this._connId = "_dofus" + Math.floor(Math.random() * 100000000);
    }).NONE = 3;
} // end if
#endinitclip
