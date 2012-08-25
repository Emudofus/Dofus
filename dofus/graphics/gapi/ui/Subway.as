// Action script...

// [Initial MovieClip Action of sprite 20864]
#initclip 129
if (!dofus.graphics.gapi.ui.Subway)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Subway = function ()
    {
        super();
    }).prototype;
    _loc1.__set__data = function (eaData)
    {
        this.addToQueue({object: this, method: function (d)
        {
            this._eaData = d;
            if (this.initialized)
            {
                this.initData();
            } // end if
        }, params: [eaData]});
        //return (this.data());
    };
    _loc1.__set__type = function (type)
    {
        this._nType = type;
        //return (this.type());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Subway.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        switch (this._nType)
        {
            case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY:
            {
                this.api.network.Subway.leave();
                break;
            } 
            case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM:
            {
                this.api.network.Subway.prismLeave();
                break;
            } 
        } // End of switch
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.initTexts = function ()
    {
        switch (this._nType)
        {
            case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY:
            {
                this._winBg.title = this.api.lang.getText("SUBWAY_LIST");
                this._lblPrismNotice._visible = false;
                this._lblDescription._visible = true;
                break;
            } 
            case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM:
            {
                this._winBg.title = this.api.lang.getText("PRISM_LIST");
                this._lblPrismNotice._visible = true;
                this._lblDescription._visible = false;
                this._lblPrismNotice.text = this.api.lang.getText("PRISM_NOTICE");
                break;
            } 
        } // End of switch
        this._lblCoords.text = this.api.lang.getText("COORDINATES_SMALL");
        this._lblName.text = this.api.lang.getText("PLACE");
        this._lblCost.text = this.api.lang.getText("COST");
        this._lblDescription.text = this.api.lang.getText("CLICK_ON_WAYPOINT");
        this._btnClose2.label = this.api.lang.getText("CLOSE");
        switch (this._nType)
        {
            case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY:
            {
                for (var a in this._eaData)
                {
                    var _loc2 = new Object();
                    _loc2._y = this._mcTabPlacer._y;
                    _loc2._height = 20;
                    _loc2.backgroundDown = "ButtonTabDown";
                    _loc2.backgroundUp = "ButtonTabUp";
                    _loc2.styleName = "BrownTabButton";
                    _loc2.toggle = true;
                    _loc2.selected = true;
                    _loc2.enabled = true;
                    _loc2.label = " " + this._eaData[a][0].category + " ";
                    var _loc3 = (ank.gapi.controls.Button)(this.attachMovie("Button", "_btnTab" + a, this.getNextHighestDepth(), _loc2));
                    _loc3.addEventListener("click", this);
                } // end of for...in
                this.setCurrentTab(0);
                break;
            } 
            case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM:
            {
                this._lstSubway.dataProvider = this._eaData;
                break;
            } 
        } // End of switch
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnClose2.addEventListener("click", this);
        this._lstSubway.addEventListener("itemSelected", this);
    };
    _loc1.initData = function ()
    {
        if (this._nType != dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
        {
            return;
        } // end if
        if (this._eaData != undefined && this._eaData.length > 0)
        {
            for (var a in this._eaData)
            {
                this.setCurrentTab(Number(a));
                return;
            } // end of for...in
        } // end if
    };
    _loc1.updateCurrentTabInformations = function ()
    {
        if (this._nType != dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
        {
            return;
        } // end if
        this._eaData[this._nCurrentCategory].sortOn("fieldToSort", Array.CASEINSENSITIVE);
        this._lstSubway.dataProvider = this._eaData[this._nCurrentCategory];
    };
    _loc1.setCurrentTab = function (nCategoryID)
    {
        if (this._nType != dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
        {
            return;
        } // end if
        var _loc3 = this["_btnTab" + this._nCurrentCategory];
        var _loc4 = this["_btnTab" + nCategoryID];
        _loc3.selected = true;
        _loc3.enabled = true;
        _loc4.selected = false;
        _loc4.enabled = false;
        this._nCurrentCategory = nCategoryID;
        this.updateCurrentTabInformations();
        this.setTabsPreferedSize();
    };
    _loc1.setTabsPreferedSize = function ()
    {
        if (this._nType != dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
        {
            return;
        } // end if
        var _loc2 = this._mcTabPlacer._x;
        for (var a in this._eaData)
        {
            var _loc3 = (ank.gapi.controls.Button)(this["_btnTab" + a]);
            _loc3._x = _loc2;
            _loc3.setPreferedSize();
            _loc2 = _loc2 + _loc3.width;
        } // end of for...in
    };
    _loc1.click = function (oEvent)
    {
        var _loc3 = oEvent.target._name;
        switch (_loc3)
        {
            case "_btnClose":
            case "_btnClose2":
            {
                this.callClose();
                break;
            } 
            default:
            {
                this.setCurrentTab(Number(_loc3.substr(7)));
                break;
            } 
        } // End of switch
    };
    _loc1.itemSelected = function (oEvent)
    {
        var _loc3 = oEvent.row.item;
        var _loc4 = _loc3.cost;
        if (this.api.datacenter.Player.Kama < _loc4)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("NOT_ENOUGH_RICH"), "ERROR_BOX");
        }
        else
        {
            switch (this._nType)
            {
                case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY:
                {
                    this.api.network.Subway.use(_loc3.mapID);
                    break;
                } 
                case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM:
                {
                    this.api.network.Subway.prismUse(_loc3.mapID);
                    break;
                } 
            } // End of switch
        } // end else if
    };
    _loc1.addProperty("type", function ()
    {
    }, _loc1.__set__type);
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Subway = function ()
    {
        super();
    }).CLASS_NAME = "Subway";
    (_global.dofus.graphics.gapi.ui.Subway = function ()
    {
        super();
    }).SUBWAY_TYPE_SUBWAY = 1;
    (_global.dofus.graphics.gapi.ui.Subway = function ()
    {
        super();
    }).SUBWAY_TYPE_PRISM = 2;
    _loc1._nCurrentCategory = 0;
    _loc1._nType = dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY;
} // end if
#endinitclip
