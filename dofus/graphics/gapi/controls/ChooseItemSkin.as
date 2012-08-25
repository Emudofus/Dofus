// Action script...

// [Initial MovieClip Action of sprite 20663]
#initclip 184
if (!dofus.graphics.gapi.controls.ChooseItemSkin)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.ChooseItemSkin = function ()
    {
        super();
    }).prototype;
    _loc1.__set__item = function (oItem)
    {
        this._oItem = oItem;
        //return (this.item());
    };
    _loc1.__get__selectedItem = function ()
    {
        return (this._oSelectedItem);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.ChooseItemSkin.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.addListeners = function ()
    {
        this._cgGrid.addEventListener("dblClickItem", this._parent);
        this._cgGrid.addEventListener("selectItem", this);
    };
    _loc1.initData = function ()
    {
        var _loc2 = new ank.utils.ExtendedArray();
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._oItem.maxSkin)
        {
            if (this._oItem.isAssociate)
            {
                _loc2.push(new dofus.datacenter.Item(-1, this._oItem.realUnicId, 1, 0, "", 0, _loc3, 1));
                continue;
            } // end if
            _loc2.push(new dofus.datacenter.Item(-1, this._oItem.unicID, 1, 0, "", 0, _loc3, 1));
        } // end while
        this._cgGrid.dataProvider = _loc2;
    };
    _loc1.selectItem = function (oEvent)
    {
        this._oSelectedItem = oEvent.target.contentData;
    };
    _loc1.addProperty("selectedItem", _loc1.__get__selectedItem, function ()
    {
    });
    _loc1.addProperty("item", function ()
    {
    }, _loc1.__set__item);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.ChooseItemSkin = function ()
    {
        super();
    }).CLASS_NAME = "ChooseItemSkin";
} // end if
#endinitclip
