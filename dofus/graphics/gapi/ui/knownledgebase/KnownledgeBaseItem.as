// Action script...

// [Initial MovieClip Action of sprite 20788]
#initclip 53
if (!dofus.graphics.gapi.ui.knownledgebase.KnownledgeBaseItem)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.knownledgebase.KnownledgeBaseItem = function ()
    {
        super();
    }).prototype;
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._lblItem.text = oItem.n;
            var _loc5 = oItem.c == undefined;
            this._mcCategory._visible = _loc5;
            this._mcArticle._visible = !_loc5;
            if (!_loc5 && !this._bWasArticle)
            {
                this._lblItem._x = this._lblItem._x + 10;
                this._mcArticle._x = this._mcArticle._x + 10;
                this._bWasArticle = true;
            } // end if
        }
        else if (this._lblItem.text != undefined)
        {
            this._lblItem.text = "";
            this._mcArticle._visible = false;
            this._mcCategory._visible = false;
            if (this._bWasArticle)
            {
                this._lblItem._x = this._lblItem._x - 10;
                this._mcArticle._x = this._mcArticle._x - 10;
                this._bWasArticle = false;
            } // end if
        } // end else if
    };
    _loc1.KnownledgeBaseCategoryItem = function ()
    {
        this._mcArticle._visible = false;
        this._mcCategory._visible = false;
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
