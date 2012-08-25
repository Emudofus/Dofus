// Action script...

// [Initial MovieClip Action of sprite 20634]
#initclip 155
if (!dofus.graphics.gapi.ui.InventorySearch)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.InventorySearch = function ()
    {
        super();
    }).prototype;
    _loc1.__set__types = function (aTypes)
    {
        this._aTypes = aTypes;
        //return (this.types());
    };
    _loc1.__set__maxLevel = function (nMaxLevel)
    {
        this._nMaxLevel = nMaxLevel;
        //return (this.maxLevel());
    };
    _loc1.__set__defaultSearch = function (sText)
    {
        this._sDefaultText = sText;
        //return (this.defaultSearch());
    };
    _loc1.__set__oParent = function (o)
    {
        this._oParent = o;
        //return (this.oParent());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.InventorySearch.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.gapi.hideTooltip();
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.generateIndexes();
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnClose2.addEventListener("click", this);
        this._btnView.addEventListener("click", this);
        this._tiSearch.addEventListener("change", this);
        this._lstItems.addEventListener("itemSelected", this);
    };
    _loc1.initTexts = function ()
    {
        this._winBackground.title = this.api.lang.getText("BIGSTORE_SEARCH");
        this._lblSearch.text = this.api.lang.getText("INVENTORY_SEARCH_ITEM_NAME", [dofus.graphics.gapi.ui.InventorySearch.MIN_SEARCH_CHAR]);
        this._btnClose2.label = this.api.lang.getText("CLOSE");
        this._btnView.label = this.api.lang.getText("BIGSTORE_SEARCH_VIEW");
        this._tiSearch.text = this._sDefaultText;
        this._tiSearch.setFocus();
    };
    _loc1.generateIndexes = function ()
    {
        var _loc2 = new Object();
        for (var k in this._aTypes)
        {
            _loc2[this._aTypes[k]] = true;
        } // end of for...in
        var _loc3 = this._oDataProvider;
        this._aItems = new Array();
        for (var k in _loc3)
        {
            var _loc4 = _loc3[k].name;
            var _loc5 = _loc3[k].unicID;
            this._aItems.push({id: _loc5, name: _loc4.toUpperCase()});
        } // end of for...in
    };
    _loc1.searchItem = function (sText)
    {
        var _loc3 = sText.split(" ");
        var _loc4 = new ank.utils.ExtendedArray();
        var _loc5 = new Object();
        var _loc6 = 0;
        var _loc7 = 0;
        
        while (++_loc7, _loc7 < this._aItems.length)
        {
            var _loc8 = this._aItems[_loc7];
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
        this._lstItems.dataProvider = _loc4;
        this._lblSearchCount.text = _loc4.length == 0 ? (this.api.lang.getText("NO_INVENTORY_SEARCH_RESULT")) : (_loc4.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("OBJECTS"), "m", _loc4 < 2));
        this._btnView.enabled = false;
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
            case "_btnClose2":
            {
                this.callClose();
                break;
            } 
            case "_btnView":
            {
                var _loc3 = this._lstItems.selectedItem;
                this.dispatchEvent({type: "selected", value: _loc3.unicID});
                this.callClose();
                break;
            } 
        } // End of switch
    };
    _loc1.change = function (oEvent)
    {
        var _loc3 = new ank.utils.ExtendedString(this._tiSearch.text).trim().toString();
        if (_loc3.length >= dofus.graphics.gapi.ui.InventorySearch.MIN_SEARCH_CHAR)
        {
            this.searchItem(_loc3.toUpperCase());
        }
        else
        {
            this._lstItems.dataProvider = new ank.utils.ExtendedArray();
            if (this._lblSearchCount.text != undefined)
            {
                this._lblSearchCount.text = "";
            } // end if
        } // end else if
        this._oParent.defaultSearch = this._tiSearch.text;
    };
    _loc1.itemSelected = function (oEvent)
    {
        this._btnView.enabled = true;
    };
    _loc1.addProperty("types", function ()
    {
    }, _loc1.__set__types);
    _loc1.addProperty("maxLevel", function ()
    {
    }, _loc1.__set__maxLevel);
    _loc1.addProperty("oParent", function ()
    {
    }, _loc1.__set__oParent);
    _loc1.addProperty("defaultSearch", function ()
    {
    }, _loc1.__set__defaultSearch);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.InventorySearch = function ()
    {
        super();
    }).CLASS_NAME = "InventorySearch";
    (_global.dofus.graphics.gapi.ui.InventorySearch = function ()
    {
        super();
    }).MIN_SEARCH_CHAR = 3;
    _loc1._sDefaultText = "";
} // end if
#endinitclip
