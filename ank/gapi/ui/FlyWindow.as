// Action script...

// [Initial MovieClip Action of sprite 20516]
#initclip 37
if (!ank.gapi.ui.FlyWindow)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.gapi)
    {
        _global.ank.gapi = new Object();
    } // end if
    if (!ank.gapi.ui)
    {
        _global.ank.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.ui.FlyWindow = function ()
    {
        super();
    }).prototype;
    _loc1.__set__title = function (sTitle)
    {
        this.addToQueue({object: this, method: function ()
        {
            this._winBackground.title = sTitle;
        }});
        //return (this.title());
    };
    _loc1.__get__title = function ()
    {
        return (this._winBackground.title);
    };
    _loc1.__set__contentPath = function (sContentPath)
    {
        this.addToQueue({object: this, method: function ()
        {
            this._winBackground.contentPath = sContentPath;
        }});
        //return (this.contentPath());
    };
    _loc1.__get__contentPath = function ()
    {
        return (this._winBackground.contentPath);
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.ui.FlyWindow.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._winBackground.addEventListener("complete", this);
    };
    _loc1.complete = function (oEvent)
    {
        this.addToQueue({object: this, method: this.initWindowContent});
    };
    _loc1.addProperty("title", _loc1.__get__title, _loc1.__set__title);
    _loc1.addProperty("contentPath", _loc1.__get__contentPath, _loc1.__set__contentPath);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.ui.FlyWindow = function ()
    {
        super();
    }).CLASS_NAME = "FlyWindow";
} // end if
#endinitclip
