// Action script...

// [Initial MovieClip Action of sprite 20569]
#initclip 90
if (!dofus.graphics.gapi.controls.ConquestJoinViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.ConquestJoinViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__error = function (value)
    {
        if (value != 0 && this._lblJoinFightDetails.text == undefined)
        {
            return;
        } // end if
        switch (Number(value))
        {
            case 0:
            {
                this._mcErrorBackground._visible = this._lblJoinFight._visible = this._lblJoinFightDetails._visible = false;
                break;
            } 
            case -1:
            {
                this._lblJoinFightDetails.text = this.api.lang.getText("CONQUEST_JOIN_FIGHT_NOFIGHT");
                this._mcErrorBackground._visible = this._lblJoinFight._visible = this._lblJoinFightDetails._visible = true;
                this._bNoUnsubscribe = true;
                break;
            } 
            case -2:
            {
                this._lblJoinFightDetails.text = this.api.lang.getText("CONQUEST_JOIN_FIGHT_INFIGHT");
                this._mcErrorBackground._visible = this._lblJoinFight._visible = this._lblJoinFightDetails._visible = true;
                this._bNoUnsubscribe = true;
                break;
            } 
            case -3:
            {
                this._lblJoinFightDetails.text = this.api.lang.getText("CONQUEST_JOIN_FIGHT_NONE");
                this._mcErrorBackground._visible = this._lblJoinFight._visible = this._lblJoinFightDetails._visible = true;
                this._bNoUnsubscribe = true;
                break;
            } 
        } // End of switch
        //return (this.error());
    };
    _loc1.__set__timer = function (value)
    {
        this._nTimer = value;
        this.updateTimer();
        //return (this.timer());
    };
    _loc1.__set__maxTimer = function (value)
    {
        this._nMaxTimer = value;
        this.updateTimer();
        //return (this.maxTimer());
    };
    _loc1.__set__timerReference = function (value)
    {
        this._nTimerReference = value;
        this.updateTimer();
        //return (this.timerReference());
    };
    _loc1.__set__maxTeamPositions = function (value)
    {
        this._nMaxPlayerCount = value;
        this.showButtonsJoin(value);
        //return (this.maxTeamPositions());
    };
    _loc1.__set__noUnsubscribe = function (value)
    {
        this._bNoUnsubscribe = value;
        //return (this.noUnsubscribe());
    };
    _loc1.__get__noUnsubscribe = function ()
    {
        return (this._bNoUnsubscribe);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.ConquestJoinViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < dofus.graphics.gapi.controls.ConquestJoinViewer.TEAM_COUNT)
        {
            this._btnPlayer._visible = false;
        } // end while
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < dofus.graphics.gapi.controls.ConquestJoinViewer.RESERVIST_COUNT)
        {
            this._btnReservist._visible = false;
        } // end while
    };
    _loc1.addListeners = function ()
    {
        this.api.datacenter.Conquest.players.removeEventListener("modelChanged", this);
        this.api.datacenter.Conquest.attackers.removeEventListener("modelChanged", this);
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < dofus.graphics.gapi.controls.ConquestJoinViewer.TEAM_COUNT)
        {
            var _loc3 = (ank.gapi.controls.Button)(this["_btnPlayer" + _loc2]);
            _loc3.addEventListener("click", this);
            _loc3.addEventListener("over", this);
            _loc3.addEventListener("out", this);
        } // end while
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < dofus.graphics.gapi.controls.ConquestJoinViewer.RESERVIST_COUNT)
        {
            var _loc5 = (ank.gapi.controls.Button)(this["_btnReservist" + _loc4]);
            _loc5.addEventListener("click", this);
            _loc5.addEventListener("over", this);
            _loc5.addEventListener("out", this);
        } // end while
        this._btnAttackers.addEventListener("over", this);
        this._btnAttackers.addEventListener("out", this);
        this.api.datacenter.Conquest.players.addEventListener("modelChanged", this);
        this.api.datacenter.Conquest.attackers.addEventListener("modelChanged", this);
        this._vcTimer.addEventListener("endTimer", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblTeam.text = this.api.lang.getText("CONQUEST_JOIN_FIGHTERS");
        this._lblReservists.text = this.api.lang.getText("CONQUEST_JOIN_RESERVISTS");
        this._lblJoinFight.text = this.api.lang.getText("CONQUEST_JOIN_FIGHT");
        this._lblJoinFightDetails.text = this.api.lang.getText("LOADING");
    };
    _loc1.updatePlayers = function ()
    {
        var _loc2 = this.api.datacenter.Conquest.players;
        var _loc3 = 0;
        var _loc4 = 0;
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc2.length)
        {
            var _loc6 = _loc2[_loc5];
            var _loc7 = null;
            if (_loc6.reservist)
            {
                _loc7 = this["_btnReservist" + _loc4++];
            }
            else
            {
                _loc7 = this["_btnPlayer" + _loc3++];
            } // end else if
            _loc7.iconClip.data = _loc6;
            _loc7.params = {player: _loc6};
        } // end while
        var _loc8 = _loc3;
        
        while (++_loc8, _loc8 < dofus.graphics.gapi.controls.ConquestJoinViewer.TEAM_COUNT)
        {
            var _loc9 = this["_btnPlayer" + _loc8];
            _loc9.iconClip.data = null;
            _loc9.params = new Object();
        } // end while
        var _loc10 = _loc4;
        
        while (++_loc10, _loc10 < dofus.graphics.gapi.controls.ConquestJoinViewer.RESERVIST_COUNT)
        {
            var _loc11 = this["_btnReservist" + _loc10];
            _loc11.iconClip.data = null;
            _loc11.params = new Object();
        } // end while
    };
    _loc1.updateAttackers = function ()
    {
        this._lblAttackersCount._visible = true;
        this._lblAttackersTitle._visible = true;
        this._lblAttackersTitle.text = this.api.lang.getText("ATTACKERS");
        var _loc2 = this.api.datacenter.Conquest.attackers.length;
        this._lblAttackersCount.text = String(_loc2);
        this._btnAttackers._visible = _loc2 > 0;
    };
    _loc1.updateTimer = function ()
    {
        if (!_global.isNaN(this._nTimer) && (this._nTimer > 0 && (!_global.isNaN(this._nMaxTimer) && (this._nMaxTimer > 0 && (!_global.isNaN(this._nTimerReference) && this._nTimerReference > 0)))))
        {
            var _loc2 = this._nTimer - (getTimer() - this._nTimerReference);
            var _loc3 = this._nMaxTimer / 1000;
            if (_loc2 > 0)
            {
                this._vcTimer.startTimer(_loc2 / 1000, _loc3);
                this.showButtonsJoin(_global.isNaN(this._nMaxPlayerCount) ? (0) : (this._nMaxPlayerCount));
            }
            else
            {
                this._vcTimer.stopTimer();
                this.showButtonsJoin(0);
            } // end else if
        }
        else
        {
            this._vcTimer.stopTimer();
            this.showButtonsJoin(0);
        } // end else if
    };
    _loc1.showButtonsJoin = function (nPlayerCount)
    {
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < nPlayerCount)
        {
            this["_btnPlayer" + _loc3]._visible = true;
        } // end while
        var _loc4 = _loc3;
        
        while (++_loc4, _loc4 < 7)
        {
            this["_btnPlayer" + _loc4]._visible = false;
        } // end while
    };
    _loc1.click = function (oEvent)
    {
        if (this.api.datacenter.Player.cantInteractWithPrism)
        {
            return;
        } // end if
        var _loc3 = oEvent.target.params.player;
        if (_loc3 != undefined)
        {
            if (_loc3.id == this.api.datacenter.Player.ID)
            {
                this.api.network.Conquest.prismFightLeave();
            }
            else
            {
                var _loc4 = this.api.datacenter.Conquest.players.findFirstItem("id", this.api.datacenter.Player.ID);
                if (_loc4.index == -1)
                {
                    return;
                } // end if
                if (_loc3.reservist)
                {
                    if (_loc4.item.reservist)
                    {
                        return;
                    }
                    else
                    {
                        var _loc5 = this.api.ui.createPopupMenu();
                        _loc5.addStaticItem(_loc3.name);
                        _loc5.addItem(this.api.lang.getText("CONQUEST_SWITCH_AS_RESERVIST"), this.api.network.Conquest, this.api.network.Conquest.switchPlaces, [_loc3.id]);
                        _loc5.show(_root._xmouse, _root._ymouse);
                    } // end else if
                }
                else if (_loc4.item.reservist)
                {
                    var _loc6 = this.api.ui.createPopupMenu();
                    _loc6.addStaticItem(_loc3.name);
                    _loc6.addItem(this.api.lang.getText("CONQUEST_SWITCH_AS_PLAYER"), this.api.network.Conquest, this.api.network.Conquest.switchPlaces, [_loc3.id]);
                    _loc6.show(_root._xmouse, _root._ymouse);
                }
                else
                {
                    return;
                } // end else if
            } // end else if
        }
        else
        {
            this.api.network.Conquest.prismFightJoin();
        } // end else if
    };
    _loc1.modelChanged = function (event)
    {
        this.api.ui.hideTooltip();
        this.updateAttackers();
        this.updatePlayers();
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnAttackers:
            {
                if (!this._lblAttackersCount._visible)
                {
                    return;
                } // end if
                var _loc3 = this.api.datacenter.Conquest.attackers.length;
                if (_loc3 == 0)
                {
                    return;
                } // end if
                var _loc4 = new String();
                var _loc5 = 0;
                
                while (++_loc5, _loc5 < _loc3)
                {
                    var _loc6 = this.api.datacenter.Conquest.attackers[_loc5];
                    _loc4 = _loc4 + ("\n" + _loc6.name + " (" + _loc6.level + ")");
                } // end while
                this.api.ui.showTooltip(this.api.lang.getText("ATTACKERS") + " : " + _loc4, oEvent.target, 40);
                break;
            } 
            default:
            {
                var _loc7 = oEvent.target.params.player;
                if (_loc7 != undefined)
                {
                    this.api.ui.showTooltip(_loc7.name + " (" + _loc7.level + ")", oEvent.target, -20);
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.api.ui.hideTooltip();
    };
    _loc1.endTimer = function (oEvent)
    {
        this._vcTimer.stopTimer();
        this.showButtonsJoin(0);
        this.updateAttackers();
    };
    _loc1.addProperty("maxTimer", function ()
    {
    }, _loc1.__set__maxTimer);
    _loc1.addProperty("noUnsubscribe", _loc1.__get__noUnsubscribe, _loc1.__set__noUnsubscribe);
    _loc1.addProperty("timerReference", function ()
    {
    }, _loc1.__set__timerReference);
    _loc1.addProperty("error", function ()
    {
    }, _loc1.__set__error);
    _loc1.addProperty("timer", function ()
    {
    }, _loc1.__set__timer);
    _loc1.addProperty("maxTeamPositions", function ()
    {
    }, _loc1.__set__maxTeamPositions);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.ConquestJoinViewer = function ()
    {
        super();
    }).CLASS_NAME = "ConquestJoinViewer";
    (_global.dofus.graphics.gapi.controls.ConquestJoinViewer = function ()
    {
        super();
    }).TEAM_COUNT = 7;
    (_global.dofus.graphics.gapi.controls.ConquestJoinViewer = function ()
    {
        super();
    }).RESERVIST_COUNT = 35;
    _loc1._nTimer = -1;
    _loc1._nMaxTimer = -1;
    _loc1._nTimerReference = -1;
} // end if
#endinitclip
