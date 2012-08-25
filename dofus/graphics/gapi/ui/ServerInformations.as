// Action script...

// [Initial MovieClip Action of sprite 20717]
#initclip 238
if (!dofus.graphics.gapi.ui.ServerInformations)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.ServerInformations = function ()
    {
        super();
    }).prototype;
    _loc1.__set__server = function (nServerID)
    {
        this._nServerID = nServerID;
        this._sServer = _global.API.datacenter.Basics.aks_servers.findFirstItem("id", nServerID).item;
        //return (this.server());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.ServerInformations.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initText});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.addListeners = function ()
    {
        this._mcOk.onRelease = function ()
        {
            this._parent.click({target: this});
        };
        this._mcBack.onRelease = function ()
        {
            this._parent.click({target: this});
        };
        this._btnMoreInfo.onRelease = function ()
        {
            this._parent.click({target: this});
        };
        this._ldrSprite.addEventListener("error", this);
        this._ldrSprite.addEventListener("initialization", this);
    };
    _loc1.initText = function ()
    {
        this._lblSelectedServer.text = this.api.lang.getText("CHOOSEN_SERVER") + " :";
        this._lblStatus.text = this.api.lang.getText("SERVER_STATUS");
        this._lblPopulation.text = this.api.lang.getText("POPULATION");
        this._lblCommunity.text = this.api.lang.getText("COMMUNITY");
        this._lblHowOld.text = this.api.lang.getText("OPENING_DATE");
        this._lblServerType.text = this.api.lang.getText("SERVER_GAME_TYPE", [this.api.lang.getText("SERVER_GAME_TYPE_" + this._sServer.typeNum)]);
        if (this._sServer.isHardcore())
        {
            this._taDescription.text = this.api.lang.getText("SERVER_RULES_" + this._sServer.typeNum);
            this._lblMoreInfo.text = this.api.lang.getText("SHORTCUTS_DESCRIPTION");
            this._bShowDescription = false;
        }
        else
        {
            this._taDescription.text = this._sServer.description;
            this._lblMoreInfo.text = this.api.lang.getText("RULES_SHORTCUT");
            this._bShowDescription = true;
        } // end else if
        this._lblOk.text = this.api.lang.getText("OK");
        this._lblBack.text = this.api.lang.getText("BACK");
        this._ldrSprite.contentPath = dofus.Constants.SERVER_SYMBOL_PATH + this._sServer.id + ".swf";
    };
    _loc1.initData = function ()
    {
        this._lblSelectedServerName.text = this._sServer.label;
        this._lblStatusValue.text = this._sServer.stateStr;
        this._lblPopulationValue.text = this._sServer.populationStr;
        this._lblCommunityValue.text = this._sServer.communityStr;
        this._lblHowOldValue.text = this._sServer.dateStr;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_mcOk":
            {
                this.dispatchEvent({type: "serverSelected", value: this._nServerID});
                break;
            } 
            case "_mcBack":
            {
                this.dispatchEvent({type: "canceled"});
                break;
            } 
            case "_btnMoreInfo":
            {
                this._bShowDescription = !this._bShowDescription;
                if (this._bShowDescription)
                {
                    this._taDescription.text = this._sServer.description;
                    this._lblMoreInfo.text = this.api.lang.getText("RULES_SHORTCUT");
                }
                else
                {
                    this._taDescription.text = this.api.lang.getText("SERVER_RULES_" + this._sServer.typeNum);
                    this._lblMoreInfo.text = this.api.lang.getText("SHORTCUTS_DESCRIPTION");
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.initialization = function (oEvent)
    {
        var _loc3 = oEvent.clip;
        _loc3._xscale = _loc3._yscale = 136;
    };
    _loc1.error = function (oEvent)
    {
        this._ldrSprite.contentPath = dofus.Constants.SERVER_SYMBOL_PATH + "0.swf";
    };
    _loc1.addProperty("server", function ()
    {
    }, _loc1.__set__server);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.ServerInformations = function ()
    {
        super();
    }).CLASS_NAME = "ServerInformations";
    _loc1._bShowDescription = false;
} // end if
#endinitclip
