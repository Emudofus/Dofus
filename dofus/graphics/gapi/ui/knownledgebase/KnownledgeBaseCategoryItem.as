// Action script...

// [Initial MovieClip Action of sprite 20776]
#initclip 41
if (!dofus.graphics.gapi.ui.knownledgebase.KnownledgeBaseCategoryItem)
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
    if (!dofus.graphics.gapi.ui.knownledgebase)
    {
        _global.dofus.graphics.gapi.ui.knownledgebase = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.knownledgebase.KnownledgeBaseCategoryItem = function ()
    {
        super();
        this._mcPicto._visible = false;
    }).prototype;
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._lblCategory.text = oItem.n;
            this._mcPicto._visible = true;
        }
        else if (this._lblCategory.text != undefined)
        {
            this._lblCategory.text = "";
            this._mcPicto._visible = false;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
