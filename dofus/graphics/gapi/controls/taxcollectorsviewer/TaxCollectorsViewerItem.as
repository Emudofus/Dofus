// Action script...

// [Initial MovieClip Action of sprite 20878]
#initclip 143
if (!dofus.graphics.gapi.controls.taxcollectorsviewer.TaxCollectorsViewerItem)
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
    if (!dofus.graphics.gapi.controls.taxcollectorsviewer)
    {
        _global.dofus.graphics.gapi.controls.taxcollectorsviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.taxcollectorsviewer.TaxCollectorsViewerItem = function ()
    {
        super();
    }).prototype;
    _loc1.__set__list = function (mcList)
    {
        this._mcList = mcList;
        //return (this.list());
    };
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        this._oItem.players.removeEventListener("modelChanged", this);
        this._oItem.attackers.removeEventListener("modelChanged", this);
        this._oItem = oItem;
        if (bUsed)
        {
            this._lblName.text = oItem.name;
            this._lblPosition.text = oItem.position;
            this.showStateIcon();
            if (!_global.isNaN(oItem.timer))
            {
                var _loc5 = oItem.timer - (getTimer() - oItem.timerReference);
                var _loc6 = oItem.maxTimer / 1000;
                if (_loc5 > 0)
                {
                    this._vcTimer.startTimer(_loc5 / 1000, _loc6);
                    this.showButtonsJoin(_global.isNaN(oItem.maxPlayerCount) ? (0) : (oItem.maxPlayerCount));
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
            oItem.players.addEventListener("modelChanged", this);
            oItem.attackers.addEventListener("modelChanged", this);
            this._btnAttackers.enabled = true;
            this.updateAttackers();
            this.updatePlayers();
        }
        else if (this._lblName.text != undefined)
        {
            this._lblName.text = "";
            this._lblPosition.text = "";
            this._mcFight._visible = false;
            this._mcEnterFight._visible = false;
            this._mcCollect._visible = false;
            this._btnState._visible = false;
            this.hideButtonsJoin();
            this._vcTimer.stopTimer();
            this._btnAttackers.enabled = false;
            this._lblAttackersCount._visible = false;
        }
        else
        {
            this.hideButtonsJoin();
            this._vcTimer.stopTimer();
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._mcFight._visible = false;
        this._mcEnterFight._visible = false;
        this._mcCollect._visible = false;
        this._btnState._visible = false;
        this._btnAttackers.enabled = false;
        this._lblAttackersCount._visible = false;
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this._btnPlayer0._visible = this._btnPlayer1._visible = this._btnPlayer2._visible = this._btnPlayer3._visible = this._btnPlayer4._visible = this._btnPlayer5._visible = this._btnPlayer6._visible = false;
    };
    _loc1.addListeners = function ()
    {
        this._btnPlayer0.addEventListener("click", this);
        this._btnPlayer1.addEventListener("click", this);
        this._btnPlayer2.addEventListener("click", this);
        this._btnPlayer3.addEventListener("click", this);
        this._btnPlayer4.addEventListener("click", this);
        this._btnPlayer5.addEventListener("click", this);
        this._btnPlayer6.addEventListener("click", this);
        this._btnPlayer0.addEventListener("over", this);
        this._btnPlayer1.addEventListener("over", this);
        this._btnPlayer2.addEventListener("over", this);
        this._btnPlayer3.addEventListener("over", this);
        this._btnPlayer4.addEventListener("over", this);
        this._btnPlayer5.addEventListener("over", this);
        this._btnPlayer6.addEventListener("over", this);
        this._btnAttackers.addEventListener("over", this);
        this._btnState.addEventListener("over", this);
        this._btnPlayer0.addEventListener("out", this);
        this._btnPlayer1.addEventListener("out", this);
        this._btnPlayer2.addEventListener("out", this);
        this._btnPlayer3.addEventListener("out", this);
        this._btnPlayer4.addEventListener("out", this);
        this._btnPlayer5.addEventListener("out", this);
        this._btnPlayer6.addEventListener("out", this);
        this._btnAttackers.addEventListener("out", this);
        this._btnState.addEventListener("out", this);
        this._vcTimer.addEventListener("endTimer", this);
    };
    _loc1.showButtonsJoin = function (nPlayerCount)
    {
        this._mcBackButtons._visible = true;
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
    _loc1.hideButtonsJoin = function ()
    {
        this._mcBackButtons._visible = false;
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < 7)
        {
            this["_btnPlayer" + _loc2]._visible = false;
        } // end while
    };
    _loc1.updatePlayers = function ()
    {
        var _loc2 = this._oItem.players;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < _loc2.length)
        {
            var _loc4 = this["_btnPlayer" + _loc3];
            var _loc5 = _loc2[_loc3];
            _loc4.iconClip.data = _loc5;
            _loc4.params = {player: _loc5};
        } // end while
        var _loc6 = _loc3;
        
        while (++_loc6, _loc6 < 7)
        {
            var _loc7 = this["_btnPlayer" + _loc6];
            _loc7.iconClip.data = null;
            _loc7.params = new Object();
        } // end while
    };
    _loc1.updateAttackers = function ()
    {
        this._lblAttackersCount._visible = true;
        if (this._oItem.state == 1)
        {
            var _loc2 = this._oItem.attackers.length;
            this._lblAttackersCount.text = String(_loc2);
            this._btnAttackers._visible = _loc2 > 0;
        }
        else
        {
            this._lblAttackersCount.text = "-";
        } // end else if
    };
    _loc1.showStateIcon = function ()
    {
        this._btnState._visible = true;
        this._mcFight._visible = this._oItem.state == 2;
        this._mcEnterFight._visible = this._oItem.state == 1;
        this._mcCollect._visible = this._oItem.state == 0;
    };
    _loc1.click = function (oEvent)
    {
        var _loc3 = this._mcList.gapi.api;
        if (_loc3.datacenter.Player.cantInteractWithTaxCollector)
        {
            return;
        } // end if
        var _loc4 = oEvent.target.params.player;
        if (_loc4 != undefined)
        {
            if (_loc4.id == _loc3.datacenter.Player.ID)
            {
                _loc3.network.Guild.leaveTaxCollector(this._oItem.id);
            } // end if
        }
        else
        {
            var _loc5 = _loc3.datacenter.Player.guildInfos;
            if (_loc5.isLocalPlayerDefender)
            {
                if (_loc5.defendedTaxCollectorID != this._oItem.id)
                {
                    _loc3.network.Guild.leaveTaxCollector(_loc5.defendedTaxCollectorID);
                    _loc3.network.Guild.joinTaxCollector(this._oItem.id);
                } // end if
            }
            else
            {
                _loc3.network.Guild.joinTaxCollector(this._oItem.id);
            } // end else if
        } // end else if
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnAttackers":
            {
                if (!this._lblAttackersCount._visible)
                {
                    return;
                } // end if
                var _loc3 = this._oItem.attackers.length;
                if (_loc3 == 0)
                {
                    return;
                } // end if
                var _loc4 = new String();
                var _loc5 = 0;
                
                while (++_loc5, _loc5 < _loc3)
                {
                    var _loc6 = this._oItem.attackers[_loc5];
                    _loc4 = _loc4 + ("\n" + _loc6.name + " (" + _loc6.level + ")");
                } // end while
                this._mcList.gapi.showTooltip(this._mcList.gapi.api.lang.getText("ATTACKERS") + " : " + _loc4, oEvent.target, 40);
                break;
            } 
            case "_btnState":
            {
                var _loc7 = new String();
                switch (this._oItem.state)
                {
                    case 0:
                    {
                        _loc7 = this._mcList.gapi.api.lang.getText("TAX_IN_COLLECT");
                        break;
                    } 
                    case 1:
                    {
                        _loc7 = this._mcList.gapi.api.lang.getText("TAX_IN_ENTERFIGHT");
                        break;
                    } 
                    case 2:
                    {
                        _loc7 = this._mcList.gapi.api.lang.getText("TAX_IN_FIGHT");
                        break;
                    } 
                } // End of switch
                if (this._oItem.showMoreInfo)
                {
                    if (this._oItem.callerName != "?")
                    {
                        _loc7 = _loc7 + ("\n" + this._mcList.gapi.api.lang.getText("OWNER_WORD") + " : " + this._oItem.callerName);
                    } // end if
                    var _loc8 = new Date(this._oItem.startDate);
                    if (_loc8.getFullYear() != 1970)
                    {
                        _loc7 = _loc7 + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_START_DATE", [_loc8.getDay(), _loc8.getMonth() + 1, _loc8.getFullYear() + this._mcList.gapi.api.lang.getTimeZoneText().z, _loc8.getHours(), _loc8.getMinutes()]));
                    } // end if
                    if (this._oItem.lastHarvesterName != "?")
                    {
                        _loc7 = _loc7 + ("\n" + this._mcList.gapi.api.lang.getText("LAST_HARVESTER_NAME") + " : " + this._oItem.lastHarvesterName);
                    } // end if
                    _loc8 = new Date(this._oItem.lastHarvestDate);
                    if (_loc8.getFullYear() != 1970)
                    {
                        _loc7 = _loc7 + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_LAST_DATE", [_loc8.getDay(), _loc8.getMonth() + 1, _loc8.getFullYear() + this._mcList.gapi.api.lang.getTimeZoneText().z, _loc8.getHours(), _loc8.getMinutes()]));
                    } // end if
                    var _loc9 = new Date();
                    var _loc10 = this._oItem.nextHarvestDate - _loc9.valueOf();
                    if (_loc10 <= 0)
                    {
                        _loc7 = _loc7 + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_CAN_BE_HARVEST"));
                    }
                    else
                    {
                        var _loc11 = Math.floor(_loc10 / 1000 / 60 / 60);
                        var _loc12 = Math.floor(_loc10 / 1000 / 60 - _loc11 * 60);
                        var _loc13 = _loc11 + " " + ank.utils.PatternDecoder.combine(this._mcList.gapi.api.lang.getText("HOURS"), "m", _loc11 == 1);
                        if (_loc12 == 0)
                        {
                            _loc7 = _loc7 + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_CAN_BE_HARVEST_IN", [_loc13, ""]));
                        }
                        else
                        {
                            var _loc14 = this._mcList.gapi.api.lang.getText("AND") + " ";
                            var _loc15 = _loc12 + " " + ank.utils.PatternDecoder.combine(this._mcList.gapi.api.lang.getText("MINUTES"), "m", _loc12 == 1);
                            _loc7 = _loc7 + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_CAN_BE_HARVEST_IN", [_loc13, _loc14 + _loc15]));
                        } // end if
                    } // end else if
                } // end else if
                this._mcList.gapi.showTooltip(_loc7, oEvent.target, 40);
                break;
            } 
            default:
            {
                var _loc16 = oEvent.target.params.player;
                if (_loc16 != undefined)
                {
                    this._mcList.gapi.showTooltip(_loc16.name + " (" + _loc16.level + ")", oEvent.target, -20);
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this._mcList.gapi.hideTooltip();
    };
    _loc1.endTimer = function (oEvent)
    {
        this._vcTimer.stopTimer();
        this.showButtonsJoin(0);
        this._oItem.state = 2;
        this.showStateIcon();
        this.updateAttackers();
        this._mcList.gapi.api.datacenter.Player.guildInfos.defendedTaxCollectorID = undefined;
    };
    _loc1.modelChanged = function (oEvent)
    {
        this._mcList.gapi.hideTooltip();
        this.updateAttackers();
        this.updatePlayers();
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
