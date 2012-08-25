// Action script...

// [Initial MovieClip Action of sprite 20886]
#initclip 151
if (!dofus.graphics.gapi.ui.GameOver)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.GameOver = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.GameOver.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initBg});
        this.addToQueue({object: this, method: this.initLol});
    };
    _loc1.initTexts = function ()
    {
        this._lblReplay.text = this.api.lang.getText("REPLAY_WORD");
    };
    _loc1.addListeners = function ()
    {
        var ref = this;
        this._btnReplay.onRelease = function ()
        {
            ref.api.kernel.changeServer(true);
        };
    };
    _loc1.initBg = function ()
    {
        this._ldrIllu.contentPath = dofus.Constants.ILLU_PATH + "gameover.swf";
    };
    _loc1.initLol = function ()
    {
        this._mcLol._visible = Math.floor(Math.random() * 500) == 100;
        if (this._mcLol._visible)
        {
            this._mcLol._x = this._mcPlacer._x;
            this._mcLol._y = this._mcPlacer._y;
        } // end if
    };
    _loc1.click = function (oEvent)
    {
        this.callClose();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.GameOver = function ()
    {
        super();
    }).CLASS_NAME = "GameOver";
} // end if
#endinitclip
