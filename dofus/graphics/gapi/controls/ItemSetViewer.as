// Action script...

// [Initial MovieClip Action of sprite 20966]
#initclip 231
if (!dofus.graphics.gapi.controls.ItemSetViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.ItemSetViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__itemSet = function (oItemSet)
    {
        this.addToQueue({object: this, method: function (oSet)
        {
            this._oItemSet = oSet;
            if (this.initialized)
            {
                this.updateData();
            } // end if
        }, params: [oItemSet]});
        //return (this.itemSet());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.ItemSetViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.updateData});
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        var _loc2 = 1;
        
        while (++_loc2, _loc2 <= 8)
        {
            var _loc3 = this["_ctr" + _loc2];
            _loc3.addEventListener("over", this);
            _loc3.addEventListener("out", this);
        } // end while
    };
    _loc1.initTexts = function ()
    {
        this._lblEffects.text = this.api.lang.getText("ITEMSET_EFFECTS");
        this._lblItems.text = this.api.lang.getText("ITEMSET_EQUIPED_ITEMS");
    };
    _loc1.updateData = function ()
    {
        if (this._oItemSet != undefined)
        {
            var _loc2 = this._oItemSet.items;
            this._winBg.title = this._oItemSet.name;
            var _loc3 = this._oItemSet.itemCount == undefined ? (8) : (this._oItemSet.itemCount);
            var _loc4 = 0;
            
            while (++_loc4, _loc4 < _loc3)
            {
                var _loc5 = _loc2[_loc4];
                var _loc6 = this["_ctr" + (_loc4 + 1)];
                _loc6._visible = true;
                _loc6.contentData = _loc5.item;
                _loc6.borderRenderer = _loc5.isEquiped ? ("ItemSetViewerItemBorderNone") : ("ItemSetViewerItemBorder");
            } // end while
            this._lstEffects.dataProvider = this._oItemSet.effects;
            var _loc7 = _loc3 + 1;
            
            while (++_loc7, _loc7 <= 8)
            {
                var _loc8 = this["_ctr" + _loc7];
                _loc8._visible = false;
            } // end while
            this._visible = true;
        }
        else
        {
            ank.utils.Logger.err("[ItemSetViewer] le set n\'est pas défini");
            this._visible = false;
        } // end else if
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            {
                this.dispatchEvent({type: "close"});
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_ctr1":
            case "_ctr2":
            case "_ctr3":
            case "_ctr4":
            case "_ctr5":
            case "_ctr6":
            case "_ctr7":
            case "_ctr8":
            {
                var _loc3 = oEvent.target.contentData;
                this.gapi.showTooltip(_loc3.name, oEvent.target, -20, undefined, _loc3.style + "ToolTip");
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("itemSet", function ()
    {
    }, _loc1.__set__itemSet);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.ItemSetViewer = function ()
    {
        super();
    }).CLASS_NAME = "ItemSetViewer";
    (_global.dofus.graphics.gapi.controls.ItemSetViewer = function ()
    {
        super();
    }).NO_TRANSFORM = {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0};
    (_global.dofus.graphics.gapi.controls.ItemSetViewer = function ()
    {
        super();
    }).INACTIVE_TRANSFORM = {ra: 50, rb: 0, ga: 50, gb: 0, ba: 50, bb: 0};
} // end if
#endinitclip
