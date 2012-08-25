// Action script...

// [Initial MovieClip Action of sprite 20687]
#initclip 208
if (!dofus.managers.MapsServersManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.MapsServersManager = function ()
    {
        super();
        dofus.managers.MapsServersManager._sSelf = this;
    }).prototype;
    _loc1.__get__isBuilding = function ()
    {
        return (this._bBuildingMap);
    };
    _loc1.__set__isBuilding = function (bBuilding)
    {
        this._bBuildingMap = bBuilding;
        //return (this.isBuilding());
    };
    (_global.dofus.managers.MapsServersManager = function ()
    {
        super();
        dofus.managers.MapsServersManager._sSelf = this;
    }).getInstance = function ()
    {
        return (dofus.managers.MapsServersManager._sSelf);
    };
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI, "maps", "maps/");
    };
    _loc1.loadMap = function (sID, sDate, sKey)
    {
        this._lastLoadedMap = undefined;
        if (!_global.isNaN(Number(sID)))
        {
            if (sKey != undefined && sKey.length > 0)
            {
                this._aKeys[Number(sID)] = dofus.aks.Aks.prepareKey(sKey);
            }
            else
            {
                delete this._aKeys[Number(sID)];
            } // end if
        } // end else if
        this.loadData(sID + "_" + sDate + (this._aKeys[Number(sID)] != undefined ? ("X") : ("")) + ".swf");
    };
    _loc1.getMapName = function (nMapID)
    {
        var _loc3 = this.api.lang.getMapText(nMapID);
        var _loc4 = this.api.lang.getMapAreaInfos(_loc3.sa);
        var _loc5 = this.api.lang.getMapAreaText(_loc4.areaID).n;
        var _loc6 = this.api.lang.getMapSubAreaText(_loc3.sa).n;
        var _loc7 = _loc5 + (_loc6.indexOf("//") == -1 ? (" (" + _loc6 + ")") : (""));
        if (dofus.Constants.DEBUG)
        {
            _loc7 = _loc7 + (" (" + nMapID + ")");
        } // end if
        return (_loc7);
    };
    _loc1.parseMap = function (oData)
    {
        if (this.api.network.Game.isBusy)
        {
            this.addToQueue({object: this, method: this.parseMap, params: [oData]});
            return;
        } // end if
        var _loc3 = Number(oData.id);
        if (this.api.config.isStreaming && this.api.config.streamingMethod == "compact")
        {
            var _loc4 = this.api.lang.getConfigText("INCARNAM_CLASS_MAP");
            var _loc5 = false;
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < _loc4.length && !_loc5)
            {
                if (_loc4[_loc6] == _loc3)
                {
                    _loc5 = true;
                } // end if
            } // end while
            if (_loc5)
            {
                var _loc7 = [dofus.Constants.GFX_ROOT_PATH + "g" + this.api.datacenter.Player.Guild + ".swf", dofus.Constants.GFX_ROOT_PATH + "o" + this.api.datacenter.Player.Guild + ".swf"];
            }
            else
            {
                _loc7 = [dofus.Constants.GFX_ROOT_PATH + "g0.swf", dofus.Constants.GFX_ROOT_PATH + "o0.swf"];
            } // end else if
            if (!this.api.gfx.loadManager.areRegister(_loc7))
            {
                this.api.gfx.loadManager.loadFiles(_loc7);
                this.api.gfx.bCustomFileLoaded = false;
            } // end if
            if (this.api.gfx.loadManager.areLoaded(_loc7))
            {
                this.api.gfx.setCustomGfxFile(_loc7[0], _loc7[1]);
            } // end if
            if (!this.api.gfx.bCustomFileLoaded || !this.api.gfx.loadManager.areLoaded(_loc7))
            {
                var _loc8 = this.api.ui.getUIComponent("CenterTextMap");
                if (!_loc8)
                {
                    _loc8 = this.api.ui.loadUIComponent("CenterText", "CenterTextMap", {text: this.api.lang.getText("LOADING_MAP"), timer: 40000}, {bForceLoad: true});
                } // end if
                this.api.ui.getUIComponent("CenterTextMap").updateProgressBar("Downloading", this.api.gfx.loadManager.getProgressions(_loc7), 100);
                this.addToQueue({object: this, method: this.parseMap, params: [oData]});
                return;
            } // end if
            if (_loc5 && !this._bPreloadCall)
            {
                this._bPreloadCall = true;
                this.api.gfx.loadManager.loadFiles([dofus.Constants.CLIPS_PERSOS_PATH + (this.api.datacenter.Player.Guild * 10 + this.api.datacenter.Player.Sex) + ".swf", dofus.Constants.CLIPS_PERSOS_PATH + "9059.swf", dofus.Constants.CLIPS_PERSOS_PATH + "9091.swf", dofus.Constants.CLIPS_PERSOS_PATH + "1219.swf", dofus.Constants.CLIPS_PERSOS_PATH + "101.swf", dofus.Constants.GFX_ROOT_PATH + "g0.swf", dofus.Constants.GFX_ROOT_PATH + "o0.swf"]);
            } // end if
        } // end if
        this._bCustomFileCall = false;
        if (this.api.network.Game.nLastMapIdReceived != _loc3 && (this.api.network.Game.nLastMapIdReceived != -1 && this.api.lang.getConfigText("CHECK_MAP_FILE_ID")))
        {
            this.api.gfx.onMapLoaded();
            return;
        } // end if
        this._bBuildingMap = true;
        this._lastLoadedMap = oData;
        var _loc9 = this.getMapName(_loc3);
        var _loc10 = Number(oData.width);
        var _loc11 = Number(oData.height);
        var _loc12 = Number(oData.backgroundNum);
        var _loc13 = this._aKeys[_loc3] != undefined ? (dofus.aks.Aks.decypherData(oData.mapData, this._aKeys[_loc3], _global.parseInt(dofus.aks.Aks.checksum(this._aKeys[_loc3]), 16) * 2)) : (oData.mapData);
        var _loc14 = oData.ambianceId;
        var _loc15 = oData.musicId;
        var _loc16 = oData.bOutdoor == 1 ? (true) : (false);
        var _loc17 = (oData.capabilities & 1) == 0;
        var _loc18 = (oData.capabilities >> 1 & 1) == 0;
        var _loc19 = (oData.capabilities >> 2 & 1) == 0;
        var _loc20 = (oData.capabilities >> 3 & 1) == 0;
        this.api.datacenter.Basics.aks_current_map_id = _loc3;
        this.api.kernel.TipsManager.onNewMap(_loc3);
        this.api.kernel.StreamingDisplayManager.onNewMap(_loc3);
        var _loc21 = new dofus.datacenter.DofusMap(_loc3);
        _loc21.bCanChallenge = _loc17;
        _loc21.bCanAttack = _loc18;
        _loc21.bSaveTeleport = _loc19;
        _loc21.bUseTeleport = _loc20;
        _loc21.bOutdoor = _loc16;
        _loc21.ambianceID = _loc14;
        _loc21.musicID = _loc15;
        this.api.gfx.buildMap(_loc3, _loc9, _loc10, _loc11, _loc12, _loc13, _loc21);
        this._bBuildingMap = false;
    };
    _loc1.onComplete = function (mc)
    {
        var _loc3 = mc;
        this.parseMap(_loc3);
    };
    _loc1.onFailed = function ()
    {
        this.api.kernel.showMessage(undefined, this.api.lang.getText("NO_MAPDATA_FILE"), "ERROR_BOX", {name: "NoMapData"});
    };
    _loc1.addProperty("isBuilding", _loc1.__get__isBuilding, _loc1.__set__isBuilding);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.MapsServersManager = function ()
    {
        super();
        dofus.managers.MapsServersManager._sSelf = this;
    })._sSelf = null;
    _loc1._lastLoadedMap = undefined;
    _loc1._aKeys = new Array();
    _loc1._bBuildingMap = false;
    _loc1._bCustomFileCall = false;
    _loc1._bPreloadCall = false;
} // end if
#endinitclip
