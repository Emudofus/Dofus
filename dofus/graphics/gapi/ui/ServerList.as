// Action script...

// [Initial MovieClip Action of sprite 20930]
#initclip 195
if (!dofus.graphics.gapi.ui.ServerList)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.ServerList = function ()
    {
        super();
    }).prototype;
    _loc1.__set__servers = function (eaServers)
    {
        this._eaServers = eaServers;
        this._eaServersSave = eaServers;
        if (this.initialized)
        {
            this.updateData();
        } // end if
        //return (this.servers());
    };
    _loc1.__set__serverID = function (nServerID)
    {
        this._nServerID = nServerID;
        //return (this.serverID());
    };
    _loc1.__get__selectedServerID = function ()
    {
        return (this._nServerID);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.ServerList.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.updateData});
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.addListeners = function ()
    {
        this._dgServers.addEventListener("itemSelected", this);
        this._dgServers.addEventListener("itemdblClick", this);
        this._dgServers.addEventListener("itemRollOver", this);
        this._dgServers.addEventListener("itemRollOut", this);
        this._btnClose.addEventListener("click", this);
        this._btnSelect.addEventListener("click", this);
        this._btnSearch.addEventListener("click", this);
        this._btnDisplayAllCommunities.addEventListener("click", this);
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
        var ref = this;
        var _loc2 = new Object();
        _loc2.onSetFocus = function (oldFocus_txt, newFocus_txt)
        {
            if (Selection.getFocus()._parent == ref._tiSearch)
            {
                if (ref._tiSearch.text == ref.api.lang.getText("PSEUDO_DOFUS_SIMPLE"))
                {
                    ref._tiSearch.text = "";
                } // end if
            }
            else if (ref._tiSearch.text == "")
            {
                ref._tiSearch.text = ref.api.lang.getText("PSEUDO_DOFUS_SIMPLE");
            } // end else if
        };
        Selection.addListener(_loc2);
    };
    _loc1.initTexts = function ()
    {
        this._winBg.title = "Liste des serveurs";
        this._btnSelect.label = this.api.lang.getText("SELECT");
        this._btnClose.label = this.api.lang.getText("BACK");
        this._btnSearch.label = this.api.lang.getText("OK");
        this._lblSearch.text = this.api.lang.getText("FIND_FRIEND");
        this._lblDisplayAllCommunities.text = this.api.lang.getText("SERVER_LIST_DISPLAY_ALL_COMMUNITIES");
        this._tiSearch.text = this._tiSearch.text.length ? (this._tiSearch.text) : (this.api.lang.getText("PSEUDO_DOFUS_SIMPLE"));
        this._dgServers.columnsNames = ["", this.api.lang.getText("NAME_BIG"), this.api.lang.getText("TYPE"), this.api.lang.getText("STATE"), this.api.lang.getText("COMMUNITY"), this.api.lang.getText("POPULATION")];
    };
    _loc1.updateData = function ()
    {
        if (this.api.lang.getConfigText("SERVER_LIST_USE_FIND_FRIEND"))
        {
            this._dgServers._y = this._mcPlacer._y;
        } // end if
        if (_global.CONFIG.onlyHardcore && !this._alreadySetShowAll)
        {
            this._btnDisplayAllCommunities.selected = true;
            this._alreadySetShowAll = true;
        } // end if
        var _loc2 = new ank.utils.ExtendedArray();
        var _loc3 = new ank.utils.ExtendedArray();
        var _loc4 = new Object();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < this._eaServers.length)
        {
            var _loc6 = this._eaServers[_loc5];
            if ((_loc6.isHardcore() || (this._btnDisplayAllCommunities.selected || _loc6.community == this.api.datacenter.Basics.communityId)) && _loc6.isAllowed())
            {
                _loc2.push(this._eaServers[_loc5]);
            } // end if
        } // end while
        var _loc7 = 0;
        
        while (++_loc7, _loc7 < _loc2.length)
        {
            var _loc8 = _loc2[_loc7];
            if (_loc8 == undefined)
            {
                continue;
            } // end if
            var _loc9 = _loc8.language;
            _loc8.sortPopulation = _loc8.population;
            if (this.api.config.language != _loc9)
            {
                if (_loc4[_loc9] == undefined)
                {
                    _loc4[_loc9] = new ank.utils.ExtendedArray();
                } // end if
                _loc4[_loc9].push(_loc8);
                continue;
            } // end if
            _loc3.push(_loc8);
        } // end while
        _loc3.sortOn("sortPopulation");
        for (var a in _loc4)
        {
            var _loc10 = _loc4[a];
            _loc10.sortOn("sortPopulation");
            var _loc11 = 0;
            
            while (++_loc11, _loc11 < _loc10.length)
            {
                _loc3.push(_loc10[_loc11]);
            } // end while
        } // end of for...in
        this._dgServers.dataProvider = _loc3;
        var _loc12 = 0;
        if (this._nServerID != undefined)
        {
            var _loc13 = 0;
            
            while (++_loc13, _loc13 < _loc3.length)
            {
                if (_loc3[_loc13].id == this._nServerID)
                {
                    _loc12 = _loc13;
                    break;
                } // end if
            } // end while
        } // end if
        this._dgServers.selectedIndex = _loc12;
        this._nServerID = this._dgServers.selectedItem.id;
    };
    _loc1.findFriend = function ()
    {
        if (this._tiSearch.text == this.api.lang.getText("PSEUDO_DOFUS_SIMPLE") || !this._tiSearch.text.length)
        {
            this._eaServers = this._eaServersSave;
            this._lblSearchResult.text = "";
            this.updateData();
            return;
        } // end if
        if (this._nLastSearchTimer + dofus.graphics.gapi.ui.ServerList.SEARCH_DELAY > getTimer())
        {
            return;
        } // end if
        this._nLastSearchTimer = getTimer();
        this.api.network.Account.searchForFriend(this._tiSearch.text);
    };
    _loc1.setSearchResult = function (aResult)
    {
        this._eaServers = new ank.utils.ExtendedArray();
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._eaServersSave.length)
        {
            var _loc4 = 0;
            
            while (++_loc4, _loc4 < aResult.length)
            {
                if (aResult[_loc4].server == this._eaServersSave[_loc3].id)
                {
                    this._eaServersSave[_loc3].friendCharactersCount = aResult[_loc4].count;
                    this._eaServersSave[_loc3].search = this._tiSearch.text;
                    this._eaServers.push(this._eaServersSave[_loc3]);
                    break;
                } // end if
            } // end while
        } // end while
        this._eaServers.bubbleSortOn("friendCharactersCount", Array.DESCENDING | Array.NUMERIC);
        if (!this._eaServers.length)
        {
            this._lblSearchResult.text = this.api.lang.getText("SEARCH_RESULT_EMPTY");
        }
        else
        {
            this._lblSearchResult.text = "";
        } // end else if
        this.updateData();
    };
    _loc1.onServerSelected = function ()
    {
        this._nServerID = this._dgServers.selectedItem.id;
        if (this._nServerID == undefined)
        {
            return;
        } // end if
        this.gapi.loadUIComponent("ServerInformations", "ServerInformations", {server: this._nServerID});
        this.gapi.getUIComponent("ServerInformations").addEventListener("serverSelected", this);
        this.gapi.getUIComponent("ServerInformations").addEventListener("canceled", this);
    };
    _loc1.serverSelected = function (oEvent)
    {
        this.gapi.unloadUIComponent("ServerInformations");
        this.dispatchEvent({type: "serverSelected", serverID: oEvent.value});
    };
    _loc1.canceled = function (oEvent)
    {
        this.gapi.unloadUIComponent("ServerInformations");
    };
    _loc1.onShortcut = function (sShortcut)
    {
        if (sShortcut == "ACCEPT_CURRENT_DIALOG" && this._tiSearch.focused)
        {
            this.click({target: this._btnSearch});
            return (false);
        } // end if
        return (true);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnSelect:
            {
                this.onServerSelected();
                break;
            } 
            case this._btnClose:
            {
                this.unloadThis();
                break;
            } 
            case this._btnDisplayAllCommunities:
            {
                this.updateData();
                break;
            } 
            case this._btnSearch:
            {
                this.findFriend();
            } 
        } // End of switch
    };
    _loc1.itemRollOver = function (oEvent)
    {
        oEvent.row.cellRenderer_mc.over();
    };
    _loc1.itemRollOut = function (oEvent)
    {
        oEvent.row.cellRenderer_mc.out();
    };
    _loc1.itemSelected = function (oEvent)
    {
        this._nServerID = this._dgServers.selectedItem.id;
    };
    _loc1.itemdblClick = function (oEvent)
    {
        this.onServerSelected();
    };
    _loc1.addProperty("servers", function ()
    {
    }, _loc1.__set__servers);
    _loc1.addProperty("selectedServerID", _loc1.__get__selectedServerID, function ()
    {
    });
    _loc1.addProperty("serverID", function ()
    {
    }, _loc1.__set__serverID);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.ServerList = function ()
    {
        super();
    }).CLASS_NAME = "ServerList";
    (_global.dofus.graphics.gapi.ui.ServerList = function ()
    {
        super();
    }).SEARCH_DELAY = 500;
    _loc1._nLastSearchTimer = 0;
} // end if
#endinitclip
