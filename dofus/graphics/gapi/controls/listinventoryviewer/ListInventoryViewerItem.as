// Action script...

// [Initial MovieClip Action of sprite 20955]
#initclip 220
if (!dofus.graphics.gapi.controls.listinventoryviewer.ListInventoryViewerItem)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.listinventoryviewer.ListInventoryViewerItem = function ()
    {
        super();
    }).prototype;
    _loc1.__set__list = function (mcList)
    {
        this._mcList = mcList;
        //return (this.list());
    };
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._lblPrice.text = bUsed ? (new ank.utils.ExtendedString(oItem.price).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3)) : ("");
            var _loc5 = this._lblPrice.textWidth;
            this._lblName.text = bUsed ? ((oItem.Quantity > 1 ? ("x" + oItem.Quantity + " ") : ("")) + oItem.name) : ("");
            this._lblName.setSize(this.__width - _loc5 - 30, this.__height);
            this._lblName.styleName = oItem.style == "" ? ("BrownLeftSmallLabel") : (oItem.style + "LeftSmallLabel");
            this._ldrIcon.contentPath = bUsed ? (oItem.iconFile) : ("");
            this._ldrIcon.contentParams = oItem.params;
        }
        else if (this._lblPrice.text != undefined)
        {
            this._lblPrice.text = "";
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
        this._lblName.setSize(this.__width - 50, this.__height);
        this._lblPrice.setSize(this.__width - 20, this.__height);
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
