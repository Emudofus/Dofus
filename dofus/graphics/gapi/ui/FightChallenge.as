// Action script...

// [Initial MovieClip Action of sprite 20658]
#initclip 179
if (!dofus.graphics.gapi.ui.FightChallenge)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.FightChallenge = function ()
    {
        super();
    }).prototype;
    _loc1.__get__challenges = function ()
    {
        return (this._aChallengeList);
    };
    _loc1.addChallenge = function (fc)
    {
        this._aChallengeList.push(fc);
        this.updateList();
    };
    _loc1.cleanChallenge = function ()
    {
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < this._aChallengeIcon.length)
        {
            (dofus.graphics.gapi.controls.FightChallengeIcon)(this._aChallengeIcon[_loc2]).unloadMovie();
            (dofus.graphics.gapi.controls.FightChallengeIcon)(this._aChallengeIcon[_loc2]).removeMovieClip();
        } // end while
        this._aChallengeIcon = new Array();
        this._aChallengeList = new ank.utils.ExtendedArray();
        this.FightChallengeViewer.unloadMovie();
        this._visible = false;
    };
    _loc1.updateChallenge = function (id, success)
    {
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this._aChallengeIcon.length)
        {
            if ((dofus.graphics.gapi.controls.FightChallengeIcon)(this._aChallengeIcon[_loc4]).challenge.id == id)
            {
                (dofus.graphics.gapi.controls.FightChallengeIcon)(this._aChallengeIcon[_loc4]).challenge.state = success ? (1) : (2);
                (dofus.graphics.gapi.controls.FightChallengeIcon)(this._aChallengeIcon[_loc4]).update();
                this.FightChallengeViewer.update();
            } // end if
        } // end while
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < this._aChallengeList.length)
        {
            if ((dofus.datacenter.FightChallengeData)(this._aChallengeList[_loc5]).id == id)
            {
                this._aChallengeList[_loc5].state = success ? (1) : (2);
            } // end if
        } // end while
    };
    _loc1.init = function ()
    {
        this._aChallengeList = new ank.utils.ExtendedArray();
        super.init(false, dofus.graphics.gapi.ui.FightChallenge.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._btnOpenClose.addEventListener("click", this);
        this._btnOpenClose.addEventListener("over", this);
        this._btnOpenClose.addEventListener("out", this);
    };
    _loc1.updateList = function ()
    {
        this._aChallengeIcon = new Array();
        this._visible = this._aChallengeList.length > 0;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._aChallengeList.length)
        {
            var _loc2 = (dofus.graphics.gapi.controls.FightChallengeIcon)(this.attachMovie("FightChallengeIcon", "FightChallengeIcon" + _loc3, _loc3 + 1, {challenge: this._aChallengeList[_loc3]}));
            _loc2._x = this._btnOpenClose._x;
            _loc2._y = this._btnOpenClose._y + 15 + (6 + _loc2._height) * _loc3;
            _loc2.addEventListener("over", this);
            this._aChallengeIcon.push(_loc2);
            _loc2._visible = !this._btnOpenClose.selected;
        } // end while
    };
    _loc1.click = function (e)
    {
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._aChallengeIcon.length)
        {
            this._aChallengeIcon[_loc3]._visible = !this._btnOpenClose.selected;
        } // end while
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnOpenClose:
            {
                this.gapi.showTooltip(this.api.lang.getText("OPEN_CLOSE"), oEvent.target, 20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("challenges", _loc1.__get__challenges, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.FightChallenge = function ()
    {
        super();
    }).CLASS_NAME = "FightChallenge";
} // end if
#endinitclip
