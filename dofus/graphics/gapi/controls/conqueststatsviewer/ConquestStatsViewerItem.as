// Action script...

// [Initial MovieClip Action of sprite 20826]
#initclip 91
if (!dofus.graphics.gapi.controls.conqueststatsviewer.ConquestStatsViewerItem)
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
    if (!dofus.graphics.gapi.controls.conqueststatsviewer)
    {
        _global.dofus.graphics.gapi.controls.conqueststatsviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.conqueststatsviewer.ConquestStatsViewerItem = function ()
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
            this._oItem = oItem;
            this._lblType.text = this._oItem.type;
            this._lblBonus.text = this._oItem.bonus;
            this._lblMalus.text = this._oItem.malus;
        }
        else if (this._lblType.text != undefined)
        {
            this._lblType.text = "";
            this._lblBonus.text = "";
            this._lblMalus.text = "";
        } // end else if
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
