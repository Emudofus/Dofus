// Action script...

// [Initial MovieClip Action of sprite 20818]
#initclip 83
if (!dofus.graphics.gapi.ui.ItemUtility)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.ItemUtility = function ()
    {
        super();
    }).prototype;
    _loc1.__set__item = function (oItem)
    {
        this._oItem = oItem;
        if (this.initialized)
        {
            this.search(oItem);
        } // end if
        //return (this.item());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.ItemUtility.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.initData});
        this.hideCraftsViewer(true);
        this.hideReceiptViewer(true);
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._cbReceiptTypes.addEventListener("itemSelected", this);
    };
    _loc1.initTexts = function ()
    {
        this._winReceipt.title = this._oItem.name;
        this._lblReceiptFilter.text = this.api.lang.getText("ITEM_TYPE");
        this._lblNoCrafts.text = this.api.lang.getText("ITEM_UTILITY_NO_CRAFTS");
        this._lblNoReceipt.text = this.api.lang.getText("ITEM_UTILITY_NO_RECEIPT");
        this._lblCrafts.text = this.api.lang.getText("ITEM_UTILITY_CRAFTS");
        this._lblReceipt.text = this.api.lang.getText("ITEM_UTILITY_RECEIPT");
    };
    _loc1.initData = function ()
    {
        if (this._oItem != undefined)
        {
            this.search(this._oItem);
        } // end if
    };
    _loc1.search = function (oItem)
    {
        this._eaReceipts = new ank.utils.ExtendedArray();
        var _loc3 = this.api.lang.getAllCrafts();
        var _loc4 = new Array();
        for (var a in _loc3)
        {
            if (a == oItem.unicID)
            {
                var _loc5 = new ank.utils.ExtendedArray();
                _loc5.push(this.createCraftObject(Number(a), _loc3));
                this._lstReceipt.dataProvider = _loc5;
                continue;
            } // end if
            var _loc6 = _loc3[a];
            var _loc7 = 0;
            
            while (++_loc7, _loc7 < _loc6.length)
            {
                if (_loc6[_loc7][0] == oItem.unicID)
                {
                    _loc4.push(a);
                } // end if
            } // end while
        } // end of for...in
        var _loc8 = new ank.utils.ExtendedArray();
        _loc8.push({label: this.api.lang.getText("WITHOUT_TYPE_FILTER"), id: 0});
        var _loc9 = new Object();
        if (_loc4.length > 0)
        {
            var _loc10 = 0;
            
            while (++_loc10, _loc10 < _loc4.length)
            {
                var _loc11 = this.createCraftObject(_loc4[_loc10], _loc3);
                var _loc12 = _loc11.craftItem.type;
                if (!_loc9[_loc12])
                {
                    _loc8.push({label: this.api.lang.getItemTypeText(_loc12).n, id: _loc12});
                    _loc9[_loc12] = true;
                } // end if
                this._eaReceipts.push(_loc11);
            } // end while
            this._cbReceiptTypes.dataProvider = _loc8;
            this._cbReceiptTypes.selectedIndex = 0;
            this._lstCrafts.dataProvider = this._eaReceipts;
            this.hideCraftsViewer(false);
        }
        else
        {
            this.hideCraftsViewer(true);
        } // end else if
        this.hideReceiptViewer(this._lstReceipt.dataProvider.length != 1);
    };
    _loc1.createCraftObject = function (nCraftItemId, aAllCrafts)
    {
        var _loc4 = aAllCrafts[nCraftItemId];
        var _loc5 = new Object();
        _loc5.craftItem = new dofus.datacenter.Item(0, nCraftItemId, 1);
        _loc5.items = new Array();
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc4.length)
        {
            var _loc7 = _loc4[_loc6][0];
            var _loc8 = _loc4[_loc6][1];
            var _loc9 = new dofus.datacenter.Item(0, _loc7, _loc8);
            _loc5.items.push(_loc9);
        } // end while
        return (_loc5);
    };
    _loc1.hideReceiptViewer = function (bHide)
    {
        this._lstReceipt._visible = !bHide;
        this._lblNoReceipt._visible = bHide;
    };
    _loc1.hideCraftsViewer = function (bHide)
    {
        this._lstCrafts._visible = !bHide;
        this._cbReceiptTypes.enabled = !bHide;
        this._lblNoCrafts._visible = bHide;
    };
    _loc1.setReceiptType = function (nTypeID)
    {
        var _loc3 = new ank.utils.ExtendedArray();
        if (nTypeID == 0)
        {
            _loc3 = this._eaReceipts;
        }
        else
        {
            var _loc4 = 0;
            
            while (++_loc4, _loc4 < this._eaReceipts.length)
            {
                var _loc5 = this._eaReceipts[_loc4];
                if (_loc5.craftItem.type == nTypeID)
                {
                    _loc3.push(_loc5);
                } // end if
            } // end while
        } // end else if
        this._lstCrafts.dataProvider = _loc3;
        var _loc6 = this._cbReceiptTypes.dataProvider;
        var _loc7 = 0;
        
        while (++_loc7, _loc7 < _loc6.length)
        {
            if (_loc6[_loc7].id == nTypeID)
            {
                this._cbReceiptTypes.selectedIndex = _loc7;
                return;
            } // end if
        } // end while
    };
    _loc1.click = function (oEvent)
    {
        if (oEvent.target == this._btnClose)
        {
            this.callClose();
            return;
        } // end if
    };
    _loc1.itemSelected = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_cbReceiptTypes":
            {
                this.setReceiptType(this._cbReceiptTypes.selectedItem.id);
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("item", function ()
    {
    }, _loc1.__set__item);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.ItemUtility = function ()
    {
        super();
    }).CLASS_NAME = "ItemUtility";
} // end if
#endinitclip
