// Action script...

// [Initial MovieClip Action of sprite 20701]
#initclip 222
if (!dofus.graphics.gapi.ui.JoinFriend)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.JoinFriend = function ()
    {
        super();
    }).prototype;
    _loc1.__set__servers = function (eaServers)
    {
        this._eaServers = eaServers;
        //return (this.servers());
    };
    _loc1.__set__remainingTime = function (nRemainingTime)
    {
        this._nRemainingTime = nRemainingTime;
        //return (this.remainingTime());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.JoinFriend.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.addListeners = function ()
    {
        var ref = this;
        this._mcDirectPlay.onRelease = function ()
        {
            this._parent.click({target: this});
        };
        this._btnSearch.onRelease = function ()
        {
            this._parent.click({target: this});
        };
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
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
        this._lblTitle.text = this.api.lang.getText("JOIN_FRIEND_SERVER");
        this._lblCopyright.text = this.api.lang.getText("COPYRIGHT");
        this._lblDirectPlay.text = this.api.lang.getText("DIRECT_PLAY");
        this._lblDownload.text = this.api.lang.getText("JOIN_FRIEND_INVITE");
    };
    _loc1.getLessPopulatedServer = function (eaServers)
    {
        if (eaServers.length == 1)
        {
            return (eaServers[0].id);
        } // end if
        eaServers.sortOn("populationWeight", Array.NUMERIC | Array.ASCENDING);
        var _loc3 = eaServers[0].populationWeight;
        var _loc4 = new ank.utils.ExtendedArray();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < eaServers.length)
        {
            if (eaServers[_loc5].populationWeight == _loc3)
            {
                _loc4.push(eaServers[_loc5]);
            } // end if
        } // end while
        _loc4.sortOn("completion", Array.NUMERIC | Array.ASCENDING);
        var _loc6 = _loc4[0].completion;
        var _loc7 = new ank.utils.ExtendedArray();
        var _loc8 = 0;
        
        while (++_loc8, _loc8 < _loc4.length)
        {
            if (_loc4[_loc8].completion == _loc6)
            {
                _loc7.push(_loc4[_loc8]);
            } // end if
        } // end while
        return (_loc7[Math.round(Math.random() * (_loc7.length - 1))].id);
    };
    _loc1.selectServer = function (nServerID)
    {
        this.gapi.loadUIComponent("ServerInformations", "ServerInformations", {server: nServerID});
        this.gapi.getUIComponent("ServerInformations").addEventListener("serverSelected", this);
        this.gapi.getUIComponent("ServerInformations").addEventListener("canceled", this);
    };
    _loc1.findFriend = function ()
    {
        if (this._tiSearch.text == this.api.lang.getText("PSEUDO_DOFUS_SIMPLE") || !this._tiSearch.text.length)
        {
            return;
        } // end if
        this.api.network.Account.searchForFriend(this._tiSearch.text);
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
        switch (oEvent.target._name)
        {
            case "_mcAutomaticSelect":
            {
                var _loc3 = new ank.utils.ExtendedArray();
                var _loc4 = 0;
                
                while (++_loc4, _loc4 < this._eaServers.length)
                {
                    if (this._eaServers[_loc4].state == dofus.datacenter.Server.SERVER_ONLINE && this._eaServers[_loc4].isAllowed())
                    {
                        _loc3.push(this._eaServers[_loc4]);
                    } // end if
                } // end while
                if (_loc3.length <= 0)
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("ALL_SERVERS_ARE_DOWN"), "ERROR_BOX");
                    break;
                } // end if
                var _loc5 = new ank.utils.ExtendedArray();
                var _loc6 = 0;
                
                while (++_loc6, _loc6 < _loc3.length)
                {
                    if (_loc3[_loc6].canLog && _loc3[_loc6].typeNum == dofus.datacenter.Server.SERVER_CLASSIC)
                    {
                        _loc5.push(_loc3[_loc6]);
                    } // end if
                } // end while
                _loc3 = _loc5;
                if (_loc3.length <= 0)
                {
                    if (this._nRemainingTime <= 0)
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("ALL_SERVERS_ARE_FULL_NOT_FULL_MEMBER"), "ERROR_BOX");
                    }
                    else
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("ALL_SERVERS_ARE_FULL_FULL_MEMBER"), "ERROR_BOX");
                    } // end else if
                    break;
                } // end if
                this._eaPreselectedServers = _loc3;
                _loc5 = new ank.utils.ExtendedArray();
                var _loc7 = 0;
                
                while (++_loc7, _loc7 < _loc3.length)
                {
                    if (_loc3[_loc7].community == this.api.datacenter.Basics.communityId)
                    {
                        _loc5.push(_loc3[_loc7]);
                    } // end if
                } // end while
                _loc3 = _loc5;
                if (_loc3.length <= 0)
                {
                    if (this._nRemainingTime <= 0)
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("COMMUNITY_IS_FULL_NOT_FULL_MEMBER"), "CAUTION_YESNO", {name: "automaticServer", listener: this});
                    }
                    else
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("COMMUNITY_IS_FULL_FULL_MEMBER"), "CAUTION_YESNO", {name: "automaticServer", listener: this});
                    } // end else if
                    break;
                } // end if
                this.selectServer(this.getLessPopulatedServer(_loc3));
                break;
            } 
            case "_mcManualSelect":
            {
                this.api.datacenter.Basics.forceManualServerSelection = true;
                this.api.network.Account.getServersList();
                break;
            } 
            case "_btnSearch":
            {
                this.findFriend();
                break;
            } 
        } // End of switch
    };
    _loc1.yes = function (oEvent)
    {
        var _loc3 = new ank.utils.ExtendedArray();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this._eaPreselectedServers.length)
        {
            if (this._eaPreselectedServers[_loc4].community == 2)
            {
                _loc3.push(this._eaPreselectedServers[_loc4]);
            } // end if
        } // end while
        if (_loc3.length > 0)
        {
            this.selectServer(this.getLessPopulatedServer(_loc3));
        }
        else
        {
            this.selectServer(this.getLessPopulatedServer(this._eaPreselectedServers));
        } // end else if
    };
    _loc1.serverSelected = function (oEvent)
    {
        this.gapi.unloadUIComponent("ServerInformations");
        var _loc3 = new dofus.datacenter.Server(oEvent.value, 1, 0);
        if (_loc3.isAllowed())
        {
            this.api.datacenter.Basics.aks_current_server = _loc3;
            this.api.datacenter.Basics.createCharacter = true;
            this.api.network.Account.setServer(oEvent.value);
        }
        else
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("SERVER_NOT_ALLOWED_IN_YOUR_LANGUAGE"), "ERROR_BOX");
        } // end else if
    };
    _loc1.canceled = function (oEvent)
    {
        this.gapi.unloadUIComponent("ServerInformations");
    };
    _loc1.addProperty("remainingTime", function ()
    {
    }, _loc1.__set__remainingTime);
    _loc1.addProperty("servers", function ()
    {
    }, _loc1.__set__servers);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.JoinFriend = function ()
    {
        super();
    }).CLASS_NAME = "JoinFriend";
    (_global.dofus.graphics.gapi.ui.JoinFriend = function ()
    {
        super();
    }).SEARCH_DELAY = 500;
} // end if
#endinitclip
