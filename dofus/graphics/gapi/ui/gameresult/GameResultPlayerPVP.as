// Action script...

// [Initial MovieClip Action of sprite 20872]
#initclip 137
if (!dofus.graphics.gapi.ui.gameresult.GameResultPlayerPVP)
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
    if (!dofus.graphics.gapi.ui.gameresult)
    {
        _global.dofus.graphics.gapi.ui.gameresult = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.gameresult.GameResultPlayerPVP = function ()
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
        oItem.items.sortOn("_itemLevel", Array.DESCENDING | Array.NUMERIC);
        this._oItems = oItem;
        var _loc5 = this._mcList._parent.api;
        if (bUsed)
        {
            switch (oItem.type)
            {
                case "monster":
                case "taxcollector":
                case "player":
                {
                    this._lblName.text = oItem.name;
                    if (oItem.rank == 0 && !_loc5.datacenter.Basics.aks_current_server.isHardcore())
                    {
                        this._pbHonour._visible = false;
                        this._lblWinHonour._visible = false;
                        this._pbDisgrace._visible = false;
                        this._lblWinDisgrace._visible = false;
                        this._lblRank._visible = false;
                    }
                    else
                    {
                        this._pbHonour._visible = true;
                        this._pbDisgrace._visible = true;
                        this._lblWinDisgrace._visible = true;
                        this._lblWinHonour._visible = true;
                        this._lblRank._visible = true;
                        if (_loc5.datacenter.Basics.aks_current_server.isHardcore())
                        {
                            if (_global.isNaN(oItem.minxp))
                            {
                                this._pbDisgrace._visible = false;
                            } // end if
                            this._pbDisgrace.minimum = oItem.minxp;
                            this._pbDisgrace.maximum = oItem.maxxp;
                            this._pbDisgrace.value = oItem.xp;
                        }
                        else
                        {
                            this._pbDisgrace.minimum = oItem.mindisgrace;
                            this._pbDisgrace.maximum = oItem.maxdisgrace;
                            this._pbDisgrace.value = oItem.disgrace;
                        } // end else if
                        this._pbHonour.minimum = oItem.minhonour;
                        this._pbHonour.maximum = oItem.maxhonour;
                        this._pbHonour.value = oItem.honour;
                    } // end else if
                    this._lblWinHonour.text = _global.isNaN(oItem.winhonour) ? ("") : (oItem.winhonour);
                    if (!_loc5.datacenter.Basics.aks_current_server.isHardcore())
                    {
                        this._lblWinDisgrace.text = _global.isNaN(oItem.windisgrace) ? ("") : (oItem.windisgrace);
                    }
                    else
                    {
                        this._lblWinDisgrace.text = _global.isNaN(oItem.winxp) ? ("") : (oItem.winxp);
                    } // end else if
                    this._lblRank.text = _global.isNaN(oItem.rank) ? ("") : (oItem.rank);
                    this._lblKama.text = _global.isNaN(oItem.kama) ? ("") : (oItem.kama);
                    this._lblLevel.text = oItem.level;
                    this._mcDeadHead._visible = oItem.bDead;
                    this.createEmptyMovieClip("_mcItems", 10);
                    var _loc6 = false;
                    var _loc7 = oItem.items.length;
                    while (--_loc7 >= 0)
                    {
                        var _loc8 = this._mcItemPlacer._x + 24 * _loc7;
                        if (_loc8 < this._mcItemPlacer._x + this._mcItemPlacer._width)
                        {
                            var _loc9 = oItem.items[_loc7];
                            var _loc10 = this._mcItems.attachMovie("Container", "_ctrItem" + _loc7, _loc7, {_x: _loc8, _y: this._mcItemPlacer._y + 1});
                            _loc10.setSize(18, 18);
                            _loc10.addEventListener("over", this);
                            _loc10.addEventListener("out", this);
                            _loc10.addEventListener("click", this);
                            _loc10.enabled = true;
                            _loc10.margin = 0;
                            _loc10.contentData = _loc9;
                            continue;
                        } // end if
                        _loc6 = true;
                    } // end while
                    this._ldrAllDrop._visible = _loc6;
                    break;
                } 
            } // End of switch
        }
        else if (this._lblName.text != undefined)
        {
            this._pbHonour._visible = false;
            this._lblName.text = "";
            this._pbHonour.minimum = 0;
            this._pbHonour.maximum = 100;
            this._pbHonour.value = 0;
            this._pbDisgrace.minimum = 0;
            this._pbDisgrace.maximum = 100;
            this._pbDisgrace.value = 0;
            this._lblWinHonour.text = "";
            this._lblWinDisgrace.text = "";
            this._lblKama.text = "";
            this._mcDeadHead._visible = false;
            this._mcItems.removeMovieClip();
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._mcItemPlacer._visible = false;
        this._pbHonour._visible = false;
        this._mcDeadHead._visible = false;
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.size = function ()
    {
        super.size();
    };
    _loc1.addListeners = function ()
    {
        var _loc2 = this;
        this._ldrAllDrop.onRollOver = function ()
        {
            this._parent.over({target: this});
        };
        this._ldrAllDrop.onRollOut = function ()
        {
            this._parent.out({target: this});
        };
        this._pbHonour.enabled = true;
        this._pbHonour.addEventListener("over", this);
        this._pbHonour.addEventListener("out", this);
        this._pbDisgrace.enabled = true;
        this._pbDisgrace.addEventListener("over", this);
        this._pbDisgrace.addEventListener("out", this);
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._ldrAllDrop:
            {
                var _loc3 = this._oItems.items;
                var _loc4 = "";
                var _loc5 = 0;
                
                while (++_loc5, _loc5 < _loc3.length)
                {
                    var _loc6 = _loc3[_loc5];
                    if (_loc5 > 0)
                    {
                        _loc4 = _loc4 + "\n";
                    } // end if
                    _loc4 = _loc4 + (_loc6.Quantity + " x " + _loc6.name);
                } // end while
                if (_loc4 != "")
                {
                    this._mcList.gapi.showTooltip(_loc4, oEvent.target, 30);
                } // end if
                break;
            } 
            case this._pbHonour:
            case this._pbDisgrace:
            {
                this._mcList.gapi.showTooltip(oEvent.target.value + " / " + oEvent.target.maximum, oEvent.target, 20);
                break;
            } 
            default:
            {
                var _loc7 = oEvent.target.contentData;
                var _loc8 = _loc7.style + "ToolTip";
                this._mcList.gapi.showTooltip(_loc7.Quantity + " x " + _loc7.name, oEvent.target, 20, undefined, _loc8);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this._mcList.gapi.hideTooltip();
    };
    _loc1.click = function (oEvent)
    {
        var _loc3 = oEvent.target.contentData;
        if (Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && _loc3 != undefined)
        {
            this._mcList._parent.gapi.api.kernel.GameManager.insertItemInChat(_loc3);
        } // end if
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
