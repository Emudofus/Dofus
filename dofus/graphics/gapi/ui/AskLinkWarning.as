// Action script...

// [Initial MovieClip Action of sprite 20557]
#initclip 78
if (!dofus.graphics.gapi.ui.AskLinkWarning)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.AskLinkWarning = function ()
    {
        super();
    }).prototype;
    _loc1.__set__text = function (sText)
    {
        this._sText = sText;
        //return (this.text());
    };
    _loc1.__get__text = function ()
    {
        return (this._sText);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.AskLinkWarning.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.addListeners = function ()
    {
        this._btnOk.addEventListener("click", this);
    };
    _loc1.initTexts = function ()
    {
        this._btnOk.label = this.api.lang.getText("OK");
        this._winBackground.title = this.api.lang.getText("CAUTION");
        this._txtText.text = this._sText;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnOk":
            {
                this.dispatchEvent({type: "ok", params: this.params});
                break;
            } 
        } // End of switch
        this.unloadThis();
    };
    _loc1.addProperty("text", _loc1.__get__text, _loc1.__set__text);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.AskLinkWarning = function ()
    {
        super();
    }).CLASS_NAME = "AskLinkWarning";
} // end if
#endinitclip
