// Action script...

// [Initial MovieClip Action of sprite 20871]
#initclip 136
if (!dofus.graphics.gapi.controls.BuffViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.BuffViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__itemData = function (oItem)
    {
        this._oItem = oItem;
        this.addToQueue({object: this, method: this.showItemData, params: [oItem]});
        //return (this.itemData());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.BuffViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
    };
    _loc1.showItemData = function (oItem)
    {
        if (oItem != undefined)
        {
            this._lblName.text = oItem.name;
            this._txtDescription.text = oItem.description;
            this._ldrIcon.contentPath = oItem.iconFile;
            this._lstInfos.dataProvider = oItem.effects;
        }
        else if (this._lblName.text != undefined)
        {
            this._lblName.text = "";
            this._txtDescription.text = "";
            this._ldrIcon.contentPath = "";
            this._lstInfos.removeAll();
        } // end else if
    };
    _loc1.addProperty("itemData", function ()
    {
    }, _loc1.__set__itemData);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.BuffViewer = function ()
    {
        super();
    }).CLASS_NAME = "BuffViewer";
} // end if
#endinitclip
