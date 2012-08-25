// Action script...

// [Initial MovieClip Action of sprite 20939]
#initclip 204
if (!dofus.graphics.gapi.ui.TitleDisplayer)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.TitleDisplayer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__title = function (sTitle)
    {
        this._sTitle = sTitle;
        //return (this.title());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.TitleDisplayer.CLASS_NAME);
        this._txtYouHaveWon.text = "";
        this._txtTitle.text = "";
    };
    _loc1.createChildren = function ()
    {
        this._txtYouHaveWon._alpha = this._txtTitle._alpha = 0;
        this.addToQueue({object: this, method: this.initText});
    };
    _loc1.initText = function ()
    {
        this._txtTitle.text = this._sTitle;
        this._txtYouHaveWon.text = this.api.lang.getText("TITLE_WON");
    };
    _loc1.addProperty("title", function ()
    {
    }, _loc1.__set__title);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.TitleDisplayer = function ()
    {
        super();
    }).CLASS_NAME = "TitleDisplayer";
} // end if
#endinitclip
