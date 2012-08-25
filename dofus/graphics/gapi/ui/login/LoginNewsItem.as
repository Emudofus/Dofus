// Action script...

// [Initial MovieClip Action of sprite 20827]
#initclip 92
if (!dofus.graphics.gapi.ui.login.LoginNewsItem)
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
    if (!dofus.graphics.gapi.ui.login)
    {
        _global.dofus.graphics.gapi.ui.login = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.login.LoginNewsItem = function ()
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
            this._lblDate.text = oItem.getPubDateStr(_global.API.lang.getConfigText("LONG_DATE_FORMAT"), _global.API.config.language);
            this._lblTitle.bDisplayDebug = true;
            this._lblTitle.text = oItem.getTitle();
            this._ldrImage.contentPath = oItem.getIcon();
            this._mcSeparator._visible = true;
        }
        else if (this._lblDate.text != undefined)
        {
            this._lblDate.text = "";
            this._lblTitle.text = "";
            this._ldrImage.contentPath = "";
            this._mcSeparator._visible = false;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._mcSeparator._visible = false;
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
