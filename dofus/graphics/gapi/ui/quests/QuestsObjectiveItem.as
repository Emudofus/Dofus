// Action script...

// [Initial MovieClip Action of sprite 20994]
#initclip 3
if (!dofus.graphics.gapi.ui.quests.QuestsObjectiveItem)
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
    if (!dofus.graphics.gapi.ui.quests)
    {
        _global.dofus.graphics.gapi.ui.quests = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.quests.QuestsObjectiveItem = function ()
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
            this._txtDescription.text = oItem.description;
            this._txtDescription.styleName = oItem.isFinished ? ("GreyLeftSmallTextArea") : ("BrownLeftSmallTextArea");
            this._mcCheckFinished._visible = oItem.isFinished;
            this._mcCompass._visible = oItem.x != undefined && oItem.y != undefined && !oItem.isFinished;
        }
        else if (this._txtDescription.text != undefined)
        {
            this._txtDescription.text = "";
            this._mcCheckFinished._visible = false;
            this._mcCompass._visible = false;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._mcCheckFinished._visible = false;
        this._mcCompass._visible = false;
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
