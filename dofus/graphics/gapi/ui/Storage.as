// Action script...

// [Initial MovieClip Action of sprite 20890]
#initclip 155
if (!dofus.graphics.gapi.ui.Storage)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Storage = function ()
    {
        super();
    }).prototype;
    _loc1.__set__data = function (oData)
    {
        this._oData = oData;
        //return (this.data());
    };
    _loc1.__set__isMount = function (bMount)
    {
        this._bMount = bMount;
        //return (this.isMount());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Storage.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        if (this._bMount == true)
        {
            this.api.ui.loadUIComponent("Mount", "Mount");
        } // end if
        this.api.network.Exchange.leave();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        if (this._bMount != true)
        {
            this._pbPods._visible = false;
        } // end if
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
        this.hideItemViewer(true);
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._ivInventoryViewer.addEventListener("selectedItem", this);
        this._ivInventoryViewer.addEventListener("dblClickItem", this);
        this._ivInventoryViewer.addEventListener("dropItem", this);
        this._ivInventoryViewer.addEventListener("dragKama", this);
        this._ivInventoryViewer2.addEventListener("selectedItem", this);
        this._ivInventoryViewer2.addEventListener("dblClickItem", this);
        this._ivInventoryViewer2.addEventListener("dropItem", this);
        this._ivInventoryViewer2.addEventListener("dragKama", this);
        if (this._oData != undefined)
        {
            this._oData.addEventListener("modelChanged", this);
        }
        else
        {
            ank.utils.Logger.err("[Storage] il n\'y a pas de data");
        } // end else if
    };
    _loc1.initTexts = function ()
    {
        this._winInventory.title = this.api.datacenter.Player.data.name;
        if (this._bMount != true)
        {
            this._winInventory2.title = this.api.lang.getText("STORAGE");
        }
        else
        {
            this._winInventory2.title = this.api.lang.getText("MY_MOUNT");
        } // end else if
    };
    _loc1.initData = function ()
    {
        if (this._bMount == true)
        {
            this._ivInventoryViewer.showKamas = false;
            this._ivInventoryViewer2.showKamas = false;
        } // end if
        this._ivInventoryViewer.dataProvider = this.api.datacenter.Player.Inventory;
        this._ivInventoryViewer.kamasProvider = this.api.datacenter.Player;
        this._ivInventoryViewer2.kamasProvider = this._oData;
        this.modelChanged();
    };
    _loc1.hideItemViewer = function (bHide)
    {
        this._itvItemViewer._visible = !bHide;
        this._winItemViewer._visible = !bHide;
    };
    _loc1.click = function (oEvent)
    {
        
        this.callClose();
        
        oEvent.target;
    };
    _loc1.selectedItem = function (oEvent)
    {
        if (oEvent.item == undefined)
        {
            this.hideItemViewer(true);
        }
        else
        {
            this.hideItemViewer(false);
            this._itvItemViewer.itemData = oEvent.item;
            switch (oEvent.target._name)
            {
                case "_ivInventoryViewer":
                {
                    this._ivInventoryViewer2.setFilter(this._ivInventoryViewer.currentFilterID);
                    break;
                } 
                case "_ivInventoryViewer2":
                {
                    this._ivInventoryViewer.setFilter(this._ivInventoryViewer2.currentFilterID);
                    break;
                } 
            } // End of switch
        } // end else if
    };
    _loc1.dblClickItem = function (oEvent)
    {
        var _loc3 = oEvent.item;
        if (_loc3 == undefined)
        {
            return;
        } // end if
        if (Key.isDown(Key.ALT) && false)
        {
            var _loc4 = new ank.utils.ExtendedArray();
            var _loc5 = oEvent.index;
            if (oEvent.target._name == "_ivInventoryViewer")
            {
                _loc4 = this._ivInventoryViewer.dataProvider;
                var _loc6 = this._ivInventoryViewer.selectedItem;
                var _loc7 = true;
            } // end if
            if (oEvent.target._name == "_ivInventoryViewer2")
            {
                _loc4 = this._ivInventoryViewer2.dataProvider;
                _loc6 = this._ivInventoryViewer2.selectedItem;
                _loc7 = false;
            } // end if
            if (_loc5 == undefined || _loc6 == undefined)
            {
                return;
            } // end if
            if (_loc5 > _loc6)
            {
                var _loc8 = _loc5;
                _loc5 = _loc6;
                _loc6 = _loc8;
            } // end if
            var _loc10 = new Array();
            var _loc12 = _loc5;
            
            while (++_loc12, _loc12 <= _loc6)
            {
                var _loc9 = _loc4[_loc12];
                var _loc11 = _loc9.Quantity;
                if (_loc11 < 1 || _loc11 == undefined)
                {
                    continue;
                } // end if
                _loc10.push({Add: _loc7, ID: _loc9.ID, Quantity: _loc11});
            } // end while
            this.api.network.Exchange.movementItems(_loc10);
        }
        else
        {
            var _loc13 = Key.isDown(Key.CONTROL) ? (_loc3.Quantity) : (1);
            switch (oEvent.target._name)
            {
                case "_ivInventoryViewer":
                {
                    this.api.network.Exchange.movementItem(true, oEvent.item.ID, _loc13);
                    break;
                } 
                case "_ivInventoryViewer2":
                {
                    this.api.network.Exchange.movementItem(false, oEvent.item.ID, _loc13);
                    break;
                } 
            } // End of switch
        } // end else if
    };
    _loc1.modelChanged = function (oEvent)
    {
        this._ivInventoryViewer2.dataProvider = this._oData.inventory;
    };
    _loc1.dropItem = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_ivInventoryViewer":
            {
                this.api.network.Exchange.movementItem(false, oEvent.item.ID, oEvent.quantity);
                break;
            } 
            case "_ivInventoryViewer2":
            {
                this.api.network.Exchange.movementItem(true, oEvent.item.ID, oEvent.quantity);
                break;
            } 
        } // End of switch
    };
    _loc1.dragKama = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._ivInventoryViewer:
            {
                this.api.network.Exchange.movementKama(oEvent.quantity);
                break;
            } 
            case this._ivInventoryViewer2:
            {
                this.api.network.Exchange.movementKama(-oEvent.quantity);
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("isMount", function ()
    {
    }, _loc1.__set__isMount);
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Storage = function ()
    {
        super();
    }).CLASS_NAME = "Storage";
} // end if
#endinitclip
