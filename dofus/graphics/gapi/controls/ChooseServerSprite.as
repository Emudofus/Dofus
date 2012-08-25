// Action script...

// [Initial MovieClip Action of sprite 20600]
#initclip 121
if (!dofus.graphics.gapi.controls.ChooseServerSprite)
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
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.ChooseServerSprite = function ()
    {
        super();
        this._lblNumChar._visible = false;
        this._mcNumChar._visible = false;
    }).prototype;
    _loc1.__set__serverID = function (nServerID)
    {
        this._nServerID = nServerID;
        if (this.initialized)
        {
            this.updateData();
        } // end if
        //return (this.serverID());
    };
    _loc1.__get__serverID = function ()
    {
        return (this._nServerID);
    };
    _loc1.__get__server = function ()
    {
        var _loc2 = this.api.datacenter.Basics.aks_servers;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < _loc2.length)
        {
            if (_loc2[_loc3].id == this._nServerID)
            {
                return (_loc2[_loc3]);
            } // end if
        } // end while
        return;
    };
    _loc1.__set__selected = function (bSelected)
    {
        this._bSelected = bSelected;
        this.updateSelected(bSelected ? (this.getStyle().selectedcolor) : (this.getStyle().overcolor));
        //return (this.selected());
    };
    _loc1.__get__selected = function ()
    {
        return (this._bSelected);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.ChooseServerSprite.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.updateData});
    };
    _loc1.addListeners = function ()
    {
        this._ldrSprite.addEventListener("initialization", this);
        this._ldrSprite.addEventListener("error", this);
        this._ctrServerState.addEventListener("over", this);
        this._ctrServerState.addEventListener("out", this);
        this._lblState.onRelease = function ()
        {
            getURL(this._parent.api.lang.getConfigText("FORUM_SERVERS_STATE_LAST_POST"), "_blank");
        };
        this._ctrServerState.onRelease = function ()
        {
            getURL(this._parent.api.lang.getConfigText("FORUM_SERVERS_STATE_LAST_POST"), "_blank");
        };
        this.api.datacenter.Basics.aks_servers.addEventListener("modelChanged", this);
    };
    _loc1.setEnabled = function ()
    {
        if (this._bEnabled)
        {
            this._mcInteraction.onRelease = function ()
            {
                this._parent.innerRelease();
            };
            this._mcInteraction.onRollOver = function ()
            {
                this._parent.innerOver();
            };
            this._mcInteraction.onRollOut = this._mcInteraction.onReleaseOutside = function ()
            {
                this._parent.innerOut();
            };
            this.setMovieClipTransform(this, {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0});
        }
        else
        {
            delete this._mcInteraction.onRelease;
            delete this._mcInteraction.onRollOver;
            delete this._mcInteraction.onRollOut;
            delete this._mcInteraction.onReleaseOutside;
            this.setMovieClipTransform(this, this.getStyle().desabledtransform);
            this.selected = false;
        } // end else if
    };
    _loc1.updateData = function ()
    {
        var _loc2 = this.server;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < dofus.graphics.gapi.controls.ChooseServerSprite.MAX_CHARS_DISPLAYED + 1)
        {
            this["Bonhomme" + _loc3].removeMovieClip();
        } // end while
        this._lblNumChar._visible = false;
        this._mcNumChar._visible = false;
        if (_loc2 != undefined)
        {
            this._lblName.text = _loc2.label;
            var _loc4 = _loc2.charactersCount;
            if (_loc4 <= dofus.graphics.gapi.controls.ChooseServerSprite.MAX_CHARS_DISPLAYED)
            {
                var _loc5 = 3;
                var _loc6 = (112 - _loc4 * (1.450000E+001 + _loc5)) / 2;
                var _loc7 = _loc6;
                var _loc8 = 165;
                var _loc9 = 0;
                
                while (++_loc9, _loc9 < _loc4)
                {
                    var _loc10 = this.attachMovie("Bonhomme", "Bonhomme" + _loc9, _loc9, {_x: _loc7, _y: _loc8});
                    _loc7 = _loc7 + (_loc5 + 1.450000E+001);
                } // end while
            }
            else
            {
                this._lblNumChar._visible = true;
                this._mcNumChar._visible = true;
                this._lblNumChar.text = "x" + _loc4;
            } // end else if
            this._lblState.text = _loc2.stateStrShort;
            this._ldrSprite.forceReload = true;
            this._ldrSprite.contentPath = dofus.Constants.SERVER_SYMBOL_PATH + _loc2.id + ".swf";
            this.enabled = _loc2.state == dofus.datacenter.Server.SERVER_ONLINE;
            this._ctrServerState.contentPath = _loc2.state == dofus.datacenter.Server.SERVER_ONLINE ? ("NewValid") : ("NewCross");
        }
        else if (this._lblName.text != undefined)
        {
            this._lblName.text = "";
            this._lblState.text = "";
            this._ldrSprite.contentPath = "";
            this._ctrServerState.contentPath = "";
            this.enabled = false;
        } // end else if
    };
    _loc1.updateSelected = function (nColor)
    {
        if (this._bSelected || this._bOver && this._bEnabled)
        {
            this._mcSelect.gotoAndPlay(1);
            this._mcSelect._visible = true;
        }
        else
        {
            this._mcSelect.stop();
            this._mcSelect._visible = false;
        } // end else if
    };
    _loc1.initialization = function (oEvent)
    {
        var _loc3 = oEvent.clip;
    };
    _loc1.error = function (oEvent)
    {
        this._ldrSprite.forceReload = true;
        this._ldrSprite.contentPath = dofus.Constants.SERVER_SYMBOL_PATH + "0.swf";
    };
    _loc1.innerRelease = function ()
    {
        this.selected = true;
        this.dispatchEvent({type: "select", serverID: this._nServerID});
    };
    _loc1.innerOver = function ()
    {
        this._bOver = true;
        this.updateSelected(this._bSelected ? (this.getStyle().selectedcolor) : (this.getStyle().overcolor));
    };
    _loc1.innerOut = function ()
    {
        this._bOver = false;
        this.updateSelected(this.getStyle().selectedcolor);
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._ctrServerState:
            {
                this.gapi.showTooltip(this.server.stateStr, _root._xmouse, _root._ymouse - 20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.modelChanged = function (oEvent)
    {
        this.updateData();
        this.dispatchEvent({type: "unselect"});
    };
    _loc1.addProperty("selected", _loc1.__get__selected, _loc1.__set__selected);
    _loc1.addProperty("server", _loc1.__get__server, function ()
    {
    });
    _loc1.addProperty("serverID", _loc1.__get__serverID, _loc1.__set__serverID);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.ChooseServerSprite = function ()
    {
        super();
        this._lblNumChar._visible = false;
        this._mcNumChar._visible = false;
    }).CLASS_NAME = "ChooseServerSprite";
    (_global.dofus.graphics.gapi.controls.ChooseServerSprite = function ()
    {
        super();
        this._lblNumChar._visible = false;
        this._mcNumChar._visible = false;
    }).MAX_CHARS_DISPLAYED = 5;
    _loc1._bSelected = false;
    _loc1._bOver = false;
} // end if
#endinitclip
