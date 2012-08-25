// Action script...

// [Initial MovieClip Action of sprite 20982]
#initclip 247
if (!dofus.graphics.gapi.controls.guildhousesviewer.GuildHousesViewerHouses)
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
    if (!dofus.graphics.gapi.controls.guildhousesviewer)
    {
        _global.dofus.graphics.gapi.controls.guildhousesviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.guildhousesviewer.GuildHousesViewerHouses = function ()
    {
        super();
        this._mcIcon._visible = false;
    }).prototype;
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._oItem = (dofus.datacenter.House)(oItem);
            this._lblName.text = this._oItem.name;
            this._lblOwner.text = this._oItem.ownerName;
            this._mcIcon._visible = true;
        }
        else if (this._lblName.text != undefined)
        {
            this._lblName.text = "";
            this._lblOwner.text = "";
            this._mcIcon._visible = false;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
