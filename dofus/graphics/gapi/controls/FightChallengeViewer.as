// Action script...

// [Initial MovieClip Action of sprite 20894]
#initclip 159
if (!dofus.graphics.gapi.controls.FightChallengeViewer)
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
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.FightChallengeViewer = function ()
    {
        super();
    }).prototype;
    _loc1.update = function ()
    {
        this._mcState.gotoAndStop(this.challenge.state + 1);
    };
    _loc1.createChildren = function ()
    {
        this._btnView._visible = this.challenge.showTarget;
        this.update();
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initText});
    };
    _loc1.initText = function ()
    {
        var _loc2 = (dofus.utils.Api)(this.api);
        var _loc3 = _loc2.lang.getFightChallenge(this.challenge.id);
        this._winBg.title = _loc2.lang.getText("CURRENT_FIGHT_CHALLENGE");
        if (this.challenge.targetId)
        {
            var _loc4 = _loc2.datacenter.Sprites.getItemAt(this.challenge.targetId).name + " (" + _loc2.lang.getText("LEVEL_SMALL") + " " + _loc2.datacenter.Sprites.getItemAt(this.challenge.targetId).mc.data.Level + ")";
            this._taDesc.text = _loc3.d.split("%1").join(_loc4);
        }
        else
        {
            this._taDesc.text = _loc3.d;
        } // end else if
        this._lblTitleDrop.text = _loc2.lang.getText("LOOT");
        this._lblTitleXp.text = _loc2.lang.getText("WORD_XP");
        this._lblTitle.text = _loc3.n;
        this._lblBonusDrop.text = "+" + (this.challenge.teamDropBonus + this.challenge.basicDropBonus) + "%";
        this._lblBonusXp.text = "+" + (this.challenge.teamXpBonus + this.challenge.basicXpBonus) + "%";
    };
    _loc1.addListeners = function ()
    {
        this._lblTitle.addEventListener("change", this);
        this._btnClose.addEventListener("click", this);
        this._btnView.addEventListener("click", this);
        this._btnView.onRelease = this.virtualEvent(this, "click", this._btnView);
        this._btnView.onRollOver = this.virtualEvent(this, "over", this._btnView);
        this._btnView.onRollOut = this.virtualEvent(this, "out", this._btnView);
        this._mcState.onRollOver = this.virtualEvent(this, "over", this._mcState);
        this._mcState.onRollOut = this.virtualEvent(this, "out", this._mcState);
        this._lblBonusDrop.onRollOver = this.virtualEvent(this, "over", this._lblBonusDrop);
        this._lblBonusDrop.onRollOut = this.virtualEvent(this, "out", this._lblBonusDrop);
        this._lblTitleDrop.onRollOver = this.virtualEvent(this, "over", this._lblTitleDrop);
        this._lblTitleDrop.onRollOut = this.virtualEvent(this, "out", this._lblTitleDrop);
        this._lblBonusXp.onRollOver = this.virtualEvent(this, "over", this._lblBonusXp);
        this._lblBonusXp.onRollOut = this.virtualEvent(this, "out", this._lblBonusXp);
        this._lblTitleXp.onRollOver = this.virtualEvent(this, "over", this._lblTitleXp);
        this._lblTitleXp.onRollOut = this.virtualEvent(this, "out", this._lblTitleXp);
        this._taDesc.addEventListener("resize", this);
    };
    _loc1.virtualEvent = function (context, callback, target)
    {
        return (function ()
        {
            context[callback]({target: target});
        });
    };
    _loc1.click = function (e)
    {
        switch (e.target)
        {
            case this._btnClose:
            {
                this.unloadMovie();
                break;
            } 
            case this._btnView:
            {
                if (getTimer() - this._lastShowAsk >= 1000)
                {
                    this.unloadMovie();
                    (dofus.utils.Api)(this.api).network.Game.showFightChallengeTarget(this.challenge.id);
                    this._lastShowAsk = getTimer();
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (e)
    {
        switch (e.target)
        {
            case this._btnView:
            {
                this.gapi.showTooltip(this.api.lang.getText("VIEW_CHALENGE_TARGET"), e.target, 40);
                break;
            } 
            case this._lblBonusXp:
            case this._lblTitleXp:
            {
                this.gapi.showTooltip(this.api.lang.getText("BASIC_BONUS") + " : " + this.challenge.basicXpBonus + "%\n" + this.api.lang.getText("GROUP_BONUS") + " : " + this.challenge.teamXpBonus + "%", e.target, 40);
                break;
            } 
            case this._lblBonusDrop:
            case this._lblTitleDrop:
            {
                this.gapi.showTooltip(this.api.lang.getText("BASIC_BONUS") + " : " + this.challenge.basicDropBonus + "%\n" + this.api.lang.getText("GROUP_BONUS") + " : " + this.challenge.teamDropBonus + "%", e.target, 40);
                break;
            } 
            case this._mcState:
            {
                if (this.challenge.state !== 0)
                {
                    break;
                } // end if
                this.gapi.showTooltip(this.api.lang.getText("CURRENT_FIGHT_CHALLENGE"), e.target, 40);
                break;
                this.gapi.showTooltip(this.api.lang.getText("FIGHT_CHALLENGE_DONE"), e.target, 40);
                break;
                this.gapi.showTooltip(this.api.lang.getText("FIGHT_CHALLENGE_FAILED"), e.target, 40);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (e)
    {
        this.gapi.hideTooltip();
    };
    _loc1.change = function (e)
    {
        this._lblTitle._y = this._lblTitle._y + (this._lblTitle.height - this._lblTitle.textHeight) / 2;
    };
    ASSetPropFlags(_loc1, null, 1);
    _loc1._lastShowAsk = 0;
} // end if
#endinitclip
