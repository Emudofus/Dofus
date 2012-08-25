// Action script...

// [Initial MovieClip Action of sprite 20736]
#initclip 1
if (!dofus.graphics.gapi.ui.ItemFound)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.ItemFound = function ()
    {
        super();
    }).prototype;
    _loc1.__set__itemId = function (nId)
    {
        this._nItemId = nId;
        //return (this.itemId());
    };
    _loc1.__set__qty = function (nQty)
    {
        this._nQty = nQty;
        //return (this.qty());
    };
    _loc1.__set__ressourceId = function (nRessourceId)
    {
        this._nRessourceId = nRessourceId;
        //return (this.ressourceId());
    };
    _loc1.__set__timer = function (nTimer)
    {
        this._nTimer = nTimer;
        //return (this.timer());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.ItemFound.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        if (this._nTimer != 0)
        {
            ank.utils.Timer.setTimer(this, "itemFound", this, this.hide, this._nTimer);
        } // end if
    };
    _loc1.initTexts = function ()
    {
        var _loc2 = new dofus.datacenter.Item(0, this._nItemId, this._nQty);
        var _loc3 = new dofus.datacenter.Item(0, this._nRessourceId, 1);
        this._ldrItem.contentPath = _loc2.iconFile;
        this._txtDescription.text = this.api.lang.getText("ITEM_FOUND", [this._nQty, _loc2.name, _loc3.name]);
    };
    _loc1.hide = function ()
    {
        this._alpha = this._alpha - 5;
        if (this._alpha < 1)
        {
            this.unloadThis();
            return;
        } // end if
        this.addToQueue({object: this, method: this.hide});
    };
    _loc1.addProperty("ressourceId", function ()
    {
    }, _loc1.__set__ressourceId);
    _loc1.addProperty("itemId", function ()
    {
    }, _loc1.__set__itemId);
    _loc1.addProperty("timer", function ()
    {
    }, _loc1.__set__timer);
    _loc1.addProperty("qty", function ()
    {
    }, _loc1.__set__qty);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.ItemFound = function ()
    {
        super();
    }).CLASS_NAME = "ItemFound";
    _loc1._nTimer = 0;
} // end if
#endinitclip
