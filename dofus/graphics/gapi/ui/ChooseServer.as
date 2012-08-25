// Action script...

// [Initial MovieClip Action of sprite 20555]
#initclip 76
if (!dofus.graphics.gapi.ui.ChooseServer)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.ChooseServer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__servers = function (eaServers)
    {
        this._eaServers = eaServers;
        //return (this.servers());
    };
    _loc1.__set__serverID = function (nServerID)
    {
        this._nServerID = nServerID;
        //return (this.serverID());
    };
    _loc1.__set__remainingTime = function (nRemainingTime)
    {
        this._nRemainingTime = nRemainingTime;
        //return (this.remainingTime());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.ChooseServer.CLASS_NAME);
        if (this.api.datacenter.Basics.aks_is_free_community)
        {
            this._btnSubscribe._visible = false;
        } // end if
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.addListeners = function ()
    {
        this._btnSelect.addEventListener("click", this);
        this._btnCreate.addEventListener("click", this);
        this._btnSubscribe.addEventListener("click", this);
        this._btnAutomaticSelection.addEventListener("click", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblTitle.text = this.api.lang.getText("CHOOSE_SERVER");
        this._lblWhy.text = this.api.lang.getText("CHOOSE_SERVER_WHY");
        this._btnSelect.label = this.api.lang.getText("SELECT");
        this._btnCreate.label = this.api.lang.getText("CREATE_CHARACTER");
        this._btnSubscribe.label = this.api.lang.getText("SUBSCRIPTION");
        this._lblAccount.text = this.api.lang.getText("ACCOUNT_INFO");
        this._lblCopyright.text = this.api.lang.getText("COPYRIGHT");
        if (!this.api.config.isStreaming)
        {
            this._lblLogin.text = this.api.lang.getText("PSEUDO_DOFUS", [this.api.datacenter.Basics.dofusPseudo]);
        }
        else
        {
            this._lblLogin.text = this.api.lang.getText("POPUP_GAME_BEGINNING_TITLE");
        } // end else if
    };
    _loc1.initData = function ()
    {
        this.api.datacenter.Basics.createCharacter = false;
        this._nServerStartIndex = 0;
        this._lblRemainingTime.text = this.api.kernel.GameManager.getRemainingString(this._nRemainingTime);
        this._lblRemainingTime.styleName = this._nRemainingTime == 0 ? ("RedRightSmallBoldLabel") : ("WhiteRightSmallBoldLabel");
        this._btnSubscribe.enabled = this._nRemainingTime != -1;
        this._lblLogin.onRollOver = function ()
        {
            this._parent.gapi.showTooltip(this._parent.api.lang.getText("PSEUDO_DOFUS_INFOS"), this, 20, undefined);
        };
        this._lblLogin.onRollOut = function ()
        {
            this._parent.gapi.hideTooltip();
        };
        this._lblLogin.onRelease = function ()
        {
            var _loc2 = this._parent.api.lang.getText("PSEUDO_DOFUS_LINK");
            if (_loc2 != undefined && _loc2 != "")
            {
                this.getURL(_loc2, "_blank");
            } // end if
        };
        this._eaFavoriteServers = new ank.utils.ExtendedArray();
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < this._eaServers.length)
        {
            if (this._eaServers[_loc2].charactersCount > 0)
            {
                this._eaFavoriteServers.push(this._eaServers[_loc2]);
            } // end if
        } // end while
        this._eaFavoriteServers.bubbleSortOn("charactersCount", Array.DESCENDING);
        this._btnArrowLeft._visible = this._btnArrowRight._visible = this._eaFavoriteServers.length > 5;
        this._btnArrowLeft.onRelease = function ()
        {
            this._parent._btnArrowLeft.gotoAndStop("on");
            this._parent._btnArrowRight.gotoAndStop("on");
            --this._parent._nServerStartIndex;
            if (this._parent._nServerStartIndex <= 0)
            {
                this._parent._nServerStartIndex = 0;
                this.gotoAndStop("off");
            } // end if
            this._parent.updateServerList();
        };
        this._btnArrowRight.onRelease = function ()
        {
            this._parent._btnArrowLeft.gotoAndStop("on");
            this._parent._btnArrowRight.gotoAndStop("on");
            ++this._parent._nServerStartIndex;
            if (this._parent._nServerStartIndex >= this._parent._eaFavoriteServers.length - 5)
            {
                this._parent._nServerStartIndex = this._parent._eaFavoriteServers.length - 5;
                this.gotoAndStop("off");
            } // end if
            this._parent.updateServerList();
        };
        this._btnArrowLeft.onRelease();
        if (this.api.datacenter.Basics.first_connection_from_miniclip)
        {
            this.click({target: {_name: "_btnCreate"}});
        } // end if
    };
    _loc1.updateServerList = function ()
    {
        if (this._eaFavoriteServers.length > 0)
        {
            var _loc2 = 0;
            
            while (++_loc2, _loc2 < 5)
            {
                var _loc3 = this._eaFavoriteServers[_loc2 + this._nServerStartIndex];
                if (_loc3 != undefined)
                {
                    var _loc4 = this["_css" + _loc2];
                    _loc4._visible = true;
                    _loc4.index = _loc2;
                    _loc4.serverID = _loc3.id;
                    _loc4.addEventListener("select", this);
                    _loc4.addEventListener("unselect", this);
                    _loc4.addEventListener("remove", this);
                    this["_mcServerEmpty" + _loc2]._visible = false;
                    continue;
                } // end if
                this["_css" + _loc2]._visible = false;
                this["_mcServerEmpty" + _loc2]._visible = true;
            } // end while
            this._txtWhy._visible = false;
            this._btnAutomaticSelection._visible = false;
        }
        else
        {
            var _loc5 = 0;
            
            while (++_loc5, _loc5 < 5)
            {
                this["_mcServerEmpty" + _loc5]._visible = false;
                this["_css" + _loc5]._visible = false;
            } // end while
            this._btnAutomaticSelection.label = this.api.lang.getText("AUTOMATIC_SERVER_SELECTION");
            this._txtWhy.text = this.api.lang.getText("CHOOSE_SERVER_WHY_BLABLA");
        } // end else if
        if (this.api.datacenter.Basics.isCreatingNewCharacter)
        {
            this.api.datacenter.Basics.hasForcedManualSelection = true;
            this.click({target: this._btnCreate});
            this.api.datacenter.Basics.isCreatingNewCharacter = false;
            this.api.datacenter.Basics.hasForcedManualSelection = false;
        } // end if
    };
    _loc1.selectServer = function (nServerID)
    {
        if (_global.isNaN(nServerID))
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("CHOOSE_SERVER"), "ERROR_BOX");
        }
        else
        {
            var _loc3 = this.api.datacenter.Basics.aks_servers.findFirstItem("id", nServerID).item;
            if (_loc3.state == dofus.datacenter.Server.SERVER_ONLINE)
            {
                var _loc4 = new dofus.datacenter.Server(nServerID, 1, 0);
                if (_loc4.isAllowed())
                {
                    this.api.datacenter.Basics.aks_current_server = _loc4;
                    this.api.network.Account.setServer(nServerID);
                }
                else
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("SERVER_NOT_ALLOWED_IN_YOUR_LANGUAGE"), "ERROR_BOX");
                } // end else if
            }
            else
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_CHOOSE_CHARACTER_SERVER_DOWN"), "ERROR_BOX");
            } // end else if
        } // end else if
    };
    _loc1.select = function (oEvent)
    {
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < 5)
        {
            this["_css" + _loc3].selected = false;
        } // end while
        oEvent.target.selected = true;
        var _loc4 = oEvent.target.serverID;
        var _loc5 = this._nServerID;
        this._nServerID = _loc4;
        if (_loc5 == _loc4)
        {
            this.click({target: this._btnSelect});
        } // end if
    };
    _loc1.unselect = function (oEvent)
    {
        var _loc3 = oEvent.target.serverID;
        if (this._nServerID == _loc3)
        {
            delete this._nServerID;
        } // end if
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnSelect":
            {
                var _loc3 = this.gapi.getUIComponent("ServerList");
                if (_loc3 != undefined)
                {
                    this._nServerID = _loc3.selectedServerID;
                    _loc3.onServerSelected();
                }
                else
                {
                    this.api.datacenter.Basics.createCharacter = false;
                    this.selectServer(this._nServerID);
                } // end else if
                break;
            } 
            case "_btnCreate":
            {
                if (this.api.datacenter.Basics.hasForcedManualSelection || this.api.datacenter.Basics.first_connection_from_miniclip)
                {
                    this.gapi.loadUIComponent("ServerList", "ServerList", {servers: this.api.datacenter.Basics.aks_servers});
                    this.gapi.getUIComponent("ServerList").addEventListener("serverSelected", this);
                    this.api.datacenter.Basics.hasForcedManualSelection = false;
                    break;
                } // end if
            } 
            case "_btnAutomaticSelection":
            {
                this.api.datacenter.Basics.forceAutomaticServerSelection = true;
                this.api.network.Account.getServersList();
                this.api.datacenter.Basics.isCreatingNewCharacter = true;
                break;
            } 
            case "_btnSubscribe":
            {
                _root.getURL(this.api.lang.getConfigText("PAY_LINK"), "_blank");
                break;
            } 
        } // End of switch
    };
    _loc1.serverSelected = function (oEvent)
    {
        this.api.datacenter.Basics.createCharacter = true;
        this.gapi.unloadUIComponent("ServerList");
        this.selectServer(oEvent.serverID);
    };
    _loc1.addProperty("servers", function ()
    {
    }, _loc1.__set__servers);
    _loc1.addProperty("remainingTime", function ()
    {
    }, _loc1.__set__remainingTime);
    _loc1.addProperty("serverID", function ()
    {
    }, _loc1.__set__serverID);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.ChooseServer = function ()
    {
        super();
    }).CLASS_NAME = "ChooseServer";
} // end if
#endinitclip
