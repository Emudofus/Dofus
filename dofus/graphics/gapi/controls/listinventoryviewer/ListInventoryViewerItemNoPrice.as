// Action script...

// [Initial MovieClip Action of sprite 20656]
#initclip 177
if (!dofus.graphics.gapi.controls.listinventoryviewer.ListInventoryViewerItemNoPrice)
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
    if (!dofus.graphics.gapi.controls.listinventoryviewer)
    {
        _global.dofus.graphics.gapi.controls.listinventoryviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.listinventoryviewer.ListInventoryViewerItemNoPrice = function ()
    {
        super();
    }).prototype;
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._lblName.text = bUsed ? ((oItem.Quantity > 1 ? ("x" + oItem.Quantity + " ") : ("")) + oItem.name) : ("");
            this._ldrIcon.contentPath = bUsed ? (oItem.iconFile) : ("");
            this._ldrIcon.contentParams = oItem.params;
            this._lblName.styleName = oItem.style == "" ? ("BrownLeftSmallLabel") : (oItem.style + "LeftSmallLabel");
        }
        else if (this._lblName.text != undefined)
        {
            this._lblName.text = "";
            this._ldrIcon.contentPath = "";
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    _loc1.createChildren = function ()
    {
        this.arrange();
    };
    _loc1.size = function ()
    {
        super.size();
        this.addToQueue({object: this, method: this.arrange});
    };
    _loc1.arrange = function ()
    {
        this._lblName.setSize(this.__width - 20, this.__height);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
