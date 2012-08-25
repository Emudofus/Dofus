// Action script...

// [Initial MovieClip Action of sprite 20705]
#initclip 226
if (!dofus.managers.StreamingDisplayManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.StreamingDisplayManager = function ()
    {
        super();
        this.initConfiguration();
    }).prototype;
    (_global.dofus.managers.StreamingDisplayManager = function ()
    {
        super();
        this.initConfiguration();
    }).getInstance = function ()
    {
        if (dofus.managers.StreamingDisplayManager._self == null)
        {
            dofus.managers.StreamingDisplayManager._self = new dofus.managers.StreamingDisplayManager();
        } // end if
        return (dofus.managers.StreamingDisplayManager._self);
    };
    _loc1.displayAdvice = function (id)
    {
        getURL("FSCommand:" add "display", id);
        if (this.getDisplaysSharedObject().data["display" + id] == undefined)
        {
            this.getDisplaysSharedObject().data["display" + id] = 1;
        }
        else
        {
            this.getDisplaysSharedObject().data["display" + id] = this.getDisplaysSharedObject().data["display" + id] + 1;
        } // end else if
        this.getDisplaysSharedObject().flush();
    };
    _loc1.displayAdviceMax = function (id, max)
    {
        if (this.getDisplaysSharedObject().data["display" + id] == undefined || this.getDisplaysSharedObject().data["display" + id] < max)
        {
            this.displayAdvice(id);
        } // end if
    };
    _loc1.getMapDisplay = function (id)
    {
        if (dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[id] != undefined)
        {
            if (this.getDisplaysSharedObject().data["display" + dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[id]] == 1)
            {
                return (this.getDefaultDisplay(this.getPlayTime()));
            }
            else
            {
                return (dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[id]);
            } // end else if
        }
        else
        {
            return (this.getDefaultDisplay(this.getPlayTime()));
        } // end else if
    };
    _loc1.getPlayTime = function ()
    {
        return (getTimer() / 1000);
    };
    _loc1.getDefaultDisplay = function (playtime)
    {
        if (playtime < 1200)
        {
            return (dofus.managers.StreamingDisplayManager.DEFAULT_DISPLAY);
        }
        else
        {
            return (dofus.managers.StreamingDisplayManager.DOWNLOAD_DISPLAY[Math.floor((playtime - 1200) / 300) % dofus.managers.StreamingDisplayManager.DOWNLOAD_DISPLAY.length]);
        } // end else if
    };
    _loc1.initConfiguration = function ()
    {
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10300] = 1;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10284] = 1;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10299] = 1;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10285] = 1;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10298] = 1;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10276] = 1;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10283] = 1;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10294] = 1;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10292] = 1;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10279] = 1;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10296] = 1;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10289] = 1;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10305] = 2;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10321] = 2;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10322] = 2;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10323] = 2;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10324] = 2;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10325] = 2;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10326] = 2;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10327] = 2;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10328] = 2;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10329] = 2;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10330] = 2;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10331] = 2;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10273] = 4;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10337] = 3;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10258] = 3;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10295] = 5;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10288] = 6;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10290] = 6;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10287] = 6;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10345] = 6;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10346] = 6;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10344] = 6;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10297] = 14;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10349] = 14;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10317] = 14;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10304] = 14;
        dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10318] = 26;
    };
    _loc1.getDisplaysSharedObject = function ()
    {
        if (this._soDisplays == undefined && this.api.datacenter.Player.Name)
        {
            this._soDisplays = SharedObject.getLocal(dofus.Constants.GLOBAL_SO_DISPLAYS_NAME + this.api.datacenter.Player.Name);
        } // end if
        return (this._soDisplays);
    };
    _loc1.onNicknameChoice = function ()
    {
        this.displayAdvice(16);
    };
    _loc1.onCharacterCreation = function ()
    {
        this.displayAdvice(17);
    };
    _loc1.onCharacterChoice = function ()
    {
        this.displayAdvice(18);
    };
    _loc1.onFightStart = function ()
    {
        this.displayAdviceMax(7, 2);
    };
    _loc1.onFightStartEnd = function ()
    {
        this.displayAdviceMax(8, 2);
    };
    _loc1.onFightEnd = function ()
    {
        if (this.api.datacenter.Player.LP < this.api.datacenter.Player.LPmax)
        {
            this.displayAdviceMax(12, 2);
        }
        else
        {
            this.displayAdvice(this.getMapDisplay(this._nCurrentMap));
        } // end else if
    };
    _loc1.onNewInterface = function (link)
    {
        _global.clearInterval(this._nNewInterfaceTimer);
        this._nNewInterfaceTimer = _global.setInterval(this, "newInterface", 200, link);
    };
    _loc1.newInterface = function (link)
    {
        _global.clearInterval(this._nNewInterfaceTimer);
        switch (link)
        {
            case "Inventory":
            {
                this.displayAdviceMax(9, 2);
                break;
            } 
            case "Spells":
            {
                this.displayAdviceMax(10, 2);
                break;
            } 
            case "StatsJob":
            {
                this.displayAdviceMax(11, 2);
                break;
            } 
        } // End of switch
    };
    _loc1.onInterfaceClose = function (instanceName)
    {
        _global.clearInterval(this._nNewInterfaceTimer);
        switch (instanceName)
        {
            case "Inventory":
            case "Spells":
            case "StatsJob":
            {
                this.displayAdvice(this.getMapDisplay(this._nCurrentMap));
                break;
            } 
        } // End of switch
    };
    _loc1.onLevelGain = function ()
    {
        this.displayAdviceMax(13, 2);
    };
    _loc1.onNewMap = function (id)
    {
        this._nCurrentMap = id;
        this.displayAdvice(this.getMapDisplay(id));
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.StreamingDisplayManager = function ()
    {
        super();
        this.initConfiguration();
    }).DEFAULT_DISPLAY = 19;
    (_global.dofus.managers.StreamingDisplayManager = function ()
    {
        super();
        this.initConfiguration();
    }).DOWNLOAD_DISPLAY = [21, 22, 23, 24, 25];
    (_global.dofus.managers.StreamingDisplayManager = function ()
    {
        super();
        this.initConfiguration();
    }).TRIGGERING_MAPS = new Array();
} // end if
#endinitclip
