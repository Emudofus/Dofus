// Action script...

// [Initial MovieClip Action of sprite 20493]
#initclip 14
if (!dofus.graphics.gapi.ui.BuffInfos)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.BuffInfos = function ()
    {
        super();
    }).prototype;
    _loc1.__set__data = function (oData)
    {
        this._oData = oData;
        if (this.initialized)
        {
            this.updateData();
        } // end if
        //return (this.data());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.BuffInfos.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.updateData});
    };
    _loc1.initTexts = function ()
    {
        this._btnClose2.label = this.api.lang.getText("CLOSE");
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnClose2.addEventListener("click", this);
    };
    _loc1.updateData = function ()
    {
        this._bvBuffViewer.itemData = this._oData;
    };
    _loc1.click = function (oEvent)
    {
        this.callClose();
    };
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.BuffInfos = function ()
    {
        super();
    }).CLASS_NAME = "BuffInfos";
} // end if
#endinitclip
