// Action script...

// [Initial MovieClip Action of sprite 20594]
#initclip 115
if (!dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTreeItem)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTreeItem = function ()
    {
        super();
    }).prototype;
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            var _loc5 = dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTreeItem.DEPTH_X_OFFSET * oItem.depth;
            if (oItem.data instanceof dofus.datacenter.Alignment)
            {
                this._ldrIcon._x = this._nLdrX + _loc5;
                this._lblName._x = this._nLdrX + _loc5;
                this._lblName.width = this.__width - this._lblName._x;
                this._lblName.styleName = "BrownLeftMediumBoldLabel";
                this._mcBackgroundLight._visible = false;
                this._mcBackgroundDark._visible = true;
                this._ldrIcon.contentPath = "";
                this._lblName.text = oItem.data.name;
                this._lblLevel.text = "";
            } // end if
            if (oItem.data instanceof dofus.datacenter.Order)
            {
                this._ldrIcon._x = this._nLdrX + _loc5;
                this._lblName._x = this._nLblX + _loc5;
                this._lblName.width = this.__width - this._lblName._x;
                this._lblName.styleName = "BrownLeftSmallBoldLabel";
                this._mcBackgroundLight._visible = false;
                this._mcBackgroundDark._visible = false;
                this._ldrIcon.contentPath = oItem.data.iconFile;
                this._lblName.text = oItem.data.name;
                this._lblLevel.text = "";
            }
            else if (oItem.data instanceof dofus.datacenter.Specialization)
            {
                this._ldrIcon._x = this._nLdrX + _loc5;
                this._lblName._x = this._nLblX + _loc5;
                this._lblName.width = this.__width - this._lblName._x;
                this._lblName.styleName = "BrownLeftSmallLabel";
                this._mcBackgroundLight._visible = false;
                this._mcBackgroundDark._visible = false;
                this._ldrIcon.contentPath = "";
                this._lblLevel.text = oItem.data.alignment.value > 0 ? (oItem.data.alignment.value + " ") : ("- ");
                this._lblName.text = oItem.data.name;
                this._lblLevel.setSize(this.__width);
                this._lblName.setSize(this.__width - this._lblName._x - this._lblLevel.textWidth - 30);
            } // end else if
        }
        else if (this._lblName.text != undefined)
        {
            this._ldrIcon._x = this._nLdrX;
            this._lblName._x = this._nLblX;
            this._ldrIcon.contentPath = "";
            this._lblName.text = "";
            this._lblLevel.text = "";
            this._mcBackgroundLight._visible = false;
            this._mcBackgroundDark._visible = false;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._nLdrX = this._ldrIcon._x;
        this._nLblX = this._lblName._x;
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTreeItem = function ()
    {
        super();
    }).DEPTH_X_OFFSET = 10;
} // end if
#endinitclip
