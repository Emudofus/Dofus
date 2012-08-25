// Action script...

// [Initial MovieClip Action of sprite 20501]
#initclip 22
if (!dofus.graphics.gapi.controls.BookPageTitle)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.BookPageTitle = function ()
    {
        super();
    }).prototype;
    _loc1.__set__page = function (oPage)
    {
        this._oPage = oPage;
        if (this.initialized)
        {
            this.updateData();
        } // end if
        //return (this.page());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.BookPageTitle.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.updateData});
    };
    _loc1.updateData = function ()
    {
        this._txtTitle.text = this._oPage.title == undefined ? ("") : (this._oPage.title);
        this._lblSubTitle.text = this._oPage.subtitle == undefined ? ("") : (this._oPage.subtitle);
        this._lblAuthor.text = this._oPage.author == undefined ? ("") : (this._oPage.author);
    };
    _loc1.addProperty("page", function ()
    {
    }, _loc1.__set__page);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.BookPageTitle = function ()
    {
        super();
    }).CLASS_NAME = "BookPageTitle";
} // end if
#endinitclip
