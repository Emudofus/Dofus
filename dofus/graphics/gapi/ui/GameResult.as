// Action script...

// [Initial MovieClip Action of sprite 20645]
#initclip 166
if (!dofus.graphics.gapi.ui.GameResult)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.GameResult = function ()
    {
        super();
    }).prototype;
    _loc1.__set__data = function (oData)
    {
        this._oData = oData;
        //return (this.data());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.GameResult.CLASS_NAME);
        this._lblBonus._visible = false;
        this._sdStars._visible = false;
        this._lblChallenges._visible = false;
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.gapi.unloadLastUIAutoHideComponent();
    };
    _loc1.initTexts = function ()
    {
        this._winBackground.title = this.api.lang.getText("GAME_RESULTS");
        this._lblDuration.text = this.api.kernel.GameManager.getDurationString(this._oData.duration, true);
        if (this.api.datacenter.Basics.aks_game_end_bonus != undefined && this.api.datacenter.Basics.aks_game_end_bonus > 0)
        {
            this._lblBonus._visible = true;
            this._sdStars._visible = true;
            this._lblBonus.text = this.api.lang.getText("GAME_RESULTS_BONUS") + " :";
            this._sdStars.value = this.api.datacenter.Basics.aks_game_end_bonus;
            this.api.datacenter.Basics.aks_game_end_bonus = -1;
        } // end if
        if (this._oData.challenges && this._oData.challenges.length)
        {
            this._lblChallenges._visible = true;
            this._lblChallenges.text = this.api.lang.getText("FIGHT_CHALLENGE_BONUS") + " :";
        } // end if
        this._btnClose.label = this.api.lang.getText("CLOSE");
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._sdStars.addEventListener("over", this);
        this._sdStars.addEventListener("out", this);
    };
    _loc1.initData = function ()
    {
        var _loc2 = this._oData.winners.length;
        var _loc3 = this._oData.loosers.length;
        var _loc4 = this._oData.collectors.length;
        var _loc5 = _loc2 + _loc3 + _loc4;
        var _loc6 = Math.min(_loc2, dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 65 + Math.min(_loc3, dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 65;
        if (_loc4 > 0)
        {
            _loc6 = _loc6 + (Math.min(_loc4, dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 65);
        } // end if
        var _loc7 = _loc6 + 32;
        var _loc8 = ((_loc5 > dofus.graphics.gapi.ui.GameResult.MAX_PLAYERS ? (550) : (this.gapi.screenHeight)) - _loc7) / 2;
        var _loc9 = this._winBackground._x + 10;
        var _loc10 = _loc8 + 32;
        var _loc11 = Math.min(_loc2, dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 55 + _loc10;
        var _loc12 = Math.min(_loc3, dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 55 + _loc11;
        switch (this._oData.fightType)
        {
            case 0:
            {
                var _loc13 = "UI_GameResultTeam";
                break;
            } 
            case 1:
            {
                _loc13 = "UI_GameResultTeamPVP";
                break;
            } 
        } // End of switch
        this.attachMovie(_loc13, "_tWinners", 10, {dataProvider: this._oData.winners, title: this.api.lang.getText("WINNERS"), _x: _loc9, _y: _loc10});
        this.attachMovie(_loc13, "_tLoosers", 20, {dataProvider: this._oData.loosers, title: this.api.lang.getText("LOOSERS"), _x: _loc9, _y: _loc11});
        if (_loc4 > 0)
        {
            this.attachMovie(_loc13, "_tCollectors", 30, {dataProvider: this._oData.collectors, title: this.api.lang.getText("GUILD_TAXCOLLECTORS"), _x: _loc9, _y: _loc12});
        } // end if
        this._winBackground._y = _loc8;
        this._winBackground.setSize(undefined, _loc7);
        this._lblDuration._y = _loc8 + 5;
        this._btnClose._y = this._winBackground._y + this._winBackground._height;
        this._lblBonus._y = this._winBackground._y + 25;
        this._sdStars._y = this._winBackground._y + 30;
        if (this._oData.challenges && this._oData.challenges.length)
        {
            this._lblChallenges._y = this._lblBonus._y + 17;
            this._mcChallengesPlacer._y = this._lblBonus._y + 18;
            var _loc15 = 0;
            
            while (++_loc15, _loc15 < this._oData.challenges.length)
            {
                var _loc14 = (dofus.graphics.gapi.controls.FightChallengeIcon)(this.attachMovie("FightChallengeIcon", "fci" + _loc15, this.getNextHighestDepth(), {challenge: this._oData.challenges[_loc15], displayUiOnClick: false}));
                _loc14._width = _loc14._height = 17;
                _loc14._x = _loc15 * (_loc14._width + 5) + this._mcChallengesPlacer._x;
                _loc14._y = this._mcChallengesPlacer._y;
            } // end while
        } // end if
    };
    _loc1.click = function (oEvent)
    {
        this.callClose();
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._sdStars:
            {
                this.gapi.showTooltip(this.api.lang.getText("GAME_RESULTS_BONUS_TOOLTIP", [this._sdStars.value]), this._sdStars, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.GameResult = function ()
    {
        super();
    }).CLASS_NAME = "GameResult";
    (_global.dofus.graphics.gapi.ui.GameResult = function ()
    {
        super();
    }).MAX_PLAYERS = 11;
    (_global.dofus.graphics.gapi.ui.GameResult = function ()
    {
        super();
    }).MAX_VISIBLE_PLAYERS_IN_TEAM = 6;
} // end if
#endinitclip
