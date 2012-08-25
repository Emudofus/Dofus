// Action script...

// [Initial MovieClip Action of sprite 20832]
#initclip 97
if (!dofus.graphics.gapi.ui.gameresult.GameResultPlayer)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.gameresult.GameResultPlayer = function ()
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
        this._oItems = oItem;
        if (bUsed)
        {
            switch (oItem.type)
            {
                case "monster":
                case "taxcollector":
                case "player":
                {
                    this._lblName.text = oItem.name;
                    if (_global.isNaN(oItem.xp))
                    {
                        this._pbXP._visible = false;
                    }
                    else
                    {
                        this._pbXP._visible = true;
                        this._pbXP.minimum = oItem.minxp;
                        this._pbXP.maximum = oItem.maxxp;
                        this._pbXP.value = oItem.xp;
                    } // end else if
                    this._lblWinXP.text = _global.isNaN(oItem.winxp) ? ("") : (oItem.winxp);
                    this._lblGuildXP.text = _global.isNaN(oItem.guildxp) ? ("") : (oItem.guildxp);
                    this._lblMountXP.text = _global.isNaN(oItem.mountxp) ? ("") : (oItem.mountxp);
                    this._lblKama.text = _global.isNaN(oItem.kama) ? ("") : (oItem.kama);
                    this._lblLevel.text = oItem.level;
                    this._mcDeadHead._visible = oItem.bDead;
                    this.createEmptyMovieClip("_mcItems", 10);
                    var _loc5 = false;
                    oItem.items.sortOn(["_itemLevel", "_itemName"], Array.DESCENDING | Array.NUMERIC);
                    var _loc6 = oItem.items.length;
                    while (--_loc6 >= 0)
                    {
                        var _loc7 = this._mcItemPlacer._x + 24 * _loc6;
                        if (_loc7 < this._mcItemPlacer._x + this._mcItemPlacer._width)
                        {
                            var _loc8 = oItem.items[_loc6];
                            var _loc9 = this._mcItems.attachMovie("Container", "_ctrItem" + _loc6, _loc6, {_x: _loc7, _y: this._mcItemPlacer._y + 1});
                            _loc9.setSize(18, 18);
                            _loc9.addEventListener("over", this);
                            _loc9.addEventListener("out", this);
                            _loc9.addEventListener("click", this);
                            _loc9.enabled = true;
                            _loc9.margin = 0;
                            _loc9.contentData = _loc8;
                            continue;
                        } // end if
                        _loc5 = true;
                    } // end while
                    this._ldrAllDrop._visible = _loc5;
                    break;
                } 
            } // End of switch
        }
        else if (this._lblName.text != undefined)
        {
            this._pbXP._visible = false;
            this._lblName.text = "";
            this._pbXP.minimum = 0;
            this._pbXP.maximum = 100;
            this._pbXP.value = random(99);
            this._lblWinXP.text = "";
            this._lblKama.text = "";
            this._mcDeadHead._visible = false;
            this._mcItems.removeMovieClip();
            this._ldrAllDrop._visible = false;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._mcItemPlacer._alpha = 0;
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
        this._pbXP.enabled = true;
        this._pbXP.addEventListener("over", this);
        this._pbXP.addEventListener("out", this);
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
            case this._pbXP:
            {
                this._mcList.gapi.showTooltip(this._oItems.xp + " / " + this._oItems.maxxp, oEvent.target, 20);
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
