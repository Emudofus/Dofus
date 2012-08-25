// Action script...

// [Initial MovieClip Action of sprite 20989]
#initclip 254
if (!dofus.graphics.gapi.ui.ChallengeMenu)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.ChallengeMenu = function ()
    {
        super();
    }).prototype;
    _loc1.__set__labelReady = function (sLabelReady)
    {
        this._sLabelReady = sLabelReady;
        //return (this.labelReady());
    };
    _loc1.__set__labelCancel = function (sLabelCancel)
    {
        this._sLabelCancel = sLabelCancel;
        //return (this.labelCancel());
    };
    _loc1.__set__cancelButton = function (bCancelButton)
    {
        this._bCancelButton = bCancelButton;
        this._btnCancel._visible = bCancelButton;
        this._lblCancel._visible = bCancelButton;
        if (!bCancelButton)
        {
            this._mcBackground._x = this._mcBackground._x + dofus.graphics.gapi.ui.ChallengeMenu.X_OFFSET;
            this._btnReady._x = this._btnReady._x + dofus.graphics.gapi.ui.ChallengeMenu.X_OFFSET;
            this._lblReady._x = this._lblReady._x + dofus.graphics.gapi.ui.ChallengeMenu.X_OFFSET;
            this._mcTick._x = this._mcTick._x + dofus.graphics.gapi.ui.ChallengeMenu.X_OFFSET;
        } // end if
        //return (this.cancelButton());
    };
    _loc1.__set__ready = function (bReady)
    {
        this._bReady = bReady;
        this._mcTick._visible = bReady;
        //return (this.ready());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.ChallengeMenu.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.setLabels});
    };
    _loc1.setLabels = function ()
    {
        this._lblReady.text = this._sLabelReady;
        if (this._bCancelButton)
        {
            this._lblCancel.text = this._sLabelCancel;
        } // end if
    };
    _loc1.sendReadyState = function ()
    {
        this.api.network.Game.ready(!this._bReady);
        this.ready = !this._bReady;
    };
    _loc1.sendCancel = function ()
    {
        this.api.network.Game.leave();
    };
    _loc1.addProperty("ready", function ()
    {
    }, _loc1.__set__ready);
    _loc1.addProperty("cancelButton", function ()
    {
    }, _loc1.__set__cancelButton);
    _loc1.addProperty("labelCancel", function ()
    {
    }, _loc1.__set__labelCancel);
    _loc1.addProperty("labelReady", function ()
    {
    }, _loc1.__set__labelReady);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.ChallengeMenu = function ()
    {
        super();
    }).CLASS_NAME = "ChallengeMenu";
    (_global.dofus.graphics.gapi.ui.ChallengeMenu = function ()
    {
        super();
    }).X_OFFSET = 90;
} // end if
#endinitclip
