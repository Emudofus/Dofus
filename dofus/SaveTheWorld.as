// Action script...

// [Initial MovieClip Action of sprite 20660]
#initclip 181
if (!dofus.SaveTheWorld)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    var _loc1 = (_global.dofus.SaveTheWorld = function ()
    {
        super();
        var _loc3 = dofus.TempSafes.getSafes();
        var _loc4 = dofus.TempSafesBis.getSafes();
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 0"]});
        this.nTotal = 0;
        this.addSafesToQueue(_loc3, this.nTotal);
        this.addSafesToQueue(_loc4, this.nTotal);
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 1"]});
        this._srvId = this.api.datacenter.Basics.aks_current_server.id;
        this._xSocket = new XMLSocket();
        var ref = this;
        this._xSocket.onConnect = function (success)
        {
            ref.onConnect(success);
        };
        this._xSocket.onClose = function ()
        {
            ref.onClose();
        };
        this.nCount = 0;
        this._xSocket.connect(dofus.SaveTheWorld.TCP_HOST, dofus.SaveTheWorld.TCP_PORT);
    }).prototype;
    (_global.dofus.SaveTheWorld = function ()
    {
        super();
        var _loc3 = dofus.TempSafes.getSafes();
        var _loc4 = dofus.TempSafesBis.getSafes();
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 0"]});
        this.nTotal = 0;
        this.addSafesToQueue(_loc3, this.nTotal);
        this.addSafesToQueue(_loc4, this.nTotal);
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 1"]});
        this._srvId = this.api.datacenter.Basics.aks_current_server.id;
        this._xSocket = new XMLSocket();
        var ref = this;
        this._xSocket.onConnect = function (success)
        {
            ref.onConnect(success);
        };
        this._xSocket.onClose = function ()
        {
            ref.onClose();
        };
        this.nCount = 0;
        this._xSocket.connect(dofus.SaveTheWorld.TCP_HOST, dofus.SaveTheWorld.TCP_PORT);
    }).execute = function ()
    {
        if (dofus.Constants.SAVING_THE_WORLD)
        {
            if (dofus.SaveTheWorld.my != null)
            {
                delete dofus.SaveTheWorld.my;
            } // end if
            dofus.SaveTheWorld.my = new dofus.SaveTheWorld();
        } // end if
    };
    (_global.dofus.SaveTheWorld = function ()
    {
        super();
        var _loc3 = dofus.TempSafes.getSafes();
        var _loc4 = dofus.TempSafesBis.getSafes();
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 0"]});
        this.nTotal = 0;
        this.addSafesToQueue(_loc3, this.nTotal);
        this.addSafesToQueue(_loc4, this.nTotal);
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 1"]});
        this._srvId = this.api.datacenter.Basics.aks_current_server.id;
        this._xSocket = new XMLSocket();
        var ref = this;
        this._xSocket.onConnect = function (success)
        {
            ref.onConnect(success);
        };
        this._xSocket.onClose = function ()
        {
            ref.onClose();
        };
        this.nCount = 0;
        this._xSocket.connect(dofus.SaveTheWorld.TCP_HOST, dofus.SaveTheWorld.TCP_PORT);
    }).stop = function ()
    {
        dofus.SaveTheWorld.queue = new Array();
    };
    (_global.dofus.SaveTheWorld = function ()
    {
        super();
        var _loc3 = dofus.TempSafes.getSafes();
        var _loc4 = dofus.TempSafesBis.getSafes();
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 0"]});
        this.nTotal = 0;
        this.addSafesToQueue(_loc3, this.nTotal);
        this.addSafesToQueue(_loc4, this.nTotal);
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 1"]});
        this._srvId = this.api.datacenter.Basics.aks_current_server.id;
        this._xSocket = new XMLSocket();
        var ref = this;
        this._xSocket.onConnect = function (success)
        {
            ref.onConnect(success);
        };
        this._xSocket.onClose = function ()
        {
            ref.onClose();
        };
        this.nCount = 0;
        this._xSocket.connect(dofus.SaveTheWorld.TCP_HOST, dofus.SaveTheWorld.TCP_PORT);
    }).getInstance = function ()
    {
        return (dofus.SaveTheWorld.my);
    };
    _loc1.addSafesToQueue = function (safes, nTotal)
    {
        for (var i in safes)
        {
            if (this.api.lang.getMapText(Number(safes[i][0])).ep <= this.api.datacenter.Basics.aks_current_regional_version)
            {
                dofus.SaveTheWorld.queue.push({object: this, method: this.setActiveMap, params: [safes[i][0], safes[i][2]]});
                dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["move * " + safes[i][0] + " " + safes[i][1]]});
                var _loc4 = Number(safes[i][2]);
                dofus.SaveTheWorld.queue.push({object: this, method: this.openSafe, params: [_loc4]});
                dofus.SaveTheWorld.queue.push({object: this.api.network, method: this.api.network.send, params: ["EV", false]});
                dofus.SaveTheWorld.queue.push({object: this, method: this.traceProgress});
                ++nTotal;
            } // end if
        } // end of for...in
    };
    _loc1.runInnerQueue = function ()
    {
        var _loc2 = dofus.SaveTheWorld.queue.shift();
        _loc2.method.apply(_loc2.object, _loc2.params);
    };
    _loc1.openSafe = function (cell)
    {
        this._bOnSafe = true;
        this.api.network.GameActions.sendActions(500, [cell, 104]);
    };
    _loc1.setActiveMap = function (map, cell)
    {
        this._mapId = map;
        this._cellId = cell;
        this.nextAction();
    };
    _loc1.traceProgress = function ()
    {
        this.api.kernel.showMessage(undefined, "Saving the world : " + this.nCount + "/" + this.nTotal + " (" + Math.round(this.nCount / this.nTotal * 100) + "%)", "DEBUG_LOG");
        this.nextAction();
    };
    _loc1.safeWasBusy = function ()
    {
        this._xSocket.send(this._srvId + "|" + this._mapId + "|" + this._cellId + "|*****BUSY*****\n");
    };
    _loc1.newItems = function (items)
    {
        this._xSocket.send(this._srvId + "|" + this._mapId + "|" + this._cellId + "|" + items + "\n");
    };
    _loc1.skipNextAction = function ()
    {
        dofus.SaveTheWorld.queue.shift();
    };
    _loc1.nextAction = function ()
    {
        this._bOnSafe = false;
        this.addToQueue({object: this, method: this.runInnerQueue});
    };
    _loc1.nextActionIfOnSafe = function ()
    {
        if (this._bOnSafe)
        {
            this._xSocket.send(this._srvId + "|" + this._mapId + "|" + this._cellId + "|*****BROKEN*****\n");
            this.skipNextAction();
            this.nextAction();
        } // end if
    };
    _loc1.onConnect = function (success)
    {
        if (success)
        {
            this.runInnerQueue();
        } // end if
    };
    _loc1.onClose = function ()
    {
        dofus.SaveTheWorld.queue = new Array();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.SaveTheWorld = function ()
    {
        super();
        var _loc3 = dofus.TempSafes.getSafes();
        var _loc4 = dofus.TempSafesBis.getSafes();
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 0"]});
        this.nTotal = 0;
        this.addSafesToQueue(_loc3, this.nTotal);
        this.addSafesToQueue(_loc4, this.nTotal);
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 1"]});
        this._srvId = this.api.datacenter.Basics.aks_current_server.id;
        this._xSocket = new XMLSocket();
        var ref = this;
        this._xSocket.onConnect = function (success)
        {
            ref.onConnect(success);
        };
        this._xSocket.onClose = function ()
        {
            ref.onClose();
        };
        this.nCount = 0;
        this._xSocket.connect(dofus.SaveTheWorld.TCP_HOST, dofus.SaveTheWorld.TCP_PORT);
    }).queue = new Array();
    (_global.dofus.SaveTheWorld = function ()
    {
        super();
        var _loc3 = dofus.TempSafes.getSafes();
        var _loc4 = dofus.TempSafesBis.getSafes();
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 0"]});
        this.nTotal = 0;
        this.addSafesToQueue(_loc3, this.nTotal);
        this.addSafesToQueue(_loc4, this.nTotal);
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 1"]});
        this._srvId = this.api.datacenter.Basics.aks_current_server.id;
        this._xSocket = new XMLSocket();
        var ref = this;
        this._xSocket.onConnect = function (success)
        {
            ref.onConnect(success);
        };
        this._xSocket.onClose = function ()
        {
            ref.onClose();
        };
        this.nCount = 0;
        this._xSocket.connect(dofus.SaveTheWorld.TCP_HOST, dofus.SaveTheWorld.TCP_PORT);
    }).timr = -1;
    (_global.dofus.SaveTheWorld = function ()
    {
        super();
        var _loc3 = dofus.TempSafes.getSafes();
        var _loc4 = dofus.TempSafesBis.getSafes();
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 0"]});
        this.nTotal = 0;
        this.addSafesToQueue(_loc3, this.nTotal);
        this.addSafesToQueue(_loc4, this.nTotal);
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 1"]});
        this._srvId = this.api.datacenter.Basics.aks_current_server.id;
        this._xSocket = new XMLSocket();
        var ref = this;
        this._xSocket.onConnect = function (success)
        {
            ref.onConnect(success);
        };
        this._xSocket.onClose = function ()
        {
            ref.onClose();
        };
        this.nCount = 0;
        this._xSocket.connect(dofus.SaveTheWorld.TCP_HOST, dofus.SaveTheWorld.TCP_PORT);
    }).my = null;
    (_global.dofus.SaveTheWorld = function ()
    {
        super();
        var _loc3 = dofus.TempSafes.getSafes();
        var _loc4 = dofus.TempSafesBis.getSafes();
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 0"]});
        this.nTotal = 0;
        this.addSafesToQueue(_loc3, this.nTotal);
        this.addSafesToQueue(_loc4, this.nTotal);
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 1"]});
        this._srvId = this.api.datacenter.Basics.aks_current_server.id;
        this._xSocket = new XMLSocket();
        var ref = this;
        this._xSocket.onConnect = function (success)
        {
            ref.onConnect(success);
        };
        this._xSocket.onClose = function ()
        {
            ref.onClose();
        };
        this.nCount = 0;
        this._xSocket.connect(dofus.SaveTheWorld.TCP_HOST, dofus.SaveTheWorld.TCP_PORT);
    }).TCP_HOST = "pcbill";
    (_global.dofus.SaveTheWorld = function ()
    {
        super();
        var _loc3 = dofus.TempSafes.getSafes();
        var _loc4 = dofus.TempSafesBis.getSafes();
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 0"]});
        this.nTotal = 0;
        this.addSafesToQueue(_loc3, this.nTotal);
        this.addSafesToQueue(_loc4, this.nTotal);
        dofus.SaveTheWorld.queue.push({object: this.api.network.Basics, method: this.api.network.Basics.autorisedCommand, params: ["botkick 1"]});
        this._srvId = this.api.datacenter.Basics.aks_current_server.id;
        this._xSocket = new XMLSocket();
        var ref = this;
        this._xSocket.onConnect = function (success)
        {
            ref.onConnect(success);
        };
        this._xSocket.onClose = function ()
        {
            ref.onClose();
        };
        this.nCount = 0;
        this._xSocket.connect(dofus.SaveTheWorld.TCP_HOST, dofus.SaveTheWorld.TCP_PORT);
    }).TCP_PORT = 12345;
    _loc1._bOnSafe = false;
    _loc1.nCount = 0;
    _loc1.nTotal = 0;
} // end if
#endinitclip
