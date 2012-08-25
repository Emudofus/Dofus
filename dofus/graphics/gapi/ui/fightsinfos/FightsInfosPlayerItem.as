// Action script...

// [Initial MovieClip Action of sprite 20951]
#initclip 216
if (!dofus.graphics.gapi.ui.fightsinfos.FightsInfosPlayerItem)
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
    if (!dofus.graphics.gapi.ui.fightsinfos)
    {
        _global.dofus.graphics.gapi.ui.fightsinfos = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.fightsinfos.FightsInfosPlayerItem = function ()
    {
        super();
    }).prototype;
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._lblName.text = oItem.name;
            this._lblLevel.text = oItem.level;
        }
        else if (this._lblName.text != undefined)
        {
            this._lblName.text = "";
            this._lblLevel.text = "";
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
