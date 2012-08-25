// Action script...

// [Initial MovieClip Action of sprite 20507]
#initclip 28
if (!dofus.graphics.gapi.ui.WaitingMessage)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.WaitingMessage = function ()
    {
        super();
    }).prototype;
    _loc1.__set__text = function (sText)
    {
        this._sText = sText;
        //return (this.text());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.WaitingMessage.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        if (this._sText.length == 0)
        {
            return;
        } // end if
        this.addToQueue({object: this, method: this.initText});
    };
    _loc1.initText = function ()
    {
        this._lblWhite.text = this._lblBlackTL.text = this._lblBlackTR.text = this._lblBlackBL.text = this._lblBlackBR.text = this._sText;
    };
    _loc1.addProperty("text", function ()
    {
    }, _loc1.__set__text);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.WaitingMessage = function ()
    {
        super();
    }).CLASS_NAME = "WaitingMessage";
    _loc1._sText = "";
} // end if
#endinitclip
