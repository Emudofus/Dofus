// Action script...

// [Initial MovieClip Action of sprite 20845]
#initclip 110
if (!dofus.graphics.gapi.controls.craftviewer.CraftViewerCraftItem)
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
    if (!dofus.graphics.gapi.controls.craftviewer)
    {
        _global.dofus.graphics.gapi.controls.craftviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.craftviewer.CraftViewerCraftItem = function ()
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
        this._oItem = oItem;
        if (bUsed)
        {
            this._ctrItemIcon.contentData = oItem.craftItem;
            this._ctrItemIcon._visible = true;
            this._lblItemName.text = oItem.craftItem.name + " (" + this._mcList._parent.api.lang.getText("LEVEL_SMALL") + " " + oItem.craftItem.level + ")";
            switch (oItem.difficulty)
            {
                case 1:
                {
                    this._lblItemName.styleName = "DarkGrayLeftSmallLabel";
                    break;
                } 
                case 2:
                {
                    this._lblItemName.styleName = "GreenLeftSmallBoldLabel";
                    break;
                } 
                case 3:
                {
                    this._lblItemName.styleName = "RedLeftSmallBoldLabel";
                    break;
                } 
            } // End of switch
            this._mcTooltip.onRollOver = function ()
            {
                this._parent.onTooltipRollOver();
            };
            this._mcTooltip.onRollOut = function ()
            {
                this._parent.onTooltipRollOut();
            };
            this._mcTooltip.onRelease = function ()
            {
                this._parent.click({target: {_name: "_lblItemIcon"}});
            };
            if (oItem.skill != undefined)
            {
                this._lblSkill.text = "(" + oItem.skill.description + " " + this._mcList._parent.api.lang.getText("ON") + " " + oItem.skill.interactiveObject + ")";
            } // end if
            var _loc5 = oItem.items;
            var _loc6 = _loc5.length;
            var _loc7 = 0;
            
            while (++_loc7, _loc7 < _loc6)
            {
                var _loc8 = _loc5[_loc7];
                this["_ctr" + _loc7]._visible = true;
                this["_ctr" + _loc7].contentData = _loc8;
                this["_lblPlus" + _loc7]._visible = true;
            } // end while
            var _loc9 = _loc6;
            
            while (++_loc9, _loc9 < 8)
            {
                this["_ctr" + _loc9]._visible = false;
                this["_lblPlus" + _loc9]._visible = false;
            } // end while
        }
        else if (this._lblItemName.text != undefined)
        {
            this._ctrItemIcon.contentData = "";
            this._ctrItemIcon._visible = false;
            this._lblItemName.text = "";
            this._lblSkill.text = "";
            var _loc10 = 0;
            
            while (++_loc10, _loc10 < 8)
            {
                this["_ctr" + _loc10]._visible = false;
                this["_lblPlus" + _loc10]._visible = false;
            } // end while
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._ctrItemIcon._visible = false;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < 8)
        {
            this["_ctr" + _loc3]._visible = this["_lblPlus" + _loc3]._visible = false;
        } // end while
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.size = function ()
    {
        super.size();
    };
    _loc1.addListeners = function ()
    {
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < 8)
        {
            this["_ctr" + _loc2].addEventListener("over", this);
            this["_ctr" + _loc2].addEventListener("out", this);
            this["_ctr" + _loc2].addEventListener("click", this);
        } // end while
        this._ctrItemIcon.addEventListener("click", this);
    };
    _loc1.setContainerContentData = function (nIndex, oItem)
    {
        this["_ctr" + nIndex].contentData = oItem;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_ctrItemIcon":
            case "_lblItemIcon":
            {
                if (Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && this._oItem != undefined)
                {
                    this._mcList._parent.gapi.api.kernel.GameManager.insertItemInChat(this._oItem.craftItem, "", "=");
                    var _loc3 = 0;
                    
                    while (++_loc3, _loc3 < this._oItem.items.length)
                    {
                        var _loc4 = this._oItem.items[_loc3];
                        this._mcList._parent.gapi.api.kernel.GameManager.insertItemInChat(_loc4, _loc4.Quantity + "x", _loc3 < this._oItem.items.length - 1 ? ("+") : (""));
                    } // end while
                }
                else
                {
                    this._mcList._parent.craftItem(this._ctrItemIcon.contentData);
                } // end else if
                break;
            } 
            default:
            {
                var _loc5 = oEvent.target.contentData;
                if (Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && _loc5 != undefined)
                {
                    this._mcList._parent.gapi.api.kernel.GameManager.insertItemInChat(_loc5);
                }
                else
                {
                    this._mcList._parent.craftItem(_loc5);
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.onTooltipRollOver = function ()
    {
        var _loc2 = "";
        switch (this._oItem.difficulty)
        {
            case 1:
            {
                _loc2 = this._mcList._parent.gapi.api.lang.getText("CRAFT_DIFFICULTY1");
                break;
            } 
            case 2:
            {
                _loc2 = this._mcList._parent.gapi.api.lang.getText("CRAFT_DIFFICULTY2");
                break;
            } 
            case 3:
            {
                _loc2 = this._mcList._parent.gapi.api.lang.getText("CRAFT_DIFFICULTY3");
                break;
            } 
        } // End of switch
        this._mcList._parent.gapi.showTooltip(_loc2, this._mcTooltip, 15);
    };
    _loc1.onTooltipRollOut = function ()
    {
        this._mcList._parent.gapi.hideTooltip();
    };
    _loc1.over = function (oEvent)
    {
        var _loc3 = oEvent.target.contentData;
        this._mcList._parent.gapi.showTooltip("x" + _loc3.Quantity + " - " + _loc3.name, oEvent.target, -20);
    };
    _loc1.out = function (oEvent)
    {
        this._mcList._parent.gapi.hideTooltip();
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
