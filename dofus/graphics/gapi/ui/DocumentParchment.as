// Action script...

// [Initial MovieClip Action of sprite 20901]
#initclip 166
if (!dofus.graphics.gapi.ui.DocumentParchment)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.DocumentParchment = function ()
    {
        super();
    }).prototype;
    _loc1.__set__document = function (oDoc)
    {
        this._oDoc = oDoc;
        //return (this.document());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.DocumentParchment.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.api.network.Documents.leave();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this._txtCore.wordWrap = true;
        this._txtCore.multiline = true;
        this._txtCore.embedFonts = true;
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.updateData});
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._bgHidder.addEventListener("click", this);
    };
    _loc1.updateData = function ()
    {
        this.setCssStyle(this._oDoc.getPage(0).cssFile);
        if (this._lblTitle.text == undefined)
        {
            return;
        } // end if
        if (this._oDoc.title.substr(0, 2) == "//")
        {
            this._lblTitle.text = "";
        }
        else
        {
            this._lblTitle.text = this._oDoc.title;
        } // end else if
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
        this._txtCore.styleSheet = ssStyle;
        this._txtCore.htmlText = this._oDoc.getPage(0).text;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_bgHidder":
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
        } // End of switch
    };
    _loc1.onHref = function (sParams)
    {
        var _loc3 = sParams.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = _loc3[1].split(";");
        if (!_global.isNaN(_loc4))
        {
            this.api.network.GameActions.sendActions(_loc4, _loc5);
            this.api.network.Documents.leave();
        } // end if
    };
    _loc1.addProperty("document", function ()
    {
    }, _loc1.__set__document);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.DocumentParchment = function ()
    {
        super();
    }).CLASS_NAME = "DocumentParchment";
} // end if
#endinitclip
