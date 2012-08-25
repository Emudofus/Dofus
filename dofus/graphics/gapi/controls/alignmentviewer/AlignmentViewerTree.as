// Action script...

// [Initial MovieClip Action of sprite 20725]
#initclip 246
if (!dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTree)
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
    if (!dofus.graphics.gapi.controls.alignmentviewer)
    {
        _global.dofus.graphics.gapi.controls.alignmentviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTree = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTree.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.initTexts = function ()
    {
        this._lblInfos.text = this.api.lang.getText("ALL_SPECIALIZATIONS");
        this._lblLevel.text = this.api.lang.getText("LEVEL_SMALL");
    };
    _loc1.addListeners = function ()
    {
        this._lstTree.addEventListener("itemRollOver", this);
        this._lstTree.addEventListener("itemRollOut", this);
        this._lstTree.addEventListener("itemSelected", this);
    };
    _loc1.initData = function ()
    {
        var _loc2 = this.api.datacenter.Player.specialization;
        var _loc3 = _loc2.alignment.index;
        var _loc4 = _loc2.index;
        var _loc5 = _loc2.order.index;
        var _loc6 = new Array();
        var _loc7 = this.api.lang.getAlignmentSpecializations();
        for (var k in _loc7)
        {
            var _loc8 = new dofus.datacenter.Specialization(Number(k));
            if (_loc8.order.index != _loc5)
            {
                continue;
            } // end if
            if (_loc8.description == "null")
            {
                continue;
            } // end if
            var _loc9 = _loc8.alignment;
            var _loc10 = _loc8.order;
            var _loc11 = _loc6[_loc3 == _loc9.index ? (0) : (_loc9.index + 1)];
            if (_loc11 == undefined)
            {
                _loc11 = new Array({data: _loc9, depth: 0});
                _loc6[_loc3 == _loc9.index ? (0) : (_loc9.index + 1)] = _loc11;
            } // end if
            var _loc12 = _loc11[_loc10.index];
            if (_loc12 == undefined)
            {
                _loc12 = new Array({data: _loc10, depth: 1, sortField: -1});
                _loc11[_loc10.index] = _loc12;
            } // end if
            _loc12.push({data: _loc8, depth: 2, sortField: _loc9.value});
        } // end of for...in
        var _loc13 = new ank.utils.ExtendedArray();
        var _loc14 = 0;
        
        while (++_loc14, _loc14 < _loc6.length)
        {
            if (_loc6[_loc14] == undefined)
            {
                continue;
            } // end if
            var _loc15 = new ank.utils.ExtendedArray();
            var _loc16 = 0;
            
            while (++_loc16, _loc16 < _loc6[_loc14].length)
            {
                if (_loc6[_loc14][_loc16] == undefined)
                {
                    continue;
                } // end if
                _loc6[_loc14][_loc16].sortOn("sortField", Array.NUMERIC);
                _loc15 = _loc15.concat(_loc6[_loc14][_loc16]);
            } // end while
            _loc13 = _loc13.concat(_loc15);
        } // end while
        this._lstTree.dataProvider = _loc13;
        if (_loc4 != undefined)
        {
            var _loc17 = -1;
            for (var k in _loc13)
            {
                var _loc18 = _loc13[k].data;
                if (_loc18 instanceof dofus.datacenter.Specialization)
                {
                    if (_loc18.index == _loc4)
                    {
                        _loc17 = Number(k);
                        break;
                    } // end if
                } // end if
            } // end of for...in
            this._lstTree.selectedIndex = _loc17;
        } // end if
    };
    _loc1.itemSelected = function (oEvent)
    {
        this.gapi.hideTooltip();
        if (oEvent.row.item.data instanceof dofus.datacenter.Specialization)
        {
            this.dispatchEvent({type: "specializationSelected", specialization: oEvent.row.item.data});
        }
        else if (oEvent.row.item.data instanceof dofus.datacenter.Order)
        {
            this.dispatchEvent({type: "orderSelected", order: oEvent.row.item.data});
        }
        else if (oEvent.row.item.data instanceof dofus.datacenter.Alignment)
        {
            this.dispatchEvent({type: "alignementSelected", alignement: oEvent.row.item.data});
        }
        else
        {
            this._lstTree.selectedIndex = -1;
            this.dispatchEvent({type: "itemSelected"});
        } // end else if
    };
    _loc1.itemRollOver = function (oEvent)
    {
        var _loc3 = oEvent.target.item.data;
        if (_loc3 instanceof dofus.datacenter.Specialization)
        {
            this.gapi.showTooltip(_loc3.description, this, this.__height + 30);
        } // end if
    };
    _loc1.itemRollOut = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTree = function ()
    {
        super();
    }).CLASS_NAME = "AlignmentViewerTree";
} // end if
#endinitclip
