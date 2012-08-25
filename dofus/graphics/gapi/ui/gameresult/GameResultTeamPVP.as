// Action script...

// [Initial MovieClip Action of sprite 20919]
#initclip 184
if (!dofus.graphics.gapi.ui.gameresult.GameResultTeamPVP)
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
    if (!dofus.graphics.gapi.ui.gameresult)
    {
        _global.dofus.graphics.gapi.ui.gameresult = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.gameresult.GameResultTeamPVP = function ()
    {
        super();
    }).prototype;
    _loc1.__set__title = function (sTitle)
    {
        this._sTitle = sTitle;
        //return (this.title());
    };
    _loc1.__set__dataProvider = function (eaDataProvider)
    {
        this._eaDataProvider = eaDataProvider;
        //return (this.dataProvider());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.gameresult.GameResultTeamPVP.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.initData});
        this._lstPlayers._visible = false;
    };
    _loc1.addListeners = function ()
    {
    };
    _loc1.initTexts = function ()
    {
        this._lblWinLoose.text = this._sTitle;
        this._lblName.text = this.api.lang.getText("NAME_BIG");
        this._lblLevel.text = this.api.lang.getText("LEVEL_SMALL");
        this._lblKama.text = this.api.lang.getText("KAMAS");
        this._lblHonour.text = this.api.lang.getText("HONOUR_POINTS");
        this._lblRank.text = this.api.lang.getText("RANK");
        this._lblItems.text = this.api.lang.getText("WIN_ITEMS");
        if (!this.api.datacenter.Basics.aks_current_server.isHardcore())
        {
            this._lblDisgrace.text = this.api.lang.getText("DISGRACE_POINTS");
        }
        else
        {
            this._lblDisgrace.text = this.api.lang.getText("WIN_XP");
        } // end else if
    };
    _loc1.initData = function ()
    {
        if (this.api.datacenter.Basics.aks_current_server.isHardcore())
        {
            this._lstPlayers.cellRenderer = "GameResultPlayerPVPNoHonour";
        }
        else
        {
            this._lstPlayers.cellRenderer = "GameResultPlayerPVP";
        } // end else if
        var _loc2 = this._eaDataProvider.length;
        this._lstPlayers.dataProvider = this._eaDataProvider;
        this._lstPlayers.setSize(undefined, Math.min(_loc2, dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * this._lstPlayers.rowHeight);
        this._lstPlayers._visible = true;
    };
    _loc1.itemRollOver = function (oEvent)
    {
    };
    _loc1.itemRollOut = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("dataProvider", function ()
    {
    }, _loc1.__set__dataProvider);
    _loc1.addProperty("title", function ()
    {
    }, _loc1.__set__title);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.gameresult.GameResultTeamPVP = function ()
    {
        super();
    }).CLASS_NAME = "GameResultPlayerPVPNoHonour";
} // end if
#endinitclip
