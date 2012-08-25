// Action script...

// [Initial MovieClip Action of sprite 20536]
#initclip 57
if (!dofus.graphics.gapi.ui.AskCancel)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.AskCancel = function ()
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
    _loc1.initWindowContent = function ()
    {
        var _loc2 = this._winBackground.content;
        _loc2._txtText.text = this._sText;
        _loc2._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
        _loc2._btnCancel.addEventListener("click", this);
        _loc2._txtText.addEventListener("change", this);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnCancel":
            {
                this.dispatchEvent({type: "cancel", params: this.params});
                break;
            } 
        } // End of switch
        this.unloadThis();
    };
    _loc1.change = function (oEvent)
    {
        var _loc3 = this._winBackground.content;
        _loc3._btnCancel._y = _loc3._txtText._y + _loc3._txtText.height + 20;
        this._winBackground.setPreferedSize();
    };
    _loc1.addProperty("text", _loc1.__get__text, _loc1.__set__text);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.AskCancel = function ()
    {
        super();
    }).CLASS_NAME = "AskCancel";
} // end if
#endinitclip
