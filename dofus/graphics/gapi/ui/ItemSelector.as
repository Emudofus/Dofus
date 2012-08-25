// Action script...

// [Initial MovieClip Action of sprite 20605]
#initclip 126
if (!dofus.graphics.gapi.ui.ItemSelector)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.ItemSelector = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.ItemSelector.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.hideItemViewer(true);
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.initTexts = function ()
    {
        this._winBg.title = "Liste des objets";
        this._lblSearch.text = this.api.lang.getText("BIGSTORE_SEARCH_ITEM_NAME");
        this._lblType.text = this.api.lang.getText("TYPE");
        this._lblQuantity.text = this.api.lang.getText("QUANTITY");
        this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
        this._btnSelect.label = this.api.lang.getText("SELECT");
        this._tiSearch.setFocus();
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnCancel.addEventListener("click", this);
        this._btnSelect.addEventListener("click", this);
        this._tiSearch.addEventListener("change", this);
        this._cbType.addEventListener("itemSelected", this);
        this._lst.addEventListener("itemSelected", this);
        this._lst.addEventListener("itemRollOver", this);
        this._lst.addEventListener("itemRollOut", this);
    };
    _loc1.initData = function ()
    {
        this._eaItems = new ank.utils.ExtendedArray();
        this._tiQuantity.restrict = "0-9";
        this._tiQuantity.text = "1";
        var _loc2 = new ank.utils.ExtendedArray();
        var _loc3 = this.api.lang.getAllItemTypes();
        for (var a in _loc3)
        {
            _loc2.push({label: _loc3[a].n, id: a});
        } // end of for...in
        _loc2.sortOn("label");
        _loc2.push({label: "All", id: -1});
        this._cbType.dataProvider = _loc2;
    };
    _loc1.hideItemViewer = function (bHide)
    {
        this._winItemViewer._visible = !bHide;
        this._itvItemViewer._visible = !bHide;
    };
    _loc1.generateIndexes = function ()
    {
        var _loc2 = new Object();
        for (var k in this._aTypes)
        {
            _loc2[this._aTypes[k]] = true;
        } // end of for...in
        var _loc3 = this.api.lang.getItemUnics();
        this._eaItems = new ank.utils.ExtendedArray();
        this._eaItemsOriginal = new ank.utils.ExtendedArray();
        for (var k in _loc3)
        {
            var _loc4 = _loc3[k];
            if (_loc4.ep != undefined && _loc4.ep > this.api.datacenter.Basics.aks_current_regional_version)
            {
                continue;
            } // end if
            if (_loc2[_loc4.t])
            {
                var _loc5 = _loc4.n;
                this._eaItems.push({id: k, name: _loc5.toUpperCase()});
                this._eaItemsOriginal.push(new dofus.datacenter.Item(0, Number(k)));
            } // end if
        } // end of for...in
        this._lblNumber.text = this._eaItemsOriginal.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("OBJECTS"), "m", this._eaItemsOriginal.length < 2);
    };
    _loc1.searchItem = function (sText)
    {
        var _loc3 = sText.split(" ");
        var _loc4 = new ank.utils.ExtendedArray();
        var _loc5 = new Object();
        var _loc6 = 0;
        var _loc7 = 0;
        
        while (++_loc7, _loc7 < this._eaItems.length)
        {
            var _loc8 = this._eaItems[_loc7];
            var _loc9 = this.searchWordsInName(_loc3, _loc8.name, _loc6);
            if (_loc9 != 0)
            {
                _loc5[_loc8.id] = _loc9;
                _loc6 = _loc9;
            } // end if
        } // end while
        for (var k in _loc5)
        {
            if (_loc5[k] >= _loc6)
            {
                _loc4.push(new dofus.datacenter.Item(0, Number(k)));
            } // end if
        } // end of for...in
        this._lst.dataProvider = _loc4;
    };
    _loc1.searchWordsInName = function (aWords, sName, nMaxWordsCount)
    {
        var _loc5 = 0;
        var _loc6 = aWords.length;
        
        while (--_loc6, _loc6 >= 0)
        {
            var _loc7 = aWords[_loc6];
            if (sName.indexOf(_loc7) != -1)
            {
                ++_loc5;
                continue;
            } // end if
            if (_loc5 + _loc6 < nMaxWordsCount)
            {
                return (0);
            } // end if
        } // end while
        return (_loc5);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            case "_btnCancel":
            {
                this.dispatchEvent({type: "cancel"});
                this.callClose();
            } 
            case "_btnSelect":
            {
                if (this._lst.selectedItem == undefined)
                {
                    return;
                } // end if
                this.dispatchEvent({type: "select", ui: "ItemSelector", itemId: this._lst.selectedItem.unicID, itemQuantity: this._tiQuantity.text});
                this.callClose();
                break;
            } 
        } // End of switch
    };
    _loc1.change = function (oEvent)
    {
        if (this._tiSearch.text.length > 3)
        {
            this.searchItem(this._tiSearch.text.toUpperCase());
        }
        else if (this._lst.dataProvider != this._eaItemsOriginal)
        {
            this._lst.dataProvider = this._eaItemsOriginal;
        } // end else if
    };
    _loc1.itemSelected = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._cbType:
            {
                this._aTypes = new Array();
                if (this._cbType.selectedItem.id != -1)
                {
                    this._aTypes.push(this._cbType.selectedItem.id);
                }
                else
                {
                    var _loc3 = 0;
                    
                    while (++_loc3, _loc3 < this._cbType.dataProvider.length)
                    {
                        if (this._cbType.dataProvider[_loc3].id != -1)
                        {
                            this._aTypes.push(this._cbType.dataProvider[_loc3].id);
                        } // end if
                    } // end while
                } // end else if
                this.generateIndexes();
                this.change();
                break;
            } 
            case this._lst:
            {
                var _loc4 = this._lst.selectedItem;
                if (_loc4 == undefined)
                {
                    this.hideItemViewer(true);
                }
                else
                {
                    if (Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY))
                    {
                        this.api.kernel.GameManager.insertItemInChat(_loc4);
                        return;
                    } // end if
                    this.hideItemViewer(false);
                    this._itvItemViewer.itemData = _loc4;
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.itemRollOver = function (oEvent)
    {
        this.gapi.showTooltip(oEvent.row.item.name + " (" + oEvent.row.item.unicID + ")", oEvent.row, 20, {bXLimit: true, bYLimit: false});
    };
    _loc1.itemRollOut = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.ItemSelector = function ()
    {
        super();
    }).CLASS_NAME = "ItemSelector";
} // end if
#endinitclip
