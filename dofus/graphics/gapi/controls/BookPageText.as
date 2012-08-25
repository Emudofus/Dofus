// Action script...

// [Initial MovieClip Action of sprite 20781]
#initclip 46
if (!dofus.graphics.gapi.controls.BookPageText)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.BookPageText = function ()
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
        super.init(false, dofus.graphics.gapi.controls.BookPageText.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this._txtPage.wordWrap = true;
        this._txtPage.multiline = true;
        this._txtPage.embedFonts = true;
        this.addToQueue({object: this, method: this.updateData});
    };
    _loc1.updateData = function ()
    {
        this.setCssStyle(this._oPage.cssFile);
    };
    _loc1.setCssStyle = function (sCssFile)
    {
        var _loc3 = new TextField.StyleSheet();
        _loc3.owner = this;
        _loc3.onLoad = function ()
        {
            this.owner.layoutContent(this);
        };
        _loc3.load(sCssFile);
    };
    _loc1.layoutContent = function (ssStyle)
    {
        this._txtPage.styleSheet = ssStyle;
        this._txtPage.htmlText = this._oPage.text;
    };
    _loc1.addProperty("page", function ()
    {
    }, _loc1.__set__page);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.BookPageText = function ()
    {
        super();
    }).CLASS_NAME = "BookPageText";
} // end if
#endinitclip
