// Action script...

// [Initial MovieClip Action of sprite 20646]
#initclip 167
if (!dofus.graphics.gapi.ui.AskGameBegin)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.AskGameBegin = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.AskGameBegin.CLASS_NAME);
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
        this._winBackground.title = this.api.lang.getText("POPUP_GAME_BEGINNING_TITLE");
        this._lblTitle.text = this.api.lang.getText("POPUP_GAME_BEGINNING_SUBTITLE");
        this._lblIncarnam.text = this.api.lang.getText("POPUP_GAME_BEGINNING_PARAGRAPH1");
        this._lblTemple.text = this.api.lang.getText("POPUP_GAME_BEGINNING_PARAGRAPH2");
        this._lblBoon.text = this.api.lang.getText("POPUP_GAME_BEGINNING_PARAGRAPH3");
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnOk":
            {
                this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_START_POPUP);
                this.dispatchEvent({type: "ok", params: this.params});
                this.unloadThis();
                break;
            } 
        } // End of switch
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.AskGameBegin = function ()
    {
        super();
    }).CLASS_NAME = "AskGameBegin";
} // end if
#endinitclip
