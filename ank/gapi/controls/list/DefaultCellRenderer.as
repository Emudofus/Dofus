// Action script...

// [Initial MovieClip Action of sprite 20651]
#initclip 172
if (!ank.gapi.controls.list.DefaultCellRenderer)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.gapi)
    {
        _global.ank.gapi = new Object();
    } // end if
    if (!ank.gapi.controls)
    {
        _global.ank.gapi.controls = new Object();
    } // end if
    if (!ank.gapi.controls.list)
    {
        _global.ank.gapi.controls.list = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.controls.list.DefaultCellRenderer = function ()
    {
        super();
    }).prototype;
    _loc1.setState = function (sState)
    {
    };
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._lblText.text = sSuggested;
        }
        else if (this._lblText.text != undefined)
        {
            this._lblText.text = "";
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    _loc1.createChildren = function ()
    {
        this.attachMovie("Label", "_lblText", 10, {styleName: this.getStyle().defaultstyle});
    };
    _loc1.size = function ()
    {
        super.size();
        this._lblText.setSize(this.__width, this.__height);
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        this._lblText.styleName = _loc2.defaultstyle;
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
