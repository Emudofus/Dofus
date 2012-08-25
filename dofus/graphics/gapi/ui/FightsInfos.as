// Action script...

// [Initial MovieClip Action of sprite 20977]
#initclip 242
if (!dofus.graphics.gapi.ui.FightsInfos)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.FightsInfos = function ()
    {
        super();
    }).prototype;
    _loc1.__get__fights = function ()
    {
        return (this._eaFights);
    };
    _loc1.addFightTeams = function (nFightID, eaTeam1, eaTeam2)
    {
        var _loc6 = this._eaFights.findFirstItem("id", nFightID);
        if (_loc6.index != -1)
        {
            var _loc5 = _loc6.item;
        } // end if
        _loc5.addPlayers(1, eaTeam1);
        _loc5.addPlayers(2, eaTeam2);
        this.showTeamInfos(true, this._oSelectedFight);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.FightsInfos.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this._eaFights = new ank.utils.ExtendedArray();
        this.showTeamInfos(false);
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this.api.network.Fights, method: this.api.network.Fights.getList});
        this.setMovieClipColor(this._mcSquare1, dofus.Constants.TEAMS_COLOR[0]);
        this.setMovieClipColor(this._mcSquare2, dofus.Constants.TEAMS_COLOR[1]);
    };
    _loc1.initTexts = function ()
    {
        this._btnClose2.label = this.api.lang.getText("CLOSE");
        this._btnJoin.label = this.api.lang.getText("JOIN_SMALL");
        this._winBg.title = this.api.lang.getText("CURRENT_FIGTHS");
        this._dgFights.columnsNames = [this.api.lang.getText("FIGHTERS_COUNT"), this.api.lang.getText("DURATION")];
        this._lblPlayers.text = this.api.lang.getText("FIGHTERS");
        this._txtSelectFight.text = this.api.lang.getText("SELECT_FIGHT_FOR_SPECTATOR");
        if (this._lblTeam1Level.text != undefined)
        {
            this._lblTeam1Level.text = "";
        } // end if
        if (this._lblTeam2Level.text != undefined)
        {
            this._lblTeam2Level.text = "";
        } // end if
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnClose2.addEventListener("click", this);
        this._btnJoin.addEventListener("click", this);
        this._dgFights.addEventListener("itemSelected", this);
        this._lstTeam1.addEventListener("itemSelected", this);
        this._lstTeam2.addEventListener("itemSelected", this);
    };
    _loc1.initData = function ()
    {
        this._dgFights.dataProvider = this._eaFights;
    };
    _loc1.showTeamInfos = function (bShow, oFight)
    {
        this._lblTeam1Level._visible = bShow;
        this._lblTeam2Level._visible = bShow;
        this._lstTeam1._visible = bShow;
        this._lstTeam2._visible = bShow;
        this._mcBackTeam._visible = bShow;
        this._mcSquare1._visible = bShow;
        this._mcSquare2._visible = bShow;
        this._txtSelectFight._visible = !bShow;
        this._btnJoin.enabled = bShow;
        if (bShow)
        {
            this._lblTeam1Level.text = this.api.lang.getText("LEVEL") + " " + oFight.team1Level;
            this._lblTeam2Level.text = this.api.lang.getText("LEVEL") + " " + oFight.team2Level;
            this._lstTeam1.dataProvider = oFight.team1Players;
            this._lstTeam2.dataProvider = oFight.team2Players;
        } // end if
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            case "_btnClose2":
            {
                this.callClose();
                break;
            } 
            case "_btnJoin":
            {
                this.api.network.GameActions.joinChallenge(this._oSelectedFight.id);
                this.callClose();
                break;
            } 
        } // End of switch
    };
    _loc1.itemSelected = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_dgFights":
            {
                this._oSelectedFight = oEvent.row.item;
                if (this._oSelectedFight.hasTeamPlayers)
                {
                    this.showTeamInfos(true, this._oSelectedFight);
                }
                else
                {
                    this.api.network.Fights.getDetails(this._oSelectedFight.id);
                    this.showTeamInfos(false);
                } // end else if
                break;
            } 
            default:
            {
                if (oEvent.row.item.type == "player")
                {
                    this.api.kernel.GameManager.showPlayerPopupMenu(undefined, oEvent.row.item.name);
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("fights", _loc1.__get__fights, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.FightsInfos = function ()
    {
        super();
    }).CLASS_NAME = "FightsInfos";
} // end if
#endinitclip
