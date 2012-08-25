// Action script...

// [Initial MovieClip Action of sprite 20527]
#initclip 48
if (!dofus.graphics.gapi.controls.FightChallengeIcon)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.FightChallengeIcon = function ()
    {
        super();
    }).prototype;
    _loc1.update = function ()
    {
        switch (this.challenge.state)
        {
            case 1:
            {
                this._ldrState.contentPath = "ChallengeOK";
                break;
            } 
            case 2:
            {
                this._ldrState.contentPath = "ChallengeKO";
                break;
            } 
        } // End of switch
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initCpt});
    };
    _loc1.initCpt = function ()
    {
        this._ldr.contentPath = this.challenge.iconPath;
        this.update();
    };
    _loc1.addListeners = function ()
    {
        if (this.displayUiOnClick)
        {
            this.onRelease = this.onEventRelease(this.api, this._parent, this, this.challenge);
        } // end if
        this.onRollOver = this.virtualEvent(this, "over", this);
        this.onRollOut = this.virtualEvent(this, "out", this);
    };
    _loc1.onEventRelease = function (oApi, attachTarget, placer, challenge)
    {
        return (function ()
        {
            if (attachTarget.FightChallengeViewer.challenge === challenge)
            {
                (MovieClip)(attachTarget.FightChallengeViewer).removeMovieClip();
            }
            else
            {
                (MovieClip)(attachTarget.FightChallengeViewer).removeMovieClip();
                attachTarget.attachMovie("FightChallengeViewer", "FightChallengeViewer", attachTarget.getNextHighestDepth(), {challenge: challenge});
            } // end else if
        });
    };
    _loc1.over = function (e)
    {
        var _loc3 = this.api.lang.getFightChallenge(this.challenge.id);
        var _loc4 = "<b>" + _loc3.n + "</b>\n";
        _loc4 = _loc4 + (this.challenge.description + "\n");
        _loc4 = _loc4 + this.api.lang.getText("LOOT");
        _loc4 = _loc4 + (" : +" + (this.challenge.teamDropBonus + this.challenge.basicDropBonus) + "%\n");
        _loc4 = _loc4 + this.api.lang.getText("WORD_XP");
        _loc4 = _loc4 + (" : +" + (this.challenge.teamXpBonus + this.challenge.basicXpBonus) + "%\n");
        _loc4 = _loc4 + (this.api.lang.getText("STATE") + " : ");
        switch (this.challenge.state)
        {
            case 0:
            {
                _loc4 = _loc4 + this.api.lang.getText("CURRENT_FIGHT_CHALLENGE");
                break;
            } 
            case 1:
            {
                _loc4 = _loc4 + this.api.lang.getText("FIGHT_CHALLENGE_DONE");
                break;
            } 
            case 2:
            {
                _loc4 = _loc4 + this.api.lang.getText("FIGHT_CHALLENGE_FAILED");
                break;
            } 
        } // End of switch
        this.gapi.showTooltip(_loc4, e.target, 40);
    };
    _loc1.out = function (e)
    {
        this.gapi.hideTooltip();
    };
    _loc1.virtualEvent = function (context, callback, target)
    {
        return (function ()
        {
            context[callback]({target: target});
        });
    };
    ASSetPropFlags(_loc1, null, 1);
    _loc1.displayUiOnClick = true;
} // end if
#endinitclip
